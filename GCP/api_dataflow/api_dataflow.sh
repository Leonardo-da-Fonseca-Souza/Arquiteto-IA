# Implementação de Pipeline de Dados do Pub/Sub para o BigQuery com Cloud Shell

# Neste projeto, você vai aprender a criar um pipeline de streaming usando um dos modelos do Google para o Dataflow. Você vai usar o modelo Pub/Sub para BigQuery, que lê mensagens em formato JSON de um tópico do Pub/Sub e as grava em uma tabela do BigQuery.

# Pré-requisitos:
# •	Uma conta do Google Cloud Platform (GCP) com um projeto ativo.
# •	Acesso ao Cloud Shell (fornecido pelo GCP).
# •	Conhecimento básico do BigQuery, Cloud Storage e Pub/Sub (opcional, mas recomendado).

# Atividades:

# Passo 1: Acessando o Cloud Shell
# 1.	No console do Google Cloud, clique no ícone do Cloud Shell (localizado na barra superior, geralmente no canto superior direito).
# 2.	Aguarde o Cloud Shell ser provisionado e inicializado. Isso pode levar alguns segundos.

# Passo 2: Configurando o Projeto (Opcional, mas recomendado)
# Se você estiver trabalhando em vários projetos, defina o projeto padrão no Cloud Shell:

gcloud config set project SEU_PROJETO_ID
Substitua SEU_PROJETO_ID pelo ID do seu projeto GCP.

# Tarefa 2: Criar um conjunto de dados e uma tabela do BigQuery, além de um bucket do Cloud Storage usando o Cloud Shell
•	Criar um conjunto de dados do BigQuery:
bq mk taxirides
Explicação: 
# o	bq: invoca a ferramenta de linha de comando do BigQuery.
# o	mk: subcomando para criar um recurso (neste caso, um conjunto de dados).
# o	taxirides: o nome do conjunto de dados que você está criando.

# •	Criar uma tabela do BigQuery:
bq mk \
--time_partitioning_field timestamp \
--schema ride_id:string,point_idx:integer,latitude:float,longitude:float,\
timestamp:timestamp,meter_reading:float,meter_increment:float,ride_status:string,\
passenger_count:integer -t taxirides.realtime

# Explicação: 
# o	bq mk: cria um recurso (neste caso, uma tabela).
# o	--time_partitioning_field timestamp: especifica que a tabela será particionada por tempo usando a coluna timestamp. Isso melhora o desempenho e reduz os custos para consultas que filtram por datas.

# •	Criar um bucket do Cloud Storage:
export BUCKET_NAME=seu-projeto-id
gsutil mb gs://$BUCKET_NAME/

# Substitua "seu-projeto-id" pelo ID real do seu projeto Google Cloud.

# Tarefa 3: Cria o bucket no Cloud Storage.

gsutil mb gs://$BUCKET_NAME/ : 

Tarefa 4: Executar o pipeline (Cloud Shell)

gcloud dataflow jobs run iotflow \
    --gcs-location gs://dataflow-templates-us-east1/latest/PubSub_to_BigQuery \
    --region us-east1 \
    --worker-machine-type e2-medium \
    --staging-location gs://seu-bucket/temp \
    --parameters inputTopic=projects/pubsub-public-data/topics/taxirides-realtime,outputTableSpec=seu-projeto-id:taxirides.realtime

# Importante:
# •	Substitua "seu-bucket" pelo nome do bucket do Cloud Storage que você criou na tarefa anterior.
# •	Substitua "seu-projeto-id" pelo ID do seu projeto Google Cloud.

# Tarefa 5: Enviar uma consulta (BigQuery UI)

# Embora a Tarefa 5 envolva a IU do BigQuery e não o Cloud Shell diretamente, o comando SQL a ser usado é crucial. Adapte a consulta SQL no BigQuery UI para que ela corresponda ao seu projeto:

SELECT * FROM `seu-projeto-id.taxirides.realtime` LIMIT 1000

# Substitua "seu-projeto-id" pelo ID real do seu projeto Google Cloud.

# Exemplo:

SELECT * FROM `qwiklabs-gcp-seu-id.taxirides.realtime` LIMIT 1000
