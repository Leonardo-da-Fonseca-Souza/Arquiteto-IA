# 1. Configuração do ambiente:
#	Atualizar o PATH e instalar o ADK:
sudo python3 -m pip install google-adk==1.2.1

# 	Copiar e descompactar os exemplos de código do Cloud Storage:
gcloud storage cp gs://qwiklabs-gcp-01-1346316c9a90-bucket/adk_tools.zip .
unzip adk_tools.zip

# 	Instalar dependências adicionais:
sudo python3 -m pip install -r adk_tools/requirements.txt

# 2. Configuração do ambiente no diretório adk_tools:
cd ~/adk_tools

# 3. Criar arquivo .env (exemplo para langchain_tool_agent):
cd ~/adk_tools
cat << EOF > langchain_tool_agent/.env
GOOGLE_GENAI_USE_VERTEXAI=TRUE
GOOGLE_CLOUD_PROJECT=SEU_ID_DO_PROJETO_GCP
GOOGLE_CLOUD_LOCATION=us-central1
MODEL=gemini-2.0-flash-001
EOF

# Substitua SEU_ID_DO_PROJETO_GCP pelo ID do seu projeto GCP.

# 4. Copiar .env para outros diretórios de agentes
```bash
cp langchain_tool_agent/.env crewai_tool_agent/.env
cp langchain_tool_agent/.env function_tool_agent/.env
cp langchain_tool_agent/.env vertexai_search_tool_agent/.env
```
# 5. Executar a Dev UI do ADK:
# 	Navegar até o diretório do projeto (exemplo):
cd ~/adk_tools

# 	Iniciar o servidor web do ADK:
adk web

# 	Se a porta 8000 estiver em uso, use uma porta diferente:
# 	adk web --port 8001

# 6. Executar agente diretamente (linha de comando):
adk run crewai_tool_agent

# 7. Visualizar o poema do arquivo
```bash
cat crew_poem.txt
```

# 8. Rastrear o arquivo de log.
```bash
tail -F /tmp/agents_log/agent.latest.log
```

# 9. Parar o servidor ADK:
# Pressione `CTRL + C` no Terminal do Cloud Shell.
