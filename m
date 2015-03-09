From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: RCU stalls on heavy socket traffic
Date: Mon, 9 Mar 2015 16:26:51 +0100
Message-ID: <20150309152651.GD13768@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

So I run "hackbench -g 600 -l 350 -s 250" which takes approx 77 seconds
to complete. Then this popped up:

|INFO: rcu_preempt detected stalls on CPUs/tasks:
| Tasks blocked on level-0 rcu_node (CPUs 0-3): P24858 P28514 P25185 P25184 P28713 P19549 P3139 P25275 P28474 P29062 P6703 P10 106 P14309 P27910 P4514 P14834 P28385 P21073 P27701 P642 P10340 P16939 P19147 P16949 P16945 P16952 P16941 P16937 P16938 P16946 P16954 P28664  P18701 P17782 P4875 P8873
| Tasks blocked on level-0 rcu_node (CPUs 0-3): P24858 P28514 P25185 P25184 P28713 P19549 P3139 P25275 P28474 P29062 P6703 P10 106 P14309 P27910 P4514 P14834 P28385 P21073 P27701 P642 P10340 P16939 P19147 P16949 P16945 P16952 P16941 P16937 P16938 P16946 P16954 P28664  P18701 P17782 P4875 P8873
| (detected by 0, t=5252 jiffies, g=2385, c=2384, q=41180)
|hackbench       R  running task        0 24858   1995 0x00000000
| ffff880058d9bb18 0000000000000082 0000000000012e40 ffff880058d9bfd8
| 0000000000012e40 ffff8804226627c0 ffff880058d9bb38 ffff880058d9bfd8
| 0000000000000001 ffff880058d5ccf8 0000000000000292 0000000000000002
|Call Trace:
| [<ffffffff81568e9f>] preempt_schedule+0x3f/0x60
| [<ffffffff812d84d7>] ___preempt_schedule+0x35/0x67
| [<ffffffff8156b725>] ? _raw_spin_unlock_irqrestore+0x25/0x30
| [<ffffffff81088503>] try_to_wake_up+0x63/0x2f0
| [<ffffffff8108881d>] default_wake_function+0xd/0x10
| [<ffffffff8109b011>] autoremove_wake_function+0x11/0x40
| [<ffffffff8109aa05>] __wake_up_common+0x55/0x90
| [<ffffffff8109afd3>] __wake_up_sync_key+0x43/0x60
| [<ffffffff8145c95e>] sock_def_readable+0x3e/0x70
| [<ffffffff8150f9d1>] unix_stream_sendmsg+0x211/0x470
| [<ffffffff81458b48>] sock_aio_write+0xf8/0x120
| [<ffffffff8109ec19>] ? rt_up_read+0x19/0x20
| [<ffffffff8116e855>] do_sync_write+0x55/0x90
| [<ffffffff8116f435>] vfs_write+0x175/0x1f0
| [<ffffffff8116fde4>] SyS_write+0x44/0xb0
| [<ffffffff8156c1ed>] system_call_fastpath+0x16/0x1b

The other processes look more or less the same. I have the full splat
here [0]. My understanding is that sock_def_readable() does a
rcu_read_lock() which forbids a grace period. Since there are many
processes (preempted) in this section, the grace period never starts
since it never blocks new readers from getting into a read critical
section.
Is my understanding correct so far? Is it likely that -RT does not do
something correctly to forbid such a situation or is it more or less
"expected" ?

[0] https://breakpoint.cc/rt-rcu-stall.txt

Sebastian
