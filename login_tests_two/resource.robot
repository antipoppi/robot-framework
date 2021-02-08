*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${WEBSITE}			gothinkster.github.io/clojurescript-keechma-realworld-example-app
${BROWSER}			Firefox
${DELAY}          	0
${VALID USER}     	testitunnus@testitunnus.fi
${VALID PASSWORD} 	testitunnus1234
${LOGIN URL}      	https://${WEBSITE}/#!login
${WELCOME URL}    	https://${WEBSITE}/#!home/personal
${HOME URL}		  	https://${WEBSITE}/#!home
${ERROR URL}      	https://${WEBSITE}/#!login

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Login Page Should Be Open

Login Page Should Be Open
    Location Should Be   ${LOGIN URL}
	Title Should Be    Conduit

Go To Login Page
    Go To    ${LOGIN URL}
    Login Page Should Be Open

Input Username
    [Arguments]    ${username}
    Input Text    xpath=//*[@id="app"]/div/div/div/div/div/form/fieldset[1]/input   ${username}

Input Password
    [Arguments]    ${password}
    Input Text    xpath=//*[@id="app"]/div/div/div/div/div/form/fieldset[2]/input    ${password}

Click Settings
	Click Element	xpath=//*[@id="app"]/div/nav/div/ul/li[3]/a
	Wait for page to load

Click Logout
	Click Element	xpath=//*[@id="app"]/div/div/div/div/div/a
	Wait for page to load
	
Click Sign In
	Click Element	xpath=//*[@id="app"]/div/nav/div/ul/li[2]/a
	Wait for page to load

Click New Post
	Click Element	xpath=//*[@id="app"]/div/nav/div/ul/li[2]/a
	Wait for page to load
	
Fill The Article
	Input Text		xpath=//*[@id="app"]/div/div/div/div/div/form/fieldset[1]/input		Article test title
	Input Text		xpath=//*[@id="app"]/div/div/div/div/div/form/fieldset[2]/input		This article is about testing
	Input Text		xpath=//*[@id="app"]/div/div/div/div/div/form/fieldset[3]/textarea	This is a test article about testing
	Input Text		xpath=//*[@id="app"]/div/div/div/div/div/form/fieldset[4]/input		test
	
Click Publish Article
	Click Button	xpath=//*[@id="app"]/div/div/div/div/div/form/button
	Wait for page to load

Submit Credentials
	Click Button	xpath=//*[@id="app"]/div/div/div/div/div/form/button
	Wait for page to load

Login Should Have Failed
    Location Should Be    ${ERROR URL}
    Title Should Be    Conduit	

Login Should Have Succeed
    Location Should Be    ${WELCOME URL}
    Title Should Be    Conduit

Wait for page to load
	Sleep	1s
	