variable "region" {
  default     = "us-east-1"
  description = "AWS region"
}

variable "worker1_instance_type" {
  default     = "t2.medium"
  description = "Instance types for worker group 1"
}

variable "worker1_desired_capacity" {
  default     = 2
  description = "Instance types for worker group 1"
}

variable "worker2_instance_type" {
  default     = "t2.medium"
  description = "Instance types for worker group 2"
}

variable "worker2_desired_capacity" {
  default     = 3
  description = "Instance types for worker group 1"
}

variable "k8_cluster_name" {
  default     = "Ben_k8s2"
  description = "K8 cluster name"
}

variable "k8_vpc_name" {
  default     = "Ben_k8s_vpc2"
  description = "K8 cluster name"
}
