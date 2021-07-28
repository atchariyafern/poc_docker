*** Settings ***
Documentation    POC Common keyword

Resource  ../../../../resources/keywords/common/api/common.resource
Resource  ../../../../resources/sale_crm/api/lead/lead.resource

Variables  ../../../../resources/sale_crm/test_data/${ENV}/data.yaml

*** Test Cases ***
TC_001 - get success
    [Tags]  Regression  Low  E2E  api  lead  db table_name  tc_001
    Generate Robot Automation Header With Cookie  ${url_crm_sabye_songkran}  ${username}  ${password}
    Get List Of Leads
#    Response Should Contain Property With String Value  $..product  products/car-insurance

TC_002 - get success
    [Tags]  Medium
    Generate Robot Automation Header With Cookie  ${url_crm_sabye_songkran}  ${username}  ${password}
    Get List Of Leads