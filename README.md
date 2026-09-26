# Provisionamento de Servidor Web com Apache

Este script Bash automatiza o processo de **configuração inicial de um servidor Linux**, realizando a atualização do sistema, instalação do Apache, download da aplicação e publicação dos arquivos no diretório padrão do servidor web.

## O que o script faz?

O processo realizado pelo script é:

1. Atualiza os pacotes do sistema.
2. Instala o Apache2 e o Unzip.
3. Habilita e inicia o serviço do Apache.
4. Baixa o código da aplicação através de um repositório GitHub.
5. Extrai os arquivos da aplicação.
6. Copia os arquivos para o diretório do Apache.
7. Remove arquivos temporários.
8. Finaliza o provisionamento.

---

## Requisitos

* Sistema operacional baseado em Debian/Ubuntu
* Acesso `root` ou utilização do script com `sudo`
* Conexão com a internet
* Bash
* Repositório da aplicação disponível no GitHub

---

## Script

```bash
#!/bin/bash

set -e

echo "Atualizando o servidor"

apt-get update
apt-get upgrade -y

echo "Instalando dependências"

apt-get install apache2 unzip -y

systemctl enable --now apache2

echo "Baixando e copiando os arquivos da aplicação"

cd /tmp

wget -q "https://github.com/usuario/repositorio/archive/refs/heads/main.zip" -O main.zip

unzip -o main.zip

cd */

cp -R . /var/www/html/

echo "Limpando arquivos temporários"

cd /tmp

rm -rf main.zip

echo "Provisionamento concluído."
```

---

# Explicação passo a passo

## 1. Definição do interpretador

```bash
#!/bin/bash
```

Define que o script deverá ser executado utilizando o **Bash**.

---

## 2. Interromper o script em caso de erro

```bash
set -e
```

Faz com que o script seja encerrado automaticamente caso algum comando retorne um erro.

Isso evita que o provisionamento continue caso alguma etapa importante tenha falhado.

---

## 3. Atualização do servidor

```bash
echo "Atualizando o servidor"

apt-get update
apt-get upgrade -y
```

### `echo`

Exibe uma mensagem no terminal para indicar qual etapa está sendo executada.

### `apt-get update`

Atualiza a lista de pacotes disponíveis nos repositórios configurados no sistema.

### `apt-get upgrade -y`

Atualiza os pacotes que já estão instalados.

O parâmetro:

```bash
-y
```

responde automaticamente `yes` às confirmações solicitadas pelo `apt-get`.

---

# 4. Instalação das dependências

```bash
echo "Instalando dependências"

apt-get install apache2 unzip -y
```

Instala os programas necessários para o restante do processo.

### Apache2

O **Apache** será utilizado como servidor web para disponibilizar a aplicação.

### Unzip

O `unzip` será utilizado para extrair o arquivo `.zip` baixado do GitHub.

---

# 5. Habilitando e iniciando o Apache

```bash
systemctl enable --now apache2
```

Esse comando realiza duas ações.

### `enable`

Configura o Apache para iniciar automaticamente quando o servidor for ligado.

### `--now`

Além de habilitar o serviço, inicia o Apache imediatamente.

É equivalente a executar:

```bash
systemctl enable apache2
systemctl start apache2
```

---

# 6. Acessando o diretório temporário

```bash
cd /tmp
```

O script entra no diretório `/tmp`, que é utilizado para armazenar arquivos temporários durante o processo de instalação.

---

# 7. Download da aplicação

```bash
wget -q "https://github.com/usuario/repositorio/archive/refs/heads/main.zip" -O main.zip
```

Realiza o download do repositório da aplicação diretamente do GitHub.

### `wget`

Ferramenta utilizada para baixar arquivos através da internet.

### `-q`

Significa **quiet**.

Faz com que o `wget` reduza a quantidade de informações exibidas no terminal.

### `-O main.zip`

Define o nome do arquivo que será salvo:

```text
main.zip
```

> **Importante:** a URL utilizada no exemplo deve ser substituída pela URL real do repositório.

---

# 8. Extração do projeto

```bash
unzip -o main.zip
```

Extrai o conteúdo do arquivo `main.zip`.

O parâmetro:

```bash
-o
```

permite sobrescrever arquivos existentes durante a extração.

Normalmente, o GitHub cria uma pasta semelhante a:

```text
repositorio-main/
```

---

# 9. Acessando a pasta extraída

```bash
cd */
```

O comando tenta entrar na pasta correspondente ao conteúdo extraído.

Por exemplo:

```text
/tmp/repositorio-main/
```

> **Observação:** essa parte pode ser melhorada. O uso de `cd */` depende da existência de apenas um diretório compatível dentro de `/tmp`. Em um servidor com outros diretórios, o comportamento pode não ser o esperado.

---

# 10. Publicando a aplicação no Apache

```bash
cp -R . /var/www/html/
```

Copia os arquivos da aplicação para:

```text
/var/www/html/
```

Esse é o diretório padrão utilizado pelo Apache para disponibilizar arquivos através do servidor web.

Por exemplo:

```text
/var/www/html/index.html
```

pode ser acessado pelo navegador através do endereço IP ou domínio do servidor.

---

# 11. Limpando arquivos temporários

```bash
cd /tmp

rm -rf main.zip
```

Volta para o diretório `/tmp` e remove o arquivo ZIP utilizado durante o processo.

O objetivo é evitar deixar arquivos desnecessários no servidor.

---

# 12. Finalização

```bash
echo "Provisionamento concluído."
```

Exibe uma mensagem informando que todas as etapas do script foram executadas com sucesso.

---

# Fluxo do provisionamento

O processo pode ser resumido da seguinte forma:

```text
Servidor Linux
      │
      ▼
Atualizar pacotes
      │
      ▼
Instalar Apache + Unzip
      │
      ▼
Iniciar Apache
      │
      ▼
Baixar aplicação do GitHub
      │
      ▼
Extrair arquivo ZIP
      │
      ▼
Copiar arquivos
      │
      ▼
/var/www/html/
      │
      ▼
Aplicação disponível
```

---

# Como executar

Salve o script, por exemplo, como:

```bash
provisionamento.sh
```

Dê permissão de execução:

```bash
chmod +x provisionamento.sh
```

Execute como administrador:

```bash
sudo ./provisionamento.sh
```

---

# Observações

Antes de executar o script em um servidor real, altere:

```bash
https://github.com/usuario/repositorio/archive/refs/heads/main.zip
```

para a URL do seu próprio repositório.

Também é importante observar que o comando:

```bash
cd */
```

pode apresentar comportamento inesperado caso existam vários diretórios dentro de `/tmp`.

Para um script de provisionamento mais robusto, é recomendado definir explicitamente o diretório onde o projeto será extraído.

---

# Objetivo do projeto

Este projeto demonstra conceitos básicos de **Linux, Bash, administração de servidores e provisionamento de infraestrutura**, automatizando tarefas que normalmente seriam executadas manualmente.

Conceitos praticados:

* Bash Script
* Linux
* `apt-get`
* `systemctl`
* Apache
* Download via `wget`
* Extração de arquivos com `unzip`
* Manipulação de diretórios
* Permissões e execução de scripts
* Provisionamento de servidor
* Deploy básico de aplicação
* GitHub
