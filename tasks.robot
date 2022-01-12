*** Settings ***
Documentation     Template robot main suite
Library           RPA.Browser.Selenium
Library           RPA.Excel.Files
Library           RPA.HTTP

*** Keywords ***
Start The Challenge
    Open Available Browser    http://rpachallenge.com/
    Download    http://rpachallenge.com/assets/downloadFiles/challenge.xlsx    overwrite=True
    Click Button    Start

*** Keywords ***
 List Of People
    Open Workbook    challenge.xlsx
    ${table}=    Read Worksheet As Table    header=True
    Close Workbook
    [Return]    ${table}

*** Keywords ***
Fill And Submit The Form
    [Arguments]    ${employee}
    Input Text    //input[@ng-reflect-name="labelFirstName"]    ${employee}[First Name]
    Input Text    //input[@ng-reflect-name="labelLastName"]    ${employee}[Last Name]
    Input Text    //input[@ng-reflect-name="labelCompanyName"]    ${employee}[Company Name]
    Input Text    //input[@ng-reflect-name="labelRole"]    ${employee}[Role in Company]
    Input Text    //input[@ng-reflect-name="labelAddress"]    ${employee}[Address]
    Input Text    //input[@ng-reflect-name="labelEmail"]    ${employee}[Email]
    Input Text    //input[@ng-reflect-name="labelPhone"]    ${employee}[Phone Number]
    Click Button    Submit

*** Keywords ***
Fill The Forms
    ${people}=    List Of People
    FOR    ${employee}    IN    @{people}
        Fill And Submit The Form    ${employee}
    END

*** Keywords ***
Collect The Results
    Capture Element Screenshot    css:div.congratulations
    Close All Browsers

*** Tasks ***
Minimal task
    Start The Challenge
    List Of People
    Fill The Forms
    Collect The Results
    Log Done.
