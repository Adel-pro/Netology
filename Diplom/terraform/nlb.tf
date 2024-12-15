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

  listener {
    name        = "jenkins-access"
    port        = 8080
    target_port = 32000
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
