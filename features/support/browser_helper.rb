#need it when an alert popup shows up on the screen
def accept_alert_popup
  page.driver.browser.switch_to.alert.accept
end

def confirm_message_appear?(message)
  binding.pry
  page.driver.browser.switch_to.alert.accept
end