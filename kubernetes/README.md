# Desafio 02: Kubernetes

## Motivação

Kubernetes atualmente é a principal ferramenta de orquestração e _deployment_ de _containers_ utilizado no mundo, práticamente tornando-se um padrão para abstração de recursos de infraestrutura. 

Na IDWall todos nossos serviços são containerizados e distribuídos em _clusters_ para cada ambiente, sendo assim é importante que as aplicações sejam adaptáveis para cada ambiente e haja controle via código dos recursos kubernetes através de seus manifestos. 

## Objetivo
Dentro deste repositório existe um subdiretório **app** e um **Dockerfile** que constrói essa imagem, seu objetivo é:

- Construir a imagem docker da aplicação
- Criar os manifestos de recursos kubernetes para rodar a aplicação (_deployments, services, ingresses, configmap_ e qualquer outro que você considere necessário)
- Criar um _script_ para a execução do _deploy_ em uma única execução.
- A aplicação deve ter seu _deploy_ realizado com uma única linha de comando em um cluster kubernetes **local**
- Todos os _pods_ devem estar rodando
- A aplicação deve responder à uma URL específica configurada no _ingress_


## Extras 
- Utilizar Helm [HELM](https://helm.sh)
- Divisão de recursos por _namespaces_
- Utilização de _health check_ na aplicação
- Fazer com que a aplicação exiba seu nome ao invés de **"Olá, candidato!"**

## Notas

* Pode se utilizar o [Minikube](https://github.com/kubernetes/minikube) ou [Docker for Mac/Windows](https://docs.docker.com/docker-for-mac/) para execução do desafio e realização de testes.

* A aplicação sobe por _default_ utilizando a porta **3000** e utiliza uma variável de ambiente **$NAME**

* Não é necessário realizar o _upload_ da imagem Docker para um registro público, você pode construir a imagem localmente e utilizá-la diretamente.

# Everton Arakaki - solução

Meus caros, eu não perdi tempo arrumando meu cluster local. Sinto muito. Meu PC em casa só serve pra jogar League of Legends, Counter Strike e Google Cloud Platform.
Todo o meu trabalho hoje está na Cloud e eu sou usuário do Google Cloud Shell. Resolvi esse desafio usando GKE com uma instancia xulinha.

Mas a chart está flexivel para trabalhar com um ingress de minikube, é só alterar o `values.yaml`.

Também fiz mais uma coisa que vocês recomendaram não fazer:  _upload_ da imagem Docker para um registro público. Eu achei necessário pois implementei um endpoint burrão para o livenessProbe e readnessProbe. Em ambientes de produção meus livenessProbe/readnessProbe são muito mais eficientes rsrs, mas esse da para o gasto. 

Para subir em um cluster GKE com nginx ingress já configurado no default namespace:
```
helm install ./appchart
```

ai é so acessar o Ip do seu ingress controller /app  e ver o `Olá Everton!`

Para subir a app no seu minikube: (espero que funcione rsrs)
```
DOMAIN="seudominio.local"
helm install \
  --set displayName=Everton \
  --set ingress.enabled=true \
  --set hosts[0].host=${DOMAIN} \
  --set hosts[0].paths={"/app"} \
  ./appchart
```

Aproveito o espaço para que vocês me deem uma tempo para eu mostrar um projeto que venho trabahando a um tempo. Um bootstrapper de cluster de GKE com log, mon, e cid + Istio. Ficou bem legal e queria ter a chance de compartilhar meus conhecimentos com alguém que entenda de GCP e possa me dar umas dicas de onde posso melhorar. 

Gostaria de aprimorar esse desafio ao máximo, mas a semana vai começar e não vou ter tempo devido a atividades na firma atual.

Espero que gostem!


