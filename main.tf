provider "docker" {}
resource "docker_image" "nginx" {
    name = "nginx:latest"
}

resource "docker_container" "name" {
  name = "nginx-container"
  image = docker_image.nginx.name
  ports {
    internal = 80
    external = 8080
  }
}

