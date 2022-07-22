#!/bin/bash
sudo yum install -y perl-Switch perl-DateTime perl-Sys-Syslog perl-LWP-Protocol-https perl-Digest-SHA.x86_64
wget http://download.opensuse.org/repositories/devel:/languages:/perl/SLE_15_SP3/noarch/perl-Switch-2.17-32.1.noarch.rpm
sudo rpm -i perl-Switch-2.17-32.1.noarch.rpm --nodeps
cd /opt/
curl https://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.2.zip -O
unzip CloudWatchMonitoringScripts-1.2.2.zip
rm CloudWatchMonitoringScripts-1.2.2.zip
cd /opt/aws-scripts-mon/
rm -rf awscreds.template
echo -e "AWSAccessKeyId=AKIATMKG3Z7QU55JWJ5F \nAWSSecretKey=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" >> awscreds.template
./mon-put-instance-data.pl --mem-util --mem-used --mem-avail --disk-space-util --disk-space-used --disk-space-avail  --disk-path=/ --aws-access-key-id="AKIATMKG3Z7QU55JWJ5F" --aws-secret-key="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"
echo -e "$(sudo crontab -u root -l)\n* * * * * /opt/aws-scripts-mon/mon-put-instance-data.pl --mem-util --mem-used --mem-avail --disk-space-util --disk-space-used --disk-space-avail  --disk-path=/ --from-cron " | sudo crontab -u root -