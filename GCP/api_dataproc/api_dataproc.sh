# Aqui estão os comandos Bash e as instruções relevantes para o Cloud Shell, organizados para facilitar a implementação eficaz com o Dataproc:

#  1. Configuração Inicial (no Cloud Shell):
# Definir a região do Dataproc:

gcloud config set dataproc/region Region

Substitua "Region" pela região desejada (ex: us-central1).

# Obter PROJECT_ID e PROJECT_NUMBER:

PROJECT_ID=$(gcloud config get-value project) && \
gcloud config set project $PROJECT_ID
	
PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format='value(projectNumber)')

# Conceder papel de Administrador de armazenamento à conta de serviço padrão:

# Ativar Acesso privado do Google na sub-rede padrão:
gcloud compute networks subnets update default --region=REGION  --enable-private-ip-google-access

Substitua "REGION" pela região do seu projeto.

# 2. Criação do Cluster Dataproc:
# Criar o cluster "example-cluster":

gcloud dataproc clusters create example-cluster \
    --region=us-east1 \
    --master-machine-type=e2-standard-2 \
    --master-boot-disk-size=100 \
    --num-workers=2 \
    --worker-machine-type=e2-standard-2 \
    --worker-boot-disk-size=100 \
    --image-version=2.1-debian11 \
    --master-boot-disk-type=pd-standard \
    --worker-boot-disk-type=pd-standard

# example-cluster: Nome do cluster. Escolha um nome apropriado.
# --worker-boot-disk-size 100: Tamanho do disco de boot dos workers (em GB).

# 3. Envio de Job Spark:
# Submeter um job Spark de exemplo para calcular Pi:

gcloud dataproc jobs submit spark --cluster example-cluster \
  --class org.apache.spark.examples.SparkPi \
  --jars file:///usr/lib/spark/examples/jars/spark-examples.jar -- 1000

o	example-cluster: Nome do cluster para o qual o job será submetido.
o	--class org.apache.spark.examples.SparkPi: Classe principal do job Spark.

# 4. Atualização do Cluster (Redimensionamento):
# Aumentar o número de workers para 4:

gcloud dataproc clusters update example-cluster --num-workers 4

# Diminuir o número de workers para 2:

gcloud dataproc clusters update example-cluster --num-workers 2

# Esses comandos devem fornecer uma base sólida para criar, executar jobs e gerenciar clusters Dataproc usando o Cloud Shell. Lembre-se de adaptar os valores de acordo com as suas necessidades específicas.