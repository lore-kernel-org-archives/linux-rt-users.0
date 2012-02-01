From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Unreliable Wireless network with 3.0.9-rt26
Date: Wed, 01 Feb 2012 15:21:12 -0500
Message-ID: <1328127672.5882.78.camel@gandalf.stny.rr.com>
References: <4F26D728.2090008@cmotion.eu>
	 <1328060114.5882.52.camel@gandalf.stny.rr.com>
	 <4F2958A9.5050109@cmotion.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Christian Kapeller <christian.kapeller@cmotion.eu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:47147 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752881Ab2BAUVP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Feb 2012 15:21:15 -0500
In-Reply-To: <4F2958A9.5050109@cmotion.eu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Please do not remove Cc's! I may only read this mailing list a couple of
times a week. If you want me to see your reply, Cc me. When I'm on a
thread, I will usually ignore replies in the mailing list, because I
expected to have read it in my inbox. Thus I may not even see your
replies.

I know some other mailing lists ask to just reply to the list and not to
Cc. I never listen to them :-)  That's just a list maintainers arrogance
thinking that everyone reads the list every day. I don't and seldom do.
I have enough trouble keeping up with my inbox to read mailing lists.




On Wed, 2012-02-01 at 16:22 +0100, Christian Kapeller wrote:
> Hi,
> 
> thank you for investigating this. I could reproduce the issue with with 
> v3.0.9-rt26 from rt stable git patches, and the 
> compat-wireless-2011-12-01 sources. The arch specific stuff came to me
> as one big 1 MiB patch, which I hesitate to attach here. Here is a link:
> http://www.cmotion.eu/wp/wp-content/uploads/2012/02/linux-3.0.9-rt26-karo-tx51-cworld.patch_.gz

I applied it, and I still don't see the line number to below in rx.c.

> 
> On 02/01/2012 02:35 AM, Steven Rostedt wrote:
> > On Mon, 2012-01-30 at 18:45 +0100, Christian Kapeller wrote:
> >> Hi,
> >>
> >> I'm having trouble running wifi in combination with a rt enabled kernel
> >> 3.0.9-rt26 on an imx51 arm platform. The distro is openwrt-trunk.
> >>
> >> The device has 2 usb wifi interfaces (AR9271 chipset; driver: based on
> >> compat-wireless-testing 2011-12-01). I am running an iperf load on both
> >> interfaces, one interface is in AP mode, the other in STA mode.
> > 
> > You added your own driver?
> 
> That's openwrt related patches. They regularly take compat-wireless snapshots,
> and apply a number of patches against that. Openwrt comes as buildroot

Does the above patch have the changes to the rx.c file?

> 
> 
> 
> > 
> >>
> >> When I configure the kernel without RT preemption, the device runs
> >> stable for >10 hours.
> >>
> >> With RT preemption enabled, after a couple of minutes some interface
> >> will stop transmitting data. Sometimes ifconfig wlan[0,1] down will
> >> hang, sometimes ifconfig wlan[0,1] down will work, but then ping will
> >>
> >> return the following:
> >>
> >> # ping 192.168.2.170
> >> PING 192.168.2.170 (192.168.2.170): 56 data bytes
> >> ping: sendto: Operation not permitted
> >>
> >> Right after loading the wireless drivers I get the following kernel
> >> warning:
> 
> Here is the new trace:
> 
> [   40.035276] ------------[ cut here ]------------
> [   40.035654] WARNING: at /home/chrkap/Development/src/compat-wireless-2011-12-01/net/mac80211/rx.c:2981 ieee80211_rx+0x38/0xb60 [mac80211]()

My file (with above patch applied) only has 2963 lines. I don't know
where that 2981 comes from.

What's at that line there (can you send the rx.c file).


