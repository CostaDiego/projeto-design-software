#!/bin/bash

FILE="/tmp/plantuml-1.2025.10.jar"
URL="https://github.com/plantuml/plantuml/releases/download/v1.2025.10/plantuml-1.2025.10.jar"

# Verifica se o arquivo existe
if [ -f "$FILE" ]; then
    echo "Plantuml disponível."
else
    echo "O arquivo $FILE não existe. Baixando..."
    wget "$URL"
    mv plantuml-1.2025.10.jar /tmp
    echo "Download concluído."
fi

echo "Produzindo arquivos PNG a partir de arquivos PlantUML (recursivamente). Aguarde ..."
mkdir -p ./imagens
echo "Diretórios pesquisados:"
find . -type f -name "*.puml" -not -path "*/imagens/*" -print0 | \
    xargs -0 -n1 dirname | sort -u
find . -type f -name "*.puml" -not -path "*/imagens/*" -print0 | \
    xargs -0 java -jar "$FILE" -quiet -o ./imagens
echo "Geração de arquivos concluída."