FROM       ubuntu:18.04

ENV FORCE_UNSAFE_CONFIGURE=1 \
	TZ=Asia/Shanghai \
	password=password \
	username=username \
	api=api

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
	&&cd /root \
	&&sed -ri 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
	&&apt-get -yqq update&&apt-get -yqq upgrade&&apt-get -yqq install libterm-readkey-perl \
	&&apt-get install -yqq sudo ssh net-tools vim screen language-pack-zh-hans bash-completion fonts-wqy-microhei \
	&&mkdir /var/run/sshd \
	&&echo 'export LC_ALL=zh_CN.UTF-8' >> /etc/profile \
	&&echo 'source /etc/profile' >> /root/.bashrc \
	&&echo 'root:root' |chpasswd \
	&&sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
	&&sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
	&&mkdir /root/.ssh \
	&&apt-get -yqq install curl cron unzip wget gdebi git python3 python3-pip screen tzdata \
	&&sed -ri 's#required#sufficient#g' /etc/pam.d/cron \
	&&python3 -m pip install --upgrade requests&&python3 -m pip install --upgrade pip&& python3 -m pip install --upgrade selenium \
	&&LATEST=$(wget -q -O - http://chromedriver.storage.googleapis.com/LATEST_RELEASE) \
	&&wget http://chromedriver.storage.googleapis.com/$LATEST/chromedriver_linux64.zip -O /root/chromedriver_linux64.zip \
	&&unzip chromedriver_linux64.zip&&chmod +x chromedriver&& mv chromedriver /usr/bin/ \
	&&wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /root/google-chrome-stable_current_amd64.deb \
	&&gdebi -n google-chrome-stable_current_amd64.deb \
	&&apt --fix-broken install \
	&&rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
	&&rm -rf /usr/share/dotnet /usr/local/lib/android /opt/ghc /root/chromedriver_linux64.zip /root/google-chrome-stable_current_amd64.deb
	
RUN cd /root&&wget -q https://raw.githubusercontent.com/wcwac/zzu-jksb/master/jksb.py -O /root/jksb.py \
	&&wget https://raw.githubusercontent.com/liwenjie119/docker-jksb/main/start.sh -O /root/start.sh \
	&&wget https://raw.githubusercontent.com/liwenjie119/docker-jksb/main/py.sh -O /root/py.sh \
	&&chmod 0755 /root/* \
	&&sed -ri 's/8*3600/0/g' /root/jksb.py \
	&&echo '/etc/init.d/cron restart -D' >> /root/.bashrc \
	&&echo "5 0 * * * /root/py.sh >> /root/jksb.log 2>&1" >> /var/spool/cron/crontabs/root \
	&&echo "40 7 * * * /root/py.sh >> /root/jksb.log 2>&1" >> /var/spool/cron/crontabs/root \
	&&/etc/init.d/cron start 

EXPOSE 22

ENTRYPOINT  ["/root/start.sh"]
