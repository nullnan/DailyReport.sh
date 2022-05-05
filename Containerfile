FROM debian:11

# Set timezone and locale
ENV TZ=Asia/Shanghai
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# install dependencies
RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
 apt-get update && apt-get install -y cron jq curl gawk && apt-get clean

# Copy files
COPY ./ /daily_report/

# Set Crontab

RUN echo '5 8-19/1 * * * bash /daily_report/main.sh' | crontab 

# Start cron 
CMD ["cron", "-f"]