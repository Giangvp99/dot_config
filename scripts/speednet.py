import psutil
import time

MB = 1024 ** 2
KB = 1024
o_net_init = psutil.net_io_counters(pernic=False)
time.sleep(1)
n_net_init = psutil.net_io_counters(pernic=False)
recv = n_net_init.bytes_recv - o_net_init.bytes_recv
sent = n_net_init.bytes_sent - o_net_init.bytes_sent
if recv / MB > 1:
    recv = "{:.1f}M".format(recv / MB)
elif recv / KB > 1:
    recv = "{:.0f}K".format(recv / KB)
else:
    recv = "{:.0f}B".format(recv)
if sent / MB > 1:
    sent = "{:.1f}M".format(sent / MB)
elif sent / KB > 1:
    sent = "{:.0f}K".format(sent / KB)
else:
    sent = "{:.0f}B".format(sent)
print(recv, sent)
