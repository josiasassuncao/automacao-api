*** Settings ***
Resource    ../steps/user_steps.robot
Test Setup    Eu acesso a API Reqres

*** Test Cases ***
Scenario: Criar um novo usuário
    Given Eu crio um novo usuário 
    When O status da resposta deve ser 201
    Then A resposta deve conter os detalhes do usuário criado


Scenario: Obter o usuário criado
    Given Um usuário foi criado
    And Eu obtenho o usuário pelo ID
    When O status da resposta deve ser 200
    Then A resposta deve conter os detalhes do usuário


Scenario: Atualizar o usuário criado
    Given Um usuário foi criado
    When Eu atualizo o usuário com os seguintes detalhes 
    Then O status da resposta deve ser 200
    Then A resposta deve conter os detalhes do usuário atualizado

Scenario: Deletar o usuário criado
    Given Um usuário foi criado
    When Eu deleto o usuário pelo ID
    Then O status da resposta deve ser 204

Scenario: Obter o usuário deletado
    Given Um usuário foi deletado
    And Eu obtenho o usuário pelo ID
    When O status da resposta deve ser 404
    Then A resposta deve conter uma mensagem de erro