provider "docker" {}
resource "docker_image" "nginx" {
    name = var.nginx_name
}

resource "docker_container" "nginx" {
  name = "nginx-container"
  image = local.nginx_image
  ports {
    internal = 80
    external = 8080
  }
}

