From: John Kacur <jkacur@gmail.com>
Subject: Re: 2.6.31-rc6-rt3 oops
Date: Tue, 18 Aug 2009 11:18:36 +0200
Message-ID: <520f0cf10908180218p9daa4benba7363c8dc32400b@mail.gmail.com>
References: <520f0cf10908171651i4ed50800n76a2c11a2cce2914@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755233AbZHRJSi@vger.kernel.org>
In-Reply-To: <520f0cf10908171651i4ed50800n76a2c11a2cce2914@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Aug 18, 2009 at 1:51 AM, John Kacur<jkacur@gmail.com> wrote:
> INFO: task irq/19-ehci_hcd:611 blocked for more than 120 seconds.
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this mess=
age.
> irq/19-ehci_h D ffff88002bfd1880 =A06832 =A0 611 =A0 =A0 =A02 0x00000=
000
> BUG: using smp_processor_id() in preemptible [00000000] code: khungta=
skd/343
> caller is show_stack_log_lvl+0x37/0x12e
> Pid: 343, comm: khungtaskd Not tainted 2.6.31-rc6-rt3 #1
> Call Trace:
> =A0[<ffffffff811fe1b6>] debug_smp_processor_id+0xda/0x108
> =A0[<ffffffff8100efbd>] show_stack_log_lvl+0x37/0x12e
> =A0[<ffffffff813df08c>] ? printk+0x4b/0x67
> =A0[<ffffffff810101ae>] show_stack+0x2a/0x40
> =A0[<ffffffff810496eb>] sched_show_task+0xd3/0xef
> =A0[<ffffffff810b6c66>] watchdog+0x1a7/0x21b
> =A0[<ffffffff81041c49>] ? need_resched+0x31/0x4f
> =A0[<ffffffff810b6abf>] ? watchdog+0x0/0x21b
> =A0[<ffffffff810728ee>] kthread+0xad/0xb5
> =A0[<ffffffff8104a1b3>] ? finish_task_switch+0xab/0x15e
> =A0[<ffffffff8100d15a>] child_rip+0xa/0x20
> =A0[<ffffffff8100cac0>] ? restore_args+0x0/0x30
> =A0[<ffffffff81072841>] ? kthread+0x0/0xb5
> =A0[<ffffffff8100d150>] ? child_rip+0x0/0x20
> =A0ffff880138999df0 0000000000000082 0000000030fa3107 0000000030fa310=
7
> =A0ffff880138999d80 ffffffff813e28d8 ffff880138f517c0 ffff880138db820=
0
> =A0ffff880138f51b58 0000000000000246 ffff880138999db0 ffffffff813e10c=
3
> Call Trace:
> =A0[<ffffffff813e28d8>] ? _atomic_spin_unlock_irqrestore+0x5f/0x91
> =A0[<ffffffff813e10c3>] ? rt_spin_lock_slowunlock+0x58/0x9c
> =A0[<ffffffff813e1ed6>] ? rt_spin_unlock+0x57/0x72
> =A0[<ffffffff810b7ade>] ? irq_thread+0x0/0x1d5
> =A0[<ffffffff813e01dc>] schedule+0x22/0x47
> =A0[<ffffffff810728da>] kthread+0x99/0xb5
> =A0[<ffffffff8104a1b3>] ? finish_task_switch+0xab/0x15e
> =A0[<ffffffff8100d15a>] child_rip+0xa/0x20
> =A0[<ffffffff8100cac0>] ? restore_args+0x0/0x30
> =A0[<ffffffff813e1149>] ? rt_spin_lock_slowlock+0x42/0x29e
> =A0[<ffffffff81072841>] ? kthread+0x0/0xb5
> =A0[<ffffffff8100d150>] ? child_rip+0x0/0x20
> INFO: lockdep is turned off.
> Kernel panic - not syncing: hung_task: blocked tasks
>

Here are two more oops - not substantially different, but then I
attempted to decode the addresses between the Call Traces

INFO: task irq/19-ehci_hcd:611 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messag=
e.
irq/19-ehci_h D ffff88002bfd1880  6832   611      2 0x00000000
BUG: using smp_processor_id() in preemptible [00000000] code: khungtask=
d/343
caller is show_stack_log_lvl+0x37/0x12e
Pid: 343, comm: khungtaskd Not tainted 2.6.31-rc6-rt3 #1
Call Trace:
 [<ffffffff811fe1b6>] debug_smp_processor_id+0xda/0x108
 [<ffffffff8100efbd>] show_stack_log_lvl+0x37/0x12e
 [<ffffffff813df08c>] ? printk+0x4b/0x67
 [<ffffffff810101ae>] show_stack+0x2a/0x40
 [<ffffffff810496eb>] sched_show_task+0xd3/0xef
 [<ffffffff810b6c66>] watchdog+0x1a7/0x21b
 [<ffffffff81041c49>] ? need_resched+0x31/0x4f
 [<ffffffff810b6abf>] ? watchdog+0x0/0x21b
 [<ffffffff810728ee>] kthread+0xad/0xb5
 [<ffffffff8104a1b3>] ? finish_task_switch+0xab/0x15e
 [<ffffffff8100d15a>] child_rip+0xa/0x20
 [<ffffffff8100cac0>] ? restore_args+0x0/0x30
 [<ffffffff81072841>] ? kthread+0x0/0xb5
 [<ffffffff8100d150>] ? child_rip+0x0/0x20
 ffff880138963df0 0000000000000082 00000000b8d49caa 00000000b8d49caa
 ffff880138963d80 ffffffff813e28d8 ffff880138ee5340 ffff880138c94040
 ffff880138ee56d8 0000000000000246 ffff880138963db0 ffffffff813e10c3
