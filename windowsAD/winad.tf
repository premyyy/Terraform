provider "ad" {
    winrm_hostname = "server.tera.com"
    winrm_username = "Administrator"
    winrm_password = "admin@1"
}

# organisational unit

resource "ad_ou" "Teraou" {
    name = "Teraou"
    path = "dc=tera,dc=com"
    description = "Created by terraform"
    protected = false
}

# group 

resource "ad_group" "tg" {
    name = "TerraformGroup"
    sam_account_name = "TerraformGroup"
    category = "security"
    container = ad_ou.Teraou.dn
}

# user 

resource "ad_user" "user" {
    principal_name  = "tUser"
    sam_account_name = "tUser"
    display_name = "Terraform TUser"
    container = ad_ou.Teraou.dn
    initial_password = "Password@12345"
    password_never_expires = true
}

