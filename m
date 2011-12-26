From: Mike Galbraith <efault@gmx.de>
Subject: Re: 3.0.14-rt31 + 64 cores = very bad jitter == highly
 synchronized tick?
Date: Mon, 26 Dec 2011 09:04:22 +0100
Message-ID: <1324886662.4855.29.camel@marge.simson.net>
References: <1324717569.5025.73.camel@marge.simson.net>
	 <1324798319.9168.22.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Ingo Molnar <mingo@elte.hu>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:57576 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753808Ab1LZIE2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 26 Dec 2011 03:04:28 -0500
In-Reply-To: <1324798319.9168.22.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 2011-12-25 at 08:31 +0100, Mike Galbraith wrote:

> Guess I need to fight fire with fire.  Make ticks jitter a little
> somehow, so they don't make itimer wakeup jitter a truckload when it
> collides with tick that is busy colliding with zillion other ticks.

Yup.  Perfect is the enemy of good.

non-virgin:
vogelweide:/abuild/mike/:[1]# sh -c 'echo $$ > /cpusets/rtcpus/tasks;./jitter -c 63 -f 960 -p 99 -t 10 -d 300'
CPU63 priority: 99 timer freq: 960 Hz (1041666 ns) tolerance: 10 usecs, stats interval: 300 secs

jitter:   8.87  min:      3.08 max:     11.95 mean:      4.92 stddev:    0.56
4 > 10 us hits  min:     11.01 max:     11.95 mean:     11.35 stddev:    0.37

jitter:   8.68  min:      3.09 max:     11.77 mean:      4.91 stddev:    0.56
2 > 10 us hits  min:     11.10 max:     11.77 mean:     11.44 stddev:    0.33

jitter:   7.90  min:      3.12 max:     11.02 mean:      4.91 stddev:    0.56
1 > 10 us hits  min:     11.02 max:     11.02 mean:     11.02 stddev:    0.00

virgin:
vogelweide:/abuild/mike/:[1]# sh -c 'echo $$ > /cpusets/rtcpus/tasks;./jitter -c 63 -f 960 -p 99 -t 10 -d 300'
CPU63 priority: 99 timer freq: 960 Hz (1041666 ns) tolerance: 10 usecs, stats interval: 300 secs

jitter:  68.30  min:      2.43 max:     70.72 mean:      6.22 stddev:    6.41
16668 > 10 us hits      min:     11.00 max:     70.72 mean:     28.57 stddev:   13.08

jitter:  71.76  min:      2.56 max:     74.32 mean:      6.29 stddev:    6.61
17257 > 10 us hits      min:     11.00 max:     74.32 mean:     28.95 stddev:   13.24

jitter:  70.51  min:      2.50 max:     73.01 mean:      6.17 stddev:    6.26
16368 > 10 us hits      min:     11.00 max:     73.01 mean:     28.29 stddev:   12.76

I'm still colliding a bit, and overhead is still too high, but poking
tick in the eye with a sharp stick made it crawl under it's rock, so
methinks the tail has been pinned on the right donkey.

	-Mike

64 core DL980 idling, nohz=1, cores 4-63 isolated

