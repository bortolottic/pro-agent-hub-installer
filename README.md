# Pro Agent Hub — Guia de Instalação

| Data | Autor | Descrição |
| ---- | ----- | --------- |
| 12/03/2026 | CVB | Criação do projeto |
| 29/04/2026 | CVB | Guia expandido para Linux, Windows e macOS |

---

## O que é o Pro Agent Hub?

O **Pro Agent Hub** é uma plataforma de agentes inteligentes que roda de forma containerizada usando Docker. Este repositório contém o **instalador oficial**, que automatiza todo o processo de download e implantação do sistema.

> **Para quem não é técnico:** pense neste instalador como um "assistente de instalação" que faz tudo sozinho. Você segue os passos abaixo, cola um único comando no terminal e ele cuida do restante: baixa a versão correta do sistema, descompacta os arquivos e coloca tudo em funcionamento.

---

## Escolha o seu sistema operacional

- [Instalação no Linux](#instalação-no-linux)
- [Instalação no Windows](#instalação-no-windows)
- [Instalação no macOS](#instalação-no-macos)

---

## Instalação no Linux

### Passo 1 — Abra o terminal

No Linux, o terminal é o programa onde você digita comandos de texto. Veja como abrir dependendo da sua distribuição:

- **Ubuntu / Debian / Mint:** pressione `Ctrl + Alt + T`
- **Fedora / RHEL:** clique com o botão direito na área de trabalho → "Abrir terminal"
- **Qualquer distribuição:** procure por "Terminal" ou "Console" no menu de aplicativos

Uma janela preta com um cursor piscando vai aparecer. É nela que você vai colar os comandos dos próximos passos.

---

### Passo 2 — Instale o Docker

O Docker é o programa que vai rodar o Pro Agent Hub. Siga os passos abaixo:

**1.** Atualize os pacotes do sistema (pode pedir a sua senha):

```bash
sudo apt update && sudo apt upgrade -y
```

> Se estiver usando Fedora/RHEL, substitua `apt` por `dnf`.

**2.** Instale o Docker:

```bash
sudo apt install -y docker.io
```

**3.** Inicie o Docker e configure-o para iniciar automaticamente com o sistema:

```bash
sudo systemctl enable docker --now
```

**4.** Adicione o seu usuário ao grupo Docker (para não precisar usar `sudo` toda vez):

```bash
sudo usermod -aG docker $USER
```

**5.** Feche o terminal e abra novamente para aplicar a alteração do passo anterior.

**6.** Verifique se o Docker foi instalado corretamente:

```bash
docker --version
```

Se aparecer algo como `Docker version 24.x.x`, a instalação foi bem-sucedida.

---

### Passo 3 — Ative o Docker Swarm

O Docker Swarm é o gerenciador de serviços que o Pro Agent Hub utiliza. Ative-o com o comando:

```bash
docker swarm init
```

Se aparecer a mensagem `Swarm initialized`, está pronto.

> **Nota:** se você receber um erro dizendo que já existe um swarm ativo, pode ignorar — significa que o Docker Swarm já estava configurado.

---

### Passo 4 — Verifique se o `curl` está instalado

O `curl` é a ferramenta usada para baixar o instalador. Verifique se ele está disponível:

```bash
curl --version
```

Se não estiver instalado, instale com:

```bash
sudo apt install -y curl
```

---

### Passo 5 — Execute o instalador

Com tudo pronto, rode o comando abaixo para instalar a versão mais recente do Pro Agent Hub:

```bash
curl -fsSL https://raw.githubusercontent.com/bortolottic/pro-agent-hub-installer/refs/heads/main/install.sh | bash
```

O instalador vai exibir o progresso no terminal. Aguarde até aparecer a mensagem:

```
======================================
 Deploy finalizado com sucesso
======================================
```

Pronto! O Pro Agent Hub está instalado e em execução.

---

### Passo 6 — Verifique se os serviços estão rodando

Confirme que tudo está funcionando:

```bash
docker service ls
```

Você verá a lista de serviços ativos do Pro Agent Hub.

---

## Instalação no Windows

No Windows, o Pro Agent Hub roda dentro do **WSL2** (Windows Subsystem for Linux), que é uma camada Linux integrada ao Windows. O **Docker Desktop** gerencia os containers automaticamente.

> **Para leigos:** o WSL2 é como ter um "Linux dentro do Windows". O Docker Desktop é o programa que vai rodar o Pro Agent Hub. Você não precisa entender tudo isso — basta seguir os passos.

---

### Passo 1 — Verifique a versão do Windows

O WSL2 e o Docker Desktop exigem **Windows 10 versão 2004 ou superior** (ou Windows 11).

**1.** Pressione `Win + R`, digite `winver` e pressione Enter.

**2.** Verifique se a versão exibida é **2004 ou superior**. Se for mais antiga, atualize o Windows pelo Windows Update antes de continuar.

---

### Passo 2 — Ative o WSL2

**1.** Clique no botão Iniciar do Windows e procure por **"PowerShell"**.

**2.** Clique com o botão direito no PowerShell e escolha **"Executar como administrador"**.

**3.** Na janela que abrir, cole o comando abaixo e pressione Enter:

```powershell
wsl --install
```

**4.** Aguarde a instalação terminar. Quando solicitado, **reinicie o computador**.

**5.** Após reiniciar, o Windows vai abrir uma janela pedindo para criar um nome de usuário e senha do Linux — defina os dois e anote em local seguro.

> **Dica:** a senha não aparece enquanto você digita. Isso é normal — basta digitar e pressionar Enter.

---

### Passo 3 — Instale o Docker Desktop

**1.** Acesse o site oficial do Docker e baixe o instalador para Windows:
`https://www.docker.com/products/docker-desktop/`

**2.** Execute o instalador baixado (`Docker Desktop Installer.exe`).

**3.** Durante a instalação, certifique-se de que a opção **"Use WSL 2 instead of Hyper-V"** está marcada.

**4.** Conclua a instalação e reinicie o computador se solicitado.

**5.** Abra o **Docker Desktop** pelo menu Iniciar. Aguarde ele inicializar — o ícone da baleia vai aparecer na barra de tarefas (perto do relógio) quando estiver pronto.

---

### Passo 4 — Configure o Docker Desktop para usar o WSL2

**1.** Abra o Docker Desktop.

**2.** Clique no ícone de engrenagem (⚙️) no canto superior direito para abrir as configurações.

**3.** Vá em **"Resources"** → **"WSL Integration"**.

**4.** Ative a integração com a sua distribuição Linux (geralmente aparece como **"Ubuntu"**).

**5.** Clique em **"Apply & Restart"**.

---

### Passo 5 — Ative o Docker Swarm

**1.** Abra o **WSL** pelo menu Iniciar (procure por "Ubuntu" ou "WSL").

**2.** Na janela do terminal Linux que abrir, execute:

```bash
docker swarm init
```

Se aparecer a mensagem `Swarm initialized`, está pronto.

---

### Passo 6 — Execute o instalador

Ainda no terminal do WSL (Ubuntu), execute o comando de instalação:

```bash
curl -fsSL https://raw.githubusercontent.com/bortolottic/pro-agent-hub-installer/refs/heads/main/install.sh | bash
```

Aguarde o processo terminar. Quando aparecer a mensagem abaixo, a instalação foi concluída com sucesso:

```
======================================
 Deploy finalizado com sucesso
======================================
```

---

### Passo 7 — Verifique se os serviços estão rodando

No terminal do WSL, confirme que os serviços estão ativos:

```bash
docker service ls
```

Você verá a lista de serviços do Pro Agent Hub em execução.

---

## Instalação no macOS

O Docker Desktop para macOS roda nativamente, sem precisar de camada adicional. Funciona tanto em Macs com chip Intel quanto em Macs com chip Apple Silicon (M1, M2, M3 e M4).

---

### Passo 1 — Abra o Terminal

O Terminal é o programa onde você digita comandos no Mac. Veja como abrir:

- **Opção 1:** pressione `Cmd + Espaço`, digite `Terminal` e pressione Enter.
- **Opção 2:** abra o Finder → vá em **Aplicativos** → **Utilitários** → **Terminal**.

Uma janela escura com um cursor piscando vai aparecer. É nela que você vai colar os comandos dos próximos passos.

---

### Passo 2 — Instale o Homebrew

O Homebrew é o gerenciador de pacotes mais usado no macOS — ele facilita a instalação de programas via terminal.

**1.** No Terminal, cole o comando abaixo e pressione Enter:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**2.** O instalador pode pedir a **senha do seu Mac** e solicitar que você pressione Enter para confirmar. Siga as instruções exibidas na tela.

**3.** Ao final, se o seu Mac tiver chip Apple Silicon (M1/M2/M3/M4), o Homebrew vai exibir um aviso pedindo para executar dois comandos adicionais. Copie e execute-os um por vez — eles aparecem no próprio terminal após a instalação.

**4.** Verifique se o Homebrew foi instalado:

```bash
brew --version
```

Se aparecer algo como `Homebrew 4.x.x`, está pronto.

---

### Passo 3 — Instale o Docker Desktop

**1.** No Terminal, execute:

```bash
brew install --cask docker
```

**2.** Aguarde o download e a instalação terminarem.

**3.** Abra o Docker Desktop pelo Launchpad ou pelo Spotlight (`Cmd + Espaço` → digite "Docker"). Na primeira vez, o macOS pode pedir permissão para abrir o aplicativo — clique em **"Abrir"**.

**4.** O Docker vai solicitar permissões de sistema. Clique em **"OK"** ou **"Permitir"** nas janelas que aparecerem.

**5.** Aguarde o Docker inicializar — o ícone da baleia vai aparecer na barra de menus (canto superior direito da tela) quando estiver pronto. Quando o ícone parar de se mover, o Docker está em execução.

---

### Passo 4 — Verifique a instalação do Docker

No Terminal, confirme que o Docker está funcionando:

```bash
docker --version
```

Se aparecer algo como `Docker version 26.x.x`, a instalação foi bem-sucedida.

---

### Passo 5 — Ative o Docker Swarm

O Docker Swarm é o gerenciador de serviços que o Pro Agent Hub utiliza. Ative-o com:

```bash
docker swarm init
```

Se aparecer a mensagem `Swarm initialized`, está pronto.

> **Nota:** se você receber um erro dizendo que já existe um swarm ativo, pode ignorar — significa que o Docker Swarm já estava configurado.

---

### Passo 6 — Execute o instalador

Com tudo pronto, rode o comando abaixo no Terminal para instalar a versão mais recente do Pro Agent Hub:

```bash
curl -fsSL https://raw.githubusercontent.com/bortolottic/pro-agent-hub-installer/refs/heads/main/install.sh | bash
```

Aguarde o processo terminar. Quando aparecer a mensagem abaixo, a instalação foi concluída com sucesso:

```
======================================
 Deploy finalizado com sucesso
======================================
```

---

### Passo 7 — Verifique se os serviços estão rodando

Confirme que os serviços estão ativos:

```bash
docker service ls
```

Você verá a lista de serviços do Pro Agent Hub em execução.

---

## Instalar uma versão específica

Caso precise de uma versão específica (para ambientes de homologação ou rollback):

**Linux, macOS ou WSL2 (Windows):**

```bash
curl -fsSL https://raw.githubusercontent.com/bortolottic/pro-agent-hub-installer/refs/heads/main/install.sh | bash -s V1.0.26.3
```

Substitua `V1.0.26.3` pelo número da versão desejada. Todas as versões disponíveis estão na página de [Releases do GitHub](https://github.com/bortolottic/pro-agent-hub-installer/releases).

---

## O que o instalador faz (para técnicos)

O `install.sh` executa as seguintes etapas automaticamente:

1. **Detecção de versão** — consulta a API do GitHub (`/releases/latest`) para obter a tag da versão mais recente, caso nenhuma versão seja especificada.
2. **Download** — baixa o arquivo `pro-agent-hub-<versão>.tar.gz` diretamente da página de releases do GitHub, usando `curl` ou `wget` (o que estiver disponível).
3. **Extração** — descompacta o pacote em `/tmp/pro-agent-hub`.
4. **Deploy** — executa o script `deploy_production.sh` incluso no pacote, que sobe os serviços via Docker Swarm.

```
GitHub Releases
      │
      ▼
install.sh  ──► baixa .tar.gz ──► extrai ──► deploy_production.sh ──► Docker Swarm
```

---

## Solução de problemas

| Problema | Possível causa | Solução |
| -------- | -------------- | ------- |
| `curl ou wget não encontrado` | Nenhuma das ferramentas está instalada | Execute: `sudo apt install -y curl` |
| Erro ao baixar o pacote | URL incorreta ou versão inexistente | Verifique as [releases disponíveis](https://github.com/bortolottic/pro-agent-hub-installer/releases) |
| `Docker not found` | Docker não está instalado ou não está no PATH | Instale o Docker e certifique-se de que está em execução |
| `permission denied` ao rodar Docker | Usuário não está no grupo docker | Execute `sudo usermod -aG docker $USER` e abra um novo terminal |
| `This node is already part of a swarm` | Docker Swarm já foi inicializado | Pode ignorar esse erro e continuar |
| Deploy falha silenciosamente | Problema no `deploy_production.sh` | Verifique os logs com `docker service ls` e `docker stack ps <nome>` |
| Docker Desktop não inicia (Windows) | Virtualização desativada na BIOS | Acesse a BIOS do computador e ative a opção de virtualização (VT-x/AMD-V) |
| WSL não instala (Windows) | Windows desatualizado | Atualize o Windows pelo Windows Update e tente novamente |
| `brew: command not found` (macOS) | Homebrew não foi instalado ou não está no PATH | Reinstale o Homebrew e siga as instruções exibidas ao final da instalação |
| Docker não abre (macOS) | macOS bloqueou o aplicativo por segurança | Vá em **Ajustes do Sistema** → **Privacidade e Segurança** e clique em "Abrir mesmo assim" |
| `permission denied` ao abrir Docker (macOS) | Permissões de sistema não concedidas | Abra o Docker Desktop manualmente e aceite as solicitações de permissão |

---

## Versões disponíveis

Todas as versões estão listadas na página de [Releases do GitHub](https://github.com/bortolottic/pro-agent-hub-installer/releases).

---

## Suporte

Em caso de dúvidas ou problemas, entre em contato com a equipe responsável pelo projeto.
