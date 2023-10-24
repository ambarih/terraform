# resource "kubernetes_namespace" "example_namespace" {
#   metadata {
#     name = "example-namespace"
#   }
# }

# resource "kubernetes_pod" "example_pod_1" {
#   metadata {
#     name      = "frontend"
#     namespace = kubernetes_namespace.example_namespace.metadata[0].name
#   }



#   spec {
#     container {
#       image = "nginx:latest"
#       name  = "container-1"
#       port {
#         container_port = 80
#       }
#     }
#   }
# }



# resource "kubernetes_pod" "example_pod_2" {
#   metadata {
#     name      = "usermanagement"
#     namespace = kubernetes_namespace.example_namespace.metadata[0].name
#   }



#   spec {
#     container {
#       image = "redis:latest"
#       name  = "container-2"
#       port {
#         container_port = 6379
#       }
#     }
#   }
# }



# resource "kubernetes_pod" "example_pod_3" {
#   metadata {
#     name      = "qa"
#     namespace = kubernetes_namespace.example_namespace.metadata[0].name
#   }



#   spec {
#     container {
#       image = "mysql:latest"
#       name  = "container-3"
#       port {
#         container_port = 3306
#       }
#     }
#   }
# }
