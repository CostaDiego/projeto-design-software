# Fluxo de Atendimento e Gerenciamento de Prontuário

## Atores
*   **Paciente**
*   **Recepcionista**
*   **Psicólogo(a)**
*   **Sistema de Armazenamento**

## Fluxo Principal de Atividades

1.  **Paciente** vai até a sala de recepção e conversa com a **Recepcionista**.
2.  *Decisão: Paciente novo?*

    ### Se **SIM** (Novo Paciente):
    3.  A **Recepcionista** cadastra o novo perfil e cria um prontuário personalizado.
    4.  A **Recepcionista** seleciona o **Psicólogo(a)** disponível para o atendimento do paciente.
    *(Continua no passo 6)*

    ### Se **NÃO** (Paciente Existente):
    3.  A **Recepcionista** busca pelo nome do paciente no sistema.
    4.  A **Recepcionista** comunica o **Psicólogo(a)** que já está selecionado para o paciente.
    5.  O **Psicólogo(a)** chama o paciente para realizar a sessão de terapia.
    *(Continua no passo 7)*

6.  O **Psicólogo(a)** chama o paciente para realizar a sessão de terapia.
7.  O **Psicólogo(a)** faz as anotações necessárias sobre a consulta.
8.  O **Psicólogo(a)** termina a sessão e dispensa o paciente.
9.  O **Psicólogo(a)** abre o prontuário do paciente para transcrever todas as anotações da sessão.
10. O **Psicólogo(a)** utiliza o **Sistema de Armazenamento** para salvar o prontuário do paciente.