> [   40.035673] Modules linked in: mmc_spi ath9k_htc xt_HL xt_hl ipt_ECN xt_CLASSIFY xt_time xt_tcpmss xt_statistic xt_mark xt_length ipt_ecn xt_DSCP xt_dscp xt_quota xt_pkttype xt_physdev xt_owner ipt_REDIRECT ipt_NETMAP ipt_MASQUERADE xt_recent xt_helper xt_connmark xt_connbytes xt_conntrack xt_NOTRACK iptable_raw xt_state ipt_REJECT xt_TCPMSS ipt_LOG xt_comment xt_multiport xt_mac xt_limit iptable_mangle iptable_filter ntfs ath9k_common ath9k_hw ath mac80211 crc7 crc_itu_t crc_ccitt cfg80211 compat
> [   40.035818] Backtrace: 
> [   40.035862] [<c0035d40>] (dump_backtrace+0x0/0x110) from [<c0334ff0>] (dump_stack+0x18/0x1c)
> [   40.035876]  r6:bf074cca r5:00000ba5 r4:00000000 r3:00000000
> [   40.035917] [<c0334fd8>] (dump_stack+0x0/0x1c) from [<c0042d94>] (warn_slowpath_common+0x54/0x6c)
> [   40.035939] [<c0042d40>] (warn_slowpath_common+0x0/0x6c) from [<c0042dd0>] (warn_slowpath_null+0x24/0x2c)
> [   40.035952]  r8:c65099d8 r7:c65c8e60 r6:bf076729 r5:c65c8e60 r4:c65099c0
> [   40.035975] r3:00000009
> [   40.036082] [<c0042dac>] (warn_slowpath_null+0x0/0x2c) from [<bf0607a8>] (ieee80211_rx+0x38/0xb60 [mac80211])
> [   40.036221] [<bf060770>] (ieee80211_rx+0x0/0xb60 [mac80211]) from [<bf1c54f8>] (ath9k_rx_tasklet+0x4b0/0x50c [ath9k_htc])
> [   40.036261] [<bf1c5048>] (ath9k_rx_tasklet+0x0/0x50c [ath9k_htc]) from [<c0048480>] (tasklet_action+0x84/0xd8)
> [   40.036282] [<c00483fc>] (tasklet_action+0x0/0xd8) from [<c004873c>] (__do_softirq_common+0xa8/0x164)
> [   40.036295]  r7:00000000 r6:c6292000 r5:00000001 r4:c0603918
> [   40.036324] [<c0048694>] (__do_softirq_common+0x0/0x164) from [<c0048c2c>] (__do_softirq+0x14/0x18)
> [   40.036345] [<c0048c18>] (__do_softirq+0x0/0x18) from [<c0048d18>] (local_bh_enable+0xe8/0x1b0)
> [   40.036371] [<c0048c30>] (local_bh_enable+0x0/0x1b0) from [<c007f718>] (irq_forced_thread_fn+0x40/0x48)
> [   40.036384]  r5:c62cc580 r4:00000001
> [   40.036405] [<c007f6d8>] (irq_forced_thread_fn+0x0/0x48) from [<c007f588>] (irq_thread+0x90/0x1a0)
> [   40.036417]  r6:c6292000 r5:c62cc580 r4:c05ad60c r3:c05ad654
> [   40.036449] [<c007f4f8>] (irq_thread+0x0/0x1a0) from [<c005dd50>] (kthread+0x90/0x98)
> [   40.036467] [<c005dcc0>] (kthread+0x0/0x98) from [<c00464fc>] (do_exit+0x0/0x674)
> [   40.036479]  r6:c00464fc r5:c005dcc0 r4:c6027d0c
> [   40.036497] ---[ end trace 0000000000000002 ]---
> 
> And another one:
> 
> [   52.835929] ------------[ cut here ]------------
> [   52.836016] WARNING: at /home/chrkap/Development/src/compat-wireless-2011-12-01/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c:501 ath9k_htc_tx_process+0x300/0x350 [ath9k_htc]()
> [   52.836061] Modules linked in: mmc_spi ath9k_htc xt_HL xt_hl ipt_ECN xt_CLASSIFY xt_time xt_tcpmss xt_statistic xt_mark xt_length ipt_ecn xt_DSCP xt_dscp xt_quota xt_pkttype xt_physdev xt_owner ipt_REDIRECT ipt_NETMAP ipt_MASQUERADE xt_recent xt_helper xt_connmark xt_connbytes xt_conntrack xt_NOTRACK iptable_raw xt_state ipt_REJECT xt_TCPMSS ipt_LOG xt_comment xt_multiport xt_mac xt_limit iptable_mangle iptable_filter ntfs ath9k_common ath9k_hw ath mac80211 crc7 crc_itu_t crc_ccitt cfg80211 compat

