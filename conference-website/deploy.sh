#!/bin/bash
# Script para deploy automático no Google Cloud Run

# Habilitar encerramento imediato se algum comando falhar
set -e

PROJECT_ID=$(gcloud config get-value project)
if [ -z "$PROJECT_ID" ]; then
    echo "Erro: Nenhum projeto ativo no gcloud. Defina com 'gcloud config set project <ID>'"
    exit 1
fi

echo "=== Iniciando Deploy do Google Cloud Summit 2026 ==="
echo "Projeto GCP Ativo: $PROJECT_ID"

# Executar deploy no Cloud Run
gcloud run deploy conference-website \
    --source . \
    --region us-central1 \
    --allow-unauthenticated \
    --port 8080

echo "=== Deploy concluído com sucesso! ==="
