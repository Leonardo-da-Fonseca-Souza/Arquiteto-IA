# Configuração Inicial (Cloud Shell)

# 1 Definir Variáveis de Ambiente:
REGION="sua-regiao"   			# Ex: us-central1
ZONE="sua-zona"       			# Ex: us-central1-a
BUCKET_NAME="nome-do-bucket" 		# Ex: team-lembrancas-bucket
TOPIC_NAME="nome-do-topico"   		# Ex: team-lembrancas-topic
CLOUD_RUN_FUNCTION_NAME="nome-da-funcao-cloud-run" # Ex: team-lembrancas-thumbnail

# É crucial definir essas variáveis no início para evitar erros nos comandos subsequentes.

# 2 Criar um Bucket (Cloud Shell)
gsutil mb -l $REGION -p $(gcloud config get-value project) gs://$BUCKET_NAME

# 3 Criar um Tópico do Pub/Sub (Cloud Shell)
gcloud pubsub topics create $TOPIC_NAME --project=$(gcloud config get-value project)

# 4 Criar a Função do Cloud Run (Cloud Shell/Instância Linux - Edição de Arquivos)
# Criar uma pasta local para a função:

mkdir $CLOUD_RUN_FUNCTION_NAME
cd $CLOUD_RUN_FUNCTION_NAME

# Clonar os arquivos index.js e package.json para a pasta criada no passo anterior.

# 5 Instalar as dependências (Cloud Shell)
npm install

# 6 Implantar a função do Cloud Run (Cloud Shell)

gcloud functions deploy $CLOUD_RUN_FUNCTION_NAME \
--gen2 \
--runtime=nodejs22 \
--trigger-resource=$BUCKET_NAME \
--trigger-event=google.cloud.storage.object.v1.finalized \
--entry-point=$CLOUD_RUN_FUNCTION_NAME \
--region=$REGION \
--project=$(gcloud config get-value project)



