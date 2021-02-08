*** Settings ***
Documentation     A test suite with various login tests both failing and succeeding
...
...               This test tries to login to the website and should
...               finally success in it. Finally it tests about logging in
...               and publishing an article and then deleting it.
Resource          resource.robot
Test Setup		  Open Browser To Login Page
Test Teardown     Close Browser

*** Test Cases ***
Invalid Username And Password
	User tries to login but misspells both credentials
	According to the User, login should have succeed
	
Invalid Username
	User misspells his username as "testitunnus" but writes his passwords correctly as "testitunnus1234"
	Then login should have failed
	
Invalid Password	
	User "testitunnus@testitunnus.fi" misspells his password again as "testitunnus321"
	Then login should have failed

Valid Credentials
	User succesfully enters credentials
	Login should have succeed

Login and Logout
	User succesfully enters credentials
	Login should have succeed
	User then Click Settings
	User then Click Logout
	User should then be able to click sign in
	Login page should be open
	
Login and post an article and delete after
	User succesfully enters credentials
	Login should have succeed
	User clicks new post
	User fills the article and publish it
	User deletes the article
	Delete should be succesfull
	
*** Keywords ***
User tries to login but misspells both credentials
    Input username    testitunnus
    Input password    testitunnus321
    Submit credentials

According to the User, login should have succeed
	login should have succeed
	
User misspells his username as "${username}" but writes his passwords correctly as "${password}"
	Input username    ${username}
    Input password    ${password}
    Submit credentials

User "${username}" misspells his password again as "${password}"
	Input username    ${username}
    Input password    ${password}
    Submit credentials

User succesfully enters credentials
	Input username    ${VALID USER}
    Input password    ${VALID PASSWORD}
    Submit credentials
	
User then Click Settings
	Click Settings
	
User then Click Logout
	Click Logout

User should then be able to Click Sign In
	Click Sign In
	
User clicks new post
	Click New Post
	
User fills the article and publish it
	Fill The Article
	Click Publish Article

User deletes the article
	Click Button	xpath=//*[@id="app"]/div/div/div[2]/div[2]/div/button
	Wait For Page To Load
	
Delete should be succesfull
	Location Should Be    ${HOME URL}
    Title Should Be    Conduit