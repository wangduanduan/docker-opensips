#!/bin/bash

rsyslogd
cron
exec /usr/local/sbin/opensips -F "$@"