#!/bin/bash

HOME='/home/johncohn/'
PYTHONPATH='/nobackup/users/johncohn/anaconda3/lib/python3.7'
SLURM_TIME_FORMAT="%s"
cd $HOME

NOW=$(date +"%Y-%m-%d-%H:%M" )
EARLIER=$(date +"%Y-%m-%d-%H:%M" -d 'now -12 hours') 


R1=$(sacct -X -o JOB,USER,ALLOCNODES,ALLOCGRES,SUBMIT,START,END,STATE -S ${EARLIER} -E ${NOW} -N node[0001-0064] | awk '($4 == "gpu:1"){gsub(/[-:T]/," ");d1=mktime($6" "$7" "$8" "$9" "$10" "$11); d2=mktime($12" "$13" "$14" "$15" "$16" "$17); print d2-d1 }' | sort --hu | awk -f median.awk | awk '{print ($1/60)}')

R4=$(sacct -X -o JOB,USER,ALLOCNODES,ALLOCGRES,SUBMIT,START,END,STATE -S ${EARLIER} -E ${NOW} -N node[0001-0064] | awk '($4 == "gpu:4"){gsub(/[-:T]/," ");d1=mktime($6" "$7" "$8" "$9" "$10" "$11); d2=mktime($12" "$13" "$14" "$15" "$16" "$17); print d2-d1 }' | sort --hu | awk -f median.awk | awk '{print ($1/60)}')

R8=$(sacct -X -o JOB,USER,ALLOCNODES,ALLOCGRES,SUBMIT,START,END,STATE -S ${EARLIER} -E ${NOW} -N node[0001-0064] | awk '($4 == "gpu:8"){gsub(/[-:T]/," ");d1=mktime($6" "$7" "$8" "$9" "$10" "$11); d2=mktime($12" "$13" "$14" "$15" "$16" "$17); print d2-d1 }' | sort --hu | awk -f median.awk | awk '{print ($1/60)}')

R16=$(sacct -X -o JOB,USER,ALLOCNODES,ALLOCGRES,SUBMIT,START,END,STATE -S ${EARLIER} -E ${NOW} -N node[0001-0064] | awk '($4 == "gpu:16"){gsub(/[-:T]/," ");d1=mktime($6" "$7" "$8" "$9" "$10" "$11); d2=mktime($12" "$13" "$14" "$15" "$16" "$17); print d2-d1 }' | sort --hu | awk -f median.awk | awk '{print ($1/60)}')

AR1=$(sacct -X -o JOB,USER,ALLOCNODES,ALLOCGRES,SUBMIT,START,END,STATE -S ${EARLIER} -E ${NOW} -N node[0001-0064] | awk '($4 == "gpu:1"){gsub(/[-:T]/," ");d1=mktime($6" "$7" "$8" "$9" "$10" "$11); d2=mktime($12" "$13" "$14" "$15" "$16" "$17); print d2-d1 }' | sort --hu | awk -f median2.awk)

AR4=$(sacct -X -o JOB,USER,ALLOCNODES,ALLOCGRES,SUBMIT,START,END,STATE -S ${EARLIER} -E ${NOW} -N node[0001-0064] | awk '($4 == "gpu:4"){gsub(/[-:T]/," ");d1=mktime($6" "$7" "$8" "$9" "$10" "$11); d2=mktime($12" "$13" "$14" "$15" "$16" "$17); print d2-d1 }' | sort --hu | awk -f median2.awk)

AR8=$(sacct -X -o JOB,USER,ALLOCNODES,ALLOCGRES,SUBMIT,START,END,STATE -S ${EARLIER} -E ${NOW} -N node[0001-0064] | awk '($4 == "gpu:8"){gsub(/[-:T]/," ");d1=mktime($6" "$7" "$8" "$9" "$10" "$11); d2=mktime($12" "$13" "$14" "$15" "$16" "$17); print d2-d1 }' | sort --hu | awk -f median2.awk) 

AR16=$(sacct -X -o JOB,USER,ALLOCNODES,ALLOCGRES,SUBMIT,START,END,STATE -S ${EARLIER} -E ${NOW} -N node[0001-0064] | awk '($4 == "gpu:16"){gsub(/[-:T]/," ");d1=mktime($6" "$7" "$8" "$9" "$10" "$11); d2=mktime($12" "$13" "$14" "$15" "$16" "$17); print d2-d1 }' | sort --hu | awk -f median2.awk)


if [ -z "$AR1" ] 
then 
AR1="no data"
else 
AR1="${AR1} (minutes)" 
fi
if [ -z "$AR4" ] 
then 
AR4="no data"
else 
AR4="${AR4} (minutes)" 
fi
if [ -z "$AR8" ] 
then 
AR8="no data"
else 
AR8=$"${AR8} (minutes)" 
fi
if [ -z "$AR16" ] 
then 
AR16="no data"
else 
AR16="${AR16} (minutes)" 
fi

echo "Interval ${EARLIER}-${NOW}"
echo "1  gpu: ${AR1}" 
echo "4  gpu: ${AR4}"
echo "8  gpu: ${AR8}"
echo "16 gpu: ${AR16}"



#echo "$((($(date -d "$RUN4" '+%s') - $(date -d "$SUBMIT4" '+%s'))/60/60))"

#"$((($(date -d "$RUN4" '+%s') - $(date -d "$SUBMIT4" '+%s'))/60))"
#echo "${RUN4} - ${SUBMIT4}"

#echo "${PENDING}"
#/nobackup/users/johncohn/anaconda3/bin/python pubstats.py ${IDLE} ${RUNNING} ${PENDING}
