*** Settings ***
Library     SeleniumLibrary
Library     Collections
Suite Setup     Open Browser And Navigate To MakeMyTrip
Suite Teardown  Close Browser

*** Variables ***
${from}    Coimbatore
${to}      Trivandrum
${urlCustomer}    https://www.makemytrip.com/
${ascOrder}       ascending
${dscOrder}       descending

*** Test Cases ***
TC-001 Verify Initial Toggle to Shortest Duration
    [Setup]       Test Setup
    Toggle Fastest Sorting And Validate 
    [Teardown]    Reset Sorting To Ascending Order

*** Keywords ***
Open Browser And Navigate To MakeMyTrip
    Open Browser     ${urlCustomer}    browser=chrome
    Maximize Browser Window
    Sleep    5s
    Click Element    //span[@data-cy="closeModal"]

Close Browser
    Close All Browsers

Test Setup
    Search Buses    ${from}    ${to}

Reset Sorting To Ascending Order
    # Check the current state of the sorting button
    ${isDescending}  Run Keyword And Return Status  Element Should Be Visible  //div[contains(@class,'sortDownIcon')]
    Run Keyword If    ${isDescending}    Click Element    //div[@class="makeFlex hrtlCenter"]//li[contains(text(), 'Fastest')]
    Wait Until Buses Are Loaded
    Log    Sorting reset to ascending order

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
    Wait Until Element Is Visible     //div[contains(text(), 'August')]/ancestor::div[@class="DayPicker-Month"]//div[text()='23']     10s
    Click Element    //div[contains(text(), 'August')]/ancestor::div[@class="DayPicker-Month"]//div[text()='23']
    Click Element    search_button
    Wait Until Element Is Visible     //div[@class="busListingContainer"]//p[contains(text(),'found')]

Toggle Fastest Sorting And Validate
    run keyword and ignore error     Click Element     //div[@id="toggle_buses" and not(contains(@class,'active'))]
    Click Element    //div[@class="makeFlex hrtlCenter"]//li[contains(text(), 'Fastest')]
    Wait Until Buses Are Loaded
    @{durationsofKsrtc}       Get Bus Durations of KSRTC       
    Log    :${durationsofKsrtc} 
    @{durationsofPrivate}       Get Bus Durations of Private     
    Log    :${durationsofPrivate} 
    @{firstDurations}    Join Lists Using Combine Lists    ${durationsofKsrtc}    ${durationsofPrivate}  
    Log   Current list: ${firstDurations}
    Validate Durations Sorted    ${firstDurations}   order=${ascOrder}

    Click Element    //div[@class="makeFlex hrtlCenter"]//li[contains(text(), 'Fastest')]
    Wait Until Buses Are Loaded
    @{durationsofKsrtc}       Get Bus Durations of KSRTC       
    Log    :${durationsofKsrtc} 
    @{durationsofPrivate}       Get Bus Durations of Private     
    Log    :${durationsofPrivate} 
    @{secondDurations}    Join Lists Using Combine Lists    ${durationsofKsrtc}    ${durationsofPrivate} 
    Validate Durations Sorted    ${secondDurations}  order=${dscOrder}

Wait Until Buses Are Loaded
    Wait Until Element Is Not Visible    //div[@class="loader"]    timeout=20s
    Wait Until Element Is Visible        //div[@class="busCardContainer "]//div[contains(@class,"makeFlex false")][1]    timeout=20s
    Wait Until Page Contains Element    //div[contains(@class,'secondaryTxt')]    timeout=20s

Get Bus Durations of KSRTC  
    ${durationsofKsrtc}    Create List
    Wait Until Element Is Visible  //p[contains(text(),"KSRTC")]/ancestor::div[@class='makeFlex false']//div[@class='font14 secondaryTxt']
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

Get Bus Durations of Private
    ${durationsofPrivate}    Create List
    Wait Until Element Is Visible      //div[@class="rtcEnd"]/following-sibling::div[@class='busCardContainer ']//div[@class="font14 secondaryTxt"]
    ${numberOfBuses}     Get Element Count    //div[@class="rtcEnd"]/following-sibling::div[@class='busCardContainer ']//div[@class="font14 secondaryTxt"]
    ${numberOfBuses}    Evaluate     $numberOfBuses+1
    FOR    ${index}    IN RANGE    1    ${numberOfBuses}
        ${durationText}    Get Text    (//div[@class="rtcEnd"]/following-sibling::div[@class='busCardContainer ']//div[@class="font14 secondaryTxt"])[${index}]
        ${hours}    Set Variable    0
        ${minutes}  Set Variable    0
        ${hoursText}   Evaluate    '''${durationText}'''.split("hrs")[0].strip()
        ${hours}   Convert To Integer    ${hoursText}
        ${minutesText}    Evaluate    '''${durationText}'''.split("hrs")[-1].split("mins")[0].strip()
        ${minutes}      Convert To Integer    ${minutesText}
        ${totalDuration}    Evaluate    (${hours}*60) + ${minutes} 
        Append To List    ${durationsofPrivate}    ${totalDuration}
    END
    Log    Private Durations: ${durationsofPrivate}
    [Return]    ${durationsofPrivate}

Join Lists Using Combine Lists

    [Arguments]    ${durationsofKsrtc}    ${durationsofPrivate}
    Log    ${durationsofKsrtc}  
    Log    ${durationsofPrivate}
    ${AllBusDuration}=   Create List    ${durationsofKsrtc}   ${durationsofPrivate}
    Log     ${AllBusDuration}   
    Log     ${AllBusDuration[0]}
    Log   ${AllBusDuration[1]}
    [Return]    ${AllBusDuration}

Validate Durations Sorted
    [Arguments]    ${AllBusDuration}     ${order}=${None}
    Log  Durations: ${AllBusDuration}
    ${sortedDurationsFinal}     Copy List     ${AllBusDuration}
    Sort List       ${sortedDurationsFinal[0]}   
    Log      ${sortedDurationsFinal[0]} 
    Sort List       ${sortedDurationsFinal[1]}   
    Log      ${sortedDurationsFinal[1]} 
    Log  ${sortedDurationsFinal} 
    Run Keyword If         '${order}' == 'descending'     Reverse List     ${sortedDurationsFinal[0]}
    Run Keyword If        '${order}' == 'descending'     Reverse List    ${sortedDurationsFinal[1]} 
    Should Be Equal    ${sortedDurationsFinal}     ${AllBusDuration}
    Log      ${sortedDurationsFinal[0]} 
    Log  ${sortedDurationsFinal[1]} 
    Log   Sorted Durations: ${sortedDurationsFinal}
