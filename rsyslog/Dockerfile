FROM ubuntu:14.10
MAINTAINER bryantsai

RUN apt-get update \
 && apt-get install -y rsyslog \
 && rm -rf /var/lib/apt/lists/* \
 && echo "\$ModLoad imudp" >> /etc/rsyslog.conf \
 && echo "\$UDPServerRun 514" >> /etc/rsyslog.conf \
 && echo "\$ModLoad imtcp" >> /etc/rsyslog.conf \
 && echo "\$InputTCPServerRun 514" >> /etc/rsyslog.conf

# edit the 50-default.conf file so that we don't get the gross xconsole error/warning:
#   Could no open output pipe '/dev/xconsole': No such file or directory
RUN cp /etc/rsyslog.d/50-default.conf /etc/rsyslog.d/50-default.conf.bak \
 && head -n -5 /etc/rsyslog.d/50-default.conf.bak > /etc/rsyslog.d/50-default.conf \
 && echo "  *.=notice;*.=warn |/dev/console" >> /etc/rsyslog.d/50-default.conf \
 && cat /etc/rsyslog.d/50-default.conf

VOLUME ["/dev", "/var/log"]

EXPOSE 514 514/udp

ENTRYPOINT ["rsyslogd"]
CMD ["-n"]
