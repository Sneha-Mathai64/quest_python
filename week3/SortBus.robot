*** Settings ***
Library     SeleniumLibrary
Library     Collections
Library     Pyfn.py   
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

*** Keywords ***
Open Make My Trip As
    Open Browser     browser=chrome
    Maximize Browser Window
    Go To            ${urlCustomer}
    Sleep    5s
    Wait Until Element Is Visible   //span[@data-cy="closeModal"]
    Click Element    //span[@data-cy="closeModal"]

Search Buses
    [Arguments]    ${fromCity}        ${toCity}    ${date}="Todays Date"
    ${day}    ${month}    Split String    ${date}    ${SPACE}
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


    Wait Until Element Is Visible     travelDate     10s
    Run Keyword And Ignore Error        Click Element        travelDate
    ${dateLocator}    Set Variable If    "${date}" == "Todays Date"
    ...    //li[contains(@id,"today_date")]
    ...    //div[contains(text(), '${month}')]/ancestor::div[@class="DayPicker-Month"]//div[contains(text(),'${day}') and contains(@class,"DayPicker")]
    Wait Until Element Is Visible     ${dateLocator}     10s
    Click Element     ${dateLocator}
    Run Keyword And Ignore Error    Click Element    search_button
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
        Append To List    ${durationsofKsrtc}    ${durationText}
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
        Append To List    ${durationsofPrivate}    ${durationText}
    END
    Log    Private Durations: ${durationsofPrivate}
    [Return]    ${durationsofPrivate}

Join Lists Using Combine Lists
    [Arguments]    ${durationsofKsrtc}    ${durationsofPrivate}
    ${AllBusDuration}=   Create List    ${durationsofKsrtc}   ${durationsofPrivate}
    Log     ${AllBusDuration}   
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


# Join Lists Using Combine Lists

#     [Arguments]    ${durationsofKsrtc}    ${durationsofPrivate}
#     Log    ${durationsofKsrtc}  
#     Log    ${durationsofPrivate}
#     ${AllBusDuration}=   Create List    ${durationsofKsrtc}   ${durationsofPrivate}
#     Log     ${AllBusDuration}   
#     Log     ${AllBusDuration[0]}
#     Log   ${AllBusDuration[1]}
#     [Return]    ${AllBusDuration}

# Validate Durations Sorted
#     [Arguments]    ${AllBusDuration}     ${order}=${None}
#     Log  Durations: ${AllBusDuration}
#     ${sortedDurationsFinal}     Copy List     ${AllBusDuration}
#     Sort List       ${sortedDurationsFinal[0]}   
#     Log      ${sortedDurationsFinal[0]} 
#     Sort List       ${sortedDurationsFinal[1]}   
#     Log      ${sortedDurationsFinal[1]} 
#     Log  ${sortedDurationsFinal} 
#     Run Keyword If         '${order}' == 'descending'     Reverse List     ${sortedDurationsFinal[0]}
#     Run Keyword If        '${order}' == 'descending'     Reverse List    ${sortedDurationsFinal[1]} 
#     Should Be Equal    ${sortedDurationsFinal}     ${AllBusDuration}
#     Log      ${sortedDurationsFinal[0]} 
#     Log  ${sortedDurationsFinal[1]} 
#     Log   Sorted Durations: ${sortedDurationsFinal}