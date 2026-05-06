#!/bin/bash

# echo "===== SERVER MONITOR =====" >> ./monitor.log

# echo "System Uptime:"
# uptime | tee -a ./monitor.log

# echo "Disk Usage:"
# df -h  | tee -a ./monitor.log

# echo "Memory Usage:"
# free -m | tee -a ./monitor.log

# echo "===== SERVER MONITOR ENDED =====" >> ./monitor.log


LOG_FILE="/home/shubh/monitorServer/monitor.log"

{
    echo "================================================ SERVER MONITOR ======================================"
    echo "Time: $(date)"

    echo "System Uptime:"
    uptime

    DISK_USAGE=$( df / | awk 'NR==2 {print $5}' | sed 's/%//' )
    DISK_LIMIT=0
    echo "Disk Usage: $DISK_USAGE"
    if [ $DISK_USAGE -gt $DISK_LIMIT ];then
        echo "ALERT! DISK USAGE REACH SAFETY LIMIT"
    fi
    df -h

    MEMORY_USAGE=$( free -m | awk '/Mem:/ {printf("%.0f"), $3/$2 * 100}' )
    MEMORY_LIMIT=5
    if [ $MEMORY_USAGE -gt $MEMORY_LIMIT ];then
        echo "ALERT! MEMORY LIMIT EXCEEDED!"
    fi
    echo "Memory Usage:"
    free -m

    echo "============================================== END ============================================================"
} | tee -a "$LOG_FILE"
