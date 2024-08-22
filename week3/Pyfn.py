def time_to_int(timeStr):
    """Convert 'HHhrs MMmin' string to integer in total minutes."""
    timeStr = timeStr.replace('hrs ', '').replace('min', '').replace(' ', '')
    hours = int(timeStr[:2])
    minutes = int(timeStr[2:])
    return (hours * 60) + minutes

def arrangeTimes(*allTimes):
    """Sort times using Python's sorted() function and a custom key."""
    return sorted(allTimes, key=time_to_int)


