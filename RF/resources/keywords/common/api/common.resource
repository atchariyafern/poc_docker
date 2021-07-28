*** Settings ***
Resource  ../../../../resources/init.resource

Variables  ../../../sale_crm/locators/crm_sabye_songkran/login.yaml

*** Keywords ***
Generate Robot Automation Header
    [Arguments]  ${user_name}  ${password}  ${grant_type}=password
    Create Session  ${GATEWAY_SESSION}  ${API_HOST}  verify=true
    &{user_information}=  Create Dictionary  username=${user_name}  password=${password}  grant_type=${grant_type}
    &{headers}=  Create Dictionary  Content-Type=application/json
    ${resp}=  Post Request  ${GATEWAY_SESSION}  api/auth  data=${user_information}  headers=${headers}
    &{resp_body}=  To Json  ${resp.text}
    Set Suite Variable  ${ACCESS_TOKEN}  ${resp_body.access_token}
    &{GATEWAY_HEADER}=  Create Dictionary  authorization=Bearer ${ACCESS_TOKEN}  Content-Type=application/json
    Set Suite Variable  &{GATEWAY_HEADER}

Response Should Contain Property With Value
    [Arguments]  ${property}  ${value}
    ${property_value}=  Get Value From Json  ${RESP.json()}  ${property}
    run keyword and continue on failure  List Should Contain Value  ${property_value}  ${value}

Response Should Contain Property With String Value
    [Arguments]  ${property}  ${value}
    ${property_value}=  Get Value From Json  ${RESP.json()}  ${property}
    run keyword and continue on failure  should be equal as strings  ${property_value}  ${value}

Response Should Not Contain Property With String Value
    [Arguments]  ${property}  ${value}
    ${property_value}=  Get Value From Json  ${RESP.json()}  ${property}
    run keyword and continue on failure  should not be equal as strings  ${property_value}  ${value}

Response Should Contain Property With Number Value
    [Arguments]  ${property}  ${value}
    ${property_value}=  Get Value From Json  ${RESP.json()}  ${property}
    run keyword and continue on failure  should be equal as numbers  ${property_value}  ${value}

Response Should Not Contain Property With Number Value
    [Arguments]  ${property}  ${value}
    ${property_value}=  Get Value From Json  ${RESP.json()}  ${property}
    run keyword and continue on failure  should not be equal as numbers  ${property_value}  ${value}

Generate Robot Automation Header With Cookie
    [Arguments]  ${url}  ${username}  ${password}  ${headless_mode}=${TRUE}  ${web_driver}=chrome
    run keyword if  ${headless_mode}==${TRUE}  Open Browser  ${url}  headlesschrome
    ...  ELSE  Open Browser  ${url}  ${web_driver}
    Wait Until Element Is Visible  ${txt_username}  timeout=5s
    Input Text  ${txt_username}  ${username}
    Input Text  ${txt_password}  ${password}
    Click Button  ${btn_signin}
    ${cookie}=  Get Cookies
    ${headers}=  Create Dictionary  content-type=application/json   cookie=${cookie}
    Create Session  ${GATEWAY_SESSION}  ${url}  headers=${headers}  verify=true
