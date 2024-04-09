# Тестирование roles
# Домашнее задание к занятию 5 «Тестирование roles»

## Подготовка к выполнению
  1. Установил molecule и его драйвера.
  2. Скачал образ с podman, tox и несколькими пайтонами версий 3.7 и 3.9. 
      
## Основная часть.
## Molecule
  1. Выполнил команду "molecule test -s ubuntu_xenial" внутри директории с ролью clickhouse. Отработал со следующей ошибкой:
     CRITICAL Failed to validate /home/test/Downloads/mnt-homeworks/08-ansible-05-testing/clickhouse/molecule/ubuntu_xenial/molecule.yml  
     ["Additional properties are not allowed ('playbooks' was unexpected)"]  
     Понял, что в verifier не существует параметра playbooks, поменял его на diretory, пошли ошибки, связанные с Python скриптом. Оставил в verifier только параметр name, добавил в переменную среды переменную "MOLECULE_ENV_FILE=/home/test/Downloads/mnt-homeworks/08-ansible-05-testing/clickhouse/molecule/resources/tests/verify.yml", выдал следующую ошибку:  
     CRITICAL Failed to validate /home/test/Downloads/mnt-homeworks/08-ansible-05-testing/clickhouse/molecule/ubuntu_xenial/molecule.yml  
     ["Additional properties are not allowed ('D', 'vv' were unexpected)"]  
     Положил в директорию "ubuntu_xenial" файл verify.yml, проблема та же.
  2. Перешел в каталог с ролью vector-role и добавил директорию molecule командой "molecule init scenario --driver-name docker".  
     ![2](https://github.com/Adel-pro/Netology/assets/116494871/407988d6-3c8c-4660-8bcf-1ab897fdd85f)  
  3. Добавил дистрибутивы oraclelinux:8 и ubuntu:latest, запустил команду "molecule test", отработало с ошибкой:  
     ![3](https://github.com/Adel-pro/Netology/assets/116494871/98264251-9452-419b-885b-e6469c8af9df)  
     Понял, что нужно скачать docker-образы. После скачивания образов, запустил ту же команду, все tasks с ubuntu-latest прошли успешно, за исключением поледнего, в котором включается vector.service:  
     ![7](https://github.com/Adel-pro/Netology/assets/116494871/5742bfa7-95a2-48f3-8582-9db74c68fac3)  
     Отработал playbook на ВМ, все работает, vector.service существует и запущен. Запустил контейнер с образом, проделал те же самые операции, только вручную, все работает:  
     ![5](https://github.com/Adel-pro/Netology/assets/116494871/a373eb71-cec7-42b5-a967-fb3c30810df3)  
     Полная отработка команды "molecule test":  
      INFO     default scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy  
      INFO     Performing prerun with role_name_check=0...  
      INFO     Set ANSIBLE_LIBRARY=/home/test/.cache/ansible-compat/f5bcd7/modules:/home/test/.ansible/plugins/modules:/usr/share/ansible/plugins/modules  
      INFO     Set ANSIBLE_COLLECTIONS_PATH=/home/test/.cache/ansible-compat/f5bcd7/collections:/home/test/.ansible/collections:/usr/share/ansible/collections  
      INFO     Set ANSIBLE_ROLES_PATH=/home/test/.cache/ansible-compat/f5bcd7/roles:/home/test/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles  
      INFO     Using /home/test/.cache/ansible-compat/f5bcd7/roles/netology.vector symlink to current repository in order to enable Ansible to find the role using its expected full name.  
      INFO     Running default > dependency  
      WARNING  Skipping, missing the requirements file.  
      WARNING  Skipping, missing the requirements file.  
      INFO     Running default > lint  
      /usr/bin/ansible-lint:6: DeprecationWarning: pkg_resources is deprecated as an API. See https://setuptools.pypa.io/en/latest/pkg_resources.html
        from pkg_resources import load_entry_point  
      701 Role info should contain license  
      /home/test/Downloads/mnt-homeworks/08-ansible-05-testing/vector-role/meta/main.yml:1  
      {'meta/main.yml': {'galaxy_info': {'role_name': 'vector', 'namespace': 'netology', 'author': 'Adel Rakhimov', 'description': 'Role for installation and configuring Vector', 'min_ansible_version': 2.8, 'platforms': [{'name': 'Ubuntu', 'versions': ['focal', 'bionic', 'xenial'], '__line__': 9, '__file__': '/home/test/Downloads/mnt-homeworks/08-ansible-05-testing/vector-role/meta/main.yml'}], 'galaxy_tags': ['vector'], '__line__': 2, '__file__': '/home/test/Downloads/mnt-homeworks/08-ansible-05-testing/vector-role/meta/main.yml'}, 'dependencies': [], '__line__': 1, '__file__': '/home/test/Downloads/mnt-homeworks/08-ansible-05-testing/vector-role/meta/main.yml', 'skipped_rules': []}}  
    
      INFO     Running default > cleanup  
      WARNING  Skipping, cleanup playbook not configured.  
      INFO     Running default > destroy  
      INFO     Sanity checks: 'docker'  

      PLAY [Destroy] *****************************************************************
      
      TASK [Set async_dir for HOME env] **********************************************  
      ok: [localhost]
      
      TASK [Destroy molecule instance(s)] ********************************************  
      changed: [localhost] => (item=centos-stream8)  
      changed: [localhost] => (item=oraclelinux8)  
      changed: [localhost] => (item=ubuntu-latest)  
      
      TASK [Wait for instance(s) deletion to complete] *******************************  
      ok: [localhost] => (item=centos-stream8)  
      ok: [localhost] => (item=oraclelinux8)  
      ok: [localhost] => (item=ubuntu-latest)  
      
      TASK [Delete docker networks(s)] ***********************************************
      
      PLAY RECAP *********************************************************************  
      localhost                  : ok=3    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
      
      INFO     Running default > syntax
      
      playbook: /home/test/Downloads/mnt-homeworks/08-ansible-05-testing/vector-role/molecule/default/converge.yml  
      INFO     Running default > create
      
      PLAY [Create] ******************************************************************
      
      TASK [Set async_dir for HOME env] **********************************************  
      ok: [localhost]
      
      TASK [Log into a Docker registry] **********************************************  
      skipping: [localhost] => (item=None)   
      skipping: [localhost] => (item=None)   
      skipping: [localhost] => (item=None)   
      skipping: [localhost]
      
      TASK [Check presence of custom Dockerfiles] ************************************  
      ok: [localhost] => (item={'image': 'quay.io/centos/centos:stream8', 'name': 'centos-stream8', 'pre_build_image': True})  
      ok: [localhost] => (item={'image': 'docker.io/dokken/oraclelinux-8', 'name': 'oraclelinux8', 'pre_build_image': True})  
      ok: [localhost] => (item={'image': 'docker.io/ubuntu:22.04', 'name': 'ubuntu-latest', 'per_build_image': True})
      
      TASK [Create Dockerfiles from image names] *************************************  
      skipping: [localhost] => (item={'image': 'quay.io/centos/centos:stream8', 'name': 'centos-stream8', 'pre_build_image': True})  
      skipping: [localhost] => (item={'image': 'docker.io/dokken/oraclelinux-8', 'name': 'oraclelinux8', 'pre_build_image': True})  
      changed: [localhost] => (item={'image': 'docker.io/ubuntu:22.04', 'name': 'ubuntu-latest', 'per_build_image': True})
      
      TASK [Synchronization the context] *********************************************  
      skipping: [localhost] => (item={'image': 'quay.io/centos/centos:stream8', 'name': 'centos-stream8', 'pre_build_image': True})  
      skipping: [localhost] => (item={'image': 'docker.io/dokken/oraclelinux-8', 'name': 'oraclelinux8', 'pre_build_image': True})  
      changed: [localhost] => (item={'image': 'docker.io/ubuntu:22.04', 'name': 'ubuntu-latest', 'per_build_image': True})
      
      TASK [Discover local Docker images] ********************************************  
      ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'item': {'image': 'quay.io/centos/centos:stream8', 'name': 'centos-stream8', 'pre_build_image': True}, 'ansible_loop_var': 'item', 'i': 0, 'ansible_index_var': 'i'})  
      ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'item': {'image': 'docker.io/dokken/oraclelinux-8', 'name': 'oraclelinux8', 'pre_build_image': True}, 'ansible_loop_var': 'item', 'i': 1, 'ansible_index_var': 'i'})  
      ok: [localhost] => (item={'diff': [], 'dest': '/home/test/.cache/molecule/vector-role/default/Dockerfile_docker_io_ubuntu_22_04', 'src': '/home/test/.ansible/tmp/ansible-tmp-1712593061.612894-34069-138293946178346/source', 'md5sum': '9150cb7fe16cfca134406c930e4144f2', 'checksum': 'fdaee7e789e2cec49211f5281b9b8759e4f38496', 'changed': True, 'uid': 1000, 'gid': 1000, 'owner': 'test', 'group': 'test', 'mode': '0600', 'state': 'file', 'size': 1051, 'invocation': {'module_args': {'src': '/home/test/.ansible/tmp/ansible-tmp-1712593061.612894-34069-138293946178346/source', 'dest': '/home/test/.cache/molecule/vector-role/default/Dockerfile_docker_io_ubuntu_22_04', 'mode': '0600', 'follow': False, '_original_basename': 'Dockerfile.j2', 'checksum': 'fdaee7e789e2cec49211f5281b9b8759e4f38496', 'backup': False, 'force': True, 'unsafe_writes': False, 'content': None, 'validate': None, 'directory_mode': None, 'remote_src': None, 'local_follow': None, 'owner': None, 'group': None, 'seuser': None, 'serole': None, 'selevel': None, 'setype': None, 'attributes': None}}, 'failed': False, 'item': {'image': 'docker.io/ubuntu:22.04', 'name': 'ubuntu-latest', 'per_build_image': True}, 'ansible_loop_var': 'item', 'i': 2, 'ansible_index_var': 'i'})  
      
      TASK [Build an Ansible compatible image (new)] *********************************  
      skipping: [localhost] => (item=molecule_local/quay.io/centos/centos:stream8)  
      skipping: [localhost] => (item=molecule_local/docker.io/dokken/oraclelinux-8)  
      ok: [localhost] => (item=molecule_local/docker.io/ubuntu:22.04)
      
      TASK [Create docker network(s)] ************************************************
      
      TASK [Determine the CMD directives] ********************************************  
      ok: [localhost] => (item={'image': 'quay.io/centos/centos:stream8', 'name': 'centos-stream8', 'pre_build_image': True})  
      ok: [localhost] => (item={'image': 'docker.io/dokken/oraclelinux-8', 'name': 'oraclelinux8', 'pre_build_image': True})  
      ok: [localhost] => (item={'image': 'docker.io/ubuntu:22.04', 'name': 'ubuntu-latest', 'per_build_image': True})
      
      TASK [Create molecule instance(s)] *********************************************  
      changed: [localhost] => (item=centos-stream8)  
      changed: [localhost] => (item=oraclelinux8)  
      changed: [localhost] => (item=ubuntu-latest)
      
      TASK [Wait for instance(s) creation to complete] *******************************  
      changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': '358171993722.34357', 'results_file': '/home/test/.ansible_async/358171993722.34357', 'changed': True, 'item': {'image': 'quay.io/centos/centos:stream8', 'name': 'centos-stream8', 'pre_build_image': True}, 'ansible_loop_var': 'item'})  
      changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': '516424387117.34385', 'results_file': '/home/test/.ansible_async/516424387117.34385', 'changed': True, 'item': {'image': 'docker.io/dokken/oraclelinux-8', 'name': 'oraclelinux8', 'pre_build_image': True}, 'ansible_loop_var': 'item'})  
      changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': '465752091295.34418', 'results_file': '/home/test/.ansible_async/465752091295.34418', 'changed': True, 'item': {'image': 'docker.io/ubuntu:22.04', 'name': 'ubuntu-latest', 'per_build_image': True}, 'ansible_loop_var': 'item'})
      
      PLAY RECAP *********************************************************************  
      localhost                  : ok=9    changed=4    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0
      
      INFO     Running default > prepare  
      WARNING  Skipping, prepare playbook not configured.  
      INFO     Running default > converge
      
      PLAY [Converge] ****************************************************************
      
      TASK [Gathering Facts] *********************************************************  
      ok: [ubuntu-latest]  
      ok: [centos-stream8]  
      ok: [oraclelinux8]
      
      TASK [Include vector-role] *****************************************************
      
      TASK [vector-role : Get Vector (Debian)] ***************************************  
      changed: [oraclelinux8]  
      changed: [ubuntu-latest]  
      changed: [centos-stream8]
      
      TASK [vector-role : Install Vector] ********************************************  
      skipping: [centos-stream8]  
      skipping: [oraclelinux8]  
      changed: [ubuntu-latest]
      
      TASK [vector-role : Copy config] ***********************************************  
      fatal: [centos-stream8]: FAILED! => {"msg": "Failed to get information on remote file (/etc/vector/vector.toml): /bin/sh: sudo: command not found\n"}  
      fatal: [oraclelinux8]: FAILED! => {"changed": false, "checksum": "c5640d16817ba75df58772b0f6ac85fc2f691334", "msg": "Destination directory /etc/vector does not exist"}  
      changed: [ubuntu-latest]
      
      TASK [vector-role : Use the right config_file] *********************************  
      changed: [ubuntu-latest]
      
      TASK [vector-role : Systemd config] ********************************************
      changed: [ubuntu-latest]
      
      TASK [vector-role : Add vector user to docker group] ***************************  
      skipping: [ubuntu-latest]
      
      TASK [vector-role : Add vector user to systemd-journal group] ******************  
      skipping: [ubuntu-latest]
      
      TASK [vector-role : Start Vector] **********************************************  
      fatal: [ubuntu-latest]: FAILED! => {"changed": false, "msg": "Could not find the requested service vector.service: "}
      
      RUNNING HANDLER [vector-role : Start vector service] ***************************
      
      PLAY RECAP *********************************************************************  
      centos-stream8             : ok=2    changed=1    unreachable=0    failed=1    skipped=1    rescued=0    ignored=0  
      oraclelinux8               : ok=2    changed=1    unreachable=0    failed=1    skipped=1    rescued=0    ignored=0  
      ubuntu-latest              : ok=6    changed=5    unreachable=0    failed=1    skipped=2    rescued=0    ignored=0
      
      WARNING  Retrying execution failure 2 of: ansible-playbook --inventory /home/test/.cache/molecule/vector-role/default/inventory --skip-tags molecule-notest,notest /home/test/Downloads/mnt-homeworks/08-ansible-05-testing/vector-role/molecule/default/converge.yml  
      CRITICAL Ansible return code was 2, command was: ['ansible-playbook', '--inventory', '/home/test/.cache/molecule/vector-role/default/inventory', '--skip-tags', 'molecule-notest,notest', '/home/test/Downloads/mnt-homeworks/08-ansible-05-testing/vector-role/molecule/default/converge.yml']  
      WARNING  An error occurred during the test sequence action: 'converge'. Cleaning up.  
      INFO     Running default > cleanup  
      WARNING  Skipping, cleanup playbook not configured.  
      INFO     Running default > destroy
      
      PLAY [Destroy] *****************************************************************
      
      TASK [Set async_dir for HOME env] **********************************************  
      ok: [localhost]
      
      TASK [Destroy molecule instance(s)] ********************************************  
      changed: [localhost] => (item=centos-stream8)  
      changed: [localhost] => (item=oraclelinux8)  
      changed: [localhost] => (item=ubuntu-latest)
      
      TASK [Wait for instance(s) deletion to complete] *******************************  
      changed: [localhost] => (item=centos-stream8)  
      changed: [localhost] => (item=oraclelinux8)  
      changed: [localhost] => (item=ubuntu-latest)
      
      TASK [Delete docker networks(s)] ***********************************************
      
      PLAY RECAP *********************************************************************  
      localhost                  : ok=3    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
      
      INFO     Pruning extra files from scenario ephemeral directory 

  4. Разобрался как добавить assert в файл verify.yml, прочитал документацию, добавил проверку существования конфига для vector и проверку статуса vector.service.
  5. Роль повторно протестировал.
  6. Добавил новый тег на коммит в репозитории https://github.com/Adel-pro/vector-role.

## Tox
  1. Добавил файлы tox.ini и tox-requirements.txt в директорию с ролью vector-role.
  2. Запустил контейнер командой "docker run --privileged=True -v /home/test/Downloads/mnt-homeworks/08-ansible-05-testing/vector-role:/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash".
  3. Внутри контейнера выполнил команду "tox", выполнил все тоже самое, что и на хосте, с той же самой ошибкой (не может найти vector.service) для всех 4х сценариев.
  4. Создал облегченный сценарий для molecule с драйвером molecule_podman. Для этого переопределил последовательность выполнения тестов в файле molecule.yml, включив туда только destroy-create-converge-destroy.
  5. Также, облегчил сценарий, уменьшив количество сценариев с 4х до 2х в файле tox.ini, включив только следующие сценарии:  
     ![9](https://github.com/Adel-pro/Netology/assets/116494871/abe117ae-72da-4591-8089-c5899f0fcf34)
  6. Выполнил команду "tox", убедился, что все отрабатывает.
  7. Добавил новый тег на коммит в репозитории https://github.com/Adel-pro/vector-role.
