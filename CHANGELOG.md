# Changelog
Todas as mudanças notáveis neste projeto serão documentadas neste arquivo.

Este formato é baseado em [Mantenha um Changelog](https://keepachangelog.com/pt-BR/1.0.0/).
Este projeto adere ao [Versionamento Semântico](https://semver.org/lang/pt-BR/).

## 1.2.9 - 2023-01-06
### Modificado
- VITE_PORT customizada na porta interna do compose.yaml.

## 1.2.8 - 2023-01-04
### Modificado
- Documentação Atualizada.

### Removido
- .env-laravel não será mais via symlink.

## 1.2.7 - 2023-01-03
### Modificado
- Documentação Atualizada.

## 1.2.6 - 2023-01-03
### Modificado
- Documentação Atualizada.

## 1.2.5 - 2023-01-03
### Modificado
- Documentação Atualizada.

## 1.2.4 - 2023-01-03
### Modificado
- Documentação Atualizada.

## 1.2.3 - 2023-01-03
### Modificado
- Documentação reescrita.

### Removido
- Script de clonagem do repositório.
- Script de configuração do repositório.

## 1.2.2 - 2023-01-03
### Corrigido
- Documentação README.md.

## 1.2.1 - 2023-01-03
### Corrigido
- Documentação README.md.

## 1.2.0 - 2023-01-03
### Modificado
- Nome da rede pego dinamicamente do .env.
- Atualizado versões dos serviços.
- Documentação atualizada.

## 1.1.3 - 2022-12-20
### Modificado
- Configurações para o xDebug funcionar com o VSCode.

## 1.1.2 - 2022-10-03
### Modificado
- Dockerfile php script deploy removido.
- Dockerfile php script configure.sh não é mais necessário mexer nas permissões de arquivos e usuário www-data.

## 1.1.1 - 2022-09-27
### Corrigido
- Dockerfile php instalar a versão especificada no .env.

## 1.1.0 - 2022-08-31
### Adicionado
- Criação de usuário para evitar problemas de permissão dentro dos containers no composer e npm.

### Modificado
- Banco de dados Maria DB.

### Corrigido
- Deploy nvm e nome de variáveis.

## 1.0.2 - 2022-07-12
### Modificado
- Ajustes de permissões de todos os arquivos e diretórios via configure.sh.
- Suporte a php-8.0

## 1.0.1 - 2022-07-06
### Corrigido
- Script deploy remover aquivo .gitkeep.
- Scripts .sh com permissões corretas.

## 1.0.0 - 2022-07-05
### Adicionado
- Melhorias.
- Inicio documentação CHANGELOG.md

