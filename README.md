# DevOps: AWS com Terraform Automatizando sua infraestrutura

Arquivos do curso de Terraform publicado na Udemy [https://www.udemy.com/aws-com-terraform](https://www.udemy.com/course/aws-com-terraform/?referralCode=05BE0FCDD1140543679C)

![Terraform-0-11](https://img.shields.io/badge/terraform-0.11-blueviolet?style=flat-square)
![Terraform-0-12](https://img.shields.io/badge/terraform-0.12-blueviolet?style=flat-square)
![aws s3](https://img.shields.io/badge/aws-s3-red?style=flat-square)
![aws ec2](https://img.shields.io/badge/aws-ec2-green?style=flat-square)
![aws lambda](https://img.shields.io/badge/aws-lambda-orange?style=flat-square)
![aws ecs](https://img.shields.io/badge/aws-ecs--fargate-orange?style=flat-square)

![Capa do curso](cover.png "Capa do curso")

# Índice

### Introdução
1. [Introdução ao curso](https://www.udemy.com/course/aws-com-terraform/learn/lecture/12122156#overview)
2. [O que é Terraform?](https://www.udemy.com/course/aws-com-terraform/learn/lecture/12168766#overview)
3. [Como pedir ajuda](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13641966#overview)
4. [Código fonte do curso](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13834272#overview)

### Instalação
1. [Instalação da versão mais recente do Terraform](https://www.udemy.com/course/aws-com-terraform/learn/lecture/12122188#overview)
2. [Instalação da versão específica do Terraform utilizada no curso](https://www.udemy.com/course/aws-com-terraform/learn/lecture/14955968#overview)
3. [Editor de teto](https://www.udemy.com/course/aws-com-terraform/learn/lecture/12122200#overview)

### Configuração da conta na AWS
1. [Criando uma conta Free Tier e setando alarme de billing](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13641896#overview)
2. [Criar usuário para ser usado pelo Terraform](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13641898#overview)
3. [Instalando e configurando o AWS CLI](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13641900#overview)

### Terraform básico
1. [Primeiro script](https://www.udemy.com/course/aws-com-terraform/learn/lecture/12123040#overview)
2. [Alterando e destruindo](https://www.udemy.com/course/aws-com-terraform/learn/lecture/12168828#overview)
3. [Interpolação](https://www.udemy.com/course/aws-com-terraform/learn/lecture/12168832#overview)
4. [terraform taint](https://www.udemy.com/course/aws-com-terraform/learn/lecture/12168834#overview)
5. [terraform console e terraform output](https://www.udemy.com/course/aws-com-terraform/learn/lecture/12168836#overview)
6. [Variáveis](https://www.udemy.com/course/aws-com-terraform/learn/lecture/12168844#overview)
7. [AWS CLI](https://www.udemy.com/course/aws-com-terraform/learn/lecture/12168846#overview)
8. [Módulos](https://www.udemy.com/course/aws-com-terraform/learn/lecture/12168850#overview)
9. [terraform fmt, get, import e graph](https://www.udemy.com/course/aws-com-terraform/learn/lecture/12168852#overview)
10. [Remote state](https://www.udemy.com/course/aws-com-terraform/learn/lecture/12168854#overview)
11. [Data source e locals](https://www.udemy.com/course/aws-com-terraform/learn/lecture/12168856#overview)
12. [Provisioners](https://www.udemy.com/course/aws-com-terraform/learn/lecture/12168858#overview)
13. [Built-in functions](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13718546#overview)
14. [Workspaces e remote state locking](https://www.udemy.com/course/aws-com-terraform/learn/lecture/14209860#overview)

### Criando um site estático no S3
1. [Introdução](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13641970#overview)
2. [Registrando um domínio](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13688582#overview)
3. [Criando nossos buckets](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13641980#overview)
4. [Criando nossa aplicação utilizando React.js](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13641984#overview)
5. [Configurando um domínio personalizado](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13641988#overview)
6. [Configurando CDN](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13641990#overview)
7. [Configurando SSL](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13641992#overview)

### Criando uma aplicação auto escalável
1. [Introdução](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13641996#overview)
2. [VPC](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13641998#overview)
3. [Internet gateway (IGW)](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13642000#overview)
4. [Subnets](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13642002#overview)
5. [Route tables](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13642004#overview)
6. [Security groups](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13642006#overview)
7. [Load balancer](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13642008#overview)
8. [Auto scalling group](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13642010#overview)
9. [Cloudwatch alarms](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13718558#overview)
10. [RDS e EC2 em subnets privadas](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13642014#overview)
11. [Testando o auto scalling group](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13718564#overview)
12. [Destruindo](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13794560#overview)

### Criando uma aplicação serverless
1. [Introdução](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13642016#overview)
2. [Cognito](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13642018#overview)
3. [DynamoDB](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13642020#overview)
4. [Lambdas](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13642022#overview)
5. [API Gateway](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13642024#overview)
6. [Bucket](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13642026#overview)
7. [SNS](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13642028#overview)
8. [Testando o fluxo completo da aplicação](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13642038#overview)
9. [Destruindo](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13642042#overview)

### Terraform 0.12
1. [Instalação](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13642044#overview)
2. [First-class expressions e mensagens de erros](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13642048#overview)
3. [For expressions](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13642052#overview)
4. [Rich types](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13642054#overview)
5. [Refazendo nosso site estático com a versão 0.12](https://www.udemy.com/course/aws-com-terraform/learn/lecture/13642056#overview)

### Terraform Cloud com AWS ECS Fargate automatizado com shell script
1. [O que é Terraform Cloud?](https://www.udemy.com/course/aws-com-terraform/learn/lecture/15722454#overview)
2. [Configurando o Terraform Cloud](https://www.udemy.com/course/aws-com-terraform/learn/lecture/15722456#overview)
3. [O que é AWS Fargate](https://www.udemy.com/course/aws-com-terraform/learn/lecture/15758378#overview)
4. [Configuração Webstorm](https://www.udemy.com/course/aws-com-terraform/learn/lecture/15722460#overview)
5. [Codificando nossa aplicação back-end](https://www.udemy.com/course/aws-com-terraform/learn/lecture/15722462#overview)
6. [Dockerfile, rodando nossa aplicação no docker](https://www.udemy.com/course/aws-com-terraform/learn/lecture/15758348#overview)
7. [AWS ECR](https://www.udemy.com/course/aws-com-terraform/learn/lecture/15758354#overview)
8. [AWS ECS Cluster](https://www.udemy.com/course/aws-com-terraform/learn/lecture/15758358#overview)
9. [AWS ECS Task](https://www.udemy.com/course/aws-com-terraform/learn/lecture/15758362#overview)
10. [AWS ECS Service](https://www.udemy.com/course/aws-com-terraform/learn/lecture/15758366#overview)
11. [AWS ECS Fargate rodando](https://www.udemy.com/course/aws-com-terraform/learn/lecture/15758368#overview)
12. [AWS ECS Auto scalling](https://www.udemy.com/course/aws-com-terraform/learn/lecture/15758372#overview)
13. [Automatizando o deploy](https://www.udemy.com/course/aws-com-terraform/learn/lecture/15758374#overview)

# Cupom

Se você tem interesse em aprender Terraform, pegue este cupom e aproveite 🚀(https://www.udemy.com/course/aws-com-terraform/?referralCode=05BE0FCDD1140543679C). São 6,5 horas de muita informação e aulas práticas!
