resource "helm_release" "opencart" {
  name = "opencart-helm"
  chart = "opencart"
  repository = "https://charts.bitnami.com/bitnami"
  namespace = "opencart"
  create_namespace = true

//set {
 // name = "opencartHost"
  //value = "benoc.milab.local"
//}
  set {
    name = "opencartUsername"
    value= "admin"
  }
  set {
    name = "opencartPassword"
    value = "password"
  }
  set {
    name = "mariadb\\.auth\\.rootPassword"
    value = "secretpassword"
  }

}