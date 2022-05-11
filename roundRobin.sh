#! /bin/bash

function roundrobin {
  #Initializing Bash variables
   timeQuantum=0
   awt=0
   atat=0
   temp=0
   temp2=0
   GanttChart=0
   totalwt=0
   totaltat=0
   
   declare -a  wt
   declare -a  tat
echo "Enter the Quantum time -- "; #Accepts user input for Quantum Time and Input Validation
read -r timeQuantum

while [[ -z "$timeQuantum" ]] || [[ "$timeQuantum" -le 0 ]]
do
echo "Quantum time cannot be blank or less than 1, please try again."
echo "Enter the Quantum time --  "
read -r timeQuantum
done 

echo -e "\n\t\t\t\tGantt Chart"
echo -n "0"
  while ((1))
  do
    for ((i = 1,count=0; i <=number; i++))
    do
      temp=$timeQuantum
      
      if [ "${rem_bt[i]}" -eq 0 ] 
      then 
        ((count++))
        
        continue
      fi

      if [ "${rem_bt[i]}" -gt "$timeQuantum" ]
        then
        rem_bt[$i]=$((rem_bt[i]-timeQuantum))
        GanttChart=$((GanttChart+timeQuantum))
        echo -n " -> P[""$i""] <-" "$GanttChart"
        else 
          if [ "${rem_bt[i]}" -ge 0 ]
          then
            temp=${rem_bt[i]};
            GanttChart=$((GanttChart+rem_bt[i]))
            echo -n " -> P[""$i""] <-" "$GanttChart"
            rem_bt[$i]=0;
          fi        
      fi
      temp2=$((temp2+temp))
      tat[$i]=$temp2
    done
    if [ "$number" -eq "$count" ]
    then
    break
    fi

  done
    echo -e "\n\nProcess\t    Burst Time    \tWaiting Time\tTurnaround Time"
    for ((i = 1; i <= number; i++))
    { 
        wt[i]=$((tat[i]-Btime[i]))
        totalwt=$((totalwt+wt[i]))
        totaltat=$((totaltat+tat[i]))
        
       echo -e "$i\t\t  ${Btime[i]}\t\t    ${wt[i]}\t\t\t${tat[i]}"
    }
    awt=$(echo 'scale=2;' "$totalwt" / "$number" | bc -l)
    atat=$(echo 'scale=2;' "$totaltat" / "$number" | bc -l)

echo "Total waiting time =" "$totalwt"
echo "Average waiting time =" "$awt"
echo "Total Turnaround Time =" "$totaltat"
echo "Average Turnaround Time =" "$atat"
}

#Accepts user input for Number of Processes and Input Validation
echo "Enter the number of processes -- "
read -r number
while [[ "$number" -le 1 ]] || [[ -z "$number" ]]
do
echo "Error: Input valid number of processes or Input cannot be blank"
echo "Please try again."
echo "Enter the number of processes -- "
read -r number
done

declare -a Btime
declare -a  p
declare -a  rem_bt

#Accepts user input for Burst Time and Input Validation
for (( i=1; i<=number; i++ ))
do

echo "Enter Burst Time for Process -- $i"
read -r "Btime[i]"

while [[ "${Btime[i]}" -lt 1 ]] || [[ -z "${Btime[i]}" ]]
do
echo "Error: Input valid burst time for the process or Inputs cannot be blank"
echo "Please try again."
echo "Enter Burst Time for Process -- $i"
read -r "Btime[i]"
done
p[i]=$i  #contains process number
rem_bt[i]=${Btime[i]} #remaining process
done

echo -e "CPU burst Time for processes in nano second --" "${Btime[@]}"
echo -e "Process Number for CPU burst time           --" "${p[@]}"
echo ""
echo "Calculation for Round Robin for processes entered are as follows: "
roundrobin