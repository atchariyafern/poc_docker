FROM gliderlabs/alpine:3.3
FROM python:3.9.0-alpine3.12

# Dependency versions
ENV ALPINE_GLIBC 2.31-r0
ENV AWS_CLI_VERSION 1.20.6
ENV AXE_SELENIUM_LIBRARY_VERSION 2.1.6
ENV BROWSER_LIBRARY_VERSION 6.0.0
ENV CHROMIUM_VERSION 86.0
ENV DATABASE_LIBRARY_VERSION 1.2.4
ENV DATADRIVER_VERSION 1.4.1
ENV DATETIMETZ_VERSION 1.0.6
ENV FAKER_VERSION 5.0.0
ENV FIREFOX_VERSION 78
ENV FTP_LIBRARY_VERSION 1.9
ENV GECKO_DRIVER_VERSION v0.26.0
ENV IMAP_LIBRARY_VERSION 0.4.0
ENV PABOT_VERSION 2.0.1
ENV REQUESTS_VERSION 0.9.1
ENV ROBOT_FRAMEWORK_VERSION 4.1
ENV SELENIUM_LIBRARY_VERSION 5.1.3
ENV SSH_LIBRARY_VERSION 3.7.0
ENV XVFB_VERSION 1.20
ENV JSON_LIBRARY_VERSION 0.31
ENV HTTP3_LIBRARY_VERSION 0.6

# RUN apk-install bash py-pip firefox xvfb dbus chromium chromium-chromedriver
RUN apt-get install -y wget xvfb unzip

# Set up the Chrome PPA
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

# Update the package list and install chrome
RUN apt-get update -y
RUN apt-get install -y google-chrome-stable

# Set up Chromedriver Environment variables
ENV CHROMEDRIVER_VERSION 2.19
ENV CHROMEDRIVER_DIR /chromedriver
RUN mkdir $CHROMEDRIVER_DIR

# Download and install Chromedriver
RUN wget -q --continue -P $CHROMEDRIVER_DIR "http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip"
RUN unzip $CHROMEDRIVER_DIR/chromedriver* -d $CHROMEDRIVER_DIR

# Put Chromedriver into the PATH
ENV PATH $CHROMEDRIVER_DIR:$PATH

RUN pip3 install --upgrade pip
RUN pip3 install robotframework==$ROBOT_FRAMEWORK_VERSION
RUN pip3 install robotframework-seleniumlibrary==$SELENIUM_LIBRARY_VERSION
RUN pip3 install robotframework-jsonlibrary==$JSON_LIBRARY_VERSION
RUN pip3 install robotframework-requests==$REQUESTS_VERSION
RUN pip3 install robotframework-httplibrary3==$HTTP3_LIBRARY_VERSION
RUN pip3 install PyYAML

# Create the default report and work folders with the default user to avoid runtime issues
# These folders are writeable by anyone, to ensure the user can be changed on the command line.
RUN mkdir -p ${ROBOT_REPORTS_DIR} \
  && mkdir -p ${ROBOT_WORK_DIR} \
  && chown ${ROBOT_UID}:${ROBOT_GID} ${ROBOT_REPORTS_DIR} \
  && chown ${ROBOT_UID}:${ROBOT_GID} ${ROBOT_WORK_DIR} \
  && chmod ugo+w ${ROBOT_REPORTS_DIR} ${ROBOT_WORK_DIR}


ADD run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh


CMD ["run.sh"]
