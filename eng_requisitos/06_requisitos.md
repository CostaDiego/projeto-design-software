Com base no contexto do sistema e nas restrições/premissas fornecidas, vamos refinar e detalhar os Requisitos Funcionais e Não-Funcionais, adicionando valores tangíveis, especialmente em relação à arquitetura.

## 📝 Requisitos Detalhados do Sistema

### 1. Requisitos Funcionais (RF)

| ID | Módulo | Requisito Funcional (Detalhamento) | Critério de Aceitação / Regras |
| :--- | :--- | :--- | :--- |
| **RF001** | **Agendamento** | **Gerenciar Agendamentos Recorrentes:** O Secretário deve poder criar, cancelar ou reagendar uma série de consultas recorrentes com um único comando. | O sistema deve solicitar confirmação para aplicar a alteração a *todos os agendamentos futuros* ou *somente ao agendamento atual*. |
| **RF002** | **Agendamento** | **Validação de Conflito de Horário:** O sistema deve verificar a disponibilidade do Psicólogo e da sala no momento da criação ou edição de um agendamento. | Se houver conflito (mesmo Psicólogo, mesma hora), o sistema deve **impedir a gravação** e exibir uma mensagem de erro clara. |
| **RF003** | **Prontuário** | **Criação e Edição de Prontuário:** O Psicólogo deve ter uma interface dedicada para transcrever anotações da sessão, permitindo a formatação básica (texto, listas). | O sistema deve **auto-salvar rascunhos** a cada 60 segundos ou em caso de perda de conexão (local storage temporário). |
| **RF004** | **Prontuário** | **Busca e Visualização de Prontuário:** O Psicólogo e a Recepcionista (com acesso limitado) devem poder buscar prontuários de pacientes. | A busca deve ser instantânea (em menos de 1 segundo) e permitir filtragem por nome, CPF e data do último atendimento. |
| **RF005** | **Versionamento** | **Rastreamento de Versões (Histórico):** O sistema deve manter um histórico de todas as modificações feitas em um prontuário. | O usuário (Psicólogo) deve poder **visualizar** e **restaurar** qualquer versão anterior do documento. |
| **RF006** | **Acesso/Perfil** | **Gerenciamento de Perfis de Acesso (RBAC):** O sistema deve implementar um sistema de controle de acesso baseado em função (Role-Based Access Control - RBAC) que restrinja o acesso a dados de prontuário, garantindo que apenas o Psicólogo e o Paciente (se aplicável) tenham acesso total. | A Recepcionista só pode acessar dados de identificação e agendamento (Ex: Nome, Telefone, Horário), sendo bloqueada de visualizar o conteúdo clínico do prontuário (conforme HU6). |
| **RF007** | **Acesso/Perfil** | **Criação e Gestão de Contas:** O sistema deve permitir a criação e manutenção de perfis de Secretários, Psicólogos e Pacientes (para agendamento online futuro). | O registro deve exigir verificação por e-mail/telefone. Senhas devem ser armazenadas com *hash* e *salt*. |

***

### 2. Requisitos Não-Funcionais (RNF)

| ID | Categoria | Requisito Não-Funcional (Detalhamento) | Valor/Métrica Tangível para a Arquitetura |
| :--- | :--- | :--- | :--- |
| **RNF001** | **Segurança (Dados)** | **Criptografia e Confidencialidade:** Todos os dados sensíveis (conteúdo de prontuários, senhas) devem ser armazenados criptografados em repouso. | Utilização de **AES-256** para dados no banco de dados (armazenamento de prontuários). Implementar **TLS/SSL (HTTPS)** de ponta a ponta na comunicação. |
| **RNF002** | **Segurança (Acesso)** | **Controle de Sessão:** O sistema deve proteger contra acesso não autorizado a contas que permaneceram logadas. | Implementar **expiração de sessão** após **30 minutos de inatividade** e exigir reautenticação após 8 horas (conforme HU3). |
| **RNF003** | **Desempenho** | **Latência de Busca:** A recuperação e carregamento de um prontuário ou a busca por um paciente deve ser quase instantânea. | Tempo máximo de resposta (Latência) para carregamento de prontuários: **< 1.5 segundos** (95% das requisições). |
| **RNF004** | **Confiabilidade/Integridade** | **Tolerância a Falhas e Versionamento:** Os dados não devem ser perdidos devido a falhas de hardware ou erros de usuário. | Implementar **backups diários** com retenção de **7 dias** e garantir o **commit** em banco de dados a cada salvamento de prontuário (garantia ACID). |
| **RNF005** | **Escalabilidade** | **Suporte ao Volume de Dados:** O sistema deve ser capaz de lidar com o crescimento de pacientes e o número de consultas. | A arquitetura de banco de dados (ex: clusterização) deve ser capaz de suportar até **10.000 pacientes ativos** e **50.000 prontuários** sem degradação do desempenho (RNF003). |
| **RNF006** | **Disponibilidade** | **Tempo de Funcionamento:** O sistema deve estar disponível continuamente para atender ao fluxo de trabalho da clínica. | O sistema deve ter um **Uptime de 99,8%** (equivalente a no máximo 17 horas de inatividade anual planejada ou não). |
| **RNF007** | **Manutenibilidade** | **Estrutura de Código/Arquitetura:** A arquitetura deve facilitar a manutenção e a inclusão de novas funcionalidades (p. ex., agendamento online). | Arquitetura de microsserviços ou em camadas (Ex: Frontend, Backend, Database) para separação clara de responsabilidades, facilitando o desenvolvimento por diferentes equipes (*time backend* e *time frontend*). |
| **RNF008** | **Usabilidade** | **Experiência do Usuário (UX/UI):** A interface deve ser projetada para minimizar a curva de aprendizado e o esforço do usuário. | O tempo para a criação de um novo agendamento por um usuário treinado não deve exceder **30 segundos** (redução da lentidão). |