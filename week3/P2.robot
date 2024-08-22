*** Settings ***
Library     SeleniumLibrary
Library     Collections
Suite Setup     Setup Suite Environment
Suite Teardown  Teardown Suite Environment
Test Setup      Setup Test Environment
Test Teardown   Teardown Test Environment

*** Variables ***
${from}    Coimbatore
${to}      Trivandrum
${urlCustomer}    https://www.makemytrip.com/
${urlOperator}    https://www.operator.makemytrip.com
${ascOrder}       ascending
${dscOrder}       descending

*** Test Cases ***
TC-001 Verify if a user is able to filter bus according to their travel duration
    get all ksrtc view details
    Toggle Fastest Sorting And Validate

*** Keywords ***
Setup Suite Environment
    Open Make My Trip As

Teardown Suite Environment
    Close Browser

Setup Test Environment
    Search Buses    ${from}    ${to}

Teardown Test Environment
    Capture Page Screenshot
Open Make My Trip As
    Open Browser     browser=chrome
    Maximize Browser Window
    Go To            ${urlCustomer}
    Sleep    5s
    Click Element    //span[@data-cy="closeModal"]

Search Buses
    [Arguments]    ${from}        ${to}
    Click Element    //nav//li[@class="menu_Buses"]
    Wait Until Element Is Visible     fromCity     10s
    Click Element        fromCity
    Wait Until Element Is Visible     //input[@placeholder="From"]     10s
    Input Text       //input[@placeholder="From"]     ${from}
    Wait Until Element Is Visible    //div[contains(@class, 'autosuggest')]//span[contains(text(),'${from},')]
    Click Element    //div[contains(@class, 'autosuggest')]//span[contains(text(),'${from},')]

    Wait Until Element Is Visible     toCity     10s
    Run Keyword And Ignore Error        Click Element        toCity
    Wait Until Element Is Visible     //input[@placeholder="To"]     10s
    Input Text       //input[@placeholder="To"]     ${to}
    Wait Until Element Is Visible       //div[contains(@class, 'autosuggest')]//span[contains(text(),'${to},') or contains(text(),'(${to}),')]
    Click Element    //div[contains(@class, 'autosuggest')]//span[contains(text(),'${to},') or contains(text(),'(${to}),')]

    Run Keyword And Ignore Error    Click Element    travelDate
    Wait Until Element Is Visible     //div[contains(text(), 'August')]/ancestor::div[@class="DayPicker-Month"]//div[text()='20']     10s
    Click Element    //div[contains(text(), 'August')]/ancestor::div[@class="DayPicker-Month"]//div[text()='20']
    Click Element    search_button
    Wait Until Element Is Visible     //div[@class="busListingContainer"]//p[contains(text(),'found')]

get all ksrtc view details
    run keyword and ignore error     Click Element     //div[@id="toggle_buses" and not(contains(@class,'active'))]

Get List of duration Strings with Separation
    ${masterlist}    Create List
    ${currentlist}   Create List
    ${durationlist}  Create List

Toggle Fastest Sorting And Validate
    
    Click Element    //div[@class="makeFlex hrtlCenter"]//li[contains(text(), 'Fastest')]
    Wait Until Buses Are Loaded
    @{firstDurations}    Get All Bus Durations
    Log   current list: ${firstDurations}
    Sort List       ${firstDurations}  
    Log   new list: ${firstDurations}
    Validate Durations Sorted    ${firstDurations}   order=${ascOrder}


    Click Element    //div[@class="makeFlex hrtlCenter"]//li[contains(text(), 'Fastest')]
    Wait Until Buses Are Loaded
    @{secondDurations}    Get All Bus Durations 
    Validate Durations Sorted    ${secondDurations}  order=${dscOrder}


Wait Until Buses Are Loaded

    Wait Until Element Is Not Visible    //div[@class="loader"]    timeout=20s
    Wait Until Element Is Visible        //div[@class="busCardContainer "]//div[contains(@class,"makeFlex false")][1]    timeout=20s
    Wait Until Page Contains Element    //div[contains(@class,'secondaryTxt')]    timeout=20s
Get All Bus Durations
     
    ${durations}    Create List
    ${numberOfBuses}     Get Element Count    //ancestor::div[contains(@class,"makeFlex false")]//div[contains(@class,"secondaryTxt")]
    ${numberOfBuses}    Evaluate     $numberOfBuses+1
     FOR    ${index}    IN RANGE    1    ${numberOfBuses}
        ${durationText}    Get Text    (//ancestor::div[contains(@class,"makeFlex false")]//div[contains(@class,"secondaryTxt")])[${index}]
        ${hours}    Set Variable    0
        ${minutes}  Set Variable    0
        ${hoursText}   Evaluate    '''${durationText}'''.split("hrs")[0].strip()
        ${hours}   Convert To Integer    ${hoursText}
        ${minutesText}    Evaluate    '''${durationText}'''.split("hrs")[-1].split("mins")[0].strip()
        ${minutes}      Convert To Integer    ${minutesText}
        ${totalDuration}    Evaluate    (${hours}*60) + ${minutes} 
        Append To List    ${durations}    ${totalDuration}
    END
    Log    ${durations}
    [Return]    ${durations}

Validate Durations Sorted
    [Arguments]    ${durations}     ${order}=${None}
    Log  duration: ${durations}
    ${sortedDurationsFinal}     Copy List     ${durations}
    Sort List       ${sortedDurationsFinal}   
    Run Keyword If         '${order}' == 'descending'     Reverse List     ${sortedDurationsFinal}
    Should Be Equal    ${sortedDurationsFinal}     ${durations}
    Log   ${sortedDurationsFinal}