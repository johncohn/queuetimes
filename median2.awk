{ 
    sum += $1
    nums[NR] = $1  # We store the input records
	}
END {
    if (NR == 0) exit  #To avoid division by zero
 
    asort(nums)  #  Here, we sort the array that
                 #+ contains the stored input
 
    median = (NR % 2 == 0) ?  #  Let's be carefull with the
                              #+ short-if syntax
        ( nums[NR / 2] + nums[(NR / 2) + 1] ) / 2 \
        :
        nums[int(NR / 2) + 1]
 
    #  We used "(NR / 2) + 1", instead "NR/2 + 1", just for
    #+ the sake of clarity; to be more verbose
 
    mean = sum/NR
 
    #Let's beautify the output
    printf \
        "median = %s, mean = %s,  min = %s, max = %s, \n\n",\
        median/60,\
        mean/60,   \
        nums[1]/60, \
        nums[NR]/60
}#/usr/bin/env awk
