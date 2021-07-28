*** Settings ***
Resource  ../../../init.resource

*** Keywords ***
Get List Of Leads
    [Arguments]  ${param_uri}=${EMPTY}
    ${RESP}=  GET On Session  ${GATEWAY_SESSION}  /api/lead/v1alpha2/leads  params=${param_uri}
    Set Test Variable  ${RESP}

POST Leads