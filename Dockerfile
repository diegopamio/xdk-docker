FROM codenvy/debian_jre
ENV NODE_VERSION=0.12.9 \
    NODE_PATH=/usr/local/lib/node_modules
    
RUN sudo apt-get update && \
    sudo apt-get -y install build-essential libssl-dev libkrb5-dev gcc make ruby-full rubygems && \
    sudo gem install sass compass && \
    sudo apt-get clean && \
    sudo apt-get -y autoremove && \
    sudo apt-get -y clean && \
    sudo rm -rf /var/lib/apt/lists/* && \
    cd /home/user && curl --insecure -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
    && curl --insecure -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
    && gpg --verify SHASUMS256.txt.asc \
    && grep "node-v$NODE_VERSION-linux-x64.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c - \
    && sudo tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
    && sudo rm "node-v$NODE_VERSION-linux-x64.tar.gz" SHASUMS256.txt.asc

EXPOSE 3000 5000 9000 5353 5354
RUN sudo npm install -g npm@latest
RUN sudo npm install --unsafe-perm -g gulp bower grunt grunt-cli yeoman-generator yo generator-angular generator-karma generator-webapp

WORKDIR /projects

CMD tail -f /dev/null

