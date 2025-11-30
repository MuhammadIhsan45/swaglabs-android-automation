*** Settings ***
Resource          ../resources/keywords.robot
Test Setup        Start App
Test Teardown     Stop App
Test Template     Login Scenario Template

*** Test Cases ***                        USERNAME           PASSWORD         EXPECTED_OUTPUT
TC01 Login Success Standard User               standard_user      secret_sauce     PRODUCTS
TC02 Login Failed Locked Out User              locked_out_user    secret_sauce     Sorry, this user has been locked out.
TC03 Login Failed Wrong Password               standard_user      wrong_pass       Username and password do not match any user in this service.
TC04 Login Failed Empty Username               ${EMPTY}           secret_sauce     Username is required
TC05 Login Failed Empty Password               standard_user      ${EMPTY}         Password is required

*** Keywords ***
Login Scenario Template
    [Arguments]    ${username}    ${password}    ${expected_output}
    
    Login With Credentials    ${username}    ${password}
    Verify Login Result       ${expected_output}