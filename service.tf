resource "kubernetes_service" "k8s_service" {
  metadata {
    name      = var.name
    namespace = var.namespace

    labels = {
      app = var.name
    }
  }

  spec {
    dynamic "port" {
      for_each = local.ports_map
      content {
        name        = "${lower(port.value["protocol"])}-${port.value["port"]}"
        protocol    = port.value["protocol"]
        port        = port.value["port"]
        target_port = port.value["port"]
      }
    }

    selector = {
      app = var.name
    }

    type = "ClusterIP"
  }
}