Call Trace:
 [<ffffffff813e28d8>] ? _atomic_spin_unlock_irqrestore+0x5f/0x91
 [<ffffffff813e10c3>] ? rt_spin_lock_slowunlock+0x58/0x9c
 [<ffffffff813e1ed6>] ? rt_spin_unlock+0x57/0x72
 [<ffffffff810b7ade>] ? irq_thread+0x0/0x1d5
 [<ffffffff813e01dc>] schedule+0x22/0x47
 [<ffffffff810728da>] kthread+0x99/0xb5
 [<ffffffff8104a1b3>] ? finish_task_switch+0xab/0x15e
 [<ffffffff8100d15a>] child_rip+0xa/0x20
 [<ffffffff8100cac0>] ? restore_args+0x0/0x30
 [<ffffffff813e1149>] ? rt_spin_lock_slowlock+0x42/0x29e
 [<ffffffff81072841>] ? kthread+0x0/0xb5
 [<ffffffff8100d150>] ? child_rip+0x0/0x20
INFO: lockdep is turned off.
Kernel panic - not syncing: hung_task: blocked tasks

-----------------------------------------------------------------------=
--------
INFO: task irq/19-ehci_hcd:611 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messag=
e.
irq/19-ehci_h D ffff88002bfd1880  6672   611      2 0x00000000
BUG: using smp_processor_id() in preemptible [00000000] code: khungtask=
d/343
caller is show_stack_log_lvl+0x37/0x12e
Pid: 343, comm: khungtaskd Not tainted 2.6.31-rc6-rt3 #1
Call Trace:
 [<ffffffff811fe1b6>] debug_smp_processor_id+0xda/0x108
 [<ffffffff8100efbd>] show_stack_log_lvl+0x37/0x12e
 [<ffffffff813df08c>] ? printk+0x4b/0x67
 [<ffffffff810101ae>] show_stack+0x2a/0x40
 [<ffffffff810496eb>] sched_show_task+0xd3/0xef
 [<ffffffff810b6c66>] watchdog+0x1a7/0x21b
 [<ffffffff81041c49>] ? need_resched+0x31/0x4f
 [<ffffffff810b6abf>] ? watchdog+0x0/0x21b
 [<ffffffff810728ee>] kthread+0xad/0xb5
 [<ffffffff8104a1b3>] ? finish_task_switch+0xab/0x15e
 [<ffffffff8100d15a>] child_rip+0xa/0x20
 [<ffffffff8100cac0>] ? restore_args+0x0/0x30
 [<ffffffff81072841>] ? kthread+0x0/0xb5
 [<ffffffff8100d150>] ? child_rip+0x0/0x20
 ffff8801389a5df0 0000000000000082 ffff8801389a5d80 ffffffff8108f769
 ffff8801389a5d80 ffffffff813e28ef ffff8801389a0b40 ffff880138f49780
 ffff8801389a0ed8 0000000038cd1a40 ffff8801389a5db0 ffffffff813e10eb
Call Trace:
 [<ffffffff8108f769>] ? rt_mutex_adjust_prio+0x44/0x63
 [<ffffffff813e28ef>] ? _atomic_spin_unlock_irqrestore+0x76/0x91
 [<ffffffff813e10eb>] ? rt_spin_lock_slowunlock+0x80/0x9c
 [<ffffffff813e1ed6>] ? rt_spin_unlock+0x57/0x72
 [<ffffffff810b7ade>] ? irq_thread+0x0/0x1d5
 [<ffffffff813e01dc>] schedule+0x22/0x47
 [<ffffffff810728da>] kthread+0x99/0xb5
 [<ffffffff8104a1b3>] ? finish_task_switch+0xab/0x15e
 [<ffffffff8100d15a>] child_rip+0xa/0x20
 [<ffffffff8100cac0>] ? restore_args+0x0/0x30
 [<ffffffff81072841>] ? kthread+0x0/0xb5
 [<ffffffff8100d150>] ? child_rip+0x0/0x20
INFO: lockdep is turned off.
Kernel panic - not syncing: hung_task: blocked tasks


for a in "ffff880138963df0 0000000000000082 00000000b8d49caa 00000000b8=
d49caa
>  ffff880138963d80 ffffffff813e28d8 ffff880138ee5340 ffff880138c94040
>  ffff880138ee56d8 0000000000000246 ffff880138963db0 ffffffff813e10c3
> "; do
> addr2line -e /bld/2.6.31-rc6-rt3/vmlinux $a
> done
??:0
??:0
??:0
??:0
??:0
/home/jkacur/rt.linux.git/arch/x86/include/asm/thread_info.h:216
??:0
??:0
??:0
??:0
??:0
/home/jkacur/rt.linux.git/kernel/rtmutex.c:904


[jkacur@tycho oops]$ for a in "ffff8801389a5df0 0000000000000082
ffff8801389a5d80 ffffffff8108f769
>  ffff8801389a5d80 ffffffff813e28ef ffff8801389a0b40 ffff880138f49780
>  ffff8801389a0ed8 0000000038cd1a40 ffff8801389a5db0 ffffffff813e10eb
> Call Trace:
> "; do
> addr2line -e /bld/2.6.31-rc6-rt3/vmlinux $a
> done
??:0
??:0
??:0
/home/jkacur/rt.linux.git/kernel/rtmutex.c:168
??:0
/home/jkacur/rt.linux.git/kernel/spinlock.c:157
??:0
??:0
??:0
??:0
??:0
/home/jkacur/rt.linux.git/kernel/rtmutex.c:913
??:0
??:0