non-virgin:
top - 08:26:35 up  2:04,  2 users,  load average: 0.00, 0.01, 0.41
Tasks: 1051 total,   2 running, 1049 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.0%us,  0.0%sy,  0.0%ni,100.0%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
Mem:   7911876k total,  1004812k used,  6907064k free,    12836k buffers
Swap:  1959924k total,        0k used,  1959924k free,   802324k cached

   PID USER      PR  NI  VIRT  RES  SHR S   %CPU %MEM    TIME+   P COMMAND                                                                                             
 22210 root      20   0  9680 2032  928 R      1  0.0   0:00.50  0 top                                                                                                 
     4 root     -41   0     0    0    0 S      0  0.0   0:07.85  0 sirq-timer/0                                                                                        
    22 root     -41   0     0    0    0 S      0  0.0   0:13.24  1 sirq-timer/1                                                                                        
    37 root     -41   0     0    0    0 S      0  0.0   0:13.32  2 sirq-timer/2                                                                                        
    51 root     -41   0     0    0    0 S      0  0.0   0:12.29  3 sirq-timer/3                                                                                        
    65 root     -41   0     0    0    0 S      0  0.0   0:12.07  4 sirq-timer/4                                                                                        
    79 root     -41   0     0    0    0 S      0  0.0   0:12.20  5 sirq-timer/5                                                                                        
    93 root     -41   0     0    0    0 S      0  0.0   0:12.07  6 sirq-timer/6                                                                                        
   121 root     -41   0     0    0    0 S      0  0.0   0:12.32  8 sirq-timer/8                                                                                        
   163 root     -41   0     0    0    0 S      0  0.0   0:12.22 11 sirq-timer/11                                                                                       
   177 root     -41   0     0    0    0 S      0  0.0   0:12.22 12 sirq-timer/12                                                                                       
   191 root     -41   0     0    0    0 S      0  0.0   0:12.25 13 sirq-timer/13                                                                                       
   205 root     -41   0     0    0    0 S      0  0.0   0:12.21 14 sirq-timer/14                                                                                       
   219 root     -41   0     0    0    0 S      0  0.0   0:12.21 15 sirq-timer/15                                                                                       
   233 root     -41   0     0    0    0 S      0  0.0   0:13.54 16 sirq-timer/16

virgin:
top - 08:57:39 up 23 min,  1 user,  load average: 0.00, 0.02, 0.10
Tasks: 468 total,   2 running, 466 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.0%us,  0.0%sy,  0.0%ni,100.0%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
Mem:   7914276k total,   471268k used,  7443008k free,    84040k buffers
Swap:  1959924k total,        0k used,  1959924k free,   243072k cached

   PID USER      PR  NI  VIRT  RES  SHR S   %CPU %MEM    TIME+   P COMMAND      
   179 root      RT   0     0    0    0 S      3  0.0   0:45.89 32 ksoftirqd/32 
   231 root      RT   0     0    0    0 S      3  0.0   0:46.48 40 ksoftirqd/40 
   241 root      RT   0     0    0    0 S      3  0.0   0:46.53 42 ksoftirqd/42 
   246 root      RT   0     0    0    0 S      3  0.0   0:46.27 43 ksoftirqd/43 
   184 root      RT   0     0    0    0 S      3  0.0   0:44.16 33 ksoftirqd/33 
   206 root      RT   0     0    0    0 S      3  0.0   0:44.48 35 ksoftirqd/35 
   211 root      RT   0     0    0    0 R      3  0.0   0:45.19 36 ksoftirqd/36 
   216 root      RT   0     0    0    0 S      3  0.0   0:44.83 37 ksoftirqd/37 
   221 root      RT   0     0    0    0 S      3  0.0   0:43.73 38 ksoftirqd/38 
   226 root      RT   0     0    0    0 S      3  0.0   0:44.73 39 ksoftirqd/39 
   236 root      RT   0     0    0    0 S      3  0.0   0:45.86 41 ksoftirqd/41 
   251 root      RT   0     0    0    0 S      3  0.0   0:43.64 44 ksoftirqd/44 
   323 root      RT   0     0    0    0 S      3  0.0   0:40.69 56 ksoftirqd/56 
   345 root      RT   0     0    0    0 S      3  0.0   0:40.83 58 ksoftirqd/58 
   201 root      RT   0     0    0    0 S      3  0.0   0:44.86 34 ksoftirqd/34 
   256 root      RT   0     0    0    0 S      3  0.0   0:41.62 45 ksoftirqd/45 
   273 root      RT   0     0    0    0 S      3  0.0   0:41.09 46 ksoftirqd/46

