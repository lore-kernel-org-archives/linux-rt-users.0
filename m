From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [ANNOUNCE] 4.1.3-rt3 - xmit queue timeout, oops, rcu stalls
Date: Thu, 6 Aug 2015 10:50:22 -0700
Message-ID: <55C39E5E.3060500@ccrma.stanford.edu>
References: <20150725103230.GA9470@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090209080509080909070205"
Cc: nando@ccrma.Stanford.EDU, LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150725103230.GA9470@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This is a multi-part message in MIME format.
--------------090209080509080909070205
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/25/2015 03:32 AM, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
>
> I'm pleased to announce the v4.1.3-rt3 patch set.
...

I've had a few hangs with nothing left behind to debug... but today I 
find this:

(NOTE: I'm attaching a file with the details, I don't know if my mailer 
will mangled these lines)

----
Aug  5 10:46:18 localhost kernel: [ 2343.673560] WARNING: CPU: 3 PID: 43 
at net/sched/sch_generic.c:303 dev_watchdog+0x26f/0x280()
Aug  5 10:46:18 localhost kernel: [ 2343.673561] NETDEV WATCHDOG: eth1 
(e1000e): transmit queue 0 timed out
----

and then:

----
Aug  5 10:46:18 localhost kernel: [ 2343.673679] e1000e 0000:04:00.0 
eth1: Reset adapter unexpectedly
Aug  5 10:46:30 localhost kernel: [ 2355.706987] ata5.00: exception 
Emask 0x40 SAct 0x0 SErr 0x80800 action 0x6 frozen
Aug  5 10:46:30 localhost kernel: [ 2355.706990] ata5: SError: { HostInt 
10B8B }
Aug  5 10:46:30 localhost kernel: [ 2355.707003] ata5.00: cmd 
a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Aug  5 10:46:30 localhost kernel: [ 2355.707003]          Get event 
status notification 4a 01 00 00 10 00 00 00 08 00res 
40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x44 (timeout)
Aug  5 10:46:30 localhost kernel: [ 2355.707005] ata5.00: status: { DRDY }
Aug  5 10:46:30 localhost kernel: [ 2355.707007] ata5: hard resetting link
----

same one but later in the log:

----
Aug  5 10:46:18 localhost kernel: WARNING: CPU: 3 PID: 43 at 
net/sched/sch_generic.c:303 dev_watchdog+0x26f/0x280()
Aug  5 10:46:18 localhost kernel: NETDEV WATCHDOG: eth1 (e1000e): 
transmit queue 0 timed out
----

Things apparently keep working and then:

----
Aug  5 11:58:36 localhost kernel: [ 6678.122596] Network Receive[2409]: 
segfault at 28 ip 0000003c4c293ca9 sp 00007fb6f64dbb58 error 6 in 
libc-2.18.so[3c4c200000+1b4000]
Aug  5 11:58:36 localhost kernel: Network Receive[2409]: segfault at 28 
ip 0000003c4c293ca9 sp 00007fb6f64dbb58 error 6 in 
libc-2.18.so[3c4c200000+1b4000]
Aug  5 11:58:36 localhost kernel: timekeeping watchdog: Marking 
clocksource 'tsc' as unstable, because the skew is too large:
Aug  5 11:58:36 localhost kernel: 	'hpet' wd_now: 47ebf654 wd_last: 
c0debfe6 mask: ffffffff
Aug  5 11:58:36 localhost kernel: 	'tsc' cs_now: 154f6e564f7d cs_last: 
7784d315c59 mask: ffffffffffffffff
Aug  5 11:58:36 localhost systemd: Starting dnf makecache...
Aug  5 11:58:36 localhost kernel: [ 6678.123233] timekeeping watchdog: 
Marking clocksource 'tsc' as unstable, because the skew is too large:
Aug  5 11:58:36 localhost kernel: [ 6678.123237] 	'hpet' wd_now: 
47ebf654 wd_last: c0debfe6 mask: ffffffff
Aug  5 11:58:36 localhost kernel: [ 6678.123238] 	'tsc' cs_now: 
154f6e564f7d cs_last: 7784d315c59 mask: ffffffffffffffff
Aug  5 11:58:36 localhost kernel: [ 6678.146207] Switched to clocksource 
hpet
Aug  5 11:58:36 localhost kernel: Switched to clocksource hpet
Aug  5 11:58:36 localhost kernel: [ 6678.150087] BUG: unable to handle 
kernel NULL pointer dereference at 0000000000000ea0
Aug  5 11:58:36 localhost kernel: [ 6678.150097] IP: 
[<ffffffffa05d922e>] nfs40_discover_server_trunking+0x5e/0x110 [nfsv4]
Aug  5 11:58:36 localhost kernel: [ 6678.150098] PGD 7f3c83067 PUD 
7f46fb067 PMD 0
Aug  5 11:58:36 localhost kernel: [ 6678.150099] Oops: 0000 [#1] PREEMPT 
SMP
----

And eventually (later) get a ton of these:

----
Aug  5 11:59:36 localhost kernel: [ 6738.107181] INFO: rcu_preempt 
detected stalls on CPUs/tasks: {} (detected by 3, t=60002 jiffies, 
g=37092, c=37091, q=0)
Aug  5 11:59:36 localhost kernel: [ 6738.107183] All QSes seen, last 
rcu_preempt kthread activity 1 (4301410925-4301410924), 
jiffies_till_next_fqs=3, root ->qsmask 0x0
----

So something is left in a not good state...

-- Fernando

--------------090209080509080909070205
Content-Type: application/x-gzip;
 name="messages.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="messages.gz"

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
iND9FnjpmhmJM+ltw7/v/gOfO8B6KT4BAA==
--------------090209080509080909070205--
