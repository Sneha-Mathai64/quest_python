*** Settings ***
Library     SeleniumLibrary
Library     Collections

*** Variables ***
${from}    Coimbatore
${to}      Trivandrum
${urlCustomer}    https://www.makemytrip.com/
${ascOrder}       ascending
${dscOrder}       descending

*** Test Cases ***
TC-001 Verify Initial toggle to shortest duration
    Open Make My Trip As
    Search Buses    ${from}    ${to}
    Toggle Fastest Sorting And Validate
    
    # Get Bus Durations
    ${ksrtcXpath}    //p[contains(text(),"KSRTC")]/ancestor::div[@class='makeFlex false']//div[@class='font14 secondaryTxt']
    ${privateXpath}    //div[@class="rtcEnd"]/following-sibling::div[@class='busCardContainer ']//div[@class="font14 secondaryTxt"]

    ${durationsofKsrtc}    Get Bus Durations    KSRTC    ${ksrtcXpath}
    Log    KSRTC Durations: ${durationsofKsrtc}

    ${durationsofPrivate}    Get Bus Durations    Private    ${privateXpath}
    Log    Private Bus Durations: ${durationsofPrivate}

    # Combine All Bus Durations
    ${AllBusDuration}    Get All Bus Duration    ${durationsofKsrtc}    ${durationsofPrivate}
    Log    All Bus Durations: ${AllBusDuration}

    # Validate Sorting
    Click Element    //div[@class="makeFlex hrtlCenter"]//li[contains(text(), 'Fastest')]
    Wait Until Buses Are Loaded
    @{firstDurations}    Get All Bus Duration
    Log   Current list: ${firstDurations}
    Validate Durations Sorted    ${firstDurations}   order=${ascOrder}

    Click Element    //div[@class="makeFlex hrtlCenter"]//li[contains(text(), 'Fastest')]
    Wait Until Buses Are Loaded
    @{secondDurations}    Get All Bus Duration 
    Validate Durations Sorted    ${secondDurations}  order=${dscOrder}

*** Keywords ***
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

Toggle Fastest Sorting And Validate
    Click Element    //div[@class="makeFlex hrtlCenter"]//li[contains(text(), 'Fastest')]
    Wait Until Buses Are Loaded
    @{firstDurations}    Get All Bus Duration
    Log   Current list: ${firstDurations}
    Validate Durations Sorted    ${firstDurations}   order=${ascOrder}

    Click Element    //div[@class="makeFlex hrtlCenter"]//li[contains(text(), 'Fastest')]
    Wait Until Buses Are Loaded
    @{secondDurations}    Get All Bus Duration 
    Validate Durations Sorted    ${secondDurations}  order=${dscOrder}

Wait Until Buses Are Loaded
    Wait Until Element Is Not Visible    //div[@class="loader"]    timeout=20s
    Wait Until Element Is Visible        //div[@class="busCardContainer "]//div[contains(@class,"makeFlex false")][1]    timeout=20s
    Wait Until Page Contains Element    //div[contains(@class,'secondaryTxt')]    timeout=20s

Get Bus Durations
    [Arguments]    ${busType}    ${xpath}
    ${durationList}    Create List
    ${numberOfBuses}     Get Element Count    ${xpath}
    ${numberOfBuses}    Evaluate     $numberOfBuses+1
    FOR    ${index}    IN RANGE    1    ${numberOfBuses}
        ${durationText}    Get Text    (${xpath})[${index}]
        ${hours}    Set Variable    0
        ${minutes}  Set Variable    0
        ${hoursText}   Evaluate    '''${durationText}'''.split("hrs")[0].strip()
        ${hours}   Convert To Integer    ${hoursText}
        ${minutesText}    Evaluate    '''${durationText}'''.split("hrs")[-1].split("mins")[0].strip()
        ${minutes}      Convert To Integer    ${minutesText}
        ${totalDuration}    Evaluate    (${hours}*60) + ${minutes} 
        Append To List    ${durationList}    ${totalDuration}
    END
    Log    ${busType} Durations: ${durationList}
    [Return]    ${durationList}

Get All Bus Duration
    [Arguments]    ${durationsofKsrtc}    ${durationsofPrivate}
    ${AllBusDuration}    Evaluate    ${durationsofKsrtc} + ${durationsofPrivate}
    Log    All Bus Durations Combined: ${AllBusDuration}
    [Return]    ${AllBusDuration}

Validate Durations Sorted
    [Arguments]    ${AllBusDuration}    ${order}=${None}
    Log  Durations: ${AllBusDuration}
    ${sortedDurationsFinal}     Copy List     ${AllBusDuration}
    Sort List       ${sortedDurationsFinal}   
    Run Keyword If    '${order}' == 'descending'    Reverse List    ${sortedDurationsFinal}
    Should Be Equal    ${sortedDurationsFinal}    ${AllBusDuration}
    Log   Sorted Durations: ${sortedDurationsFinal}
