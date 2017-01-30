 #!/bin/bash
 #
 #
  
  target=/mnt/sysroot
  
  clearCmd(){
          if which $cmd &> /dev/null; then
                  cmdPath=`which --skip-alias $cmd`
                  echo $cmdPath
          else
                  echo "no such command"
          fi
  }
  cmdCopy(){
         cmdDir=`dirname $1`
          [ -d ${target}${cmdDir} ] || mkdir -p ${target}${cmdDir}
          [ -f ${target}${1} ] || cp $1 ${target}${cmdDir}
  }
  
  libCopy(){
         for lib in `ldd $1 | grep -o "/[^[:space:]]\{1,\}"`; do
                 libDir=`dirname $lib`
                 [ -d ${target}${libDir} ] || mkdir -p ${target}${libDir}
                 [ -f ${target}${lib} ] || cp $lib ${target}${libDir}
         done
 }
 

 read -p "please type a command: " cmd
 
 clearCmd $cmd
 cmdCopy $cmdPath
 libCopy $cmdPath

