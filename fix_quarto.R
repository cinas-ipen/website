# Script para processar arquivos Quarto (.qmd) e configs
# Autor: CINAS AI

# Lista COMPLETA de arquivos (PT, EN e Configs)
files_to_process <- c(
  # Português (.qmd)
  "index.qmd",
  "about.qmd",
  "research.qmd",
  "people.qmd",
  "publications.qmd",
  "join.qmd",
  
  # Inglês (.qmd)
  "index.en.qmd",
  "about.en.qmd",
  "research.en.qmd",
  "people.en.qmd",
  "publications.en.qmd",
  "join.en.qmd",
  
  # Configurações (.yml)
  "_quarto.yml",
  "_quarto-pt.yml", # Novo arquivo PT
  "_quarto-en.yml"
)

# Função de substituição segura
process_quarto_file <- function(file_path) {
  
  if (!file.exists(file_path)) {
    message(paste("Arquivo não encontrado (ignorando):", file_path))
    return(NULL)
  }
  
  # Ler o conteúdo do arquivo
  text <- readLines(file_path, warn = FALSE)
  
  # --- 1. PROTEÇÃO DE CABEÇALHO (YAML) ---
  text <- gsub("\\{\\{YAML\\}\\}", "---", text)
  
  # --- 2. IMAGENS ---
  text <- gsub("\\{\\{IMG:(.*?)\\{\\{ENDIMG\\}\\}", "![](\\1)", text)
  
  # --- 3. LINKS ---
  text <- gsub("\\{\\{LINK:(.*?)\\|(.*?)\\{\\{ENDLINK\\}\\}", "[\\1](\\2)", text)
  
  # --- 4. ÍCONES (FONTAWESOME) ---
  text <- gsub("\\{\\{ICON:HOSPITAL\\}\\}", "{{< fa hospital >}}", text)
  text <- gsub("\\{\\{ICON:CHART\\}\\}", "{{< fa chart-line >}}", text)
  text <- gsub("\\{\\{ICON:ATOM\\}\\}", "{{< fa atom >}}", text)
  text <- gsub("\\{\\{ICON:HANDSHAKE\\}\\}", "{{< fa handshake >}}", text)
  text <- gsub("\\{\\{ICON:LATTES\\}\\}", "{{< fa file-lines >}}", text)
  text <- gsub("\\{\\{ICON:PROJECT\\}\\}", "{{< fa laptop-code >}}", text)
  
  # Escrever o arquivo de volta
  writeLines(text, file_path)
  message(paste("Processado com sucesso:", file_path))
}

# Executar o processamento
message("Iniciando processamento dos arquivos CINAS...")
for (f in files_to_process) {
  process_quarto_file(f)
}
message("Concluído! Agora execute os comandos de renderização.")