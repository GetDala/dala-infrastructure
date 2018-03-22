FROM python:3.5.2
LABEL Jared Leonard <jared@getwala.com>

# RUN useradd -ms /bin/bash user -u 1000 -U
# USER user
ENV PATH=/home/user/.local/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin
COPY files/microraiden /microraiden
COPY files/dala-wallet /dala-wallet
COPY files/password /tmp/password
COPY files/private_key.json /tmp/private_key.json
COPY files/startscript.sh /root/startscript.sh
COPY files/config.ini /dala-wallet/src/microraiden/config.ini
RUN chmod +x /root/startscript.sh  
WORKDIR /microraiden
RUN pip install -e . 
WORKDIR /dala-wallet
RUN pip install boto3 
RUN pip install PyJWT
RUN pip install --upgrade gevent
EXPOSE 80 443 5000 8545 8180 8080
ENTRYPOINT ["/root/startscript.sh"]
