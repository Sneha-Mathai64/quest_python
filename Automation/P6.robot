* Settings *
# SeleniumLibrary
Library     SeleniumLibrary
Library     Collections
Resource    GeneralKeyword.robot
Library     Date.py
Test Teardown     Clear Filter     Register Result

* Variables *
${from}    Coimbatore
${to}      Trivandrum
${date}    23 Aug
#${date}    None   # Optional date


* Test Cases *
Parent Test Case
    [Tags]    parent
    run keyword and ignore error      Log     ${url}
    Set Test Variable     ${url}    pre ${TEST_NAME}
#    ${url}    Set Variable     test variable
    Log     ${url}
    Some Keyword
    Log     ${url}
    Set Suite Variable     ${url}    post ${TEST_NAME}
    Log     ${url}

    ${some}    Set Variable

Child
#    [Tags]    parent

    ${parentResult}    Get Result For Test     Parent Test Case
    Skip If     '${parentResult}'=='FAIL'


    run keyword and ignore error      Log     ${url}
    Set Test Variable     ${url}    pre ${TEST_NAME}
#    ${url}    Set Variable     test variable
    Log     ${url}
    Some Keyword
    Log     ${url}
    Set Test Variable     ${url}    post ${TEST_NAME}
    Log     ${url}





#    Log    Pass
#    Run Keyword     FAIL
#    Some Keyword
    #Red



#Parent test case


Child TC 1
    [Documentation]     This test case is dependant on "Parent Test Case".
    Skip If     '${PREV TEST STATUS}'=='FAIL' and '${PREV TEST STATUS}'=='SKIP'
    ...          Skipping this test because ${PREV TEST NAME} has failed with error: ${PREV TEST MESSAGE}
    Sleep     3s
    #many lines below
    #Yellow

Child TC 2
    [Documentation]     This test case is dependant on "Parent Test Case".
    ...      Step1
    ...      Step2
    Skip If     '${PREV TEST STATUS}'=='FAIL' and '${PREV TEST STATUS}'=='SKIP'
    ...         Skipping this test because ${PREV TEST NAME} has failed with error: ${PREV TEST MESSAGE}
    Sleep     3s
    #many lines below

Search Bus
    Search Buses
    [Arguments]    ${fromCity}    ${toCity}    ${date}
    IF    '${date}' == '${None}'
        ${day}    ${month}    Get Current Day And Month
    ELSE
        ${day}    ${month}    Split String    ${date}    ${SPACE}
    END
    Log    ${day} ${month}

* Keywords *

Register Result
   # add to dictionary
    #   key : TEST_NAME
    #   status

Get Status For Test
    [Arguments]     ${nameOfTest}
            Get From Dictionary
    [Return]
