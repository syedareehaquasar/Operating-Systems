process=("p1" "p2" "p3" "p4" "p5")
bt=(0 0 0 0 0)
wt=(0 0 0 0 0)
tat=(0 0 0 0 0)

bt[0]=1
factor=0
wtSum=0
tatSum=0

echo "We will be using FCFS for 5 processes"

for ((i=0; i<5; i++))
do
  echo "Enter burst time for process ${process[i]}"
  read ele
  bt[i]=$ele
  wt[i]=$factor
  factor=$((factor + ele))
  tat[i]=$((bt[i] + wt[i]))
  wtSum=$((wt[i] + wtSum))
  tatSum=$((tat[i] + tatSum))
done

echo ""
echo "Process | Burst Time | Wait Time | Turn Around Time"

for ((i=0; i<5; i++))
do
  echo "${process[i]}      | ${bt[i]}          | ${wt[i]}          | ${tat[i]}" 
done

echo ""
echo "Average waiting time = $((wtSum/5))"
echo "Average turn around time = $((tatSum/5))"


