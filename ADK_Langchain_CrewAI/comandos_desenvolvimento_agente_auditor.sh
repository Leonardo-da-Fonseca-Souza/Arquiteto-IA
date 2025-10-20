# 1. Atualizar o PATH e instalar o ADK:
sudo python3 -m pip install google-adk==1.2.1

# 2. Copiar e descompactar o projeto ADK:
gcloud storage cp gs://qwiklabs-gcp-04-d50ed6632476-bucket/adk_project.zip ./adk_project.zip
unzip adk_project.zip

# 3. Instalar requisitos adicionais:
sudo python3 -m pip install -r adk_project/requirements.txt

# 4. Navegar para o diretório do projeto:
cd ~/adk_project

# 5. Iniciar a interface de desenvolvimento do ADK:
adk web

# Para iniciar a interface web numa nova porta
adk web --port 8001

# 6. Navegar para o diretório do agente (exemplo):
cd ~/adk_project/my_google_search_agent
comando para visualizar arquivos ocultos
Exibir > Alternar Arquivos Ocultos

# 7. Executar o agente programaticamente (após configurar as variáveis de ambiente):
export GOOGLE_GENAI_USE_VERTEXAI=TRUE
export GOOGLE_CLOUD_PROJECT=SEU_ID_DO_PROJETO_GCP
export GOOGLE_CLOUD_LOCATION=LOCAL_GCP
export MODEL=gemini-2.0-flash-001
python3 app_agent/agent.py
# 8. Executar o agente via interface de linha de comando:
adk execute meu_agente_de_pesquisa_do_google

# 9.Criar um arquivo .env para este agente e inicie a interface de desenvolvimento novamente executando o seguinte no Terminal do Cloud Shell:
cd ~/projeto_adk
gato << EOF > llm_auditor/.env
GOOGLE_GENAI_USE_VERTEXAI = TRUE 
GOOGLE_CLOUD_PROJECT = SEU_ID_DE_PROJETO_GCP
GOOGLE_CLOUD_LOCATION = MODELO_DE_LOCALIZAÇÃO_GCP
 = gemini-2.0-flash-001
EOF
