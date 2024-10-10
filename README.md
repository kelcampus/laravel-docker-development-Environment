# Laravel 11 Projects

Ambiente de desenvolvimento para [Laravel 11](https://laravel.com/docs/11.x) utilizando [Docker Compose](https://docs.docker.com/compose/).
 
## Requisitos

- [Windows Subsistemas](https://docs.microsoft.com/pt-br/windows/wsl/install) for Linux - WSL2;
- Ubuntu 20.04 TLS ativado como Distro default no WSL;
- [Docker Desktop](https://www.docker.com/products/docker-desktop) integrado [ao WSL](https://docs.docker.com/desktop/windows/wsl/#install);
- Docker [BuildKit](https://docs.docker.com/develop/develop-images/build_enhancements);
- WSL com git instalado e configurado;

## Serviços
- [php 8.3-fpm](https://hub.docker.com/_/php);
- [nginx 1.27](https://hub.docker.com/_/nginx);
- [mariadb 11.4](https://hub.docker.com/_/mariadb).

## Extensões PHP
- [Extensões requiridas pelo laravel](https://laravel.com/docs/11.x/deployment#server-requirements)
- gd;
- zip;
- [xdebug](https://xdebug.org/docs/install#pecl);
- [phpcs](https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar).

## Gerenciadores de Pacotes
- [composer](https://hub.docker.com/_/composer) latest stable version;
- [nvm 0.39.7](https://hub.docker.com/_/mariadb);
- [nodejs](https://nodejs.org/en/) versão base 20.14.0 instalado via [nvm](https://github.com/nvm-sh/nvm);  
- [npm](https://docs.npmjs.com) latest version instalado via [nvm](https://github.com/nvm-sh/nvm).

## Download e Configuração

Vamos assumir que você está logado no **WSL** e a pasta raiz do nosso projeto é "/home/[user]/apps/meuproejto/" onde [user] é o nome do seu usuário no WSL: 

1. Clone o repositório que contém os arquivos da estrutura de containers.

       https://github.com/kelcampus/laravel-docker-development-environment.git .

2. Você pode excluir alguns arquivos se desejar:
    - .git;
    - CHANGELOG.md;
    - README.md;

3. Renomeie o arquivo "/home/[user]/apps/meuproejto/.env-example" para ["/home/[user]/apps/meuproejto/.env"](https://docs.docker.com/compose/environment-variables) e configure-o conforme necessário;    

4. Configure o arquivo "/home/[user]/apps/meuproejto/build/.env-laravel" com o seu .env de desenvolvimento utilizado no seu projeto Laravel.

## Criando os Containers

1. Na raiz (no mesmo nível do arquivo compose.yaml) crie os containers executando o comando:

        docker compose up --build -d

2. Após a criação dos 3 containers (php, mysql e web) e para garantir que tudo esteja certo, você pode fazer alguns testes. Acesse o shell do **container php** e verifique as versões dos serviços instalados:

        # php -v        
        # node -v
        # npm -v
        # composer --version
        # phpcs --version

3. Se quiser ver o php funcionando antes de clonar seu projeto Laravel, você pode criar um arquivo index.php (com um phpinfo() dentro) no caminho "/home/[user]/apps/meuproejto/app/public/index.php" e acessar via browse conforme configurado no seu **/home/[user]/apps/meuproejto/.env**, por exemplo **http://IPLOCAL:NGINX_PORT** ou http://localhost:NGINX_PORT;

4. Para testar o banco de dados, faça o acesso utilizando um gerenciador de sua preferência com os dados de acesso configurados no **/home/[user]/apps/meuproejto/meuprojeto/.env**. Lembrando que o banco de dados é criado com as informações do **/home/[user]/apps/meuproejto/.env** somente se ainda não existir, caso contrário nenhuma alteração será realizada no banco.

4. Até este ponto, temos os containers funcionais e a partir daqui podemos instalar o nosso projeto principal em Laravel. Se você utilizou o VSCode para alterar os arquivos, feche-o. 

## Clonando o projeto Laravel
1. Acesse o WSL via shell em **/home/[user]/apps/meuproejto/app**;
2. Delete o arquivo **/home/[user]/apps/meuproejto/app/.gitkeep** e qualquer outro, a pasta **/home/[user]/apps/meuproejto/app** deve estar vazia, caso contrário não será possível clonar o repositório;
3. Clone o repositório do projeto:

        git clone REPOSITORIO-DO-MEU-PROJETO .

## Configurando o Laravel
1. Abra o VSCode na raiz do seu projeto:

        code /home/[user]/apps/meuproejto/app . 

2. Acesse o shell do container php via VSCode, ou se preferir via shell no WSL;

3. Renomeio o arquivo .env.example do laravel para .env e configure-o conforme necessário. 

3. Atualize os pacotes dependentes do composer:

        composer update

4. Execute os demais comandos de acordo com seu projeto, por exemplo:

        php artisan migrate // ou migrator se usa o pacote personalizado
        npm install
        npm run dev         // se você usa vite, vai inicializar o servidor de dev
        php artisan storage:link

A partir deste ponto seu projeto deve estar funcional.

## Outros Comandos para containers

Todos os comandos do docker compose cli estão em: https://docs.docker.com/compose/reference/. Os comandos abaixo devem ser executados no mesmo nível do arquivo **compose.yaml**.

OBS: **php** nos comandos abaixo é o nome de um container específico. 

### Parar a execução de todos os containers do projeto

    docker compose stop

### Remover todos os dados de containers parados (INDEPENDENTE DE PROJETO)

Cuidado ao executar esse comando. **TUDO** relacionado ao containers que não estão em execução no momento será **DELETADO**.

    docker system prune -a

### Recriar todos os containers 

    docker compose up --build -d

### Recriar um container 

    docker compose up --build --force-recreate -d NOME_CONTAINER

### Construir uma imagem verificando os logs

    docker compose build php --no-cache --progress=plain

### Remover todos os containers parados

    docker compose rm

### iniciar todos os containers

    docker compose start

## xDebug com VSCode

Considerando que o container php é criado como o xDebug instalado e disponível para uso, para configurá-lo no Vscode, siga os seguintes passos:

- No VSCode em Run -> Add Configuration;
- Ajuste o arquivo launch.json gerado conforme abaixo:

```json
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Listen for Xdebug",
            "type": "php",
            "request": "launch",
            "hostname": "0.0.0.0",
            "port": 9003,
            "pathMappings": {
                "/path/from/container": "${workspaceFolder}"
            },
            "ignore": ["**/vendor/**/*.php"],
            "xdebugSettings": {
                "max_children": 10000,
                "max_data": 10000,
                "show_hidden": 1
            }
        }
    ]
}
```
- Altere **/path/from/container** para o caminho do seu projeto dentro do container;

## Configurando o VSCode para reconhecer o phpcs via WSL

Seguindo nossa estrutura temos todos os containers rodando via WSL, independente da quantidade de containers. Podemos ter vários projetos e cada um com múltiplos containers (nginx, mysql, php, etc...) rodando em redes diferentes através do docker compose. 

Apesar destes containers rodarem dentro no WSL, o SO do WSL em si não possui nenhum serviço rodando diretamente, por exemplo, se executarmos php -v no WSL não vai reconhecer o comando.

O VSCode é instalado no windows e tem acesso ao WSL via plugin, permitindo executar o editor diretamente em projetos armazenados no WSL. Ao instalarmos o plugin phpcs no VSCode, ele vai procurar o path do PHP dentro no WSL, que é onde o editor está sendo executado e não vai encontrar.

Para resolver isso, executamos um script que cria um alias para o comando php no WSL apontando para um container php específico. No caso de projetos com php de versões diferentes, basta ajustar o script para a versão do projeto atual.

Acesse **/home/[user]/apps/meuproejto/build** e execute o script wsl-php-phpcs-vscode.sh.

    // tornar executável, se não estiver
    chmod +x wsl-php-phpcs-vscode.sh

    // executar
    ./wsl-php-phpcs-vscode.sh

Após a execução, os plugins de php e phpcs do VSCode já devem estar funcionando, caso contrário verifique o path do php no WSL e configure-o no editor para todos os plugins que exigem o path do php funcionem corretamente.


