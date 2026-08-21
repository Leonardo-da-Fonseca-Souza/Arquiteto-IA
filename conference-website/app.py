import datetime
from flask import Flask, render_template, jsonify, request

app = Flask(__name__)

# Configurações do Evento
EVENT_INFO = {
    "name": "Google Cloud Summit 2026",
    "location": "Google Cloud Tech Center, São Paulo & Transmissão Online",
    "date": datetime.datetime.now().strftime("%d de %B de %Y")
}

# Tradução de meses para Português
MONTHS_PT = {
    "January": "Janeiro", "February": "Fevereiro", "March": "Março", "April": "Abril",
    "May": "Maio", "June": "Junho", "July": "Julho", "August": "Agosto",
    "September": "Setembro", "October": "Outubro", "November": "Novembro", "December": "Dezembro"
}

def get_formatted_date():
    now = datetime.datetime.now()
    month_en = now.strftime("%B")
    month_pt = MONTHS_PT.get(month_en, month_en)
    return now.strftime(f"%d de {month_pt} de %Y")

# Banco de dados fictício de Palestras e Cronograma
TALKS_DATABASE = [
    {
        "id": 1,
        "title": "Introdução ao Google Cloud: Primeiros Passos e Arquitetura Global",
        "category_id": 1,
        "category_name": "Cloud & Infra",
        "description": "Uma visão geral detalhada sobre a infraestrutura global do Google Cloud. Entenda como as regiões, zonas de disponibilidade e a rede privada de fibra óptica de alta performance do Google garantem resiliência e baixa latência para suas aplicações.",
        "time": "09:00 - 09:45",
        "speakers": [
            {
                "first_name": "Amanda",
                "last_name": "Silva",
                "linkedin": "https://www.linkedin.com/in/amanda-silva-gcp"
            },
            {
                "first_name": "Bruno",
                "last_name": "Santos",
                "linkedin": "https://www.linkedin.com/in/bruno-santos-gcp"
            }
        ]
    },
    {
        "id": 2,
        "title": "Modernizando Aplicações com Cloud Run e Serverless",
        "category_id": 1,
        "category_name": "Cloud & Infra",
        "description": "Descubra como construir e implantar contêineres altamente escaláveis de forma totalmente gerenciada e com cobrança por milissegundo de uso no Cloud Run, simplificando a jornada serverless.",
        "time": "09:45 - 10:30",
        "speakers": [
            {
                "first_name": "Carlos",
                "last_name": "Oliveira",
                "linkedin": "https://www.linkedin.com/in/carlos-oliveira-gcp"
            }
        ]
    },
    {
        "id": 3,
        "title": "Construindo Pipelines de Dados em Tempo Real com Dataflow",
        "category_id": 2,
        "category_name": "Data & AI",
        "description": "Veja na prática como processar fluxos massivos de dados de forma unificada (batch e streaming) utilizando o Apache Beam e o poder de processamento totalmente gerenciado do Cloud Dataflow.",
        "time": "10:30 - 11:15",
        "speakers": [
            {
                "first_name": "Daniela",
                "last_name": "Lima",
                "linkedin": "https://www.linkedin.com/in/daniela-lima-gcp"
            },
            {
                "first_name": "Eduardo",
                "last_name": "Souza",
                "linkedin": "https://www.linkedin.com/in/eduardo-souza-gcp"
            }
        ]
    },
    {
        "id": 4,
        "title": "BigQuery: Data Warehouse e Análise de Dados em Escala Petabyte",
        "category_id": 2,
        "category_name": "Data & AI",
        "description": "Aprenda a realizar consultas SQL ultrarrápidas em conjuntos de dados de petabytes e a utilizar recursos nativos de Machine Learning direto na plataforma de análise sem servidor do BigQuery.",
        "time": "11:15 - 12:00",
        "speakers": [
            {
                "first_name": "Felipe",
                "last_name": "Costa",
                "linkedin": "https://www.linkedin.com/in/felipe-cost-gcp"
            }
        ]
    },
    {
        "id": 99,  # ID especial para o almoço
        "title": "Intervalo para Almoço e Networking",
        "category_id": 0,
        "category_name": "Intervalo",
        "description": "Aproveite para recarregar as energias, saborear o almoço e interagir com outros profissionais e palestrantes na área de networking do evento.",
        "time": "12:00 - 13:00",
        "speakers": []
    },
    {
        "id": 5,
        "title": "A Revolução da IA Generativa com Vertex AI",
        "category_id": 2,
        "category_name": "Data & AI",
        "description": "Explore as capacidades incríveis da família de modelos Gemini e saiba como integrar IA generativa avançada, tuning de modelos e busca semântica em suas aplicações empresariais usando o Vertex AI.",
        "time": "13:00 - 13:45",
        "speakers": [
            {
                "first_name": "Gabriel",
                "last_name": "Almeida",
                "linkedin": "https://www.linkedin.com/in/gabriel-almeida-gcp"
            },
            {
                "first_name": "Helena",
                "last_name": "Ribeiro",
                "linkedin": "https://www.linkedin.com/in/helena-ribeiro-gcp"
            }
        ]
    },
    {
        "id": 6,
        "title": "Segurança Avançada e Controle de Acessos no Google Cloud",
        "category_id": 1,
        "category_name": "Cloud & Infra",
        "description": "Descubra como adotar os princípios do Zero Trust no Google Cloud. Cobriremos boas práticas de IAM, uso de VPC Service Controls e proteção contra exfiltração de dados sensíveis.",
        "time": "13:45 - 14:30",
        "speakers": [
            {
                "first_name": "Igor",
                "last_name": "Carvalho",
                "linkedin": "https://www.linkedin.com/in/igor-carvalho-gcp"
            }
        ]
    },
    {
        "id": 7,
        "title": "Bancos de Dados Multicloud e Globais com Cloud Spanner",
        "category_id": 2,
        "category_name": "Data & AI",
        "description": "Veja como alcançar escalabilidade horizontal ilimitada combinada com consistência forte relacional globalmente usando o Cloud Spanner, o banco de dados de missão crítica do Google.",
        "time": "14:30 - 15:15",
        "speakers": [
            {
                "first_name": "Juliana",
                "last_name": "Martins",
                "linkedin": "https://www.linkedin.com/in/juliana-martins-gcp"
            },
            {
                "first_name": "Lucas",
                "last_name": "Ferreira",
                "linkedin": "https://www.linkedin.com/in/lucas-ferreira-gcp"
            }
        ]
    },
    {
        "id": 8,
        "title": "Kubernetes na Nuvem: Orquestração Eficiente com GKE Autopilot",
        "category_id": 1,
        "category_name": "Cloud & Infra",
        "description": "Aprenda a focar na sua aplicação e deixar o gerenciamento e provisionamento automático do Kubernetes por conta do GKE Autopilot, garantindo alta eficiência e redução de custos operacionais.",
        "time": "15:15 - 16:00",
        "speakers": [
            {
                "first_name": "Mariana",
                "last_name": "Rocha",
                "linkedin": "https://www.linkedin.com/in/mariana-rocha-gcp"
            }
        ]
    }
]

