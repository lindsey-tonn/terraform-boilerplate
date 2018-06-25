# terraform-boilerplate
Este projeto tem como proposito provisionar um ambiente em nuvem AWS seguindo os pricipios de IaC utilizando a ferramento [Terraform](https://www.terraform.io/)

# Getting Started

## Pré-requisitos

- Terraform versão >= v0.11.7
- git

Para começar a utilizar o projeto deve-se ter as chaves `AWS_SECRET_KEY` e `AWS_ACCESS_KEY` configuradas com base na sua conta [AWS](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html).

Para iniciar o projeto corretamente deve-se clonar o memso, após isso na pastar raiz executar o comando `terraform init` para dar incio ao planejamento da IaC. Assumindo que o passo anterior esteja concluido, basta executar o comando `terraform apply` que irá executar o plano de contrução.

## Variaveis

Neste projeto possuimos um aquivo de variaveis, localizado na raiz do projeto denominado `varibles.tf` ao qual serve para auxiliar na configuração do ambiente deixando o projeto mais flexivel. Abaixo as variaveis mais communs e suas definições.

- **vpc_cidr** - Range que sera aplicado na VCP, padrão 10.20.0.0/16
- **public_subnet_cidr** - Range da subnet publica, padrão 10.20.0.0/24, lembarando que este deve respeitar o padrão aplicado a variável `vpc_cidr`.
- **private_subnet_cidr** - Range da subnet privada, padrão 10.20.1.0/24, lembarando que este deve respeitar o padrão aplicado a variável `vpc_cidr`.
- **app_image** - repositorio e versão da imagem que será utilizada na configuração do ecs fargate, padrão lindseytonn/app-nginx:1.0.0.
- **app_port** - Porta que será utilizada no redirecionamento e na exposição do container, padrão porta 80.
- **fargate_cpu** - Configuração de cpu do ecs fargate, padrão 256.
- **fargate_memory** - Configuração de memoria do ecs fargate, padrão 512 MiB.