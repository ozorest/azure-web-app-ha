### PARAMETROS REQUERIDOS ###

variable "project" {
    description = "Projeto usado para nomear os recursos"
}

variable "admin_password" {
    description = "Senha do usuário para acesso as máquinas"
}

### PARAMETROS OPCIONAIS ###

variable "location" {
    default = "brazilsouth"
    description = "Região da Azure aonde serão provisionados os recursos"
}

variable "address_space" {
    type = list(string)
    default = ["10.0.0.0/16"]
    description = "Endereçamento para a rede virtual"
}

variable "backend_address_prefixes" {
    type = list(string)
    default = ["10.0.2.0/24"]
    description = "Endereçamento da subnet para o backend"
}

variable "frontend_address_prefixes" {
    type = list(string)
    default = ["10.0.1.0/24"]
    description = "Endereçamento da subnet para o frontend"
}

variable "nodes" {
    type = number
    default = 3
    description = "Quantidade de servidores para provisionar"
}

variable "machine_size" {
    default = "Standard_DS1_v2"
    description = "Determina o tamanho da máquina"
}

variable "image_publisher" {
    default = "Canonical"
    description = "Publisher da imagem do sistema operacional"
}

variable "image_offer" {
    default = "UbuntuServer"
    description = "Offer da imagem do sistema operacional"
}

variable "image_sku" {
    default = "16.04-LTS"
    description = "SKU da imagem do sistema operacional"
}

variable "image_version" {
    default = "latest"
    description = "Versão da imagem do sistema operacional"
}

variable "admin_username" {
    default = "admuser"
    description = "Usuário para acesso as máquinas"
}

variable "private_key_path" {
    default = "~/.ssh/id_rsa.pub"
    description = "Chave privada do usuário"
}

variable "cloud_init_path" {
    default = "cloud-init.txt"
    description = "Caminho do cloud-init"
}

