***Settings***
# SeleniumLibrary
Library     SeleniumLibrary
Library     Collections
Library     string
Test Teardown    Close Browser
Test Template    Search And Verify Bus Results

*** Test Cases ***

Verify Search Result if source and destination are in same states
    Ernakulam        Trivandrum

Verify Search Result if source and destination are in different states
    Coimbatore     Trivandrum    1 Sep

***Keywords***
Open Make My Trip As
    Open Browser     browser=chrome
    Maximize Browser Window
    Go To            https://www.makemytrip.com
    Sleep    5s
    Click Element    //span[@data-cy="closeModal"]
 
Search And Verify Bus Results
    [Arguments]   ${fromcity}   ${tocity}   ${date}
    Search bus    ${fromcity}   ${tocity}
    Verify Search Result    ${fromcity}   ${tocity}
    Capture Page Screenshot

Search bus

    [Arguments]   ${fromcity}   ${tocity}     "${date}" ="Today's Date"
    ${day}    ${month}    Split String    ${date}    ${SPACE}
    Wait Until Element Is Visible   //li[@class='menu_Buses']

    Click Element  //li[@class='menu_Buses']

    Wait Until Element Is Visible   fromCity      10s

    Click Element    fromCity

    Wait Until Element Is Visible  //input[contains(@placeholder,'From')]

    Input Text   //input[contains(@placeholder,'From')]  ${fromcity}

    Wait Until Element Is Visible  //div[contains(@class,'autosuggest')]//span[contains(text(),'${fromcity},')]

    Click Element  //div[contains(@class,'autosuggest')]//span[contains(text(),'${fromcity},')]



    Run Keyword And Ignore Error  Click Element    toCity

    Wait Until Element Is Visible  //input[contains(@placeholder,'To')]

    Input Text   //input[contains(@placeholder,'To')]  ${tocity}

    Wait Until Element Is Visible  //div[contains(@class,'autosuggest')]//span[contains(text(),'(${tocity})')]

    Click Element  //div[contains(@class, 'autosuggest')]//span[contains(text(),'${toCity},') or contains(text(),'(${toCity}),')]   


    Run Keyword And Ignore Error  Click Element    travelDate
    
    ${dateLocator}    Set Variable If  "${date}"="Today's Date"   
    ...    //div/ancestor::div[@class='DayPicker-Month']//div[@aria-Selected="true"]  
    ...    //div[contains(text(),'${month}')]/ancestor::div[@class='DayPicker-Month']//div[contains(text(),'${day}')]



    Wait Until Element Is Visible  //div[contains(text(),'${month}')]/ancestor::div[@class='DayPicker-Month']//div[contains(text(),'${day}')]  10s

    Click Element   //div[contains(text(),'${month}')]/ancestor::div[@class='DayPicker-Month']//div[contains(text(),'${day}')]

    Click Element   search_button

    Wait Until Element Is Visible     //div[@class="busListingContainer"]//p[contains(text(),'found')]


 