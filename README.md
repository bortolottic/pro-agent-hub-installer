# pro-agent-hub-installer

| Data | Autor | Descrição |
| ---- | ----- | --------- |
| 12/03/2026 | CVB | Criação do projeto |

    Projeto para instalação do aplicativo ProAgentHub.

## Requisitos

    - Docker desktop
    - Docker swarm
    - Licença de produto

## Instalação

    Para efetuar a instalação da última versão do produto, basta ir no terminal (Linux ou Windows WSL2) e digitar:

```bash
curl -fsSL https://raw.githubusercontent.com/bortolottic/pro-agent-hub-installer/refs/heads/main/install.sh | bash
```

    Caso queira instalar uma versão específica:

```bash
curl -fsSL https://raw.githubusercontent.com/bortolottic/pro-agent-hub-installer/refs/heads/main/install.sh | bash -s v1.0.25.2
```