from selenium import webdriver
import chromedriver_binary # これは必要なので、消さないでください
from selenium.webdriver.chrome.options import Options
import sys

# seleniumを起動
def start_selenium():
    options = Options()
    options.add_argument('--headless')
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    options.add_argument('--lang=ja-JP')
    browser = webdriver.Chrome(options=options)
    return browser
#quit処理
#browserがNoneの場合はcloseしない
def quit_selenium(browser):
    if browser is not None:
        browser.close()
        browser.quit()
    return
#実行例
#python getshops.py address_in_japan_no00 aichi/
#※フォルダ名にはスラッシュ(/)を忘れずに
if __name__ == '__main__':
    args = sys.argv
    if 2 <= len(args):
        if args[1].isascii:
            url = args[1]
        else:
            print('Argument is not bucket name')
            exit()
    browser = start_selenium()
    browser.get(url)
    html = browser.page_source
    print(html)
    quit_selenium(browser)
