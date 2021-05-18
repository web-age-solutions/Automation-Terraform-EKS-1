# Storage class, defining storage provisoner
resource "kubernetes_storage_class" "kubeSC" {
depends_on = [aws_db_instance.mydb,]
  metadata {
    name = "kubesc"
  }
  storage_provisioner = "kubernetes.io/aws-ebs"
  reclaim_policy      = "Retain"
  parameters = {
    type = "gp2"
  }
 }



# PVC 
resource "kubernetes_persistent_volume_claim" "pvc" {
depends_on = [kubernetes_storage_class.kubeSC,]
  metadata {
    name = "wp-pvc"
    labels = {
      app = "wp-frontend"
    }
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    storage_class_name = kubernetes_storage_class.kubeSC.metadata.0.name
    resources {
      requests = {
        storage = "2Gi"
      }
    }
  }
}