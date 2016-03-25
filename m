From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RT 4/6] rt/locking: Reenable migration accross schedule
Date: Fri, 25 Mar 2016 17:24:33 +0100
Message-ID: <1458923073.3849.26.camel@gmail.com>
References: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>
	 <1455318168-7125-4-git-send-email-bigeasy@linutronix.de>
	 <1458463425.3908.5.camel@gmail.com> <1458814024.23732.35.camel@gmail.com>
	 <alpine.DEB.2.11.1603241140510.3978@nanos>
	 <1458817594.3972.16.camel@gmail.com> <1458884330.3836.21.camel@gmail.com>
	 <alpine.DEB.2.11.1603250951100.3978@nanos>
	 <1458897196.3870.8.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458897196.3870.8.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2016-03-25 at 10:13 +0100, Mike Galbraith wrote:
> On Fri, 2016-03-25 at 09:52 +0100, Thomas Gleixner wrote:
> > On Fri, 25 Mar 2016, Mike Galbraith wrote:
> > > On Thu, 2016-03-24 at 12:06 +0100, Mike Galbraith wrote:
> > > > On Thu, 2016-03-24 at 11:44 +0100, Thomas Gleixner wrote:
> > > > >  
> > > > > > On the bright side, with the busted migrate enable business reverted,
> > > > > > plus one dinky change from me [1], master-rt.today has completed 100
> > > > > > iterations of Steven's hotplug stress script along side endless
> > > > > > futexstress, and is happily doing another 900 as I write this, so the
> > > > > > next -rt should finally be hotplug deadlock free.
> > > > > > 
> > > > > > Thomas's state machinery seems to work wonders.  'course this being
> > > > > > hotplug, the other shoe will likely apply itself to my backside soon.
> > > > > 
> > > > > That's a given :)
> > > > 
> > > > blk-mq applied it shortly after I was satisfied enough to poke xmit.
> > > 
> > > The other shoe is that notifiers can depend upon RCU grace periods, so
> > > when pin_current_cpu() snags rcu_sched, the hotplug game is over.
> > > 
> > > blk_mq_queue_reinit_notify:
> > >         /*
> > >          * We need to freeze and reinit all existing queues.  Freezing
> > >          * involves synchronous wait for an RCU grace period and doing it
> > >          * one by one may take a long time.  Start freezing all queues in
> > >          * one swoop and then wait for the completions so that freezing can
> > >          * take place in parallel.
> > >          */
> > >         list_for_each_entry(q, &all_q_list, all_q_node)
> > >                 blk_mq_freeze_queue_start(q);
> > >         list_for_each_entry(q, &all_q_list, all_q_node) {
> > >                 blk_mq_freeze_queue_wait(q);
> > 
> > Yeah, I stumbled over that already when analysing all the hotplug notifier
> > sites. That's definitely a horrible one.
> >  
> > > Hohum (sharpens rock), next.
> > 
> > /me recommends frozen sharks
> 
> With the sharp rock below and the one I'll follow up with, master-rt on
> my DL980 just passed 3 hours of endless hotplug stress concurrent with
> endless tbench 8, stockfish and futextest.  It has never survived this
> long with this load by a long shot.

I knew it was unlikely to surrender that quickly.  Oh well, on the
bright side it seems to be running low on deadlocks.

	Happy Easter,

	-Mike

(bite me beast, 666 indeed)

[26666.886077] ------------[ cut here ]------------
[26666.886078] kernel BUG at kernel/sched/core.c:1717!
[26666.886081] invalid opcode: 0000 [#1] PREEMPT SMP
[26666.886094] Dumping ftrace buffer:
[26666.886112]    (ftrace buffer empty)
[26666.886137] Modules linked in: autofs4 edd af_packet cpufreq_conservative cpufreq_ondemand cpufreq_userspace cpufreq_powersave fuse loop md_mod dm_mod vhost_net macvtap macvlan vhost tun ipmi_ssif kvm_intel kvm joydev hid_generic sr_m
od cdrom sg shpchp netxen_nic hpwdt hpilo ipmi_si ipmi_msghandler irqbypass bnx2 iTCO_wdt iTCO_vendor_support gpio_ich pcc_cpufreq fjes i7core_edac edac_core lpc_ich pcspkr 8250_fintek ehci_pci acpi_cpufreq acpi_power_meter button ext4 m
bcache jbd2 crc16 usbhid uhci_hcd ehci_hcd sd_mod usbcore usb_common thermal processor scsi_dh_hp_sw scsi_dh_emc scsi_dh_rdac scsi_dh_alua ata_generic ata_piix libata hpsa scsi_transport_sas cciss scsi_mod
[26666.886140] CPU: 2 PID: 41 Comm: migration/2 Not tainted 4.6.0-rt11 #69
[26666.886140] Hardware name: Hewlett-Packard ProLiant DL980 G7, BIOS P66 07/07/2010
[26666.886142] task: ffff88017e34e580 ti: ffff88017e394000 task.ti: ffff88017e394000
[26666.886149] RIP: 0010:[<ffffffff810a6f5c>]  [<ffffffff810a6f5c>] select_fallback_rq+0x19c/0x1d0
[26666.886149] RSP: 0018:ffff88017e397d28  EFLAGS: 00010046
[26666.886150] RAX: 0000000000000100 RBX: ffff88017e668348 RCX: 0000000000000003
[26666.886151] RDX: 0000000000000100 RSI: 0000000000000100 RDI: ffffffff81811420
[26666.886152] RBP: ffff88017e668000 R08: 0000000000000003 R09: 0000000000000000
[26666.886153] R10: ffff8802772b3ec0 R11: 0000000000000001 R12: 0000000000000002
[26666.886153] R13: 0000000000000002 R14: ffff88017e398000 R15: ffff88017e668000
[26666.886155] FS:  0000000000000000(0000) GS:ffff880276680000(0000) knlGS:0000000000000000
[26666.886156] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[26666.886156] CR2: 0000000000695c5c CR3: 0000000271419000 CR4: 00000000000006e0
[26666.886157] Stack:
[26666.886159]  ffff880276696900 ffff880276696900 ffff88017e668808 0000000000016900
[26666.886160]  ffffffff810a88f9 ffff88017e398000 ffff88017e398000 0000000000000046
[26666.886161]  ffff88017e34e580 00000000fffffff7 ffffffff81c5be90 0000000000000000
[26666.886162] Call Trace:
[26666.886166]  [<ffffffff810a88f9>] ? migration_call+0x1b9/0x3b0
[26666.886168]  [<ffffffff8109d724>] ? notifier_call_chain+0x44/0x70
[26666.886171]  [<ffffffff8107d430>] ? notify_online+0x20/0x20
[26666.886172]  [<ffffffff8107d381>] ? __cpu_notify+0x31/0x50
[26666.886173]  [<ffffffff8107d448>] ? notify_dying+0x18/0x20
[26666.886175]  [<ffffffff8107dfbf>] ? cpuhp_invoke_callback+0x3f/0x150
[26666.886178]  [<ffffffff8111ed01>] ? cpu_stop_should_run+0x11/0x50
[26666.886180]  [<ffffffff8107e6a2>] ? take_cpu_down+0x52/0x80
[26666.886181]  [<ffffffff8111ee7a>] ? multi_cpu_stop+0x9a/0xc0
[26666.886182]  [<ffffffff8111ede0>] ? cpu_stop_queue_work+0x80/0x80
[26666.886184]  [<ffffffff8111f078>] ? cpu_stopper_thread+0x88/0x120
[26666.886186]  [<ffffffff8109fede>] ? smpboot_thread_fn+0x14e/0x270
[26666.886188]  [<ffffffff8109fd90>] ? smpboot_update_cpumask_percpu_thread+0x130/0x130
[26666.886192]  [<ffffffff8109c68d>] ? kthread+0xbd/0xe0
[26666.886196]  [<ffffffff816097c2>] ? ret_from_fork+0x22/0x40
[26666.886198]  [<ffffffff8109c5d0>] ? kthread_worker_fn+0x160/0x160
[26666.886211] Code: 06 00 00 44 89 e9 48 c7 c7 f8 72 9f 81 31 c0 e8 fd 0a 0e 00 e9 32 ff ff ff 41 83 fc 01 74 21 72 0c 41 83 fc 02 0f 85 33 ff ff ff <0f> 0b 48 89 ef 41 bc 01 00 00 00 e8 54 5c 07 00 e9 1e ff ff ff
[26666.886212] RIP  [<ffffffff810a6f5c>] select_fallback_rq+0x19c/0x1d0
[26666.886213]  RSP <ffff88017e397d28>
