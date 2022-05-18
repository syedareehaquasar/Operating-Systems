#! /bin/bash

> input.txt

function priorityScheduling {
    awt=0 
    totalwt=0
    totaltat=0
    atat=0
    declare -a  wt
    declare -a  tat

    sh sortfile.sh
    IFS=$'\n'
    i=1
    for line in $(cat ./output.txt)
    do
        IFS=" "
        var=($line)
        priority[i]=${var[0]}
        Btime[i]=${var[1]}
        p[i]=${var[2]}
        i=$((i+1))
    done

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
    echo "Error: No. of process cannot be blank or less than 2"
    echo "Please try again."
    echo "Enter the number of processes -- "
    read -r number
done

declare -a Btime
declare -a  p
declare -a priority
declare -a data

#Accepts user input for Burst Time and Input Validation
for (( i=1; i<=number; i++ ))
do
    echo "For process ------- $((i))"
    echo "Enter Priority of the process:"
    read -r "priority[i]"
    echo "Enter Burst Time of the process:"
    read -r "Btime[i]"

    while [[ "${Btime[i]}" -lt 1 ]] || [[ -z "${Btime[i]}" ]]
    do
        echo "Error: Input valid priority or burst time for the process or Inputs cannot be blank"
        echo "Please try again."
        echo "Enter Priority of the process:"
        read -r "priority[i]"
        echo "Enter Burst Time of the process:"
        read -r "Btime[i]"
    done
    p[i]=$((i))
    echo $(echo ${priority[i]} ${Btime[i]} ${p[i]}) >> input.txt
done

echo -e "CPU burst Time for processes in nano second --" "${Btime[@]}"
echo -e "Process Number for CPU burst time           --" "${p[@]}"
echo ""
echo "Calculation for Priority Scheduling for processes entered are as follows: "
priorityScheduling