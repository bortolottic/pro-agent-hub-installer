# Pro Agent Hub — Installer

| Data | Autor | Descrição |
| ---- | ----- | --------- |
| 12/03/2026 | CVB | Criação do projeto |

---

## O que é o Pro Agent Hub?

O **Pro Agent Hub** é uma plataforma de agentes inteligentes que roda de forma containerizada, usando Docker. Este repositório contém o **instalador oficial**, que automatiza todo o processo de download e implantação do sistema em servidores Linux (ou Windows via WSL2).

> **Para quem não é técnico:** pense neste instalador como um "assistente de instalação" que faz tudo sozinho — você cola um único comando no terminal e ele cuida do restante: baixa a versão correta do sistema, descompacta os arquivos e coloca tudo em funcionamento.

---

## Requisitos

Antes de instalar, certifique-se de que o servidor ou máquina possui:

| Requisito | Por quê é necessário |
| --------- | -------------------- |
| **Docker Desktop** (Linux/WSL2) | O Pro Agent Hub é executado dentro de containers Docker |
| **Docker Swarm** ativado | Gerencia e escala os containers em produção |
| **`curl` ou `wget`** | Necessário para baixar o pacote de instalação |
| **Licença de produto válida** | O sistema exige uma licença ativa para funcionar |

> **Para leigos:** Docker é como uma "caixa isolada" onde o sistema roda sem interferir no resto do seu computador/servidor. O Docker Swarm é o gerenciador dessas caixas.

---

## Instalação

### Instalar a versão mais recente

Abra o terminal (Linux ou Windows com WSL2) e execute:

```bash
curl -fsSL https://raw.githubusercontent.com/bortolottic/pro-agent-hub-installer/refs/heads/main/install.sh | bash
```

O instalador irá automaticamente:
1. Detectar a versão mais recente disponível
2. Baixar o pacote de instalação
3. Descompactar os arquivos
4. Executar o deploy em produção

### Instalar uma versão específica

Caso precise de uma versão específica (por exemplo, para ambientes de homologação ou rollback):

```bash
curl -fsSL https://raw.githubusercontent.com/bortolottic/pro-agent-hub-installer/refs/heads/main/install.sh | bash -s v1.0.25.2
```

Substitua `v1.0.25.2` pelo número da versão desejada.

---

## Como funciona (para técnicos)

O `install.sh` executa as seguintes etapas:

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
| `curl ou wget não encontrado` | Nenhuma das ferramentas está instalada | Instale com `apt install curl` ou `apt install wget` |
| Erro ao baixar o pacote | URL incorreta ou versão inexistente | Verifique as [releases disponíveis](https://github.com/bortolottic/pro-agent-hub-installer/releases) |
| Docker não encontrado | Docker não está instalado ou não está no PATH | Instale o Docker Desktop e certifique-se de que está rodando |
| Deploy falha silenciosamente | Problema no `deploy_production.sh` | Verifique os logs com `docker service ls` e `docker stack ps <nome>` |

---

## Versões disponíveis

Todas as versões estão listadas na página de [Releases do GitHub](https://github.com/bortolottic/pro-agent-hub-installer/releases).

---

## Suporte

Em caso de dúvidas ou problemas, entre em contato com a equipe responsável pelo projeto.
