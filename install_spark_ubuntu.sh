# installation script for spark 1.2.1 on ubuntu 14.x 
# usage : sudo sh install_spark_ubuntu.sh

# install java 7
apt-add-repository ppa:webupd8team/java
apt-get update
apt-get install oracle-java7-installer

# verify java
java -version

# set min and max heap memory
export _JAVA_OPTIONS = "-Xms64M -Xmx1024M"

# install scala 2.11.7
wget http://www.scala-lang.org/files/archive/scala-2.11.7.tgz
mkdir /usr/local/src/scala
tar xvf scala-2.11.7.tgz -C /usr/local/src/scala/

# set the path for scala 
echo 'export SCALA_HOME=/usr/local/src/scala/scala-2.11.7' >> ~/.bashrc
echo 'export PATH=$SCALA_HOME/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# verify scala
sudo apt-get install git

# download and extract spark 1.2.1
wget http://d3kbcqa49mib13.cloudfront.net/spark-1.2.1.tgz
tar xvf spark-1.2.1.tgz 
cd spark-1.2.1/

# set logging parameters
cp /conf/log4j.properties.template conf/log4j.properties
sed -i '/log4j.rootCategory=INFO, console/ c\ log4j.rootCategory=ERROR, console' log4j.properties

# build spark
sbt/sbt assembly

# verify spark
./bin/run-example SparkPi 10