# Desafio 01: Infrastructure-as-code - Terraform

## Motivação

Recursos de infraestrutura em nubvem devem sempre ser criados utilizando gerenciadores de configuração, tais como [Cloudformation](https://aws.amazon.com/cloudformation/), [Terraform](https://www.terraform.io/) ou [Ansible](https://www.ansible.com/), garantindo que todo recurso possa ser versionado e recriado de forma facilitada.

## Objetivo

- Criar uma instância **n1-standard-1** (GCP) ou **t2.micro** (AWS) Linux utilizando **Terraform**.
- A instância deve ter aberta somente às portas **80** e **443** para todos os endereços
- A porta SSH (**22**) deve estar acessível somente para um _range_ IP definido.
- **Inputs:** A execução do projeto deve aceitar dois parâmetros:
  - O IP ou _range_ necessário para a liberação da porta SSH
  - A região da _cloud_ em que será provisionada a instância
- **Outputs:** A execução deve imprimir o IP público da instância


## Extras

- Pré-instalar o docker na instância que suba automáticamente a imagem do [Apache](https://hub.docker.com/_/httpd/), tornando a página padrão da ferramenta visualizável ao acessar o IP público da instância
- Utilização de módulos do Terraform

## Notas
- Pode se utilizar tanto AWS quanto GCP (Google Cloud), não é preciso executar o teste em ambas, somente uma.
- Todos os recursos devem ser criados utilizando os créditos gratuitos da AWS/GCP.
- Não esquecer de destruir os recursos após criação e testes do desafio para não haver cobranças ou esgotamento dos créditos.

# Everton Arakaki - solução

Essa solução funciona no Google Cloud Shell, a melhor coisa que já inventaram (na cloud) ponto final. 
Use o Google Cloud Shell para rodar os codigos desse repositório.

Nessa mesma pasta se encontra um arquivo `build.sh`.
Ele vai fazer o meio de campo entre GCP, Terraform e o Ansible. Foi necessário um meio de campo pois eu automatizei a criação de uma google cloud service account para criar os recursos necessários na cloud. Essa service account está completamente errada!!! Digo isso pois ela tem permissão demais. Não perca essa chave, não distribua essa chave por favor nunca pedi te nada!!! 

OK, para começar, faça o import de 3 variaveis de ambiente. Essas variaveis vão ser usadas pelo Terraform e pelo GCP CLI para automação:

- PROJECT_ID: Seu GCP Project ID
- REGION: Região onde você vai fazer o deploy dos Recursos
- ZONE: Zona da região onde você vai fazer o deploy dos Recursos eg: a,b,c,d,e,f
- IP_RANGE_ALLOW_SSH: range de ips permitidos acessar sua VM via SSH. Aqui existe um erro meu... Como vou usar Ansible + Terraform, se você colocar somente seu IP, o Google Cloud Shell + Ansible não vai conseguir conectar na sua maquina. Como demonstração, estou liberando pra geral (rs), sugiro que façam o mesmo para evitar varios erros vermelhos de conexão do Ansible...  

```
export PROJECT_ID='sandbox-216902'
export REGION='us-central1'
export ZONE='a'
export IP_RANGE_ALLOW_SSH='"0.0.0.0/0","189.120.77.4/32"'
```

Com as variaveis de ambiente definidas, é hora de buildar:
```
./build.sh
```

To destroy:
```
./destroy.sh
```

Tem um probleminha aqui nesse destroy, eu uso sed para alimentar o Ansible com o output do Terraform. Se buildar de novo, sem clonar o repo novamente, o sed vai falhar.....

É isso!