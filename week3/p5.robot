*** Settings ***
Library     SeleniumLibrary
Library     Collections

*** Variables ***
${from}    Coimbatore
${to}      Trivandrum
${urlCustomer}    https://www.makemytrip.com/
${ascOrder}       ascending
${dscOrder}       descending
${durationsofKsrtc}    # Initialize as an empty list
${durationsofPrivate}  # Initialize as an empty list

*** Test Cases ***
TC-001 Verify Initial toggle to shortest duration
    Open Make My Trip As
    Search Buses    ${from}    ${to}
    Toggle Fastest Sorting And Validate
    Get Bus Durations of KSRTC     ${durationsofKsrtc}
    Get Bus Durations of Private     ${durationsofPrivate} 
    @{allDurations}    Join Lists Using Combine Lists    ${durationsofKsrtc}    ${durationsofPrivate}
    Log    All Durations: ${allDurations}
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
    @{firstDurations}    Join Lists Using Combine Lists    ${durationsofKsrtc}    ${durationsofPrivate}  
    Log   Current list: ${firstDurations}
    Validate Durations Sorted    ${firstDurations}   order=${ascOrder}

    Click Element    //div[@class="makeFlex hrtlCenter"]//li[contains(text(), 'Fastest')]
    Wait Until Buses Are Loaded
    @{secondDurations}    Join Lists Using Combine Lists    ${durationsofKsrtc}    ${durationsofPrivate} 
    Validate Durations Sorted    ${secondDurations}  order=${dscOrder}

Get Bus Durations of KSRTC  
    ${durationsofKsrtc}    Create List
    ${numberOfBuses}     Get Element Count    //p[contains(text(),"KSRTC")]/ancestor::div[@class='makeFlex false']//div[@class='font14 secondaryTxt']
    ${numberOfBuses}    Evaluate     $numberOfBuses+1
    FOR    ${index}    IN RANGE    1    ${numberOfBuses}
        ${durationText}    Get Text    (//p[contains(text(),"KSRTC")]/ancestor::div[@class='makeFlex false']//div[@class='font14 secondaryTxt'])[${index}]
        ${hours}    Set Variable    0
        ${minutes}  Set Variable    0
        ${hoursText}   Evaluate    '''${durationText}'''.split("hrs")[0].strip()
        ${hours}   Convert To Integer    ${hoursText}
        ${minutesText}    Evaluate    '''${durationText}'''.split("hrs")[-1].split("mins")[0].strip()
        ${minutes}      Convert To Integer    ${minutesText}
        ${totalDuration}    Evaluate    (${hours}*60) + ${minutes} 
        Append To List    ${durationsofKsrtc}    ${totalDuration}
    END
    Log    KSRTC Durations: ${durationsofKsrtc}
    [Return]    ${durationsofKsrtc}