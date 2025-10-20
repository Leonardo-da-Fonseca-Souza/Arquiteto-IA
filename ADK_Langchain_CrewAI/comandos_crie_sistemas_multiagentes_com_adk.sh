# Caminho para o diretório de trabalho
cd ~/

# Instalação do Google ADK (Agent Development Kit) com versão especifica
sudo python3 -m pip install google-adk==1.4.2

# Copia e descompacta o código do laboratório
gcloud storage cp gs://qwiklabs-gcp-04-a8a3ea76a6bb-bucket/adk_multiagent_systems.zip .
unzip adk_multiagent_systems.zip

# Instala dependências adicionais do laboratório
sudo python3 -m pip install -r adk_multiagent_systems/requirements.txt

# Cria e preenche o arquivo .env com variáveis de ambiente no diretório parent_and_subagents
cd ~/adk_multiagent_systems
cat << EOF > parent_and_subagents/.env
GOOGLE_GENAI_USE_VERTEXAI=TRUE
GOOGLE_CLOUD_PROJECT=qwiklabs-gcp-04-a8a3ea76a6bb
GOOGLE_CLOUD_LOCATION=us-central1
MODEL=gemini-2.0-flash-001
EOF

# Copia o arquivo .env para o diretório workflow_agents
cp parent_and_subagents/.env workflow_agents/.env

# Executa o ADK no modo interativo (CLI) no diretório parent_and_subagents
adk run parent_and_subagents

# Inicia a interface web do ADK
adk web

# Inicia a interface web do ADK em outra porta caso a 8000 esteja ocupada
adk web --port 8001
