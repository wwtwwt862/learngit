#!/bin/sh

JAVA_HOME=/home/amarsoft/software/jdk1.8.0_152
export JAVA_HOME
cd /home/amarsoft/work/workspace/AmarPIDR

if [ -z "$JAVA_HOME" ]; then
echo "Please configure the JAVA_HOME!"
exit
fi

export PATH

CLASSPATH=.:${JAVA_HOME}/jre/lib/rt.jar:./classes:./bin:
export CLASSPATH

JLIBDIR=./lib
export JLIBDIR

for LL in `ls $JLIBDIR/*.jar`
do
CLASSPATH=$CLASSPATH:$LL
export CLASSPATH
done

JAVA_OPTION="-Dfile.encoding=UTF-8 -Xmx256M -Xms64M"
RUN_CLASS=com.amarsoft.app.pbc.pidr.AmarPIDR
ARE_CONFIG_FILE=etc/pidr_are.xml
TASK_FILES=$1

export JAVA_OPTION
export RUN_CLASS
export ARE_CONFIG_FILE
export TASK_CONFIG_FILE

${JAVA_HOME}/bin/java ${JAVA_OPTION} -classpath ${CLASSPATH} ${RUN_CLASS} are=${ARE_CONFIG_FILE} task=${TASK_FILES}
cd shell/pidr_sh
