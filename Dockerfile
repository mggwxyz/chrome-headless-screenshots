FROM ubuntu:trusty

RUN apt-get update && apt-get -y install libxss1 libappindicator1 libindicator7 wget curl
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN apt-get -y install xdg-utils 
RUN dpkg --force-all -i google-chrome*.deb && apt-get -y install -f

# Install Node Stable (v7)
RUN curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash - && \
	sudo apt-get install -y nodejs

# Run Chrome as background process
# https://chromium.googlesource.com/chromium/src/+/lkgr/headless/README.md
# --disable-gpu currently required, see link above
# RUN google-chrome --no-sandbox --user-data-dir --headless --hide-scrollbars --remote-debugging-port=9222 --disable-gpu &

RUN mkdir chrome-headless-screenshots
COPY . chrome-headless-screenshots

WORKDIR chrome-headless-screenshots
RUN npm install && mkdir screenshots 
VOLUME screenshots

# Take the screenshot
CMD nodejs index.js
