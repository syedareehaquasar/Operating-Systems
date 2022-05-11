#! /bin/bash

function priorityScheduling {
#Initializing Bash variables
awt=0 
totalwt=0
totaltat=0
atat=0
temp=0
declare -a  wt
declare -a  tat

echo "Priority ${priority[@]}"
echo "process ${p[@]}"
echo "burst time ${Btime[@]}"

#sorting priority in ascending order using selection sort
for ((i=0; i < $(($number - 1)); i++))
do
echo "checking for ${p[i]}, ${priority[i]}, ${Btime[i]} and $i"
    for ((j=$((i + 1)); j < $number; j++))
    do
        if [[ ${priority[i]} -lt ${priority[j]} ]]
        then
            echo "i in $i and j in $j"
            echo "swapping process ${p[i]}"
            # swap priorities
            tmp=${priority[i]}
            priority[i]=${priority[j]}
            priority[j]=$tmp     
            
            # swap process
            tmp=${p[i]}
            p[i]=${p[j]}
            p[j]=$tmp
            
            # swap Burst Time
            tmp=${Btime[i]}
            Btime[i]=${Btime[j]}
            Btime[j]=$tmp
        fi
    done
done
echo "Priority ${priority[@]}"
echo "process ${p[@]}"
echo "burst time ${Btime[@]}"

echo -e "Process\t    Burst Time    \tWaiting Time\tTurnaround Time \t Priority" 

for ((i=1;i<=number;i++))
do
        wt[i]=0;
        tat[i]=0;
        for ((j=0;j<i;j++))
        do
            wt[i]="$((wt[i]+Btime[j]))"     #calculate waiting time  
        done
        
        totalwt="$((totalwt+wt[i]))"     #calculate total waiting time
        tat[i]="$((Btime[i]+wt[i]))"     #calculate turnaround time
        totaltat="$((totaltat+tat[i]))"     #calculate total turnaround time
done

for ((i=0; i<number; i++))
do
    echo -e "${p[i]}\t\t  ${Btime[i]}\t\t    ${wt[i]}\t\t\t${tat[i]} \t\t ${priority[i]}"
done

awt=$(echo 'scale=2;' "$totalwt" / "$number" | bc -l)     #calculate average waiting time
atat=$(echo 'scale=2;' "$totaltat" / "$number" | bc -l)   #calculate average turnaround time
echo -e "\n"
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
declare -a priority

#Accepts user input for Burst Time and Input Validation
for (( i=1; i<=number; i++ ))
do

echo "Enter Burst Time for Process -- $i"
read -r "Btime[i]"
echo "Enter Priority for Process -- $i"
read -r "priority[i]"

while [[ "${Btime[i]}" -lt 1 ]] || [[ -z "${Btime[i]}" ]]
do
echo "Error: Input valid burst time for the process or Inputs cannot be blank"
echo "Please try again."
echo "Enter Burst Time for Process -- $i"
read -r "Btime[i]"
done
p[i]=$i  #contains process number
done

echo -e "CPU burst Time for processes in nano second --" "${Btime[@]}"
echo -e "Process Number for CPU burst time           --" "${p[@]}"
echo ""
echo "Calculation for Priority Scheduling for processes entered are as follows: "
priorityScheduling