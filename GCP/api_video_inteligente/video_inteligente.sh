# Configuração da API Google Cloud Video Intelligence

# Visão Geral:
# Este projeto irá guiá-lo na utilização da API Google Cloud Video Intelligence para analisar um vídeo armazenado no Google Cloud Storage (GCS). Usaremos uma conta de serviço para autenticação, o arquivo de solicitação JSON está nesta pasta do GitHub e deve ser clonado para sua pasto do projeto no GCP, enviaremos a solicitação à API e monitoraremos o progresso da operação.

# Pré-requisitos:
# Uma conta no Google Cloud Platform (GCP) com um projeto criado.
# A API Cloud Video Intelligence habilitada no seu projeto.
# O Google Cloud SDK (gcloud) instalado e configurado no Cloud Shell ou na sua máquina virtual.
# Um vídeo armazenado em um bucket do Google Cloud Storage (GCS). No exemplo, usa-se gs://spls/gsp154/video/train.mp4, mas você pode substituí-lo pelo seu vídeo.

# Passo 1: Configuração do Ambiente (Cloud Shell ou Máquina Virtual)
# 1.	Acessar o Cloud Shell ou Conectar-se à sua Máquina Virtual:
# o	Cloud Shell: Abra o Cloud Shell diretamente no console do Google Cloud. Ele já vem com o gcloud e outras ferramentas pré-instaladas.
# o	Máquina Virtual: Conecte-se à sua instância Linux usando SSH.
# 2.	Autenticação com o Google Cloud SDK (gcloud):
# o	Se você estiver usando o Cloud Shell, ele geralmente já está autenticado com sua conta do Google. Verifique com:
gcloud auth list

# o	Se você estiver usando uma máquina virtual, pode ser necessário autenticar explicitamente:
gcloud auth login

# Isso abrirá um navegador para que você faça login na sua conta do Google e conceda permissões ao gcloud.
# 3.	Configurar o Projeto Padrão (IMPORTANTE):
# Defina o projeto padrão para que o gcloud saiba qual projeto usar:

gcloud config set project <seu-projeto-id>

# Substitua <seu-projeto-id> pelo ID do seu projeto no Google Cloud. Você pode encontrar o ID do projeto no painel do Google Cloud Console.

# Passo 2: Criar e Configurar uma Conta de Serviço
# 1.	Criar a Conta de Serviço:

# 2.	Criar um Arquivo de Chave da Conta de Serviço:
# 3.	Definir a Variável de Ambiente GOOGLE_APPLICATION_CREDENTIALS (OPCIONAL, MAS RECOMENDADO para VMs):

# Passo 3: Obter um Token de Acesso
# 1.	Autenticar a Conta de Serviço:
# 2.	Imprimir o Token de Acesso:

# Passo 4: Criar o Arquivo de Solicitação JSON
# 1.	Clonar o arquivo request.json

# Passo 5: Enviar a Solicitação à API Video Intelligence
# 1.	Executar o Comando curl:
curl -X POST \
    -H "Authorization: Bearer $(gcloud auth print-access-token)" \
    -H "Content-Type: application/json" \
    https://videointelligence.googleapis.com/v1/videos:annotate \
    -d @request.json

# o	-X POST: Especifica que estamos enviando uma solicitação POST.
# 2.	Analisar a Resposta:
# A resposta será um JSON que contém informações sobre a operação em andamento

#  Passo 6: Monitorar o Progresso da Operação
# 1.	Executar o Comando curl para Obter Informações sobre a Operação:

curl -s -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer '$(gcloud auth print-access-token)'' \
    'https://videointelligence.googleapis.com/v1/projects/<seu-projeto-id>/locations/us-central1/operations/<operation-id>'

# Substitua:
# o	<seu-projeto-id> pelo ID do seu projeto no Google Cloud.
# o	<operation-id> pelo ID da operação que você copiou da resposta do passo anterior. O ID da operação é a parte após operations/ no campo name.

# Passo 7: Interpretar os Resultados
# A estrutura dos resultados JSON depende das features que você solicitou. 

# Limpeza (Opcional, mas recomendado):
# •	Excluir a Conta de Serviço (se não for mais necessária):
# •	Excluir o Arquivo de Chave key.json: