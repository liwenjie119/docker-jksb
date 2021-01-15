FROM       ubuntu:18.04

ENV FORCE_UNSAFE_CONFIGURE=1 \
	TZ=Asia/Shanghai

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
	&&sed -ri 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
	&&apt-get -yqq update&&apt-get -yqq install libterm-readkey-perl \
	&&apt-get -yqq install curl cron unzip wget gdebi git python3 python3-pip screen\
	&&python3 -m pip install --upgrade requests&&python3 -m pip install --upgrade pip&& python3 -m pip install --upgrade selenium \
	&&LATEST=$(wget -q -O - http://chromedriver.storage.googleapis.com/LATEST_RELEASE) \
	&&wget http://chromedriver.storage.googleapis.com/$LATEST/chromedriver_linux64.zip \
	&&unzip chromedriver_linux64.zip&&chmod +x chromedriver&& mv chromedriver /usr/bin/ \
	&&wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
	&&gdebi -n google-chrome-stable_current_amd64.deb \
	&&apt --fix-broken install 
	
RUN wget -q https://raw.githubusercontent.com/wcwac/zzu-jksb/master/jksb.py -O /root/jksb.py \
	&&sed -ri 's/8*3600/0/g' /root/jksb.py \
	&&echo "5 0 * * * /usr/bin/python3 /root/jksb.py" >> /var/spool/cron/crontabs/root \
	&&echo "35 7 * * * /usr/bin/python3 /root/jksb.py" >> /var/spool/cron/crontabs/root


CMD  ["screen","-S","cron"]