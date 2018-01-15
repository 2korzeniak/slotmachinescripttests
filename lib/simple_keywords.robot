*** Settings ***
Library	Selenium2Library
Library	lib_tests.LibTests
Library	DateTime

*** Variables ***
${Browser}	firefox
${APP_Address}	http://slotmachinescript.com/
${TIMEOUT}	60

*** Keywords ***
Start Browser
	Set Selenium Speed	0.2 seconds
	Set Selenium Timeout	60
	Open Browser	${APP_Address}	${Browser}
	Go To	${APP_Address}
	Set Window Position	0	0
	Set Window Size	1920	1080
	Maximize Browser Window

Finish Test Set
	Close All Browsers

Timeout
	[Arguments]	${Locator}
	Wait For Timeout	${Locator}	${TIMEOUT}

Click button
	[Documentation]	Click button with particular label
	[Arguments]	${btn_name}
	${xpath_btn}=	Set Variable	//li/a[contains(., '${btn_name}')]
	Timeout	${xpath_btn}
	Click Element	${xpath_btn}

Check background customization
	: FOR	${i}	IN RANGE	1	5
	\	Wait Until Page Contains Element	//div[contains(@id,'changeable_background_${i}') and not(contains(@style,'display: none'))]	30
	\	Click button	Change Background

Check icons customization
	: FOR	${i}	IN RANGE	1	4
	\	Wait Until Page Contains Element	//div[contains(@id,'slotsSelectorWrapper') and contains(@class,'reelSet${i}')]	30
	\	Click button	Change Icons

Check machine customization
	: FOR	${i}	IN RANGE	1	6
	\	Wait Until Page Contains Element	//div[contains(@id,'slotsSelectorWrapper') and contains(@class,'slotMachine${i}')]	30
	\	Click button	Change Machine

Get field value
	[Documentation]	Gets value from fields below slot machine
	[Arguments]	${field_id}
	${bets}=	Get Text	//span[@id='${field_id}']
	[Return]	${bets}

