# #!/usr/bin/env python
from selenium import webdriver
from selenium.webdriver.chrome.options import Options as ChromeOptions
from selenium.webdriver.common.by import By
import syslog


# Start the browser and login with standard_user
def login (user, password):
    print ('Starting the browser...')
    # --uncomment when running in Azure DevOps.
    options = ChromeOptions()
    options.add_argument('--no-sandbox')
    options.add_argument('--headless') 
    options.add_argument('--disable-dev-shm-usage')
    driver = webdriver.Chrome(options=options)
    print ('Browser started successfully. Navigating to the demo page to login.')
    syslog.syslog('Browser started successfully. Navigating to the demo page to login.')
    driver.get('https://www.saucedemo.com/')

    homepage_url = 'https://www.saucedemo.com/inventory.html'

    driver.find_element(By.ID, "user-name").send_keys(user)
    driver.find_element(By.ID, "password").send_keys(password)
    driver.find_element(By.ID, "login-button").click()

    assert driver.current_url == homepage_url
    print ('user ' + user + ' login test successfully')
    syslog.syslog('user ' + user + ' login test successfully')

    return driver

def add_and_remove_items_to_cart(driver):
    items = driver.find_elements(By.CLASS_NAME,"inventory_item_name")
    add_button_lists = driver.find_elements(By.CLASS_NAME, "btn_primary btn_inventory")
    add_button_lists = driver.find_elements(By.CLASS_NAME, "btn_secondary btn_inventory")
    for item in items:
        print (item.text + "is added to cart")
        syslog.syslog(item.text + ' login test successfully')
    for button in add_button_lists:
        button.click()
    for item in items:
        print (item.text + "is removed from cart")
        syslog.syslog(item.text + "is removed from cart")
    for button in add_button_lists:
        button.click()
    
    print ('add and remove test successfully')
    syslog.syslog('add and remove test successfully')

driver = login('standard_user', 'secret_sauce')

add_and_remove_items_to_cart(driver)

