terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token = "<iam-token>" # yc iam create-token  
  cloud_id  = "<cloud-id>"
  folder_id = var.folder-id
  zone      = "ru-central1-a"
}

variable "folder-id" {
  default = "<folder-id>"
}

resource "yandex_mdb_mongodb_cluster" "mongodb-cluster" {
  name        = "test"
  environment = "PRODUCTION" #enviroment - can be PRESTABLE or PRODUCTION
  network_id  = "<your-network-id>"

  cluster_config {
    version = "4.2"
  }

  labels = {
    test_key = "test_value"
  }

  database {
    name = "nursultan-db1"
  }

  user {
    name     = "nursultan"
    password = "<your-password>"
    permission {
      database_name = "nursultan-db1"
    }
  }

  resources {
    resource_preset_id = "b1.nano"
    disk_size          = 16
    disk_type_id       = "network-hdd"
  }

  host {
    zone_id   = "ru-central1-a"
    subnet_id = "<your-subnet-id>"
  }

  maintenance_window {
    type = "ANYTIME"
  }
}
