From: Christoph Mathys <eraserix@gmail.com>
Subject: Re: Hung task for proc_cgroup_show
Date: Mon, 21 Dec 2015 10:49:41 +0100
Message-ID: <CALqGcGpRQ5nO00qfHEBksuKV5ND3zMCwDK2zprXAPfVg3Lc59Q@mail.gmail.com>
References: <CALqGcGoMqJuvzQpGb84LzyxQCJADB73YEreND0HgOFK5DOQ6ig@mail.gmail.com>
	<20150714150016.GC21820@linutronix.de>
	<CALqGcGqzWsNacBHRUgFOrtJB6MSoqR+kDJteA8mgi9E4_o8vxw@mail.gmail.com>
	<20151211161450.GA6720@linutronix.de>
	<CALqGcGob5_qWeK1ndErqN9Z3DkGTPciTojjkEOkvauZyNd59Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:36301 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbbLUJtm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Dec 2015 04:49:42 -0500
Received: by mail-lf0-f49.google.com with SMTP id z124so102678460lfa.3
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Dec 2015 01:49:42 -0800 (PST)
In-Reply-To: <CALqGcGob5_qWeK1ndErqN9Z3DkGTPciTojjkEOkvauZyNd59Bg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

When testing on another computer I got a BUG from the same general area:

[   57.430698] BUG: sleeping function called from invalid context at
kernel/locking/rtmutex.c:917
[   57.430699] in_atomic(): 1, irqs_disabled(): 0, pid: 3329, name: init
[   57.430700] 2 locks held by init/3329:
[   57.430709]  #0:  (&mm->mmap_sem){++++++}, at: [<ffffffff8103f17e>]
__do_page_fault+0x12e/0x5f0
[   57.430715]  #1:  (ptlock_ptr(page)#2){+.+...}, at:
[<ffffffff8117235f>] do_read_fault.isra.66+0xaf/0x2d0
[   57.430718] CPU: 1 PID: 3329 Comm: init Tainted: G            E
3.18.24-realtime-1-rt22 #1
[   57.430719] Hardware name: Komax AG, Dierikon Komax-PC/DH61DL, BIOS
BEH6110H.86A.0042.2012.0327.2202 03/27/2012
[   57.430721]  0000000000000003 ffff8800d03c3888 ffffffff8174ad8a
0000000000000005
[   57.430723]  ffff8800d010a630 ffff8800d03c38a8 ffffffff810771a7
ffff8800d010a630
[   57.430724]  ffffffff81c5f220 ffff8800d03c38d8 ffffffff81751b44
ffff8800d03c38d8
[   57.430725] Call Trace:
[   57.430729]  [<ffffffff8174ad8a>] dump_stack+0x4e/0x84
[   57.430733]  [<ffffffff810771a7>] __might_sleep+0xe7/0x120
[   57.430735]  [<ffffffff81751b44>] rt_spin_lock+0x24/0x60
[   57.430737]  [<ffffffff8109e44d>] ? trace_hardirqs_on_caller+0xfd/0x1c0
[   57.430740]  [<ffffffff81093349>] __wake_up+0x29/0x60
[   57.430742]  [<ffffffff810bcd04>] rcu_report_exp_rnp.isra.64+0xb4/0xc0
[   57.430744]  [<ffffffff810c0a9b>] rcu_read_unlock_special+0x1fb/0x250
[   57.430747]  [<ffffffff8174e4ba>] ? preempt_schedule_irq+0x4a/0x80
[   57.430748]  [<ffffffff810c0cd4>] rcu_note_context_switch+0x1e4/0x420
[   57.430750]  [<ffffffff8174d7c6>] __schedule+0x56/0x8a0
[   57.430752]  [<ffffffff8174e4ae>] ? preempt_schedule_irq+0x3e/0x80
[   57.430754]  [<ffffffff8174e4b4>] preempt_schedule_irq+0x44/0x80
[   57.430757]  [<ffffffff811ac815>] ? mem_cgroup_begin_page_stat+0x5/0x110
[   57.430758]  [<ffffffff81753883>] check_int_off+0x11/0x1e
[   57.430760]  [<ffffffff810c08a5>] ? rcu_read_unlock_special+0x5/0x250
[   57.430762]  [<ffffffff810bada5>] ? __rcu_read_unlock+0x95/0xa0
[   57.430764]  [<ffffffff81143848>] filemap_map_pages+0x188/0x270
[   57.430765]  [<ffffffff811436c5>] ? filemap_map_pages+0x5/0x270
[   57.430768]  [<ffffffff8117246a>] do_read_fault.isra.66+0x1ba/0x2d0
[   57.430770]  [<ffffffff81173abf>] handle_mm_fault+0x5ef/0xec0
[   57.430772]  [<ffffffff8103f17e>] ? __do_page_fault+0x12e/0x5f0
[   57.430774]  [<ffffffff8103f1e2>] __do_page_fault+0x192/0x5f0
[   57.430777]  [<ffffffff8139edeb>] ? trace_hardirqs_off_thunk+0x3a/0x3f
[   57.430779]  [<ffffffff8103f64c>] do_page_fault+0xc/0x10
[   57.430781]  [<ffffffff81754752>] page_fault+0x22/0x30
[   57.430783]  [<ffffffff813bd9dc>] ? strncpy_from_user+0x6c/0x120
[   57.430786]  [<ffffffff811c7a75>] getname_flags+0xb5/0x1a0
[   57.430788]  [<ffffffff811c7b72>] getname+0x12/0x20
[   57.430790]  [<ffffffff811b594d>] do_sys_open+0xfd/0x220
[   57.430792]  [<ffffffff8109e44d>] ? trace_hardirqs_on_caller+0xfd/0x1c0
[   57.430793]  [<ffffffff811b5a8e>] SyS_open+0x1e/0x20
[   57.430795]  [<ffffffff81752976>] system_call_fastpath+0x16/0x1b
