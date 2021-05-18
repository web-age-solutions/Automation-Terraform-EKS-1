# Deployment resources
resource "kubernetes_deployment" "mydeployment" {
  depends_on = [kubernetes_persistent_volume_claim.pvc, ]
  metadata {
    name = "mydeployment"
    labels = {
      app = "wp-frontend"
    }
  }

  # Spec for deployment
  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "wp-frontend"
      }
    }
    template {
      metadata {
        labels = {
          app = "wp-frontend"
        }
      }
      # Spec for container
      spec {
        volume {
          name = "wordpress-persistent-storage"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.pvc.metadata.0.name
          }
        
        }
        container {
          # Image to be used 
          image = "wordpress:4.8-apache"
          # Providing host, credentials and database name in environment variable
          env {
            name  = "WORDPRESS_DB_HOST"
            value = aws_db_instance.mydb.address
          }
          env {
            name  = "WORDPRESS_DB_USER"
            value = aws_db_instance.mydb.username
          }
          env {
            name  = "WORDPRESS_DB_PASSWORD"
            value = aws_db_instance.mydb.password
          }
          env {
            name  = "WORDPRESS_DB_NAME"
            value = aws_db_instance.mydb.name
          }


          name = "wp-container"
          port {
            container_port = 80
          }
          volume_mount {
            name       = "wordpress-persistent-storage"
            mount_path = "/var/www/html"
          }
        }
      }
    }
  }
}