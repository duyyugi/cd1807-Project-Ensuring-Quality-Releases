# #!/usr/bin/env python
from selenium import webdriver
from selenium.webdriver.chrome.options import Options as ChromeOptions


# Start the browser and login with standard_user
def login (user, password):
    print ('Starting the browser...')
    # --uncomment when running in Azure DevOps.
    # options = ChromeOptions()
    # options.add_argument("--headless") 
    # driver = webdriver.Chrome(options=options)
    driver = webdriver.Chrome()
    print ('Browser started successfully. Navigating to the demo page to login.')
    driver.get('https://www.saucedemo.com/')

    driver.find_elements(By.ID, "user-name").send_keys(user)
    driver.find_elements(By.ID, "password").send_keys(password)
    driver.find_elements(By.ID, "login-button").click()

    link = driver.find_element(By.ID, "item_4_img_link").src
    assert "/static/media/sauce-backpack-1200x1500.34e7aa42.jpg" in link

login('standard_user', 'secret_sauce')

