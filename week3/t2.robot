* Settings *
Library    SeleniumLibrary
Library    String

Suite Setup    Open Make My Trip As
Test Teardown    Undo Changes
Suite Teardown    Close Browser 

Test Template    Search and verify
* Test Cases *

Verify if cities are in same state
    Coimbatore    Trivandrum    22 August    Pick up point     Ettimadai    Ettimadai
    [Teardown]    Undo Changes

* Keywords *
Open Make My Trip As
    Open Browser     browser=chrome
    Maximize Browser Window
    Go To            https://www.makemytrip.com
    Wait Until Element Is Visible     //span[@data-cy="closeModal"]     10s
    run keyword and ignore error    Click Element    //span[@data-cy="closeModal"]

Search and verify
    [Arguments]    ${fromCity}        ${toCity}    ${date}     ${filterType}     ${filterExactText}    ${filtertext}
    Search Buses    ${fromCity}        ${toCity}    ${date}
    Select Filter     ${filterType}     ${filterExactText}
    Pickups and Drop    ${filtertext}
    Capture Page Screenshot
   
    

Search Buses
    [Arguments]    ${fromCity}        ${toCity}    ${date}="Todays Date"
    ${day}    ${month}    Split String    ${date}    ${SPACE}
    Click Element    //nav//li[@class="menu_Buses"]
    Wait Until Element Is Visible     fromCity     10s
    Click Element        fromCity
    Wait Until Element Is Visible     //input[@placeholder="From"]     10s
    Input Text       //input[@placeholder="From"]     ${fromCity}
    Wait Until Element Is Visible    //div[contains(@class, 'autosuggest')]//span[contains(text(),'${fromCity},')]
    Click Element    //div[contains(@class, 'autosuggest')]//span[contains(text(),'${fromCity},')]

    Wait Until Element Is Visible     toCity     10s
    Run Keyword And Ignore Error        Click Element        toCity
    Wait Until Element Is Visible     //input[@placeholder="To"]     10s
    Input Text       //input[@placeholder="To"]     ${toCity}
    Wait Until Element Is Visible       //div[contains(@class, 'autosuggest')]//span[contains(text(),'${toCity},') or contains(text(),'(${toCity}),')]
    Click Element    //div[contains(@class, 'autosuggest')]//span[contains(text(),'${toCity},') or contains(text(),'(${toCity}),')]
    
    Wait Until Element Is Visible     travelDate     10s
    Run Keyword And Ignore Error        Click Element        travelDate
    ${dateLocator}    Set Variable If    "${date}" == "Todays Date"
    ...    //li[contains(@id,"today_date")]
    ...    //div[contains(text(), '${month}')]/ancestor::div[@class="DayPicker-Month"]//div[contains(text(),'${day}') and contains(@class,"DayPicker")]
    Wait Until Element Is Visible     ${dateLocator}     10s
    Click Element     ${dateLocator}
    Run Keyword And Ignore Error    Click Element    search_button
    Wait Until Element Is Visible     //div[@class="busListingContainer"]//p[contains(text(),'found')]


Select Filter

    [Arguments]     ${filterType}     ${filterExactText}
    # take the initial count
    Click Element     toggle_buses
    ${initialCount}    Get Element Count     //div[@class="busCardContainer "]     # maximum bus in search result, no filter applied
    Click Element    //div[contains(text(),'${filterType}')]/../..//span[text()='${filterExactText}']
    Wait Until Element Is Not Visible     //div[@class="busListingContainer"]//p[contains(text(),'found') and contains(text(),'${initialCount}')]
    #wait till its not the previous count or wait till elemnt disappears.
    sleep   10s



Pickups and Drop

    [Arguments]    ${filtertext}
    @{place}    Create List
    Run Keyword And Ignore Error    Click Element    //div[@id="toggle_buses" and not(contains(@class,'active'))]
    Wait Until Element Is Visible    //div[@class="busCardContainer "]
    ${numberOfBuscard}    Get Element Count    //div[@class="busCardContainer "]
    ${numberOfBuses}    Evaluate    $numberOfBuscard + 1
    

    FOR    ${index}    IN RANGE    1    ${numberOfBuses}
        Scroll Element Into View    (//div[contains(@class,"busCardFooter")]//span[text()="Pickups & Drops"])[${index}]
        Click Element    (//div[contains(@class,"busCardFooter")]//span[text()="Pickups & Drops"])[${index}]
        Sleep    3s
        Element Should Be Visible    //ul[@class="btnSelectBusWithoutRadio"]//span[@title="${filtertext}"]
        Run Keyword And Ignore Error    Click Element    (//div[contains(@class,"busCardFooter")]//span[text()="Pickups & Drops"])[${index}]
        
    END

    
Undo Changes
    Run Keyword And Ignore Error    Click Element    //span[@class='logoContainer']//a[@class='chMmtLogo']
    Sleep    3s