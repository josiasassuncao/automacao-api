*** Settings ***
Library     RequestsLibrary


*** Variables ***
${BASE_URL}         https://reqres.in/api
${USER_ID}          0
${user_details}     ${EMPTY}
${response}         ${EMPTY}


*** Keywords ***
Eu acesso a API Reqres
    Create Session    reqres    ${BASE_URL}

Eu crio um novo usuário
    ${user_details}=    Create Dictionary    nome=João    trabalho=Líder
    ${response}=    Eu crio um novo usuário com os seguintes detalhes    ${user_details}
    Set Suite Variable    ${response}

Eu crio um novo usuário com os seguintes detalhes
    [Arguments]    ${user_details}
    ${response}=    POST On Session    reqres    /users    json=${user_details}
    Set Suite Variable    ${USER_ID}    ${response.json()['id']}
    RETURN    ${response}

Um usuário foi criado
    ${user_details}=    Create Dictionary    nome=João    trabalho=Líder
    ${response}=    Eu crio um novo usuário com os seguintes detalhes    ${user_details}
    Set Suite Variable    ${response}

Eu obtenho o usuário pelo ID
    ${response}=    GET On Session    reqres    /users/${USER_ID}
    Set Suite Variable    ${response}

Eu atualizo o usuário com os seguintes detalhes
    ${user_details}=    Create Dictionary    nome=João    trabalho=Gerente
    ${response}=    PUT On Session    reqres    /users/${USER_ID}    json=${user_details}
    Set Suite Variable    ${response}

Eu deleto o usuário pelo ID
    ${response}=    DELETE On Session    reqres    /users/${USER_ID}
    Set Suite Variable    ${response}

Um usuário foi deletado
    Eu deleto o usuário pelo ID

O status da resposta deve ser 201
    Should Be Equal As Numbers    ${response.status_code}    201

O status da resposta deve ser 200
    Should Be Equal As Numbers    ${response.status_code}    200

O status da resposta deve ser 204
    Should Be Equal As Numbers    ${response.status_code}    204

O status da resposta deve ser 404
    Should Be Equal As Numbers    ${response.status_code}    404

A resposta deve conter os detalhes do usuário criado
    Should Contain    ${response.json()['nome']}    João
    Should Contain    ${response.json()['trabalho']}    Líder

A resposta deve conter os detalhes do usuário atualizado
    Should Contain    ${response.json()['nome']}    João
    Should Contain    ${response.json()['trabalho']}    Gerente

A resposta deve conter os detalhes do usuário
    Should Contain    ${response.json()['data']['id']}    ${USER_ID}

A resposta deve conter uma mensagem de erro
    Should Contain    ${response.json()}    "user not found"
