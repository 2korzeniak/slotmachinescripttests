from robot.libraries.BuiltIn import BuiltIn
from selenium import webdriver
import Selenium2Library
import time
import sys


class LibTests(object):
    def __init__(self):
        # Including Selenium2Library
        self._selenium2lib = BuiltIn().get_library_instance('Selenium2Library')

    def waitForTimeout(self, xpath, timeout):
        """Sets Timeout if there is no xpath on the screen"""
        BuiltIn().log("1: Before setting timeout")
        secondsToWait = int(timeout);
        BuiltIn().log("2: Before checking loop")
        while True:
            BuiltIn().log("3: before mathing xpath")
            count = self._selenium2lib.get_matching_xpath_count(xpath)
            BuiltIn().log("4: before checking results of matching")
            if count > "0":
                BuiltIn().log("5: matched - GO")
                break
            elif secondsToWait == 0:
                BuiltIn().log("6: there is no xpath in the screen but the timeout exceeded ")
                self.CaptureScreenShot()
                BuiltIn().fail(
                    "Waiting for xpath %s seconds timeout exceeded (xpath %s found %s times)" % (timeout, xpath, count))
            else:
                BuiltIn().log("7: there is no xpath in the screen - waiting 1 second")
                time.sleep(1)
                BuiltIn().log("8: consuming 1 second of timeout")
                secondsToWait = secondsToWait - 1
                BuiltIn().log("9: repeating the xpath matching")

    def get_all_texts(self, locator):
        """Returns the text values of elements identified by locator"""
        elements = self._selenium2lib.get_webelements(locator)
        return [e.text for e in elements]

    def multiply_elements_scalar(self, elist, scalar):
        """Multiply list elements by scalar"""
        elist = map(lambda x: int(x) * int(scalar), elist)
        elist = map(str, elist)
        return elist

    def keepClickingWaitingForElement(self, WaitedElementXpath, ClickedElementXpath, timeout, ErrorMessage):
        """Function that is going to click waited element, else Timeout"""
        secondsToWait = int(timeout)
        BuiltIn().log("1. Timeout is set to %s seconds" % secondsToWait)
        while True:
            BuiltIn().log("2. Checking if waited element is visible in the screen - xpath: %s" % WaitedElementXpath)
            count = self._selenium2lib.get_matching_xpath_count(WaitedElementXpath)
            BuiltIn().log("3. Before checking results of matching")
            if count > "0":
                BuiltIn().log("4. There is an waited element visible in the screen - count: %s. Countinue test." % count)
                break
            elif secondsToWait == 0:
                BuiltIn().log("5. Timeout exceeded")
                self.CaptureScreenShot()
                BuiltIn().fail("Timeout %s seconds exceeded (Error message: %s)" % (timeout, ErrorMessage))
            else:
                BuiltIn().log("6. There is no waited element visible in the screen - waiting 1 more second")
                time.sleep(2)
                BuiltIn().log("7. Consuming 2 seconds of timeout")
                secondsToWait = secondsToWait - 2
                BuiltIn().log("8. Remaining timeout: %s seconds" % secondsToWait)
                try:
                    BuiltIn().log("9: Click again - xpath: %s" % ClickedElementXpath)
                    self._selenium2lib.click_element(ClickedElementXpath)
                except:
                    e = sys.exc_info()[0]
                    BuiltIn().log("10: Error when clicked: %s " % e)
