FROM ubuntu:trusty

# Set up project files
RUN mkdir chrome-headless-screenshots
COPY . chrome-headless-screenshots
WORKDIR chrome-headless-screenshots

# Download dependencies
RUN apt-get update && apt-get -y install libxss1 libappindicator1 libindicator7 wget curl xdg-utils
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg --force-all -i google-chrome*.deb && apt-get -y install -f
RUN curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash - && \
	sudo apt-get install -y nodejs && npm install
RUN google-chrome --no-sandbox --headless --hide-scrollbars --remote-debugging-port=9222 --disable-gpu &

RUN mkdir screenshots 
VOLUME screenshots

