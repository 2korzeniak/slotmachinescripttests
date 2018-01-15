*** Settings ***
Library	Selenium2Library
Resource	../TestCases/TCs.robot

Suite Teardown	Finish Test Set

*** Test Cases ***
01. Checking menu buttons
	Check menu buttons

02. Checking slot machine customization
	Check customization

03. Checking bets increase/decrease
	Checking bets

04. Checking credits
	Checking credits

05. Checking if player won
	Checking win

06. Checking message
	Checking message

07. Check FAQ open close arrows
	Check FAQ open close arrows