# ANÁLISE DE TEXTO COM A API CLOUD NATURAL LANGUAGE

# PARTE 1: CONFIGURAÇÃO INICIAL NO CLOUD SHELL
# Objetivo: Configurar o ambiente do Cloud Shell e criar uma conta de serviço com as credenciais necessárias para acessar a API Cloud Natural Language.

# Passo 1: Abrir o Cloud Shell
# Ação: Acesse o Google Cloud Console (console.cloud.google.com) e clique no ícone "Ativar o Cloud Shell" no canto superior direito da tela.

# Passo 2: Definir a Variável de Ambiente PROJECT_ID
# Ação: Execute o seguinte comando no Cloud Shell:

export GOOGLE_CLOUD_PROJECT=$(gcloud config get-value core/project)
echo $GOOGLE_CLOUD_PROJECT 		#Verifique se o ID do projeto está correto

# Passo 3: Criar uma Conta de Serviço

# Passo 4: Criar uma Chave JSON para a Conta de Serviço

# Passo 5: Definir a Variável de Ambiente GOOGLE_APPLICATION_CREDENTIALS

# PARTE 2: ANÁLISE DE ENTIDADES NA INSTÂNCIA LINUX VIA SSH
# Objetivo: Conectar-se à instância Linux via SSH e usar a API Cloud Natural Language para analisar um texto.

# Passo 1: Conectar-se à Instância Linux via SSH
# Ação: No Google Cloud Console, vá para "Compute Engine" -> "VM instances". Localize a instância Linux que você deseja usar e clique no botão "SSH" ao lado dela. Uma janela de terminal SSH será aberta no seu navegador.

# Passo 2: Copiar o Arquivo de Chave JSON para a Instância Linux
# Ação: Na janela do Cloud Shell, execute o seguinte comando para copiar o arquivo key.json para a instância Linux. Substitua <nome-da-instancia> pelo nome da sua instância:

gcloud compute scp ~/key.json <nome-da-instancia>:/tmp/key.json

# Explicação: Este comando usa o gcloud compute scp para copiar o arquivo de forma segura.

# Passo 3: Definir a Variável de Ambiente GOOGLE_APPLICATION_CREDENTIALS na Instância Linux
# Ação: Dentro da sessão SSH na instância Linux, execute os seguintes comandos:

export GOOGLE_APPLICATION_CREDENTIALS="/tmp/key.json"
echo $GOOGLE_APPLICATION_CREDENTIALS   #Verifique se o caminho está correto

# Passo 4: Executar a Análise de Entidades

# Ação: Dentro da sessão SSH na instância Linux, execute o seguinte comando:
gcloud ml language analyze-entities --content="Michelangelo Caravaggio, Italian painter, is known for 'The Calling of Saint Matthew'." > result.json

# Passo 5: Visualizar os Resultados
gcloud ml language analyze-entities --content="Old Norse texts portray Odin as one-eyed and long-bearded, frequently wielding a spear named Gungnir and wearing a cloak and a broad hat." > result.json

# Passo 6: fazer o upload de arquivos para um bucket do Cloud Storage.
gsutil cp result.json gs://qwiklabs-gcp-04-93387031f1a3-marking/task4-cnl-772.result

