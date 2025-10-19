# Esta célula cria o arquivo app.py que contém o código do seu backend Flask.

# app.py
import os
from flask import Flask, request, jsonify

from dotenv import load_dotenv
 
app = Flask(__name__)
 
@app.route('/saudacao', methods=['GET'])
def saudacao():
    """
    Endpoint que retorna uma saudação.
    Aceita um parâmetro 'nome' na URL.
    """
    nome = request.args.get('nome', 'Visitante') # Pega o parâmetro 'nome' da URL, padrão é 'Visitante'
    mensagem = f'Olá, {nome}! Bem-vindo ao meu servidor Flask.'
    return jsonify({'mensagem': mensagem})
 
if __name__ == '__main__':
    # Para rodar o servidor, execute este arquivo: python app.py
    # Ele estará acessível em http://127.0.0.1:5000/
    app.run(debug=True) # Uncommented this line
