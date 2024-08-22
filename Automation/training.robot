*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${browser}                  chrome
${URL}                      https://www.makemytrip.com/bus/search/Coimbatore/Thiruvananthapuram/19-08-2024?from_code=MMTCC1184&to_code=MMTCC48867
${FASTEST_BUTTON_XPATH}    //div[@style='width: 70vw;']/div[@class='busListingContainer']/div[@class="sortViewContainer makeFlex spaceBetween hrtlCenter"]//li[@class="activeItem"]/span[contains(@class,"listingSprite ")]
${BUS_DURATION_XPATH}      //ancestor::div[contains(@class,"makeFlex false")]//div[contains(@class,"secondaryTxt")]

*** Test Cases ***
Verify Bus Duration Sorting by Fastest Button

    # Open the MakeMyTrip website and navigate to the bus section
    Open Browser    https://www.makemytrip.com/bus/search/Coimbatore/Thiruvananthapuram/19-08-2024?from_code=MMTCC1184&to_code=MMTCC48867   chrome
    Maximize Browser Window

    # Click the "Fastest" button to sort buses by shortest duration first
    Click Element    xpath:fastest uparrow
 //div[@style='width: 70vw;']/div[@class='busListingContainer']/div[@class="sortViewContainer makeFlex spaceBetween hrtlCenter"]//li[@class="activeItem"]/span[contains(@class,"rotate180")]
    Sleep    2s  # Wait for sorting to take effect
    ${durations_asc}=    Get Bus Durations
    ${is_sorted_asc}=    Evaluate Sorting    ${durations_asc}    ascending
    Should Be True    ${is_sorted_asc}    Buses should be sorted by shortest duration first

    # Click the "Fastest" button again to sort buses by longest duration first
    Click Element    xpath=//div[@style='width: 70vw;']/div[@class='busListingContainer']/div[@class="sortViewContainer makeFlex spaceBetween hrtlCenter"]//li[@class="activeItem"]/span[contains(@class,"appendLeft6 ")]
    Sleep    2s  # Wait for sorting to take effect
    ${durations_desc}=    Get Bus Durations
    ${is_sorted_desc}=    Evaluate Sorting    ${durations_desc}    descending
    Should Be True    ${is_sorted_desc}    Buses should be sorted by longest duration first

    # Close the browser
    Close Browser

*** Keywords ***
Get Bus Durations
    # Fetches all the bus duration elements on the page
    @{durations}=    Get WebElements    xpath=${//ancestor::div[contains(@class,"makeFlex false")]//div[contains(@class,"secondaryTxt")]}
    ${duration_values}=    Create List
    FOR    ${element}    IN    @{durations}
        ${duration}=    Get Text    ${element}
        ${parsed_duration}=    Parse Duration    ${duration}
        Append To List    ${duration_values}    ${parsed_duration}
    END
    [Return]    ${duration_values}

Parse Duration
    [Arguments]    ${duration}
    # Assuming the duration format is something like "5h 30m"
    ${hours}=    Replace String    ${duration.split("h")[0]}    " "    ""
    ${minutes}=    Replace String    ${duration.split("h")[1].replace("m","")}    " "    ""
    ${total_minutes}=    Evaluate    int(${hours}) * 60 + int(${minutes})
    [Return]    ${total_minutes}

Evaluate Sorting
    [Arguments]    ${duration_list}    ${order}
    ${sorted_list}=    Evaluate    sorted(${duration_list}, reverse=(${order}=="descending"))
    [Return]    ${duration_list} == ${sorted_list}
