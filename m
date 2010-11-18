From: Nathan Grennan <linux-rt-users@cygnusx-1.org>
Subject: Re: Soft lock issue with 2.6.33.7-rt29
Date: Thu, 18 Nov 2010 14:11:47 -0800
Message-ID: <4CE5A4A3.4040202@cygnusx-1.org>
References: <4CE428CB.20808@willowgarage.com> <4CE480BF.7050603@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Darren Hart <dvhart@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from okcforum.org ([173.8.189.10]:59245 "EHLO mail.okcforum.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752904Ab0KRWLt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Nov 2010 17:11:49 -0500
In-Reply-To: <4CE480BF.7050603@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/17/2010 05:26 PM, Darren Hart wrote:
> On 11/17/2010 11:11 AM, Nathan Grennan wrote:
>> I have been working for weeks to get a stable rt kernel. I had been
>> focusing on 2.6.31.6-rt19. It is stable for about four days under stress
>> testing before it soft locks. I am using rt19 instead of rt21, because
>> rt19 seems to be more stable. The rtmutex issue that seems to still be
>> in rt29 is in rt21. I also had to backport the iptables fix to rt19.
>>
>> I just started looking at 2.6.33.7-rt29 again, since I can reproduce a
>> soft lock with it in 10-15 minutes. I have yet to get sysrq output for
>> rt19, since it takes four days. The soft lock with rt29 as far as I can
>> tell seems to relate to disk i/o.
>>
>> There are links to two logs of rt29 from a serial console below. They
>> include sysrq output like "Show Blocked State" and "Show State". The
>> level7 file is with nfsd enable, and level9 is with it disable. So nfsd
>> doesn't seem to be the issue.
>>
>> If any other debugging information is useful or needed, just say the 
>> word.
>
> A reproducible test-case is always the first thing we ask for :-) What 
> is your stress test?

I have been able to boil it down the script below. If I just run yes it 
is fine, if I just run dd, it is fine. If you just run octave, it is 
fine. Run yes+dd, gets it most of the way there, but will wake up 
sometimes, off and on. Do all three together and it soft locks.  It 
takes 5-15 minutes. I did it on our main example hardware, which is a 
server. I have also reproduced it on a desktop. Sometimes sysrq-n, to 
renice realtime processes, brings it out of it enough you can kill 
processes off.


Run with:

./stress_test


#!/bin/bash

TIMEOUT=600
MAXTEMP=75

args=`getopt qt:m: $*`
set -- $args

for i
do
     case "$i" in
         -q) shift; QUIET=1;;
         -t) shift; TIMEOUT=$1; shift;;
         -m) shift; MAXTEMP=$1; shift;;
     esac
done

PROCLOOP=`mktemp`
CHECKLOOP=`mktemp`

echo 1 > ${PROCLOOP}
echo 1 > ${CHECKLOOP}

trap 'cat /dev/null > $CHECKLOOP' SIGHUP SIGINT SIGTERM

if [[ ! -e `which octave` ]]; then
   echo "Octave not installed. Please apt-get install octave." >&2
   exit -1
fi

[[ $QUIET ]] || echo "Starting Octave processes..."
for i in {1..8}; do
   (while [ -s $PROCLOOP ]; do nice -n 20 octave --eval 
"a=rand(2000);det(a);a=inv(a);"; done) > /dev/null 2>&1 &
done

[[ $QUIET ]] || echo "Starting yes processes..."
for i in {1..8}; do
   nice -n 20 yes > /dev/null 2>&1 &
done

[[ $QUIET ]] || echo "Starting dd in 5 seconds so that other processes 
can finish loading..."
sleep 5
for d in /dev/sd? /dev/hd?; do
   if [[ -b $d ]]; then
     [[ $QUIET ]] || echo Starting dd on $d now...
     (while [ -s $PROCLOOP ]; do test -e $d && nice -n 20 dd if=$d 
of=/dev/null; sleep 10; done) > /dev/null 2>&1 &
     (while [ -s $PROCLOOP ]; do test -e $d && nice -n 20 dd if=$d 
of=/dev/null skip=20000 bs=1000000; sleep 10; done) > /dev/null 2>&1 &
   fi
done



  Here is a cut and paste from top right before the server soft locks.

top - 13:42:25 up 6 min,  3 users,  load average: 28.52, 18.06, 7.90
Tasks: 371 total,  23 running, 348 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.3%us,  1.6%sy, 98.0%ni,  0.0%id,  0.0%wa,  0.0%hi,  0.1%si,  
0.0%st
Mem:  24734280k total, 24600312k used,   133968k free, 21564200k buffers
Swap:        0k total,        0k used,        0k free,    37292k cached

   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
  3440 root      39  19  5484  728  604 R  100  0.0   4:39.56 yes
  3432 root      39  19  5484  732  604 R  100  0.0   5:01.25 yes
  3436 root      39  19  5484  732  604 R  100  0.0   4:53.26 yes
  3437 root      39  19  5484  732  604 R  100  0.0   3:47.83 yes
  3441 root      39  19  5484  732  604 R  100  0.0   4:34.36 yes
  3439 root      39  19  5484  728  604 R  100  0.0   4:46.99 yes
  6030 root      39  19  243m 137m  11m R   61  0.6   0:04.96 octave
  6032 root      39  19  211m 107m  11m R   30  0.4   0:00.90 octave
  5997 root      39  19  211m 107m  11m R   19  0.4   0:00.56 octave
  6031 root      39  19  211m 107m  11m R   16  0.4   0:00.79 octave
  6029 root      39  19  211m 107m  11m R   14  0.4   0:00.66 octave
  6012 root      39  19  216m 111m  11m R   13  0.5   0:01.33 octave
  3606 root      39  19 10736 1840  704 D    4  0.0   0:05.63 dd
  3608 root      39  19  9748  856  696 D    2  0.0   0:06.61 dd
  1310 root      20   0  254m  15m 3288 S    2  0.1   0:04.95 python
   159 root      20   0     0    0    0 S    1  0.0   0:00.29 kswapd0
    61 root     -50   0     0    0    0 S    1  0.0   0:02.70 sirq-block/4
    45 root     -50   0     0    0    0 S    0  0.0   0:00.28 sirq-timer/3
    84 root     -50   0     0    0    0 S    0  0.0   0:00.56 sirq-timer/6
    97 root     -50   0     0    0    0 S    0  0.0   0:00.36 sirq-timer/7
   373 root     -51   0     0    0    0 S    0  0.0   0:01.05 irq/61-ahci
  3434 root      39  19  5484  732  604 R    0  0.0   3:53.88 yes
  3438 root      39  19  5484  732  604 R    0  0.0   1:00.93 yes
  3513 root      20   0 77060 3480 2688 S    0  0.0   0:00.09 sshd
  6007 root      39  19  243m 137m  11m R    0  0.6   0:05.06 octave
     1 root      20   0 23792 1952 1268 S    0  0.0   0:01.19 init


>
> What policy and priority are you running your load at? Are you 
> providing enough cycles for the system threads to run?
>

   With the script above, the processes are actually nice 19.
