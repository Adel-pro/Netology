# Дипломный практикум в Yandex.Cloud

## Цели:
   1. Подготовить облачную инфраструктуру на базе облачного провайдера Яндекс.Облако.  
   2. Запустить и сконфигурировать Kubernetes кластер.  
   3. Установить и настроить систему мониторинга.  
   4. Настроить и автоматизировать сборку тестового приложения с использованием Docker-контейнеров.  
   5. Настроить CI для автоматической сборки и тестирования.  
   6. Настроить CD для автоматического развёртывания приложения. 

## Этапы выполнения:
### Создание облачной инфраструктуры 

   1. Создал сервисный аккаунт, который будет в дальнейшем использоваться Terraform для работы с инфраструктурой с необходимыми и достаточными правами:  
      
      ```
      resource "yandex_iam_service_account" "sa-terraform" {
         name = "sa-terraform"
      }

      resource "yandex_resourcemanager_folder_iam_member" "terraform-editor" {
         folder_id  = var.folder_id
         role       = "editor"
         member     = "serviceAccount:${yandex_iam_service_account.sa-terraform.id}"
         depends_on = [yandex_iam_service_account.sa-terraform]
      }

      resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
         service_account_id = yandex_iam_service_account.sa-terraform.id
         description        = "static access key"
      }
      ``` 
  
   Также, настроил output для получения access_key и secret_key:  
      
      ```
      output "s3_access_key" {
         description = "access key"
         value       = yandex_iam_service_account_static_access_key.sa-static-key.access_key
         sensitive   = true
      }

      output "s3_secret_key" {
         description = "secret key"
         value       = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
         sensitive   = true
      }
      ```

   2. Ввел команды:

      terraform init
      terraform plan  
      terraform apply  
      terraform output s3_access_key  
      terraform output s3_secret_key  

      Подготовил backend для Terraform:

      ```
      terraform {
         backend "s3" {
            endpoint = "https://storage.yandexcloud.net"

            bucket     = "bucket-terraform"
            region     = "ru-central1"
            key        = "terraform.tfstate"
            access_key = "some_value"
            secret_key = "some_value"

            skip_region_validation      = true
            skip_credentials_validation = true
            skip_metadata_api_check = true
         }
      }
      ```

      Подставил значения в access_key и secret_key, которые получил через terraform output. Ввел terraform init:  
      ![1](https://github.com/user-attachments/assets/2a383a44-b451-473c-9ca4-896f825148cb)  

      Terraform.tfstate записался в bucket:  
      ![2](https://github.com/user-attachments/assets/818967f5-f324-49c7-a295-00884047e50a)  

   4. Создал VPC с подсетями в разных зонах доступности:

      ```
      resource "yandex_vpc_network" "netology-net" {
         name = var.vpc_name
      }

      resource "yandex_vpc_subnet" "public-subnets" {
         name           = "public_${var.vpc_name}"
         zone           = var.subnets[0]
         network_id     = yandex_vpc_network.netology-net.id
         v4_cidr_blocks = var.public_cidr
      }
      ```     
      ![3](https://github.com/user-attachments/assets/f4b259ea-03aa-4c5c-9d94-66934e813c28)  

   5. Убедился, что terraform apply и terraform destroy выполняются без дополнительных ручных действий.

### Создание Kubernetes кластера

   1. Необходимо разместить Kubernetes кластер в приватной сети и пустить трафик через jump-хост для обеспечения безопасности кластера. Поэтому первым делом был создан nat-инстанс.

      ```
      resource "yandex_compute_instance" "nat-instance" {
         name                      = var.nat_instance_name
         platform_id               = var.vm_platform
         allow_stopping_for_update = true

         resources {
            cores         = var.vms_resources.nat_vm.cores
            memory        = var.vms_resources.nat_vm.memory
            core_fraction = var.vms_resources.nat_vm.core_fraction
         }

         boot_disk {
            initialize_params {
               image_id = "fd80mrhj8fl2oe87o4e1"
            }
         }

         scheduling_policy {
            preemptible = true
         }

         network_interface {
            subnet_id  = yandex_vpc_subnet.public_subnet.id
            ip_address = "192.168.1.254"
            nat        = true
         }

         metadata = {
            serial-port-enable = local.metadata.serial-port-enable
            ssh-keys           = local.metadata.ssh-keys
         }
      }
      ```

   2. Создал приватную подсеть:

      ```
      resource "yandex_vpc_subnet" "private_subnet" {
         count          = length(var.subnets)
         name           = "private_${var.subnets[count.index]}"
         zone           = var.subnets[count.index]
         network_id     = yandex_vpc_network.netology-net.id
         v4_cidr_blocks = [var.private_cidr[count.index]]
         route_table_id = yandex_vpc_route_table.netology-route.id
      }
      ```

   3. Создал таблицу маршрутизации и статический маршрут через nat-инстанс:

      ```
      resource "yandex_vpc_route_table" "netology-route" {
         name       = "private-into-nat"
         network_id = yandex_vpc_network.netology-net.id
         static_route {
            destination_prefix = "0.0.0.0/0"
            next_hop_address   = "192.168.1.254"
         }
      }
      ```

   4. Создал ВМ для мастера кластера:

      ```
      data "yandex_compute_image" "ubuntu" {
         family = var.vm_image
      }

      resource "yandex_compute_instance" "masters" {
         name        = "master"
         hostname    = "master"
         platform_id = var.vm_platform
         zone        = var.subnets[0]

         resources {
            cores         = var.vms_resources.masters_vm.cores
            memory        = var.vms_resources.masters_vm.memory
            core_fraction = var.vms_resources.masters_vm.core_fraction
         }

         boot_disk {
            initialize_params {
               image_id = data.yandex_compute_image.ubuntu.image_id
               size     = 15
            }
         }

         scheduling_policy {
            preemptible = true
         }

         network_interface {
            subnet_id = yandex_vpc_subnet.private_subnet[0].id
            nat       = false
         }

         metadata = {
            serial-port-enable = local.metadata.serial-port-enable
            ssh-keys           = local.metadata.ssh-keys
         }
      }
      ```

   5. Создал ВМ для рабочих нод кластера:

      ```
      resource "yandex_compute_instance" "slaves" {
         count       = 2
         name        = "slave-${count.index + 1}"
         hostname    = "slave-${count.index + 1}"
         platform_id = var.vm_platform
         zone        = var.subnets[count.index]

         resources {
            cores         = var.vms_resources.slaves_vm.cores
            memory        = var.vms_resources.slaves_vm.memory
            core_fraction = var.vms_resources.slaves_vm.core_fraction
         }

         boot_disk {
            initialize_params {
               image_id = data.yandex_compute_image.ubuntu.image_id
               size     = 15
            }
         }

         scheduling_policy {
            preemptible = true
         }

         network_interface {
            subnet_id = yandex_vpc_subnet.private_subnet[count.index].id
            nat       = false
         }

         metadata = {
            serial-port-enable = local.metadata.serial-port-enable
            ssh-keys           = local.metadata.ssh-keys
         }
      }
      ```

   6. Определил переменные для ресурсов ВМ:

      ```
      vms_resources = {
         nat_vm     = { cores = 2, memory = 2, core_fraction = 20 }
         slaves_vm  = { cores = 2, memory = 4, core_fraction = 50 }
         masters_vm = { cores = 2, memory = 4, core_fraction = 50 }
      }
      ```

   7. Подготовил template file для создания inventory файла hosts.yml:

      ```
      ---
      all:
         vars:
            ansible_ssh_user: ubuntu
            ansible_ssh_private_key_file: ~/.ssh/id_rsa
            ansible_ssh_common_args: '-o ProxyCommand="ssh -W %h:%p -q -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no "{{ ansible_ssh_user }}"@${nat_instance["network_interface"][0]["nat_ip_address"]} -i "{{ ansible_ssh_private_key_file }}""'
            become: true
            ansible_python_interpreter: /usr/bin/python3

         hosts:
            %{~ for i in masters ~}

            ${i["name"]}:
               ansible_host: ${i["network_interface"][0]["nat_ip_address"] == "" ? i["network_interface"][0]["ip_address"] : i["network_interface"][0]["nat_ip_address"]}
               ip: ${i["network_interface"][0]["ip_address"]}
               access_ip: ${i["network_interface"][0]["ip_address"]}
            %{~ endfor ~}

            %{~ for i in slaves ~}
            
            ${i["name"]}:
               ansible_host: ${i["network_interface"][0]["nat_ip_address"] == "" ? i["network_interface"][0]["ip_address"] : i["network_interface"][0]["nat_ip_address"]}
               ip: ${i["network_interface"][0]["ip_address"]}
               access_ip: ${i["network_interface"][0]["ip_address"]}
            %{~ endfor ~}

         children:
            kube_control_plane:
               hosts:
               %{~ for i in masters ~}      
               ${i["name"]}:
               %{~ endfor ~}
            
            kube_node:
               hosts:
               %{~ for i in slaves ~}       
               ${i["name"]}:
               %{~ endfor ~}
            
            etcd:
               hosts:
               %{~ for i in masters ~}
               ${i["name"]}:
               %{~ endfor ~}

            k8s_cluster:
               children:
               kube_control_plane:
               kube_node:

            calico_rr:
               hosts: {}
      ```

   8. Создал playbook для выполнения таймаута перед тем, как начнет устанавливаться kubespray на ВМ, для того, чтобы дать время на поднятие ВМ, и установки необходимых пакетов:

      ```
      ---
      -  name: Prepare to install kubespray 
         hosts: all
         become: true
         gather_facts: false

         pre_tasks:
            -  name: Wait for connection
               wait_for_connection:
                  timeout: 300

         tasks:
            -  name: Package update
               apt:
               name:
                  - git
                  - python3-pip
               state: present
               update_cache: true
      ```

   9. Создал playbook для автоматизации настройки kubeconfig:

      ```
      ---
      -  name: Configure kubespray
         hosts: kube_control_plane
         become: true
         gather_facts: false
         
         tasks:
         -  name: Get user home directory
            getent:
               database: passwd
               key: "{{ ansible_user }}"
            register: user_info

         -  name: Extract home directory from user_info
               set_fact:
                  home_dir: "{{ user_info.ansible_facts.getent_passwd.ubuntu[4] }}"

         -  name: Make directory for config
               ansible.builtin.file:
                  path: "{{ home_dir }}/.kube"
                  state: directory
                  mode: '0755'
                  owner: "{{ ansible_user }}"
                  group: "{{ ansible_user }}"

         -  name: Copy config
               ansible.builtin.copy:
                  remote_src: true
                  src: "/etc/kubernetes/admin.conf"
                  dest: "{{ home_dir }}/.kube/config"
                  owner: "{{ ansible_user }}"
                  group: "{{ ansible_user }}"

         -  name: Make directory
               ansible.builtin.file:
                  path: "{{ home_dir }}/k8s"
                  state: directory
                  mode: '0755'
                  owner: "{{ ansible_user }}"
                  group: "{{ ansible_user }}"
      ```

   10. Подготовил основной playbook для установки kubespray:

      ```
      ---
      -  name: Prepare to install kubespray
            ansible.builtin.import_playbook: pre-config.yml
   
      -  name: Install kubespray
            ansible.builtin.import_playbook: kubespray/cluster.yml

      -  name: Copy config kubespray
            ansible.builtin.import_playbook: post-config.yml
      ```

   11. Создал файл для создания inventory и выполнения основного playbook:

      ```
      resource "local_file" "hosts_templatefile" {
         depends_on = [
            yandex_compute_instance.masters,
            yandex_compute_instance.slaves,
            yandex_compute_instance.nat-instance,
         ]

         content = templatefile("${path.module}/hosts.tftpl",

            { masters      = yandex_compute_instance.masters[*],
               slaves       = yandex_compute_instance.slaves[*],
               nat_instance = yandex_compute_instance.nat-instance,
            }
            )
         filename = "${abspath(path.module)}/../ansible/hosts.yml"
      }

      resource "null_resource" "installation" {
         depends_on = [
            yandex_compute_instance.masters,
            yandex_compute_instance.slaves,
            yandex_compute_instance.nat-instance,
         ]

         provisioner "local-exec" {
            command = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ../ansible/hosts.yml -b ../ansible/installation.yml"
         }
      }
      ```

   12. Склонировал репозиторий kubespray командой 
   
      git clone https://github.com/kubernetes-sigs/kubespray.git

   13. Запустил terraform apply. После корректировки конфигов, изменения несоответствия и скачивания дополнительных модулей, kubespray поднялся:  
      ![6](https://github.com/user-attachments/assets/a7dfd565-d92c-4e34-a448-d175e4c408f7)  

      hosts.yml выглядит так:  
      ```
      ---
      all:
         vars:
            ansible_ssh_user: ubuntu
            ansible_ssh_private_key_file: ~/.ssh/id_rsa
            ansible_ssh_common_args: '-o ProxyCommand="ssh -W %h:%p -q -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no "{{ ansible_ssh_user }}"@89.169.136.32 -i "{{ ansible_ssh_private_key_file }}""'
            become: true
            ansible_python_interpreter: /usr/bin/python3

         hosts:

            master:
               ansible_host: 10.10.10.20
               ip: 10.10.10.20
               access_ip: 10.10.10.20
      
            slave-1:
               ansible_host: 10.10.10.4
               ip: 10.10.10.4
               access_ip: 10.10.10.4
            
            slave-2:
               ansible_host: 10.10.20.21
               ip: 10.10.20.21
               access_ip: 10.10.20.21

         children:
            kube_control_plane:
               hosts:
               master:
    
            kube_node:
               hosts:
               slave-1:
               slave-2:
            
            etcd:
               hosts:
               master:

            k8s_cluster:
               children:
               kube_control_plane:
               kube_node:

            calico_rr:
               hosts: {}
      ```

   14. Создались ВМ:  
       ![4](https://github.com/user-attachments/assets/8e91fbb5-23ae-4ec9-b7db-eeed11964987)  

   15. Карта облачной сети выглядит так:  
       ![5](https://github.com/user-attachments/assets/150030b0-5c9b-4157-849e-f5bf35987850)  

   16. Через jump-хост зашел на мастера и проверил ноды и неймспейсы:  
       ![7](https://github.com/user-attachments/assets/2f5dd141-d5bc-4ab7-9491-64c42252a43e)  

   17. Файл ~/.kube/config выглядит так:

      ```
      apiVersion: v1
      clusters:
      -  cluster:
         certificate-authority-data: ...
         server: https://127.0.0.1:6443
      name: cluster.local
      contexts:
      -  context:
         cluster: cluster.local
         user: kubernetes-admin
      name: kubernetes-admin@cluster.local
      current-context: kubernetes-admin@cluster.local
      kind: Config
      preferences: {}
      users:
      -  name: kubernetes-admin
         user:
            client-certificate-data: ...
            client-key-data: ...
      ```

### Создание тестового приложения

   1. Создал отдельный репозиторий в github:  
      ![8](https://github.com/user-attachments/assets/ae1ae213-70c1-48a0-a710-ab085485f98d)  

   2. Добавил в репозиторий простой index.html и картинку:

      ```
      <!DOCTYPE html>
      <html lang="en">

      <head>
         <meta charset="UTF-8">
         <meta name="viewport" content="width=device-width, initial-scale=1.0">
         <title>Интерактивная страница</title>
         <style>
            body {
               font-family: Arial, sans-serif;
               background-color: #f0f0f0;
               color: #333;
            }

            h1 {
               color: #007BFF;
            }

            p {
               font-size: 1.2em;
            }

            button {
               padding: 10px 20px;
               font-size: 1em;
               color: #fff;
               background-color: #007BFF;
               border: none;
               border-radius: 5px;
               cursor: pointer;
            }
	      </style>
      </head>

      <body>
	      <div class="image-text-container">
            <img src="sunrise.jpeg">
            <div class="text-overlay">
               <button onclick="showAlert()">Я сдал дипломную работу?</button>
               <script>
                  function showAlert() {
                     alert('Неисключено');
                  }
               </script>
		      </div>
      	</div>
      </body>

      </html>
      ```

   3. Создал Dockerfile:

      ```
      FROM nginx:1.26.2
      COPY index.html /usr/share/nginx/html/index.html
      EXPOSE 80
      CMD ["nginx", "-g", "daemon off;"]
      ```

   4. Создал образ из Dockerfile:  
      ![9](https://github.com/user-attachments/assets/2991b56b-7f9b-4b49-8ff7-baf0b428ee56)  

   5. Зарегистрировался в yandex cloud через ус. Аутентифицировался в Container Registry командой:

      ```
      echo <token>|docker login --username oauth --password-stdin cr.yandex
      ```

   6. Создал Container Registry через Terraform и дал права на pull и push:

      ```
      resource "yandex_container_registry" "my-reg" {
         name      = "netology-registry"
         folder_id = var.folder_id
         labels = {
            my-label = "docker-images"
         }
      }

      resource "yandex_container_registry_iam_binding" "puller" {
	  registry_id = yandex_container_registry.my-reg.id
	  role        = "container-registry.images.pusher"
	
	  members = [
	    "system:allUsers",

	  ]
      }

      resource "yandex_container_registry_iam_binding" "pusher" {
	  registry_id = yandex_container_registry.my-reg.id
	  role        = "container-registry.images.puller"
	
	  members = [
	    "system:allUsers",
	  ]
      }

      ```

   7. Создал необходимый тег для образа:  
      ![10](https://github.com/user-attachments/assets/0af5bb39-79c4-41fa-bc20-4fa38b61b83b)

   8. Запушил образ в Container Registry:  
      ![11](https://github.com/user-attachments/assets/45558579-4d25-4ecb-9fc0-6ea597daccd6)
      
   9. Увидел, что образ появился в Container Registry:
      ![12](https://github.com/user-attachments/assets/34255f96-13b7-4dcc-911c-61e0ff6b560c)

### Подготовка cистемы мониторинга и деплой приложения

   1. Создал playbook для развертывания системы мониторинга:

      ```
      -  name: Install monitoring tools
         hosts: kube_control_plane
         become: false
         gather_facts: false

         tasks:

      -  name: Git clone kube-prometheus
         ansible.builtin.git:
            repo: https://github.com/prometheus-operator/kube-prometheus.git
            dest: kube-prometheus

      -  name: Create the namespace and CRDs
         ansible.builtin.command:
            cmd: 'kubectl apply --server-side -f manifests/setup'
            chdir: 'kube-prometheus/'

      -  name: Wait until namespace and CRDS become available
         ansible.builtin.command:
            cmd: 'kubectl wait --for condition=Established --all CustomResourceDefinition --namespace=monitoring'
            chdir: 'kube-prometheus/'

      -  name: Deploy kube-prometheus
         ansible.builtin.command:
            cmd: 'kubectl apply -f manifests/'
            chdir: 'kube-prometheus/'

      -  name: Copy grafana-service
         ansible.builtin.copy:
            src: 'grafana-service.yml'
            dest: '~/'
            mode: '0644'

      -  name: Deploy grafana-service
         ansible.builtin.command:
            cmd: 'kubectl apply -f ~/grafana-service.yml'

      -  name: Copy grafana-networkpolicy
         ansible.builtin.copy:
            src: 'grafana-networkpolicy.yml'
            dest: '~/'
            mode: '0644'
    
      -  name: Deploy grafana-networkpolicy
         ansible.builtin.command:
            cmd: 'kubectl apply -f ~/grafana-networkpolicy.yml'
      ```

   2. Переопредил сервис для доступа к графане:

      ```
      apiVersion: v1
      kind: Service
      metadata:
      labels:
         app.kubernetes.io/component: grafana
         app.kubernetes.io/name: grafana
         app.kubernetes.io/part-of: kube-prometheus
         app.kubernetes.io/version: 11.3.1
      name: grafana-service
      namespace: monitoring
      spec:
         selector:
            app.kubernetes.io/component: grafana
            app.kubernetes.io/name: grafana
            app.kubernetes.io/part-of: kube-prometheus
      type: NodePort
      ports:
         -  name: http
            protocol: TCP
            port: 3000
            targetPort: 3000
            nodePort: 31200
      ```

   3. Переопредил политики доступа для графаны:

      ```
      apiVersion: networking.k8s.io/v1
      kind: NetworkPolicy
      metadata:
         labels:
            app.kubernetes.io/component: grafana
            app.kubernetes.io/name: grafana
            app.kubernetes.io/part-of: kube-prometheus
            app.kubernetes.io/version: 11.3.1
         name: grafana-networkpolicy
         namespace: monitoring
      spec:
         egress:
         - to:
            - ipBlock:
               cidr: 0.0.0.0/0
         ingress:
         - from:
            - ipBlock:
               cidr: 0.0.0.0/0
            - podSelector:
               matchLabels:
                  app.kubernetes.io/name: prometheus
            ports:
            - port: 3000
               protocol: TCP
         podSelector:
            matchLabels:
               app.kubernetes.io/component: grafana
               app.kubernetes.io/name: grafana
               app.kubernetes.io/part-of: kube-prometheus
         policyTypes:
         - Egress
         - Ingress
      ```

   4. Также, так как кластер находится в приватной сети, доступ извне будет отсутствовать, поэтому необходимо поднять балансировщик нагрузки для доступа к графане и приложению:

      ```
      resource "yandex_lb_target_group" "nlb-group" {
         name       = "nlb-group"
         depends_on = [yandex_compute_instance.slaves]
         dynamic "target" {
            for_each = yandex_compute_instance.slaves
            content {
               subnet_id = target.value.network_interface.0.subnet_id
               address   = target.value.network_interface.0.ip_address
            }
         }
      }

      resource "yandex_lb_network_load_balancer" "nlb-grafana" {
         name = "nlb-grafana"
         listener {
            name        = "grafana-access"
            port        = 3000
            target_port = 31200
            external_address_spec {
               ip_version = "ipv4"
            }
         }

         listener {
            name        = "app-access"
            port        = 80
            target_port = 32200
            external_address_spec {
               ip_version = "ipv4"
            }
         }

         attached_target_group {
            target_group_id = yandex_lb_target_group.nlb-group.id
            healthcheck {
               name = "healthcheck-grafana"
               tcp_options {
               port = 31200
               }
            }
         }
         depends_on = [yandex_lb_target_group.nlb-group]
      }
      ```

   5. Далее, создал playbook для деплоя приложения:

      ```
      -  name: Deploy app
         hosts: kube_control_plane
         gather_facts: true
         become: false

         tasks:
         - name: Copy app-deployment
            ansible.builtin.copy:
               src: 'app-deployment.yml'
               dest: '~/'
               mode: '0644'

         - name: Copy app-service
            ansible.builtin.copy:
               src: 'app-service.yml'
               dest: '~/'
               mode: '0644'

         - name: Deploy app
            ansible.builtin.command:
               cmd: 'kubectl apply -f {{ item }}'
            with_items:
               - '~/app-deployment.yml'
               - '~/app-service.yml'
      ```

   6. Написал deployment для приложения:

      ```
      apiVersion: apps/v1
      kind: Deployment
      metadata:
         name: myapp-nginx
         labels:
            app: app
      spec:
      replicas: 2
      strategy:
         type: RollingUpdate
         rollingUpdate:
            maxSurge: 50%
            maxUnavailable: 50%
      selector:
         matchLabels:
            app: app
      template:
         metadata:
            labels:
            app: app
         spec:
            containers:
            - name: nginx
            image: cr.yandex/crpgfloaqiho2c5h1t9c/nginx:latest
            ports:
            - containerPort: 80 
      ```

   7. Определил сервис для приложения для доступа извне:

      ```
      apiVersion: v1
      kind: Service
      metadata:
         name: myapp-service
      labels:
         app: app
      spec:
      selector:
         app: app
      type: NodePort
      ports:
         - name: app-http
            port: 80
            targetPort: 80
            nodePort: 32200
      ```

   8. Добавил в основной playbook задачи для развертывания систем мониторинга и приложения:

      ```
      -  name: Prepare to install kubespray
         ansible.builtin.import_playbook: pre-config.yml
      
      -  name: Install kubespray
         ansible.builtin.import_playbook: kubespray/cluster.yml

      -  name: Copy config kubespray
         ansible.builtin.import_playbook: post-config.yml

      -  name: Install monitoring tools
         ansible.builtin.import_playbook: install-monitoring.yml

      -  name: Deploy app
         ansible.builtin.import_playbook: deploy-app.yml
      ```

   9. После использования команды "terraform apply", увидел создание балансировщика в консоли Yandex Cloud:  
      ![14](https://github.com/user-attachments/assets/d9f7142e-77d8-4a94-bfb6-7211ab2a0560)

   10. Получил доступ к графане:  
       ![13](https://github.com/user-attachments/assets/ca22820f-f452-4557-b567-bcfd37692023)

   11. Увидел уже созданные дашборды, показывающие состояние кластера:  
       ![15](https://github.com/user-attachments/assets/58d89ece-f5db-4efe-9bff-0ed3247cb798)

### Установка и настройка CI/CD

   1. В качестве оркестратора выбрал Jenkins. Для этого склонировал репозиторий 

      ```
      git clone https://github.com/scriptcamp/kubernetes-jenkins
      ```

   2. Адаптировал конфиги, добавив в deployment дополнительные volumeMounts и volumes для работы docker в jenkins. Также, в файл с pre-config.yml добавляю установку docker на хостах кластера.

      ```
      - name: Update apt cache
         apt:
            update_cache: true

      - name: Install required system packages
         apt:
         pkg:
            - apt-transport-https
            - ca-certificates
            - curl
            - gnupg-agent
            - software-properties-common

      - name: Add Docker's official GPG key
         apt_key:
            url: https://download.docker.com/linux/ubuntu/gpg
            state: present

      - name: Add Docker repository
         apt_repository:
            repo: deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable
            state: present

      - name: Update apt and install docker-ce
         apt:
            name: docker-ce
            state: latest
            update_cache: true

      - name: Ensure Docker service is started and enabled
         service:
            name: docker
            state: started
            enabled: yes

      - name: Add current user to docker group
         user:
            name: "{{ ansible_user }}"
            groups: docker
            append: yes

      - name: Set permessions on /var/run/docker.sock
         file:
            path: /var/run/docker.sock
            mode: '0666'
      ```

   3. Написал playbook для установки jenkins в кластере:

       ```
       - name: Install jenkins
         hosts: kube_control_plane
         become: false
         gather_facts: false

         tasks:
            - name: Copy kubernetes-jenkins
               ansible.builtin.copy:
                  src: '../kubernetes-jenkins/'
                  dest: '~/kubernetes-jenkins/'
                  mode: '0644'

            - name: Create a namespace
               ansible.builtin.command:
                  cmd: 'kubectl apply -f ~/kubernetes-jenkins/namespace.yaml'

            - name: Create a service-account
               ansible.builtin.command:
                  cmd: 'kubectl apply -f ~/kubernetes-jenkins/serviceAccount.yaml'

            - name: Create a volume
               ansible.builtin.command:
                  cmd: 'kubectl create -f ~/kubernetes-jenkins/volume.yaml'

            - name: Apply a deployment
               ansible.builtin.command:
                  cmd: 'kubectl apply -f ~/kubernetes-jenkins/deployment.yaml'

            - name: Apply a service
               ansible.builtin.command:
                  cmd: 'kubectl apply -f ~/kubernetes-jenkins/service.yaml'
       ```

   4. Для доступа к кластеру извне создал балансировщик:

      ```
      resource "yandex_lb_target_group" "nlb-k8s" {
      name = "nlb-k8s"
      target {
         subnet_id = yandex_compute_instance.masters.network_interface.0.subnet_id
         address   = yandex_compute_instance.masters.network_interface.0.ip_address
      }
      }


      resource "yandex_lb_network_load_balancer" "nlb-k8s" {
         name = "nlb-k8s"
         listener {
            name        = "k8s-access"
            port        = 32400
            target_port = 6443
            external_address_spec {
               ip_version = "ipv4"
            }
         }


         attached_target_group {
            target_group_id = yandex_lb_target_group.nlb-k8s.id
            healthcheck {
               name = "healthcheck-k8s"
               tcp_options {
               port = 6443
               }
            }
         }
         depends_on = [yandex_lb_target_group.nlb-k8s]
      }
      ```

      А также добавил в предыдущий балансировщик доступ к jenkins:

      ```
         listener {
            name        = "jenkins-access"
            port        = 8080
            target_port = 32000
            external_address_spec {
               ip_version = "ipv4"
            }
         }
      ```

   5. Также, во избежании ошибки доступа к кластеру по 6443 порту без сертификата использовал в кластере команду:

   ```
   kubectl create clusterrolebinding cluster-system-anonymous --clusterrole=cluster-admin --user=system:anonymous
   ```
   ![21](https://github.com/user-attachments/assets/1b10bb2b-44d6-43a0-9ba7-7362964819c8)

   6. Проделал первоначальную установку Jenkins:
      ![16](https://github.com/user-attachments/assets/f833b9ec-ee7b-446c-b200-5e50b2d5a167)

   7. Настроил webhook в веб-интерфейсе GitHub:
      ![17](https://github.com/user-attachments/assets/4d0d0a72-862d-4c84-bc1c-36997c45485a)

   8. Для настройки агентов для сборки, установил плагин Kubernetes для Jenkins, создал облако Kubernetes, в настройках прописал пространство имен devops-tools и доступ к кластеру по сокету <ip_balancer>:32400, протестировал соединение.
      ![18](https://github.com/user-attachments/assets/9f5a9537-1f31-4892-a18d-834dec275e99)

   9. Создал шаблон пода jenkins-agent, где указал неймспейс, лейблы и способы его применения.

   10. Создал job, в котором указал источник git, и pipeline:

      ```
      pipeline {
         agent any  

         environment {
            CONTAINER_REGISTRY = 'cr.yandex/crpgfloaqiho2c5h1t9c/nginx'
         }

         stages {
            stage('Checkout') {
                  steps {
                     // Получение кода из GitHub
                     git branch: 'main', url: 'https://github.com/Adel-pro/netology-diplom-app.git'
                  }
            }
            
            stage('Build Docker Image') {
                  steps {
                     script {
                        // Получение текущего тега, если есть
                        def tag = env.GIT_TAG_NAME ?: 'latest'
                        // Сборка Docker-образа
                        sh "docker build -t ${CONTAINER_REGISTRY}:${tag} ."
                     }
                  }
            }
            
            stage('Push to Container Registry') {
               steps {
                     script {
                        def tag = env.GIT_TAG_NAME ?: 'latest'
                        sh "docker push ${CONTAINER_REGISTRY}:${tag}"
                     }
                  }
            }
            
            stage('Deploy to Kubernetes') {
                  steps {
                     script {
                        def tag = env.GIT_TAG_NAME ?: 'latest'
                        // Применение конфигурации деплоя в Kubernetes
                        sh """
                        kubectl set image deployment/myapp-nginx nginx=${CONTAINER_REGISTRY}:${tag}
                        kubectl rollout status deployment/myapp-nginx
                        """
                     }
                  }
            }   
         }

         post {
            success {
                  echo 'Pipeline completed successfully!'
            }
            failure {
                  echo 'Pipeline failed!'
            }
         }
      }
      ```

   11. Проверил доступность приложения:  
       ![20](https://github.com/user-attachments/assets/10c3ccc6-887f-4dc2-9799-f120b236737b)
       
   13. Исправил в main ветке index.html, проверил джобу:  
       ![19](https://github.com/user-attachments/assets/fe92d97a-e98a-4382-a7d4-7179f5f241fe)

   14. Новая версия приложения применилась:  
       ![22](https://github.com/user-attachments/assets/dbb6b290-d223-42fc-9efb-7fd7d7dc81e7)













