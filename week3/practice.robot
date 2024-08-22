* Settings *
# SeleniumLibrary
Library     SeleniumLibrary
Library     Collections
* Variables *
${from}    Coimbatore
${to}      Trivandrum
${urlCustomer}    https://www.makemytrip.com/
${urlOperator}    https://www.operator.makemytrip.com
${ascOrder}       ascending
${dscOrder}       descending
* Test Cases *
TC-001 Verify if a user is able to filter bus according to their seat preference
    Open Make My Trip As
    Search Buses    ${from}    ${to}
    Select Filter     Seat type     Sleeper
    Get All Bus Id
TC-002 Verify Initial toggle to shortest duration
    Toggle Fastest Sorting And Validate
        
* Keywords *
Open Make My Trip As
    Open Browser     browser=chrome
    Maximize Browser Window
    Go To            https://www.makemytrip.com
    Sleep    5s
    Click Element    //span[@data-cy="closeModal"]

Search Buses
    [Arguments]    ${from}        ${to}    #${date}
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

    Run Keyword And Ignore Error    Click Element    travelDate      #date picker/calender will open up
    Wait Until Element Is Visible     //div[contains(text(), 'August')]/ancestor::div[@class="DayPicker-Month"]//div[text()='19']     10s
    Click Element    //div[contains(text(), 'August')]/ancestor::div[@class="DayPicker-Month"]//div[text()='19']
    Click Element    search_button
    Wait Until Element Is Visible     //div[@class="busListingContainer"]//p[contains(text(),'found')]
Select Filter
    [Arguments]     ${filterType}     ${filterExactText}
    # take the initial count
    Click Element     toggle_buses
    ${initialCount}    Get Element Count     //div[@class="busCardContainer "]     # maximum bus in search result, no filter applied
    Click Element    //div[contains(text(),'${filterType}')]/../..//span[text()='${filterExactText}']
    Wait Until Element Is Not Visible     //div[@class="busListingContainer"]//p[contains(text(),'found') and contains(text(),'${initialCount}')]
    #wait till its not the previous count or wait till elemnt disappears.
Get All Bus Id


    @{allBusId}    Create List
    run keyword and ignore error     Click Element     //div[@id="toggle_buses" and not(contains(@class,'active'))]
    ${numberOfBuses}     Get Element Count    //div[starts-with(@id,"bus_")]
    ${numberOfBuses}    Evaluate     $numberOfBuses+1
    FOR    ${index}    IN RANGE     1    ${numberOfBuses}
    ${busId}     Get Element Attribute       (//div[starts-with(@id,"bus_")])[${index}]        id  # node with id in it, exact 16 matches.
    Append To List     ${allBusId}    ${busId}

    END
    Log    ${allBusId}

Toggle Fastest Sorting And Validate
    
    Click Element    //div[@class="makeFlex hrtlCenter"]//li[contains(text(), 'Fastest')]
    Wait Until Buses Are Loaded
    @{firstDurations}    Get All Bus Durations
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
    ${numberOfBuses}     Get Element Count    //div[@class="busCardContainer "]//div[contains(@class,"makeFlex false")]//div[contains(@class,"secondaryTxt")]
    ${numberOfBuses}    Evaluate     $numberOfBuses+1
     FOR    ${index}    IN RANGE    1    ${numberOfBuses}
        ${durationText}    Get Text    (//div[@class="busCardContainer "]//div[contains(@class,"makeFlex false")]//div[contains(@class,"secondaryTxt")])[${index}]
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