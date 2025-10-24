# Projeto: Integração e Utilização da API Google Cloud Speech-to-Text via Curl em Linux

# Este projeto detalhado fornece as informações necessárias para configurar e utilizar a API Speech-to-Text do Google Cloud a partir de uma instância Linux utilizando o curl. Seguindo estes passos, você poderá enviar requisições para a API, receber as transcrições e integrá-las em suas aplicações.

# Pré-requisitos:
# 1.	Conta Google Cloud: Você precisa de uma conta ativa no Google Cloud Platform (GCP).
# 2.	Projeto Google Cloud: Um projeto GCP com a API Speech-to-Text habilitada.
# 3.	Chave de API: Uma chave de API válida para acessar a API Speech-to-Text.
# 4.	Instância Linux: Uma instância Linux em execução no Google Compute Engine (GCE).
# 5.	Cloud Shell: Acesso ao Cloud Shell para interagir com a instância GCE.

# Passo 1: Acessando a Instância Linux via SSH no Cloud Shell
# 1.	Abra o Cloud Shell: Acesse o console do Google Cloud e clique no ícone do Cloud Shell no canto superior direito.
# 2.	Conecte-se à Instância: Utilize o comando gcloud compute ssh para se conectar à sua instância Linux. Substitua <nome-da-instancia> e <zona> pelos valores corretos.

gcloud compute ssh <nome-da-instancia> --zone=<zona>

# Exemplo:
# gcloud compute ssh linux-instance --zone=us-central1-a

# Este comando abrirá uma sessão SSH dentro do Cloud Shell, permitindo que você execute comandos diretamente na sua instância Linux.
# A partir deste ponto, todos os comandos serão executados DENTRO da sessão SSH para a sua instância Linux.

# Passo 2: Configurar a Chave de API
# 1.	Definir a Variável de Ambiente: Exporte sua chave de API como uma variável de ambiente chamada API_KEY. Substitua <YOUR_API_KEY> pela sua chave de API real.

export API_KEY=<YOUR_API_KEY>

# Importante: Substitua <YOUR_API_KEY> pela sua chave de API real. Você pode obter sua chave de API no console do Google Cloud, na seção "APIs & Serviços" -> "Credenciais".

# 2.	Verificar a Configuração: Para verificar se a variável foi definida corretamente, execute:
echo $API_KEY

# O comando deve retornar sua chave de API.

# Passo 3: Criar o Arquivo de Solicitação (request.json)
# 1.	Clonar o arquivo (request.json) desta pasta para seu projeto noGCP..

# Passo 4: Chamar a API Speech-to-Text com Curl
# 1.	Realizar a Requisição POST: Execute o seguinte comando curl para enviar uma requisição POST para a API Speech-to-Text.

curl -s -X POST -H "Content-Type: application/json" --data-binary @request.json "https://speech.googleapis.com/v1/speech:recognize?key=${API_KEY}"

# o	-s: Modo silencioso. Suprime a saída de progresso.
o	-X POST: Especifica o método HTTP POST.

Passo 5. Enviar a Solicitação para a API Speech-to-Text
#Você usará o comando curl (fornecido no texto_02) para enviar a solicitação. Este comando lê o arquivo request.json e salva a resposta da API (que contém a transcrição) em um novo arquivo chamado result.json.

# Certifique-se de que a variável de ambiente API_KEY está configurada
# Exemplo: export API_KEY="SUA_CHAVE_DE_API"

curl -s -X POST -H "Content-Type: application/json" \
--data-binary @request.json \
"https://speech.googleapis.com/v1/speech:recognize?key=${API_KEY}" > result.json


# Passo 6. Carregar o Resultado para o Cloud Storage
# Após a execução bem-sucedida do comando acima, o arquivo result.json conterá a transcrição.
# Comando para carregar o arquivo de resultado (result.json) para o destino do GCS.

gsutil cp result.json gs://qwiklabs-gcp-02-99ae0a2882e0-marking/task3-gcs-999.result