FROM alpine
COPY ./pilotv2client /root/
COPY ./conf /root/conf

RUN chmod +x /root/pilotv2client

WORKDIR /root/
CMD ["/root/pilotv2client"]

