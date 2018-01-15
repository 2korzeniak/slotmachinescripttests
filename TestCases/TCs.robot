*** Settings ***
Resource 	../lib/simple_keywords.robot
Library		Collections

*** Keywords ***

Check menu buttons
	[Documentation]	Checks if menu buttons scroll down to particular frame after clicking
	Start Browser
	Click button	Overview
	Current Frame Should Contain	Overview
	Click button	Testimonials
	Current Frame Should Contain	What our previous customers say
	Click button	Buy Now!
	Current Frame Should Contain	Buy now!
	Close Browser

Check customization
	[Documentation]	Checks if slot machine is customizable (background, icons and machine)
	Start Browser
	Check background customization
	Check icons customization
	Check machine customization
	Close Browser

Checking bets
	[Documentation]	Checks changing of points value when bet value is increased/decreased
	Start Browser
	${prizes_xpath}=	Set variable	//div[contains(@class,'prizes_list_slot_machine') and not(contains(@style,'display: none'))]//span[@class='tdPayout']
	@{prizes}	Get All Texts	${prizes_xpath}
	#increase +2
	: FOR	${i}	IN RANGE	1	3
	\	Click Element	//div[contains(@id,'betSpinUp')]
	\	${bets}=	Get field value	bet
	\	Should Be Equal As Strings	${bets}	${i+1}
	\	@{new_prizes}	Get All Texts	${prizes_xpath}
	\	${new_prize_1}=	Multiply elements scalar	${prizes}	${bets}
	\	Lists Should Be Equal	${new_prizes}	${new_prize_1}
	#decrese -1 (bet should be 2)
	Click Element	//div[contains(@id,'betSpinDown')]
	${bets}=	Get field value	bet
	Should Be Equal As Strings	${bets}	2
	@{new_prizes}	Get All Texts	${prizes_xpath}
	${new_prize_1}=	Multiply elements scalar	${prizes}	${bets}
	Lists Should Be Equal	${new_prizes}	${new_prize_1}
	Close Browser

Checking credits
	[Documentation]	Checks if amount of total spins is increased
	Start Browser
	${spin_btn_xpath}=	Set variable	//div[contains(@id,'spinButton') and not(contains(@class,'disable'))]
	${credits}=	Get field value	credits
	Click Element	${spin_btn_xpath}
	${new_credits}=	Evaluate	${credits}-1
	${credits}=	Get field value	credits
	Should Be Equal As Integers	${credits}	${new_credits}
	# Click once again if element is still disabled - check error
	Run Keyword And Expect Error	Element with locator * not found.	Click Element	${spin_btn_xpath}
	Close Browser

Checking win
	[Documentation]	Checks if player won the prize and if value in last win field is correct
	Start Browser
	${spin_btn_xpath}=	Set variable	//div[contains(@id,'spinButton') and not(contains(@class,'disable'))]
	${won_xpath}=	Set variable	//div[@class='trPrize won']
	${last_win}=	Get field value	lastWin
	Should Be Equal As Strings	${last_win}	${EMPTY}
	Keep Clicking Waiting For Element	${won_xpath}	${spin_btn_xpath}	${TIMEOUT}	No win
	${prize}=	Get Text	${won_xpath}/span[@class='tdPayout']
	Wait Until Page Contains Element	${spin_btn_xpath}
	${last_win}=	Get field value	lastWin
	Should Be Equal As Strings	${prize}	${last_win}
	Close Browser

Checking message
	[Documentation]	Checks if message has been sent
	Start Browser
	Select frame    xpath=//div[@id='Smallchat']/iframe
	${send_msg_btn_xpath}=	Set variable	//div[contains(@class,'Launcher-button')]
	${send_btn_xpath}=	Set variable	//button[@class='Input_button Input_button-send']
	Timeout	${send_msg_btn_xpath}
	Click Element	${send_msg_btn_xpath}
	Input Text	//textarea[@class='Input_field']	testingmessage
	Timeout	${send_btn_xpath}
	Click Element	${send_btn_xpath}
	${check_sent_txt}=	Get Text	//div[@class='SlackText']/span
	Should Be Equal As Strings	${check_sent_txt}	testingmessage
	Close Browser

Check FAQ open close arrows
	[Documentation]	Checks open/close arrows in FAQ section
	Start Browser
	${open_close_arrow_xpath}=	Set variable	//span[@class='st-arrow']
	Click Element	${open_close_arrow_xpath}
	${check_content_opened}=	Set variable	//div[contains(@class,'st-content') and not(contains(@style,'display: none'))]
	Page Should Contain Element	${check_content_opened}
	# Uncomment sleep to check visually if element was opened
	# Sleep	3
	Click Element	${open_close_arrow_xpath}
	${check_content_not_opened}=	Set variable	//div[contains(@class,'st-content') and not(contains(@style,'display: block'))]
	Page Should Contain Element	${check_content_not_opened}
	# Uncomment sleep to check visually if element was closed
	# Sleep	3
	Close Browser