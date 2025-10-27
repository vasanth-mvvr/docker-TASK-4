provider "docker" {}
resource "docker_image" "nginx" {
    name = "nginx:latest"
}

resource "docker_container" "name" {
  name = "nginx-container"
  image = var.nginx_image
  ports {
    internal = 80
    external = 8080
  }
}

