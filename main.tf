terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.25.0"
    }
  }
}

provider "google" {
  # Configuration options


project = "class5-416923"
region = "us-central1"
zone = "us-central1-a"
credentials = "class5-416923-41e01aa0ce3e.json"
}


resource "google_storage_bucket" "macrelbucket" {
  name          = "ilovesolana"
  location      = "us-central1"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 3
    }
    action {
      type = "Delete"
    }
  }

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}



#VPC

resource "google_compute_network" "auto-vpc-tf" {
  name = "auto-vpc-tf"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "sub-sg" {
  name ="sub-sg"
  network = google_compute_network.auto-vpc-tf.id
  ip_cidr_range = "10.50.1.0/24"
  region = "southamerica-west1"
}


#resource "google_compute_network" "custom-vpc-tf" {
  #name = "custom-vpc-tf"
 #auto_create_subnetworks = false
#}

output "auto" {
  value = google_compute_network.auto-vpc-tf.id
}

#output "custom" {
#  value = google_compute_network.custom-vpc-tf.id
#}