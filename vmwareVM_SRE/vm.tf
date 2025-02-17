data "vsphere_datacenter" "dc" {
  name = "ACI2-Lab"
}

data "vsphere_datastore" "datastore" {
  name          = "ACI2-Lab"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = "HX-Cluster"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "2101"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = "CentOS7-Template"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = var.vm_name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = 2
  memory   = 1024
  guest_id = data.vsphere_virtual_machine.template.guest_id

    network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
  }
disk {
    label            = "disk0"
    size             = "100"
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    
    customize {
      linux_options {
        host_name = "terraform-test"
        domain    = "test.internal"
        time_zone = "America/Chicago"
      }

      network_interface {
        ipv4_address = "10.21.1.100"
        ipv4_netmask = 24
      }

      ipv4_gateway = "10.21.1.1"
    }
  }
}
