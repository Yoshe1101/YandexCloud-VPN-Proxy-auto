
resource "yandex_compute_instance" "vm" {
  name        = var.vmname
  platform_id = "standard-v3"
  zone        = var.zone

  resources {
    cores  = 2
    memory = 4
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
        size = 10
        type = "network-hdd"
        image_id = var.imageid
    }
  }
  network_interface {
    #index  = 1
    subnet_id = var.subnetid
    nat = true
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
  connection {
    type     = "ssh"
    host     = self.network_interface.0.nat_ip_address
    user     = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
  }

  provisioner "file" {
    source      = "./files/docker-compose.yml"
    destination = "docker-compose.yml"
  }
  provisioner "file" {
    source      = "./files/init.sh"
    destination = "init.sh"
  }

  provisioner "file" {
    source      = "./files/.env"
    destination = ".env"
  }
  provisioner "remote-exec" {
    inline = [
      "echo 'Running script...'",
      "bash init.sh"
    ]
  }
}

output "public_ip" {
  value = yandex_compute_instance.vm.network_interface.0.nat_ip_address
}