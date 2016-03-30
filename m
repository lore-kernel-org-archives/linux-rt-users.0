From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v1] Use swait in completion
Date: Wed, 30 Mar 2016 16:53:04 +0200
Message-ID: <1459349585-6527-1-git-send-email-wagi@monom.org>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hotel311.server4you.de ([85.25.146.15]:60766 "EHLO
	hotel311.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970AbcC3OxY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Mar 2016 10:53:24 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

Hi,

To avoid a size increase of struct completion, I spitted the done
field into two half. 

add/remove: 3/0 grow/shrink: 3/10 up/down: 242/-236 (6)
function                                     old     new   delta
swake_up_all_locked                            -     181    +181
__kstrtab_swake_up_all_locked                  -      20     +20
__ksymtab_swake_up_all_locked                  -      16     +16
complete_all                                  73      87     +14
try_wait_for_completion                       99     107      +8
completion_done                               40      43      +3
complete                                      73      65      -8
wait_for_completion_timeout                  283     265     -18
wait_for_completion_killable_timeout         319     301     -18
wait_for_completion_io_timeout               283     265     -18
wait_for_completion_io                       275     257     -18
wait_for_completion                          275     257     -18
wait_for_completion_interruptible_timeout     304     285     -19
kexec_purgatory                            26473   26449     -24
wait_for_completion_killable                 544     499     -45
wait_for_completion_interruptible            522     472     -50


Obviously, that decreases the number of waiters which can be handled
to 32k instead of 2M. I started to review all complete_all() users
(half through) and none so far seem to use a huge number of
waiters. It looks almost like most usages of complete_all() could be
turned into complete(). Let's see what the rest of the complete_all()
users do.

So far I only found one hot path user of complete_all(), it's ceph's
rdb code. Luckily I could play with fio on a real ceph cluster.

[global]
ioengine=rbd
pool=rbd
rbdname=fio_test
rw=rw
bs=4k

runtime=60

[rbd_iodepth32]
iodepth=32


baseline (4.5.0-00038-g5b87ae2):

rbd_iodepth32: (g=0): rw=rw, bs=4K-4K/4K-4K/4K-4K, ioengine=rbd, iodepth=32
fio-2.2.8
Starting 1 process
rbd engine: RBD version: 0.1.9

rbd_iodepth32: (groupid=0, jobs=1): err= 0: pid=2370: Wed Mar 30 15:43:52 2016
  read : io=85596KB, bw=1425.8KB/s, iops=356, runt= 60038msec
    slat (usec): min=0, max=73, avg= 1.76, stdev= 3.91
    clat (usec): min=27, max=174894, avg=28943.97, stdev=31059.18
     lat (usec): min=33, max=174908, avg=28945.73, stdev=31059.18
    clat percentiles (usec):
     |  1.00th=[  179],  5.00th=[  708], 10.00th=[ 1112], 20.00th=[ 1720],
     | 30.00th=[ 2256], 40.00th=[ 2832], 50.00th=[24704], 60.00th=[35584],
     | 70.00th=[44288], 80.00th=[54528], 90.00th=[72192], 95.00th=[86528],
     | 99.00th=[116224], 99.50th=[136192], 99.90th=[148480], 99.95th=[175104],
     | 99.99th=[175104]
    bw (KB  /s): min=  464, max= 2576, per=100.00%, avg=1435.27, stdev=451.79
  write: io=85464KB, bw=1423.6KB/s, iops=355, runt= 60038msec
    slat (usec): min=0, max=63, avg= 1.99, stdev= 4.05
    clat (msec): min=6, max=177, avg=60.84, stdev=24.07
     lat (msec): min=6, max=177, avg=60.84, stdev=24.07
    clat percentiles (msec):
     |  1.00th=[   23],  5.00th=[   30], 10.00th=[   34], 20.00th=[   41],
     | 30.00th=[   46], 40.00th=[   50], 50.00th=[   57], 60.00th=[   64],
     | 70.00th=[   72], 80.00th=[   81], 90.00th=[   93], 95.00th=[  104],
     | 99.00th=[  137], 99.50th=[  145], 99.90th=[  176], 99.95th=[  176],
     | 99.99th=[  178]
    bw (KB  /s): min=  543, max= 2401, per=100.00%, avg=1432.49, stdev=437.34
    lat (usec) : 50=0.15%, 100=0.20%, 250=0.38%, 500=0.84%, 750=1.23%
    lat (usec) : 1000=1.75%
    lat (msec) : 2=8.49%, 4=10.52%, 10=0.21%, 20=0.26%, 50=34.17%
    lat (msec) : 100=36.94%, 250=4.86%
  cpu          : usr=0.29%, sys=0.07%, ctx=2950, majf=0, minf=69
  IO depths    : 1=2.4%, 2=4.7%, 4=9.5%, 8=19.8%, 16=58.9%, 32=4.7%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=96.1%, 8=0.4%, 16=0.8%, 32=2.7%, 64=0.0%, >=64=0.0%
     issued    : total=r=21399/w=21366/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   READ: io=85596KB, aggrb=1425KB/s, minb=1425KB/s, maxb=1425KB/s, mint=60038msec, maxt=60038msec
  WRITE: io=85464KB, aggrb=1423KB/s, minb=1423KB/s, maxb=1423KB/s, mint=60038msec, maxt=60038msec

Disk stats (read/write):
  sde: ios=3/7, merge=0/0, ticks=1/0, in_queue=1, util=0.00%


swait-completion (4.5.0-00040-g5e20c37):

rbd_iodepth32: (g=0): rw=rw, bs=4K-4K/4K-4K/4K-4K, ioengine=rbd, iodepth=32
fio-2.2.8
Starting 1 process
rbd engine: RBD version: 0.1.9

rbd_iodepth32: (groupid=0, jobs=1): err= 0: pid=2655: Wed Mar 30 15:40:59 2016
  read : io=85180KB, bw=1417.3KB/s, iops=354, runt= 60103msec
    slat (usec): min=0, max=75, avg= 1.74, stdev= 4.10
    clat (usec): min=25, max=200465, avg=29529.78, stdev=31181.31
     lat (usec): min=32, max=200466, avg=29531.52, stdev=31181.29
    clat percentiles (usec):
     |  1.00th=[  239],  5.00th=[  788], 10.00th=[ 1256], 20.00th=[ 1800],
     | 30.00th=[ 2416], 40.00th=[ 3216], 50.00th=[26752], 60.00th=[36608],
     | 70.00th=[44288], 80.00th=[54016], 90.00th=[72192], 95.00th=[90624],
     | 99.00th=[118272], 99.50th=[138240], 99.90th=[154624], 99.95th=[175104],
     | 99.99th=[195584]
    bw (KB  /s): min=  418, max= 2567, per=100.00%, avg=1420.58, stdev=431.94
  write: io=85136KB, bw=1416.6KB/s, iops=354, runt= 60103msec
    slat (usec): min=0, max=413, avg= 1.98, stdev= 5.15
    clat (msec): min=7, max=204, avg=60.72, stdev=24.68
     lat (msec): min=7, max=204, avg=60.73, stdev=24.68
    clat percentiles (msec):
     |  1.00th=[   24],  5.00th=[   30], 10.00th=[   35], 20.00th=[   41],
     | 30.00th=[   46], 40.00th=[   51], 50.00th=[   57], 60.00th=[   62],
     | 70.00th=[   71], 80.00th=[   81], 90.00th=[   94], 95.00th=[  108],
     | 99.00th=[  137], 99.50th=[  153], 99.90th=[  202], 99.95th=[  204],
     | 99.99th=[  204]
    bw (KB  /s): min=  544, max= 2304, per=100.00%, avg=1420.61, stdev=397.98
    lat (usec) : 50=0.14%, 100=0.10%, 250=0.30%, 500=0.73%, 750=1.08%
    lat (usec) : 1000=1.53%
    lat (msec) : 2=8.29%, 4=10.62%, 10=0.50%, 20=0.23%, 50=34.29%
    lat (msec) : 100=37.51%, 250=4.69%
  cpu          : usr=0.31%, sys=0.08%, ctx=2827, majf=0, minf=31
  IO depths    : 1=2.4%, 2=4.7%, 4=9.5%, 8=20.0%, 16=58.8%, 32=4.6%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=96.1%, 8=0.3%, 16=0.8%, 32=2.8%, 64=0.0%, >=64=0.0%
     issued    : total=r=21295/w=21284/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   READ: io=85180KB, aggrb=1417KB/s, minb=1417KB/s, maxb=1417KB/s, mint=60103msec, maxt=60103msec
  WRITE: io=85136KB, aggrb=1416KB/s, minb=1416KB/s, maxb=1416KB/s, mint=60103msec, maxt=60103msec

Disk stats (read/write):
  sde: ios=0/13, merge=0/1, ticks=0/0, in_queue=0, util=0.00%


My micro benchmark shows some small improvements if there is one waiter
only, which I think is the common use case. You can clearly the
latency increase if the complete_all() call is from the irq context
and there are more than 1 waiter because the wake up all call is
deferred.

irqwork 0/1:     complete_all() is called from thread or irq context
counter-100000:  number of iterations
waiter_nr-[0-5]: number of waiters


proc-irqwork-0-counter-10000-waiter_nr-1
                                        mean               std               var               max               min       
             4.5.0-00038-g5b87ae2    0.01515          0.002489         6.194e-06             0.028             0.012       
             4.5.0-00040-g5e20c37    0.01483   2.09   0.002614  -5.05  6.835e-06 -10.35      0.029  -3.57      0.011   8.33


proc-irqwork-0-counter-10000-waiter_nr-2
                                        mean               std               var               max               min       
             4.5.0-00038-g5b87ae2     0.1081          0.005127         2.629e-05             0.161             0.098       
             4.5.0-00040-g5e20c37     0.1066   1.40   0.003345  34.76  1.119e-05  57.43      0.142  11.80      0.101  -3.06


proc-irqwork-0-counter-10000-waiter_nr-3
                                        mean               std               var               max               min       
             4.5.0-00038-g5b87ae2     0.1185          0.004941         2.441e-05             0.181             0.111       
             4.5.0-00040-g5e20c37     0.1254  -5.78   0.004619   6.51  2.134e-05  12.60      0.176   2.76      0.121  -9.01


proc-irqwork-0-counter-10000-waiter_nr-4
                                        mean               std               var               max               min       
             4.5.0-00038-g5b87ae2     0.1343          0.004129         1.705e-05             0.173             0.128       
             4.5.0-00040-g5e20c37     0.1289   4.03   0.004587 -11.11  2.104e-05 -23.45      0.177  -2.31      0.124   3.13


proc-irqwork-0-counter-10000-waiter_nr-5
                                        mean               std               var               max               min       
             4.5.0-00038-g5b87ae2     0.1463          0.004261         1.815e-05             0.175             0.141       
             4.5.0-00040-g5e20c37     0.1469  -0.44   0.004617  -8.35  2.131e-05 -17.40      0.201 -14.86      0.141   0.00


proc-irqwork-1-counter-10000-waiter_nr-1
                                        mean               std               var               max               min       
             4.5.0-00038-g5b87ae2    0.01992          0.002911         8.476e-06             0.038             0.019       
             4.5.0-00040-g5e20c37    0.01932   3.00   0.002845   2.28  8.095e-06   4.50      0.037   2.63      0.018   5.26


proc-irqwork-1-counter-10000-waiter_nr-2
                                        mean               std               var               max               min       
             4.5.0-00038-g5b87ae2     0.1357          0.005088         2.589e-05             0.184             0.118       
             4.5.0-00040-g5e20c37     0.1558 -14.85   0.004727   7.10  2.234e-05  13.69      0.213 -15.76      0.151 -27.97


proc-irqwork-1-counter-10000-waiter_nr-3
                                        mean               std               var               max               min       
             4.5.0-00038-g5b87ae2     0.1309          0.004545         2.066e-05             0.173             0.119       
             4.5.0-00040-g5e20c37     0.1598 -22.08   0.005181 -13.98  2.684e-05 -29.93      0.226 -30.64      0.155 -30.25


proc-irqwork-1-counter-10000-waiter_nr-4
                                        mean               std               var               max               min       
             4.5.0-00038-g5b87ae2     0.1413          0.004988         2.488e-05             0.168             0.131       
             4.5.0-00040-g5e20c37     0.1651 -16.90   0.005854 -17.36  3.427e-05 -37.74       0.24 -42.86      0.159 -21.37


proc-irqwork-1-counter-10000-waiter_nr-5
                                        mean               std               var               max               min       
             4.5.0-00038-g5b87ae2     0.1478          0.004044         1.635e-05             0.181             0.144       
             4.5.0-00040-g5e20c37     0.1755 -18.76   0.004753 -17.54  2.259e-05 -38.15      0.231 -27.62      0.166 -15.28



With Tom Zanussi's hist patches I was able to gather some more data on
the distribution of the latencies. This is only with 1 waiter.


irqwork-0

4.5.0-00038-g5b87ae2

{ latency: ~ 2^9  } hitcount:         10
{ latency: ~ 2^10 } hitcount:  100790083
{ latency: ~ 2^11 } hitcount:     141105
{ latency: ~ 2^12 } hitcount:      84360
{ latency: ~ 2^13 } hitcount:      34744
{ latency: ~ 2^14 } hitcount:       8632
{ latency: ~ 2^15 } hitcount:        443
{ latency: ~ 2^16 } hitcount:         35
{ latency: ~ 2^17 } hitcount:          4
{ latency: ~ 2^19 } hitcount:        149

4.5.0-00040-g5e20c37

{ latency: ~ 2^9  } hitcount:        193
{ latency: ~ 2^10 } hitcount:  103169910
{ latency: ~ 2^11 } hitcount:     101648
{ latency: ~ 2^12 } hitcount:      78514
{ latency: ~ 2^13 } hitcount:      35127
{ latency: ~ 2^14 } hitcount:       9922
{ latency: ~ 2^15 } hitcount:        562
{ latency: ~ 2^16 } hitcount:         19
{ latency: ~ 2^17 } hitcount:         18
{ latency: ~ 2^19 } hitcount:        146


irqwork-1

4.5.0-00038-g5b87ae2

{ latency: ~ 2^10 } hitcount:    9088981
{ latency: ~ 2^11 } hitcount:   48496198
{ latency: ~ 2^12 } hitcount:      90199
{ latency: ~ 2^13 } hitcount:      55650
{ latency: ~ 2^14 } hitcount:       9940
{ latency: ~ 2^15 } hitcount:        766
{ latency: ~ 2^16 } hitcount:         19
{ latency: ~ 2^17 } hitcount:         28
{ latency: ~ 2^19 } hitcount:        130

4.5.0-00040-g5e20c37

{ latency: ~ 2^10 } hitcount:   28371223
{ latency: ~ 2^11 } hitcount:   28260205
{ latency: ~ 2^12 } hitcount:      99544
{ latency: ~ 2^13 } hitcount:      47821
{ latency: ~ 2^14 } hitcount:       9860
{ latency: ~ 2^15 } hitcount:        443
{ latency: ~ 2^16 } hitcount:         28
{ latency: ~ 2^17 } hitcount:         21
{ latency: ~ 2^19 } hitcount:        121


The patches are available also here:

git://git.kernel.org/pub/scm/linux/kernel/git/wagi/linux.git completion-test-3
git://git.kernel.org/pub/scm/linux/kernel/git/wagi/linux.git baseline


cheers,
daniel

Daniel Wagner (1):
  sched/completion: convert completions to use simple wait queues

 include/linux/completion.h | 23 ++++++++++++++++-------
 include/linux/swait.h      |  1 +
 kernel/sched/completion.c  | 43 ++++++++++++++++++++++++++-----------------
 kernel/sched/swait.c       | 24 ++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 24 deletions(-)

-- 
2.5.5
