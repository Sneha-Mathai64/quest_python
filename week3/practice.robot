
*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${from}                  coimbatore
${to}                    Trivandrum
${urlCustomer}           https://www.makemytrip.com/
${urlOperator}           https://www.operator.makemytrip.com


* Test Cases *
TC-001 Verify if a user is able to filter bus according to their seat preference
Open Make My Trip As
  Search  Buses  ${from}  ${to}
  Sleep  10s


* Keywords *
Open Make My Trip As
  Open Browser              browser=chrome
  Maximize Browser Window
  Go To  https://www.makemytrip.com
  Sleep  5s
  Click Element  //span[@data-cy="closeModal"]



Search  Buses
  [Arguments]  ${fromCity}  ${toCity}  ${date}
  Click Element  //nav//li[@class="menu_Buses"]

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

    Click Element    travelDate     
    Wait Until Element Is Visible     //div[text()='August 2024']/ancestor::div[@class="DayPicker-Month"]//div[contains(@class,'Day--today')and text()="17"]
    Click Element    //div[text()='August 2024']/ancestor::div[@class="DayPicker-Month"]//div[contains(@class,'Day--today')and text()="17"]
    Click Element    search_button

