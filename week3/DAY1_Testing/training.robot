*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${browser}                  chrome
${URL}                      https://www.makemytrip.com/bus/search/Coimbatore/Thiruvananthapuram/19-08-2024?from_code=MMTCC1184&to_code=MMTCC48867
${FASTEST_BUTTON_XPATH}    //div[@style='width: 70vw;']/div[@class='busListingContainer']/div[@class="sortViewContainer makeFlex spaceBetween hrtlCenter"]//li[@class="activeItem"]
${BUS_DURATION_XPATH}      //ancestor::div[contains(@class,"makeFlex false")]//div[contains(@class,"secondaryTxt")]

*** Test Cases ***
Verify Bus Duration Sorting by Fastest Button

    # Open the MakeMyTrip website and navigate to the bus section

    Open Browser    ${URL}   ${browser}
    Maximize Browser Window
    Sleep    2s

    # Click the "Fastest" button to sort buses by shortest duration first
    Click Element    xpath:${FASTEST_BUTTON_XPATH} 
    
    # Click the "Fastest" button again to sort buses by longest duration first
    Click Element    xpath:${FASTEST_BUTTON_XPATH} 
    
    # Close the browser
    Close Browser

*** Keywords ***
