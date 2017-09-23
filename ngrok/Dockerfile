FROM busybox:ubuntu-14.04

ADD https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip /ngrok.zip
RUN set -x \
 && unzip -o /ngrok.zip -d /bin \
 && rm -f /ngrok.zip

COPY entrypoint.sh /

RUN set -x \
 && echo 'ngrok:x:6737:6737:Ngrok user:/home/ngrok:/bin/false' >> /etc/passwd \
 && echo 'ngrok:x:6737:' >> /etc/group \
 && chown -R ngrok:ngrok /home/ngrok \
 && chmod -R go=u,go-w /home/ngrok \
 && chmod go= /home/ngrok

USER ngrok

EXPOSE 4040

CMD ["/entrypoint.sh"]
