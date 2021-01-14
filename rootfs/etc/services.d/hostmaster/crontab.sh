#!/bin/bash
# add crontab
# https://stackoverflow.com/a/17975418/2315024
croncmd="/usr/bin/env php /usr/local/bin/drush '@hm' hosting-dispatch  > /dev/null 2>&1"
cronjob="* * * * * $croncmd"
( gosu aegir crontab -l | grep -v -F "$croncmd" ; echo "$cronjob" ) | gosu aegir crontab -
# To remove it from the crontab whatever its current schedule:
# ( crontab -l | grep -v -F "$croncmd" ) | crontab -
