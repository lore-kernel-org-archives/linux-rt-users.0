From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Unreliable Wireless network with 3.0.9-rt26
Date: Tue, 31 Jan 2012 20:35:14 -0500
Message-ID: <1328060114.5882.52.camel@gandalf.stny.rr.com>
References: <4F26D728.2090008@cmotion.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Christian Kapeller <christian.kapeller@cmotion.eu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:58154 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754364Ab2BABfQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 31 Jan 2012 20:35:16 -0500
In-Reply-To: <4F26D728.2090008@cmotion.eu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2012-01-30 at 18:45 +0100, Christian Kapeller wrote:
> Hi,
> 
> I'm having trouble running wifi in combination with a rt enabled kernel
> 3.0.9-rt26 on an imx51 arm platform. The distro is openwrt-trunk.
> 
> The device has 2 usb wifi interfaces (AR9271 chipset; driver: based on
> compat-wireless-testing 2011-12-01). I am running an iperf load on both
> interfaces, one interface is in AP mode, the other in STA mode.

You added your own driver?

> 
> When I configure the kernel without RT preemption, the device runs
> stable for >10 hours.
> 
> With RT preemption enabled, after a couple of minutes some interface
> will stop transmitting data. Sometimes ifconfig wlan[0,1] down will
> hang, sometimes ifconfig wlan[0,1] down will work, but then ping will
> 
> return the following:
> 
> # ping 192.168.2.170
> PING 192.168.2.170 (192.168.2.170): 56 data bytes
> ping: sendto: Operation not permitted
> 
> Right after loading the wireless drivers I get the following kernel
> warning:
> 
> [   36.917065] ------------[ cut here ]------------
> [   36.917202] WARNING: at /home/chrkap/Development/cworld/openwrt/build_dir/linux-cmotion_generic/compat-wireless-2011-12-01/net/mac80211/rx.c:3011 ieee80211_rx+0x34/0xb2c [mac80211]()

The net/mac80211/rx.c I have doesn't have 3011 lines. Just 2963. I don't
know what warning was triggered here.

> [   36.917222] Modules linked in: mmc_spi gpio_buttons ath9k_htc xt_HL xt_hl ipt_ECN xt_CLASSIFY xt_time xt_tcpmss xt_statistic xt_mark xt_length ipt_ecn xt_DSCP xt_dscp xt_quota xt_pkttype xt_physdev xt_owner ipt_REDIRECT ipt_NETMAP ipt_MASQUERADE xt_recent xt_helper xt_connmark xt_connbytes xt_conntrack xt_NOTRACK iptable_raw xt_state ipt_REJECT xt_TCPMSS ipt_LOG xt_comment xt_multiport xt_mac xt_limit iptable_mangle iptable_filter ntfs button_hotplug rt2800usb rt2800lib ath9k_common ath9k_hw rt2x00usb ath rt2x00lib mac80211 crc7 crc_itu_t crc_ccitt cfg80211 lib80211_crypt_ccmp lib80211_crypt_wep lib80211 compat
> [   36.917402] Backtrace: 
> [   36.917449] [<c0034a50>] (dump_backtrace+0x0/0x110) from [<c03428f8>] (dump_stack+0x18/0x1c)
> [   36.917463]  r6:00000bc3 r5:bf079bd9 r4:00000000 r3:00000000
> [   36.917503] [<c03428e0>] (dump_stack+0x0/0x1c) from [<c00414f8>] (warn_slowpath_common+0x54/0x6c)
> [   36.917526] [<c00414a4>] (warn_slowpath_common+0x0/0x6c) from [<c0041534>] (warn_slowpath_null+0x24/0x2c)
> [   36.917539]  r8:c667ce60 r7:00000080 r6:c667ce60 r5:bf07c273 r4:c6731800
> [   36.917561] r3:00000009
> [   36.917607] [<c0041510>] (warn_slowpath_null+0x0/0x2c) from [<bf066d78>] (ieee80211_rx+0x34/0xb2c [mac80211])
> [   36.917669] [<bf066d44>] (ieee80211_rx+0x0/0xb2c [mac80211]) from [<bf1d9590>] (ath9k_rx_tasklet+0x48c/0x4e8 [ath9k_htc])
> [   36.917701] [<bf1d9104>] (ath9k_rx_tasklet+0x0/0x4e8 [ath9k_htc]) from [<c00469d4>] (tasklet_action+0x84/0xd8)
> [   36.917722] [<c0046950>] (tasklet_action+0x0/0xd8) from [<c0046c34>] (__do_softirq_common+0xa8/0x164)
> [   36.917734]  r7:00000000 r6:00000001 r5:c0619ed8 r4:c6324000
> [   36.917763] [<c0046b8c>] (__do_softirq_common+0x0/0x164) from [<c0047254>] (__do_softirq+0x14/0x18)
> [   36.917784] [<c0047240>] (__do_softirq+0x0/0x18) from [<c0047340>] (local_bh_enable+0xe8/0x1b0)
> [   36.917809] [<c0047258>] (local_bh_enable+0x0/0x1b0) from [<c007cd3c>] (irq_forced_thread_fn+0x40/0x48)
> [   36.917822]  r5:c05c35cc r4:c62d8480
> [   36.917842] [<c007ccfc>] (irq_forced_thread_fn+0x0/0x48) from [<c007cbb8>] (irq_thread+0x88/0x18c)
> [   36.917855]  r6:c62d8480 r5:c05c35cc r4:c6324000 r3:00020000
> [   36.917885] [<c007cb30>] (irq_thread+0x0/0x18c) from [<c005c1d4>] (kthread+0x90/0x98)
> [   36.917908] [<c005c144>] (kthread+0x0/0x98) from [<c0044b44>] (do_exit+0x0/0x67c)
> [   36.917919]  r6:c0044b44 r5:c005c144 r4:c6027d14
> [   36.917937] ---[ end trace 0000000000000002 ]---
> 
> as well as a lockdep warning:
> 
> [   91.890473] =======================================================
> [   91.890484] [ INFO: possible circular locking dependency detected ]
> [   91.890499] 3.0.9-rt26 #6
> [   91.890507] -------------------------------------------------------
> [   91.890519] ksoftirqd/0/3 is trying to acquire lock:
> [   91.890530]  (&port_lock_key){+.+...}, at: [<c01f61c4>] imx_timeout+0x24/0x1f0
> [   91.890572] 
> [   91.890575] but task is already holding lock:
> [   91.890583]  (&sport->timer){+.+...}, at: [<c004d724>] run_timer_softirq+0x118/0x264
> [   91.890617] 
> [   91.890620] which lock already depends on the new lock.

This doesn't look related to you other troubles. But I'm curious to why
this happened. Seems to be the timer lockdep code is triggering here,
which is made to protect against bad del_timer_sync() actions. But
that's not the case here. I'm not sure what that "port_lock_key" is.
Could you post the rest of that locked splat. There should be a lot more
useful information.

> 
> For a while the network interfaces will transmit data normally though.
> 
> The configuration I use is far from optimal, both wireless drivers, as well as 
> the kernel contain the openwrt patches. If requested, I'll provide traces from
> the vanilla sources.

Ah that explains it ;-) Yeah that would be helpful, as I could then look
at the code those back traces represent.

Thanks!

-- Steve


