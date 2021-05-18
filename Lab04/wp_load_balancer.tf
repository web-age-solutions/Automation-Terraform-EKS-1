# LoadBalancer service 
resource "kubernetes_service" "mysvc" {
  depends_on = [kubernetes_deployment.mydeployment,]
  metadata {
    name = "wp-service"
    labels = {
      app = "wp-frontend"
    }
  }
  spec {
    selector = {
      app = "wp-frontend"
    }
    port {
      port = 80
    }
    type = "LoadBalancer"
  }
}
