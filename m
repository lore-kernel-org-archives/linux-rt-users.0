From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: RCU stalls on heavy socket traffic
Date: Mon, 9 Mar 2015 17:39:15 +0100
Message-ID: <20150309163915.GF13768@linutronix.de>
References: <20150309152651.GD13768@linutronix.de>
 <20150309155947.GW5236@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150309155947.GW5236@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Paul E. McKenney | 2015-03-09 08:59:47 [-0700]:

>On Mon, Mar 09, 2015 at 04:26:51PM +0100, Sebastian Andrzej Siewior wr=
ote:
>> So I run "hackbench -g 600 -l 350 -s 250" which takes approx 77 seco=
nds
>> to complete. Then this popped up:
>>=20
>> |INFO: rcu_preempt detected stalls on CPUs/tasks:
>> | Tasks blocked on level-0 rcu_node (CPUs 0-3): P24858 P28514 P25185=
 P25184 P28713 P19549 P3139 P25275 P28474 P29062 P6703 P10 106 P14309 P=
27910 P4514 P14834 P28385 P21073 P27701 P642 P10340 P16939 P19147 P1694=
9 P16945 P16952 P16941 P16937 P16938 P16946 P16954 P28664  P18701 P1778=
2 P4875 P8873
>> | Tasks blocked on level-0 rcu_node (CPUs 0-3): P24858 P28514 P25185=
 P25184 P28713 P19549 P3139 P25275 P28474 P29062 P6703 P10 106 P14309 P=
27910 P4514 P14834 P28385 P21073 P27701 P642 P10340 P16939 P19147 P1694=
9 P16945 P16952 P16941 P16937 P16938 P16946 P16954 P28664  P18701 P1778=
2 P4875 P8873
>
>Definitely lots of tasks recently preempted within RCU read-side
>critical sections!
>
>For example, the P24858 says that the task with PID 24858 was preempte=
d
>(or blocked) while within an RCU read-side critical section that block=
s
>the current grace period, and that this task has not yet exited that
>critical section.  This might be because that task has been preempted
>throughout by a higher-priority task, that there is an infinite loop i=
n
>that critical section, or that the task is blocked on a spinlock that
>is being held indefinitely by some other task (possibly because that
>other task is being indefinitely preempted).

=46rom what it looks in the backtrace of each task is that it got
preempted within the RCU read section (once hackbach is done, everythin=
g
gets back to normal). Nothing loops indefinitely. Once hackbench is don=
e
with sending messages, everything gets back to normal. I'm just not sur=
e
if everything in terms of RCU works okay on -RT or of something is
missing. But as you suggested that it is rcurc/$CPU job to do this, I
will check if this process runs=E2=80=A6

>> | (detected by 0, t=3D5252 jiffies, g=3D2385, c=3D2384, q=3D41180)
>> |hackbench       R  running task        0 24858   1995 0x00000000
>> | ffff880058d9bb18 0000000000000082 0000000000012e40 ffff880058d9bfd=
8
>> | 0000000000012e40 ffff8804226627c0 ffff880058d9bb38 ffff880058d9bfd=
8
>> | 0000000000000001 ffff880058d5ccf8 0000000000000292 000000000000000=
2
>> |Call Trace:
>> | [<ffffffff81568e9f>] preempt_schedule+0x3f/0x60
>> | [<ffffffff812d84d7>] ___preempt_schedule+0x35/0x67
>> | [<ffffffff8156b725>] ? _raw_spin_unlock_irqrestore+0x25/0x30
>> | [<ffffffff81088503>] try_to_wake_up+0x63/0x2f0
>> | [<ffffffff8108881d>] default_wake_function+0xd/0x10
>> | [<ffffffff8109b011>] autoremove_wake_function+0x11/0x40
>> | [<ffffffff8109aa05>] __wake_up_common+0x55/0x90
>> | [<ffffffff8109afd3>] __wake_up_sync_key+0x43/0x60
>> | [<ffffffff8145c95e>] sock_def_readable+0x3e/0x70
>> | [<ffffffff8150f9d1>] unix_stream_sendmsg+0x211/0x470
>> | [<ffffffff81458b48>] sock_aio_write+0xf8/0x120
>> | [<ffffffff8109ec19>] ? rt_up_read+0x19/0x20
>> | [<ffffffff8116e855>] do_sync_write+0x55/0x90
>> | [<ffffffff8116f435>] vfs_write+0x175/0x1f0
>> | [<ffffffff8116fde4>] SyS_write+0x44/0xb0
>> | [<ffffffff8156c1ed>] system_call_fastpath+0x16/0x1b
>>=20
>> The other processes look more or less the same. I have the full spla=
t
>> here [0]. My understanding is that sock_def_readable() does a
>> rcu_read_lock() which forbids a grace period. Since there are many
>> processes (preempted) in this section, the grace period never starts
>> since it never blocks new readers from getting into a read critical
>> section.
>> Is my understanding correct so far? Is it likely that -RT does not d=
o
>> something correctly to forbid such a situation or is it more or less
>> "expected" ?
>>=20
>> [0] https://breakpoint.cc/rt-rcu-stall.txt
>
>If you don't have CONFIG_RCU_BOOST=3Dy with priority set above that of
>any CPU-bound components of your workload, then yes, this is expected
>behavior.  The priority boosting will be inherited, so that this cover=
s
>the case of indefinite preemption.  Of course, this won't help with
>infinite loops.

I have
 CONFIG_RCU_BOOST=3Dy
 CONFIG_RCU_BOOST_PRIO=3D6

and hackbach is a normal user process. How does this suppose to work? I
have five tasks preempted in RCU read section. Then rcuc gets scheduled
somehow. It boosts the five tasks one after the other until they get ou=
t
of the RCU section. And since nothing has a higher priority than rcuc
nothing can get on the CPU and into the RCU section again.
What happens if the task got preempted because it was waiting for
something? Say for a lock which was hold by another task on another CPU=
?
It would then boost the task on the other CPU while this CPU would
become "idle" and allow a task with a lower priority to get into RCU
read section again.
rcuc gets on the CPU again after the 5 tasks left the critical section
but a new make it into the section. Is it possible and if so what would
it do then?

>That said, someone was having trouble with the rcuoc kthreads that are
>generated by CONFIG_RCU_BOOST=3Dy when running NO_HZ_FULL.  So there m=
ight
>need to be different kernel configs for different workloads.  Or we mi=
ght
>need some way to enable and disable boosting at boot time, I suppose.

I think I saw this with CONFIG_NO_HZ_IDLE, too.

>							Thanx, Paul

Sebastian
