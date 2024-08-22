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