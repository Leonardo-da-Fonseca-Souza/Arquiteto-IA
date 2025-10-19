# client.py
import requests

# URL do seu endpoint Flask
# Certifique-se de que o app.py esteja rodando para que esta URL funcione
BASE_URL = 'http://127.0.0.1:5000'

def fazer_saudacao(nome=None):
    """
    Função para fazer uma requisição GET ao endpoint /saudacao.
    """
    url = f'{BASE_URL}/saudacao'
    params = {}
    if nome:
        params['nome'] = nome

    print(f"Fazendo requisição para: {url} com parâmetros: {params}")

    try:
        response = requests.get(url, params=params)
        response.raise_for_status()  # Levanta um erro para códigos de status HTTP ruins (4xx ou 5xx)

        data = response.json()
        print("\n--- Resposta do Servidor ---")
        print(f"Status Code: {response.status_code}")
        print(f"Mensagem: {data.get('mensagem')}")
        print("---------------------------\n")

    except requests.exceptions.ConnectionError:
        print(f"Erro: Não foi possível conectar ao servidor em {BASE_URL}.")
        print("Certifique-se de que o 'app.py' esteja rodando.")
    except requests.exceptions.HTTPError as e:
        print(f"Erro HTTP: {e}")
        print(f"Detalhes da resposta: {response.text}")
    except requests.exceptions.RequestException as e:
        print(f"Ocorreu um erro inesperado: {e}")

if __name__ == '__main__':
    # Exemplo 1: Saudação sem nome (usará o padrão 'Visitante')
    print("--- Teste 1: Saudação sem nome ---")
    fazer_saudacao()

    # Exemplo 2: Saudação com um nome específico
    print("--- Teste 2: Saudação com nome 'Maria' ---")
    fazer_saudacao("Maria")

    # Exemplo 3: Saudação com outro nome
    print("--- Teste 3: Saudação com nome 'João' ---")
    fazer_saudacao("João")