@app.route("/")
def index():
    EVENT_INFO["date"] = get_formatted_date()
    return render_template("index.html", event=EVENT_INFO, talks=TALKS_DATABASE)

@app.route("/api/talks")
def api_talks():
    search_query = request.args.get("q", "").lower().strip()
    category_id = request.args.get("category", "")
    
    filtered_talks = TALKS_DATABASE
    
    # Filtrar por categoria (se informado e não for 0)
    if category_id:
        try:
            cat_id = int(category_id)
            if cat_id != 0:
                filtered_talks = [t for t in filtered_talks if t["category_id"] == cat_id or t["id"] == 99]
        except ValueError:
            pass

    # Filtrar por busca (título, palestrante ou descrição)
    if search_query:
        result = []
        for talk in filtered_talks:
            # Manter sempre o almoço visível ou não dependendo de preferência (vamos permitir busca no almoço também)
            title_match = search_query in talk["title"].lower()
            desc_match = search_query in talk["description"].lower()
            speaker_match = False
            for speaker in talk["speakers"]:
                fullname = f"{speaker['first_name']} {speaker['last_name']}".lower()
                if search_query in fullname:
                    speaker_match = True
                    break
            
            # Se for almoço e não conter a busca, mas for busca geral, não exibe a menos que dê match
            if title_match or desc_match or speaker_match:
                result.append(talk)
        filtered_talks = result

    return jsonify(filtered_talks)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080, debug=True)
