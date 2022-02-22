provider "intersight" {
  apikey        = var.apikey
  secretkey     = var.secretkey
  endpoint      = var.endpoint
}

data "intersight_kubernetes_cluster" "KXV-CL1" {
  name = "KXV-CL1"
}

provider "kubernetes" {

  host                   = yamldecode(base64decode(data.intersight_kubernetes_cluster.KXV-CL1.results.0.kube_config)).clusters.0.cluster.server
  cluster_ca_certificate = base64decode(yamldecode(base64decode(data.intersight_kubernetes_cluster.KXV-CL1.results.0.kube_config)).clusters.0.cluster.certificate-authority-data)
  client_certificate     = base64decode(yamldecode(base64decode(data.intersight_kubernetes_cluster.KXV-CL1.results.0.kube_config)).users[0].user.client-certificate-data)
  client_key             = base64decode(yamldecode(base64decode(data.intersight_kubernetes_cluster.KXV-CL1.results.0.kube_config)).users[0].user.client-key-data)
}

provider "helm" {
  experiments {
    manifest = true
  }
  kubernetes {
    host                   = yamldecode(base64decode(data.intersight_kubernetes_cluster.KXV-CL1.results.0.kube_config)).clusters.0.cluster.server
    cluster_ca_certificate = base64decode(yamldecode(base64decode(data.intersight_kubernetes_cluster.KXV-CL1.results.0.kube_config)).clusters.0.cluster.certificate-authority-data)
    client_certificate     = base64decode(yamldecode(base64decode(data.intersight_kubernetes_cluster.KXV-CL1.results.0.kube_config)).users[0].user.client-certificate-data)
    client_key             = base64decode(yamldecode(base64decode(data.intersight_kubernetes_cluster.KXV-CL1.results.0.kube_config)).users[0].user.client-key-data)
  }
}