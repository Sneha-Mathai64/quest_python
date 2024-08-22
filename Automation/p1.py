def isGreater(time1Str, time2Str):
    #  replace() to remove 'hrs ' and 'min' from the strings to get the time in HHMM format
    time1 = time1Str.replace('hrs ', '').replace('min', '').replace(' ', '')
    time2 = time2Str.replace('hrs ', '').replace('min', '').replace(' ', '')
    

    if int(time1) >= int(time2):
        return time1Str
    else:
        return time2Str

def arrangeTimes(*allTimes):

    allTimes = list(allTimes)
  
    n = len(allTimes)
    
  
    for i in range(n):
        for j in range(0, n-i-1):
            if isGreater(allTimes[j], allTimes[j+1]) == allTimes[j]:
                # Swap the elements if  not in the correct order
                allTimes[j], allTimes[j+1] = allTimes[j+1], allTimes[j]
    
    return allTimes