This one has:

send_mac80211:
	spin_lock_bh(&priv->tx.tx_lock);
	if (WARN_ON(--priv->tx.queued_cnt < 0))
		priv->tx.queued_cnt = 0;
	spin_unlock_bh(&priv->tx.tx_lock);

looks like the tx.queued_cnt got corrupted.

> [   52.836226] Backtrace: 
> [   52.836271] [<c0035d40>] (dump_backtrace+0x0/0x110) from [<c0334ff0>] (dump_stack+0x18/0x1c)
> [   52.836285]  r6:bf1ca9f7 r5:000001f5 r4:00000000 r3:00000000
> [   52.836326] [<c0334fd8>] (dump_stack+0x0/0x1c) from [<c0042d94>] (warn_slowpath_common+0x54/0x6c)
> [   52.836349] [<c0042d40>] (warn_slowpath_common+0x0/0x6c) from [<c0042dd0>] (warn_slowpath_null+0x24/0x2c)
> [   52.836362]  r8:c6531eb0 r7:c63aa858 r6:c67bb0a8 r5:c67ba6a0 r4:c643e380
> [   52.836384] r3:00000009
> [   52.836421] [<c0042dac>] (warn_slowpath_null+0x0/0x2c) from [<bf1c40ec>] (ath9k_htc_tx_process+0x300/0x350 [ath9k_htc])
> [   52.836468] [<bf1c3dec>] (ath9k_htc_tx_process+0x0/0x350 [ath9k_htc]) from [<bf1c4978>] (ath9k_htc_txstatus+0xc0/0xe4 [ath9k_htc])
> [   52.836514] [<bf1c48b8>] (ath9k_htc_txstatus+0x0/0xe4 [ath9k_htc]) from [<bf1c3598>] (ath9k_wmi_event_tasklet+0x130/0x13c [ath9k_htc])
> [   52.836551] [<bf1c3468>] (ath9k_wmi_event_tasklet+0x0/0x13c [ath9k_htc]) from [<c0048480>] (tasklet_action+0x84/0xd8)
> [   52.836573] [<c00483fc>] (tasklet_action+0x0/0xd8) from [<c004873c>] (__do_softirq_common+0xa8/0x164)
> [   52.836585]  r7:00000000 r6:c6312000 r5:00000009 r4:c0603918
> [   52.836614] [<c0048694>] (__do_softirq_common+0x0/0x164) from [<c0048c2c>] (__do_softirq+0x14/0x18)
> [   52.836635] [<c0048c18>] (__do_softirq+0x0/0x18) from [<c0048d18>] (local_bh_enable+0xe8/0x1b0)
> [   52.836661] [<c0048c30>] (local_bh_enable+0x0/0x1b0) from [<c007f718>] (irq_forced_thread_fn+0x40/0x48)
> [   52.836673]  r5:c62cc200 r4:00000001
> [   52.836694] [<c007f6d8>] (irq_forced_thread_fn+0x0/0x48) from [<c007f588>] (irq_thread+0x90/0x1a0)
> [   52.836706]  r6:c6312000 r5:c62cc200 r4:c05ad23c r3:c05ad284
> [   52.836737] [<c007f4f8>] (irq_thread+0x0/0x1a0) from [<c005dd50>] (kthread+0x90/0x98)
> [   52.836756] [<c005dcc0>] (kthread+0x0/0x98) from [<c00464fc>] (do_exit+0x0/0x674)
> [   52.836767]  r6:c00464fc r5:c005dcc0 r4:c6027d0c
> [   52.836786] ---[ end trace 0000000000000003 ]---
> 
> >> as well as a lockdep warning:
> ...
> > 
> > This doesn't look related to you other troubles. But I'm curious to why
> > this happened. Seems to be the timer lockdep code is triggering here,
> > which is made to protect against bad del_timer_sync() actions. But
> > that's not the case here. I'm not sure what that "port_lock_key" is.
> > Could you post the rest of that locked splat. There should be a lot more
> > useful information.
> > 
> 
> [  103.136064] =======================================================
> [  103.136075] [ INFO: possible circular locking dependency detected ]
> [  103.136090] 3.0.9-rt26+ #25
> [  103.136098] -------------------------------------------------------
> [  103.136109] ksoftirqd/0/3 is trying to acquire lock:
> [  103.136120]  (&port_lock_key){+.+...}, at: [<c01e6844>] imx_timeout+0x24/0x1f0
> [  103.136168] 
> [  103.136171] but task is already holding lock:
> [  103.136179]  (&sport->timer){+.+...}, at: [<c004e950>] run_timer_softirq+0x110/0x264
> [  103.136212] 
> [  103.136215] which lock already depends on the new lock.
> [  103.136221] 
> [  103.136226] 
> [  103.136229] the existing dependency chain (in reverse order) is:
> [  103.136238] 
> [  103.136241] -> #1 (&sport->timer){+.+...}:
> [  103.136256]        [<c0071ad0>] __lock_acquire+0x143c/0x1954
> [  103.136275]        [<c00724ec>] lock_acquire+0x68/0x7c
> [  103.136290]        [<c004ec70>] del_timer_sync+0x4c/0x154
> [  103.136306]        [<c01e645c>] imx_set_termios+0x144/0x304
> [  103.136322]        [<c01e3c40>] uart_set_options+0x128/0x168
> [  103.136338]        [<c001a2b0>] imx_console_setup+0x1b0/0x1c0
> [  103.136364]        [<c004439c>] register_console+0x17c/0x334
> [  103.136391]        [<c01e3664>] uart_add_one_port+0x2d0/0x3a8
> [  103.136407]        [<c01e6798>] serial_imx_probe+0x17c/0x204
> [  103.136422]        [<c01ef718>] platform_drv_probe+0x1c/0x20
> [  103.136449]        [<c01ee420>] driver_probe_device+0xb0/0x160
> [  103.136465]        [<c01ee538>] __driver_attach+0x68/0x8c
> [  103.136480]        [<c01ed5ec>] bus_for_each_dev+0x58/0x88
> [  103.136495]        [<c01ee0e4>] driver_attach+0x20/0x28
> [  103.136510]        [<c01edd08>] bus_add_driver+0xa4/0x22c
> [  103.136524]        [<c01eead0>] driver_register+0xb0/0x134
> [  103.136540]        [<c01efb98>] platform_driver_register+0x4c/0x60
> [  103.136557]        [<c001a0dc>] imx_serial_init+0x2c/0x50
> [  103.136572]        [<c002d500>] do_one_initcall+0x9c/0x170
> [  103.136596]        [<c00089dc>] kernel_init+0x7c/0x120
> [  103.136611]        [<c00464fc>] do_exit+0x0/0x674
> [  103.136626] 
> [  103.136630] -> #0 (&port_lock_key){+.+...}:
> [  103.136643]        [<c006eeac>] print_circular_bug+0x5c/0x2ac
> [  103.136659]        [<c00718a8>] __lock_acquire+0x1214/0x1954
> [  103.136673]        [<c00724ec>] lock_acquire+0x68/0x7c
> [  103.136687]        [<c03374bc>] rt_spin_lock+0x3c/0x44
> [  103.136716]        [<c01e6844>] imx_timeout+0x24/0x1f0
> [  103.136731]        [<c004e9d0>] run_timer_softirq+0x190/0x264
> [  103.136747]        [<c004873c>] __do_softirq_common+0xa8/0x164
> [  103.136763]        [<c00488cc>] __thread_do_softirq+0xd4/0x168
> [  103.136777]        [<c00489dc>] run_ksoftirqd+0x7c/0x17c
> [  103.136791]        [<c005dd50>] kthread+0x90/0x98
> [  103.136808]        [<c00464fc>] do_exit+0x0/0x674
> [  103.136823] 
> [  103.136826] other info that might help us debug this:
> [  103.136831] 
> [  103.136838]  Possible unsafe locking scenario:
> [  103.136843] 
> [  103.136849]        CPU0                    CPU1
> [  103.136856]        ----                    ----
> [  103.136863]   lock(&sport->timer);
> [  103.136875]                                lock(&port_lock_key);
> [  103.136887]                                lock(&sport->timer);
> [  103.136899]   lock(&port_lock_key);

