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
${index_counter}=   1
* Test Cases *
TC-001 Verify Initial toggle to shortest duration
    Open Make My Trip As
    Search Buses    ${from}    ${to}
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
    Wait Until Element Is Visible     //div[contains(text(), 'August')]/ancestor::div[@class="DayPicker-Month"]//div[text()='23']     10s
    Click Element    //div[contains(text(), 'August')]/ancestor::div[@class="DayPicker-Month"]//div[text()='23']
    Click Element    search_button
    Wait Until Element Is Visible     //div[@class="busListingContainer"]//p[contains(text(),'found')]

Get All Bus duration masterList

 
    Wait Until Element Is Visible    xpath=//div[@class='busCardContainer '] | //div[@class='rtcEnd']    timeout=10s
    ${all_divs}=    Get WebElements    //div[@class='busCardContainer '] | //div[@class='rtcEnd']
    ${duration_list}=    Create List
    ${master_list}=    Create List
    
    FOR    ${div}    IN    @{all_divs}
        
        ${class}=    Get Element Attribute    ${div}    class
        Run Keyword If    '${class}' == 'busCardContainer '    Handle BusCardContainer Div    ${div}    ${duration_list}    ${index_counter}
        Run Keyword If    '${class}' == 'rtcEnd'    Log, Add to Master List and Reset    ${duration_list}    ${master_list}   
        ${index_counter}=    Evaluate    ${index_counter} - 1 if '${class}' == 'rtcEnd' else ${index_counter} + 1
    END
    [Return]    ${master_list}
    Log    Master List: ${master_list}

Handle BusCardContainer Div
    [Arguments]    ${div}    ${duration_list}    ${index_counter_1}
    Log    ${div}
    Log    ${index_counter_1}
    Log    ${duration_list}
    ${duration}    Get Text    (//div[@class="busCardContainer "]//div[contains(@class,"makeFlex false")]//div[contains(@class,"secondaryTxt")])[${index_counter_1}] 
    ${hours}    Set Variable    0
    ${minutes}  Set Variable    0
    ${hoursText}   Evaluate    '''${duration}'''.split("hrs")[0].strip()
    ${hours}   Convert To Integer    ${hoursText}
    ${minutesText}    Evaluate    '''${duration}'''.split("hrs")[-1].split("mins")[0].strip()
    ${minutes}      Convert To Integer    ${minutesText}
    ${totalDuration}    Evaluate    (${hours}*60) + ${minutes}
    Append To List    ${duration_list}    ${totalDuration}
    Log    ${duration}
    Log    ${totalDuration}
    Log    ${duration_list}

Log, Add to Master List and Reset
    [Arguments]    ${duration_list}    ${master_list}   
    Log    ${duration_list}
    Append To List    ${master_list}    ${duration_list}
    ${duration_list}=    Create List

Toggle Fastest Sorting And Validate
    
    Wait Until Element Is Visible    xpath=//div[@id='toggle_buses' and contains(@class, 'bluePrimarybtn')]    timeout=10s
    Click Element    xpath=//div[@id='toggle_buses' and contains(@class, 'bluePrimarybtn')]

    Click Element    //div[@class="makeFlex hrtlCenter"]//li[contains(text(), 'Fastest')]
    Wait Until Buses Are Loaded
    @{firstDurations}    Get All Bus duration masterList
    Validate Durations Sorted    ${firstDurations}   order=${ascOrder}

    Click Element    //div[@class="makeFlex hrtlCenter"]//li[contains(text(), 'Fastest')]
    Wait Until Buses Are Loaded
    @{secondDurations}    Get All Bus duration masterList
    Validate Durations Sorted    ${secondDurations}  order=${dscOrder}

Wait Until Buses Are Loaded

    Wait Until Element Is Not Visible    //div[@class="loader"]    timeout=20s
    Wait Until Element Is Visible        //div[@class="busCardContainer "]//div[contains(@class,"makeFlex false")][1]    timeout=20s
    Wait Until Page Contains Element    //div[contains(@class,'secondaryTxt')]    timeout=20s

Validate Durations Sorted
    [Arguments]    ${durations}     ${order}=${None}
    ${sorted_durations_sorted}    Copy List    ${durations}
    
    Sort List    ${sorted_durations_sorted}   
    Run Keyword If    '${order}' == 'descending'    Reverse List    ${sorted_durations_sorted} 
    Log     ${sorted_durations_sorted}
    Should Be Equal    ${sorted_durations_sorted}    ${durations}