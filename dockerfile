# Docker image with uWSGI and Nginx for web applications in Python in a single container
# FROM tiangolo/uwsgi-nginx-flask:python3.8 # Flask
# django
FROM tiangolo/uwsgi-nginx:python3.8

# Install a package, this removes the server details header
RUN apt-get update
RUN yes | apt-get -y install vim
RUN yes | apt-get install nginx-extras
RUN yes | apt-get install libgirepository1.0-dev
RUN yes | apt-get install libdbus-glib-1-dev libgirepository1.0-dev libcairo2-dev
RUN python3 --version

# <---- java dependencies --->
# RUN apt-get update
# RUN apt-get -y install default-jre
# RUN java -version
# RUN apt-get -y install default-jdk
# RUN javac -version

# Configuration settings for UWSGI
ENV UWSGI_CHEAPER 4
ENV UWSGI_PROCESSES 64

# Which uWSGI .ini file should be used, to make it customizable
# ENV UWSGI_INI /app/uwsgi.ini
ENV UWSGI_INI /cicd_repo/uwsgi.ini
RUN pwd
RUN ls
# ## Copy app folder to app
RUN mkdir module
COPY ./module ./module

RUN pwd
# Set app as the root directory
WORKDIR /app
RUN pwd
# Make /app/* available to be imported by Python

ENV PYTHONPATH=/app
RUN pwd
# # Make permissions for mitm files
# RUN chmod -R 777 /module
# RUN chmod -R 777 /app/mitmweb
# RUN chmod -R 777 /app/mitmproxy

# # Copy dependencies to project root
COPY requirements.txt ./
# # #Copying Environment file
#
COPY main.py ./
# COPY module ./module
# # COPY default_mongodb_update.py /default_mongodb_update.py
# # COPY was_env_update.py /was_env_update.py
# RUN ls

# Install app dependencies
RUN pip3 install --no-cache-dir -r requirements.txt
# RUN pip3 install cryptography
# RUN pip3 install pywinrm
EXPOSE 8080
CMD ["python3" ,"main.py"]


# what is docker file?
# A text file with instructions to build image Automation of Docker Image Creation
# COMMANDS
# : docker build
# : docker build -t ImageName:Tag directoryOfDocekrfile
#
# : docker run image
