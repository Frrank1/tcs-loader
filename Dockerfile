FROM maven:3.3.9-jdk-8

RUN mkdir -p /usr/share/tc/exports

RUN apt-get update && apt-get install -y --no-install-recommends cron

COPY . /usr/share/tc/app


WORKDIR /usr/share/tc/app


RUN mvn install:install-file -Dfile=./RedshiftJDBC42-1.2.1.1001.jar \
    -DgroupId=com.amazon -DartifactId=redshift.jdbc42 \
    -Dversion=1.2.1.1001 -Dpackaging=jar -DgeneratePom=true \
    -DlocalRepositoryPath=./repo

RUN mvn install && mvn package

RUN crontab tccron

ADD /usr/share/tc/exports/data.txt

RUN echo "Starting.."  > /usr/share/tc/exports/data.txt

#EXPOSE 2020

#RUN bash ./scripts/loadredshiftscript.sh

CMD cron && tail -f /usr/share/tc/exports/data.txt