This is definitely a bug!

In drivers/tty/serial/imx.c: imx_set_termios()

	spin_lock_irqsave(&sport->port.lock, flags);
	[...]
	del_timer_sync(&sport->timer);

If the timer is on another CPU and tries to grab the sport->port.lock,
but blocks while this code is holding the spinlock. We deadlock.

The del_timer_sync() will spin until the timer in question is finished,
but the timer in question could be spinning on the spinlock that is held
here.


But this is a separate issue. I don't think this is the cause of your
original problem.

-- Steve


> [  103.136910] 
> [  103.136913]  *** DEADLOCK ***
> [  103.136917] 
> [  103.136925] 2 locks held by ksoftirqd/0/3:
> [  103.136932]  #0:  (&per_cpu(local_softirq_lock, __cpu).lock){+.+...}, at: [<c004884c>] __thread_do_softirq+0x54/0x168
> [  103.136959]  #1:  (&sport->timer){+.+...}, at: [<c004e950>] run_timer_softirq+0x110/0x264
> [  103.136983] 
> [  103.136987] stack backtrace:
> [  103.136994] Backtrace: 
> [  103.137020] [<c0035d40>] (dump_backtrace+0x0/0x110) from [<c0334ff0>] (dump_stack+0x18/0x1c)
> [  103.137033]  r6:c06b9b70 r5:c06b9b70 r4:c06b9dd0 r3:00000000
> [  103.137062] [<c0334fd8>] (dump_stack+0x0/0x1c) from [<c006f0b0>] (print_circular_bug+0x260/0x2ac)
> [  103.137082] [<c006ee50>] (print_circular_bug+0x0/0x2ac) from [<c00718a8>] (__lock_acquire+0x1214/0x1954)
> [  103.137103] [<c0070694>] (__lock_acquire+0x0/0x1954) from [<c00724ec>] (lock_acquire+0x68/0x7c)
> [  103.137124] [<c0072484>] (lock_acquire+0x0/0x7c) from [<c03374bc>] (rt_spin_lock+0x3c/0x44)
> [  103.137135]  r6:00000000 r5:c01e6844 r4:c615d000
> [  103.137162] [<c0337480>] (rt_spin_lock+0x0/0x44) from [<c01e6844>] (imx_timeout+0x24/0x1f0)
> [  103.137174]  r5:c602e000 r4:c615d000
> [  103.137197] [<c01e6820>] (imx_timeout+0x0/0x1f0) from [<c004e9d0>] (run_timer_softirq+0x190/0x264)
> [  103.137218] [<c004e840>] (run_timer_softirq+0x0/0x264) from [<c004873c>] (__do_softirq_common+0xa8/0x164)
> [  103.137239] [<c0048694>] (__do_softirq_common+0x0/0x164) from [<c00488cc>] (__thread_do_softirq+0xd4/0x168)
> [  103.137259] [<c00487f8>] (__thread_do_softirq+0x0/0x168) from [<c00489dc>] (run_ksoftirqd+0x7c/0x17c)
> [  103.137272]  r6:00000000 r5:c06038c0 r4:c602e000 r3:00000202
> [  103.137300] [<c0048960>] (run_ksoftirqd+0x0/0x17c) from [<c005dd50>] (kthread+0x90/0x98)
> [  103.137311]  r7:00000013 r6:c0048960 r5:00000000 r4:c6027ebc
> [  103.137339] [<c005dcc0>] (kthread+0x0/0x98) from [<c00464fc>] (do_exit+0x0/0x674)
> [  103.137350]  r6:c00464fc r5:c005dcc0 r4:c6027ebc
> 
> 
> Thanks again,
> Christian


