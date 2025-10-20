# Comandos Bash

#  1.	Verificar autenticação e projeto:

gcloud auth list
gcloud config list project

#  Propósito: Estes comandos são as primeiras ações recomendadas após ativar o Cloud Shell, para verificar a conta de usuário logada e o projeto GCP configurado.

# 2.	Atribuir papel de Worker do Composer à conta de serviço do Compute:

export PROJECT_ID=$(gcloud config get-value project)
export PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format="value(projectNumber)")
gcloud projects add-iam-policy-binding  \
--member=serviceAccount:$PROJECT_NUMBER-compute@developer.gserviceaccount.com \
--role=roles/composer.worker

# Propósito: Definir variáveis de ambiente para o ID e número do projeto e, em seguida, conceder a permissão necessária (roles/composer.worker) à conta de serviço padrão do Compute Engine, que é utilizada pelo Composer para diversas operações.

# 3.	Desativar e Ativar APIs:
gcloud services disable composer.googleapis.com
gcloud services disable artifactregistry.googleapis.com
gcloud services disable container.googleapis.com

gcloud services enable artifactregistry.googleapis.com
gcloud services enable container.googleapis.com
gcloud services enable composer.googleapis.com

#  Propósito: Garantir que as APIs de serviços como Composer, Artifact Registry e Container Registry (GKE) estejam em um estado conhecido (desativadas e depois reativadas) para evitar problemas de dependência ou ativação.

#  4.	Fazer upload do DAG para o Cloud Storage:
gcloud storage cp gs://cloud-training/datawarehousing/lab_assets/hadoop_tutorial.py <DAGs_folder_path>

# Propósito: Este comando é um modelo para copiar o arquivo Python do DAG (hadoop_tutorial.py) de um bucket de treinamento para o bucket do Cloud Storage associado ao ambiente do Cloud Composer, na pasta específica para DAGs. O placeholder <DAGs_folder_path> deve ser substituído pelo caminho real.
gcloud storage cp gs://cloud-training/datawarehousing/lab_assets/hadoop_tutorial.py gs://REGION-highcpu-0682d8c0-bucket/dags
