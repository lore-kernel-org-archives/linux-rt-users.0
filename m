From: John Dulaney <j_dulaney@live.com>
Subject: RE: [ANNOUNCE] 4.1.3-rt3 - xmit queue timeout, oops, rcu stalls
Date: Thu, 6 Aug 2015 18:19:37 -0400
Message-ID: <BLU180-W1458FC965E73F67EC8437DF8740@phx.gbl>
References: <20150725103230.GA9470@linutronix.de>,<55C39E5E.3060500@ccrma.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	John Kacur <jkacur@redhat.com>
To: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55C39E5E.3060500@ccrma.stanford.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

----------------------------------------
> Subject: Re: [ANNOUNCE] 4.1.3-rt3 - xmit queue timeout, oops, rcu sta=
lls
> To: bigeasy@linutronix.de; linux-rt-users@vger.kernel.org
> CC: nando@ccrma.Stanford.EDU; linux-kernel@vger.kernel.org; tglx@linu=
tronix.de; rostedt@goodmis.org; jkacur@redhat.com
> From: nando@ccrma.Stanford.EDU
> Date: Thu, 6 Aug 2015 10:50:22 -0700
>
> On 07/25/2015 03:32 AM, Sebastian Andrzej Siewior wrote:
>> Dear RT folks!
>>
>> I'm pleased to announce the v4.1.3-rt3 patch set.
> ...
>
> I've had a few hangs with nothing left behind to debug... but today I
> find this:
>
> (NOTE: I'm attaching a file with the details, I don't know if my mail=
er
> will mangled these lines)
>
> ----
> Aug 5 10:46:18 localhost kernel: [ 2343.673560] WARNING: CPU: 3 PID: =
43
> at net/sched/sch_generic.c:303 dev_watchdog+0x26f/0x280()
> Aug 5 10:46:18 localhost kernel: [ 2343.673561] NETDEV WATCHDOG: eth1
> (e1000e): transmit queue 0 timed out
> ----
>
> and then:
>
> ----
> Aug 5 10:46:18 localhost kernel: [ 2343.673679] e1000e 0000:04:00.0
> eth1: Reset adapter unexpectedly
> Aug 5 10:46:30 localhost kernel: [ 2355.706987] ata5.00: exception
> Emask 0x40 SAct 0x0 SErr 0x80800 action 0x6 frozen
> Aug 5 10:46:30 localhost kernel: [ 2355.706990] ata5: SError: { HostI=
nt
> 10B8B }
> Aug 5 10:46:30 localhost kernel: [ 2355.707003] ata5.00: cmd
> a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
> Aug 5 10:46:30 localhost kernel: [ 2355.707003] Get event
> status notification 4a 01 00 00 10 00 00 00 08 00res
> 40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x44 (timeout)
> Aug 5 10:46:30 localhost kernel: [ 2355.707005] ata5.00: status: { DR=
DY }
> Aug 5 10:46:30 localhost kernel: [ 2355.707007] ata5: hard resetting =
link
> ----
>
> same one but later in the log:
>
> ----
> Aug 5 10:46:18 localhost kernel: WARNING: CPU: 3 PID: 43 at
> net/sched/sch_generic.c:303 dev_watchdog+0x26f/0x280()
> Aug 5 10:46:18 localhost kernel: NETDEV WATCHDOG: eth1 (e1000e):
> transmit queue 0 timed out
> ----
>
> Things apparently keep working and then:
>
> ----
> Aug 5 11:58:36 localhost kernel: [ 6678.122596] Network Receive[2409]=
:
> segfault at 28 ip 0000003c4c293ca9 sp 00007fb6f64dbb58 error 6 in
> libc-2.18.so[3c4c200000+1b4000]
> Aug 5 11:58:36 localhost kernel: Network Receive[2409]: segfault at 2=
8
> ip 0000003c4c293ca9 sp 00007fb6f64dbb58 error 6 in
> libc-2.18.so[3c4c200000+1b4000]
> Aug 5 11:58:36 localhost kernel: timekeeping watchdog: Marking
> clocksource 'tsc' as unstable, because the skew is too large:
> Aug 5 11:58:36 localhost kernel: 'hpet' wd_now: 47ebf654 wd_last:
> c0debfe6 mask: ffffffff
> Aug 5 11:58:36 localhost kernel: 'tsc' cs_now: 154f6e564f7d cs_last:
> 7784d315c59 mask: ffffffffffffffff
> Aug 5 11:58:36 localhost systemd: Starting dnf makecache...
> Aug 5 11:58:36 localhost kernel: [ 6678.123233] timekeeping watchdog:
> Marking clocksource 'tsc' as unstable, because the skew is too large:
> Aug 5 11:58:36 localhost kernel: [ 6678.123237] 'hpet' wd_now:
> 47ebf654 wd_last: c0debfe6 mask: ffffffff
> Aug 5 11:58:36 localhost kernel: [ 6678.123238] 'tsc' cs_now:
> 154f6e564f7d cs_last: 7784d315c59 mask: ffffffffffffffff
> Aug 5 11:58:36 localhost kernel: [ 6678.146207] Switched to clocksour=
ce
> hpet
> Aug 5 11:58:36 localhost kernel: Switched to clocksource hpet
> Aug 5 11:58:36 localhost kernel: [ 6678.150087] BUG: unable to handle
> kernel NULL pointer dereference at 0000000000000ea0
> Aug 5 11:58:36 localhost kernel: [ 6678.150097] IP:
> [<ffffffffa05d922e>] nfs40_discover_server_trunking+0x5e/0x110 [nfsv4=
]
> Aug 5 11:58:36 localhost kernel: [ 6678.150098] PGD 7f3c83067 PUD
> 7f46fb067 PMD 0
> Aug 5 11:58:36 localhost kernel: [ 6678.150099] Oops: 0000 [#1] PREEM=
PT
> SMP
> ----
>
> And eventually (later) get a ton of these:
>
> ----
> Aug 5 11:59:36 localhost kernel: [ 6738.107181] INFO: rcu_preempt
> detected stalls on CPUs/tasks: {} (detected by 3, t=3D60002 jiffies,
> g=3D37092, c=3D37091, q=3D0)
> Aug 5 11:59:36 localhost kernel: [ 6738.107183] All QSes seen, last
> rcu_preempt kthread activity 1 (4301410925-4301410924),
> jiffies_till_next_fqs=3D3, root ->qsmask 0x0
> ----
>
> So something is left in a not good state...
>
> -- Fernando

Do you still have your box setup to capture a vmcore?=A0 Also, is this =
my latest
build?=A0 I've been having issues with LUKs.

If you do still have your system setup to capture a vmcore, maybe set:

kernel.panic_on_oops =3D 1
In your /etc/sysctl.conf and then reboot to this kernel.

John.
 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
