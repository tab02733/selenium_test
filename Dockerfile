# For more information, please refer to https://aka.ms/vscode-docker-python
FROM python:3.9

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# Chrome入れる
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add && \
    echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && \
    apt-get install -y google-chrome-stable && \
# インストールしたChromeとPythonのchromedriver-binaryのバージョンが合わない
# 場合があるので、google-chromeのバージョン情報から バージョンの
# 近いものを pip installする
#
RUN google-chrome --version | perl -pe 's/([^0-9]+)([0-9]+\.[0-9]+).+/$2/g' > chrome-version
RUN pip install --upgrade pip
#RUN pip install chromedriver-binary~=`cat chrome-version` && rm chrome-version うまくいかないので諦め(本当はこちらを入れたかった)
RUN pip install chromedriver-binary~=110.0.5481.77.0

# フォントを追加（日本語のページをスクリーンショットする場合には追加）
RUN apt-get install -y fonts-ipafont-gothic --no-install-recommends
RUN apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*

# Copy local code to the container image.
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . $APP_HOME

# Change Timezone to JP
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# Install production dependencies.
RUN pip install -r requirements.txt

# CMD ["python", "main.py", "10"]