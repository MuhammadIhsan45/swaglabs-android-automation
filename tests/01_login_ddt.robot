*** Settings ***
Resource          ../resources/keywords.robot
Test Setup        Start App
Test Teardown     Stop App
Test Template     Login Scenario Template

*** Test Cases ***                        USERNAME           PASSWORD         EXPECTED_OUTPUT
Login Success Standard User               standard_user      secret_sauce     PRODUCTS
Login Failed Locked Out User              locked_out_user    secret_sauce     Sorry, this user has been locked out.
Login Failed Wrong Password               standard_user      wrong_pass       Username and password do not match any user in this service.
Login Failed Empty Username               ${EMPTY}           secret_sauce     Username is required
Login Failed Empty Password               standard_user      ${EMPTY}         Password is required

*** Keywords ***
Login Scenario Template
    [Arguments]    ${username}    ${password}    ${expected_output}
    
    Login With Credentials    ${username}    ${password}
    Verify Login Result       ${expected_output}