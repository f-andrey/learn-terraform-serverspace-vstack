#Example Terraform for [provider Serverspace](https://registry.terraform.io/providers/itglobalcom/serverspace/latest)

## Prerequest

* Get API key inside Automation section Settings.
* Terraform

## Use

```
ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519_terr -C "terraform@test"
terraform init
terraform validate
terraform plan
terraform apply
terraform destroy
```

# Infrastructure

For example this infrastructure contain
* FreeBSD-13.0 vm [vStack cloud](https://serverspace.io/services/cloud-servers/)
  * public interface \(real IP after apply\), 50Mb limit
  * private interface, with out limit
  * system disk 30G
  * external disk 30G
* Isolated network

# Links

* base on https://github.com/itglobalcom/terraform-provider-serverspace/tree/master/examples
