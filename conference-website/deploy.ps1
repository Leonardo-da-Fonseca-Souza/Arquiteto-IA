# deploy.ps1
# Script para deploy automático no Google Cloud Run no Windows

$project = gcloud config get-value project
if (-not $project) {
    Write-Host "Erro: Nenhum projeto ativo no gcloud. Defina com 'gcloud config set project <ID>'" -ForegroundColor Red
    exit 1
}

Write-Host "=== Iniciando Deploy do Google Cloud Summit 2026 ===" -ForegroundColor Cyan
Write-Host "Projeto GCP Ativo: $project" -ForegroundColor Cyan

# Executar deploy no Cloud Run
gcloud run deploy conference-website `
    --source . `
    --region us-central1 `
    --allow-unauthenticated `
    --port 8080

if ($LASTEXITCODE -eq 0) {
    Write-Host "=== Deploy concluído com sucesso! ===" -ForegroundColor Green
} else {
    Write-Host "=== Ocorreu um erro no deploy. ===" -ForegroundColor Red
}
