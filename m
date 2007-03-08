From: Guennadi Liakhovetski <gl@dsa-ac.de>
Subject: BUG() in rt_mutex_top_waiter()
Date: Thu, 8 Mar 2007 17:15:29 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703081709230.534@pcgl.dsa-ac.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.dsa-ac.de ([62.112.80.99]:45369 "EHLO mail.dsa-ac.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752442AbXCHQPf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 8 Mar 2007 11:15:35 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi

I'm having bad problems trying to get fast IrDA with ppp over irnet under 
2.6.20-rt8 to run. Apart from various problems re-connecting after 
Ir-disturbances, I've got this:

kernel BUG at kernel/rtmutex_common.h:74!
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 817 [#1]
Modules linked in: irnet ppp_generic slhc pxaficp_ir irda crc_ccitt arc4 ecb blkcipher ieee80211_crypt_wep ohci_hcd rfcomm l2cap hci_usb bluetooth zd1211rw firmware_class ieee80211softmac ieee80211 ieee80211_crypt colibri_bl backlight rtc_dev rtc_pcf8583 rtc_core i2c_dev i2c_pxa i2c_core uinput fpga_kbd spartan2 evdev snd_pxa2xx_ac97 snd_pxa2xx_pcm snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc ucb1x00_ts ucb1400_core ac97_bus usbcore
CPU: 0
PC is at __bug+0x20/0x2c
LR is at rt_mutex_slowunlock+0x3c/0xb8
pc : [<c0023d40>]    lr : [<c01e7f2c>]    Not tainted
sp : c0357d74  ip : c0357c78  fp : c0357d80
r10: c13a670c  r9 : 00000001  r8 : bf120664
r7 : c13a6704  r6 : c107e300  r5 : c0356000  r4 : c107e30c
r3 : 00000000  r2 : 00000002  r1 : c0356000  r0 : 0000002d
Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  Segment kernel
Control: 397F
Table: A2C20000  DAC: 00000017
Process softirq-net-rx/ (pid: 6, stack limit = 0xc0356258)
Stack: (0xc0357d74 to 0xc0358000)
7d60:                                              c0357dac c0357d84 c005e530 
7d80: c0023d2c c0356000 20000013 c13a6704 00000000 bf120664 00000018 00000010 
7da0: c0357dc8 c0357db0 c01e7e98 c005e3fc c13a6704 c13a6600 c0381a80 c0357dd8 
7dc0: c0357dcc c01e87ac c01e7e44 c0357df8 c0357ddc bf105e54 c01e87a8 c1b764a0 
7de0: c1b764a0 c3dfc383 c0381a80 c0357e0c c0357dfc bf0f6804 bf105e00 c17901c0 
7e00: c0357e40 c0357e10 bf0f97bc bf0f6790 c17e48c0 00000000 00000001 00000001 
7e20: c10a3c00 c0357ec0 c0381a80 00000000 00000001 c0357e50 c0357e44 bf0f9afc 
7e40: bf0f9624 c0357e90 c0357e54 bf0fe64c bf0f9ac4 c0357e60 c00886bc c01e87a8 
7e60: 00000000 00000000 bf11fab4 c10a3c00 c0381a80 c0357ec0 bf120664 c1791000 
7e80: c0293fd8 c0357eb8 c0357e94 bf0fb9e4 bf0fe07c 00000001 c10a3c00 c0381a80 
7ea0: 00000007 00001700 c0293fd8 c0357f08 c0357ebc bf100518 bf0fb988 c0357eec 
7ec0: c03568f0 c005e70c c005fc28 00000000 40000403 c028322c 40000013 c0283220 
7ee0: c0357f5c c0293ff8 c0381a80 bf11fff0 00000007 00001700 c0293fd8 c0357f34 
7f00: c0357f0c c0188630 bf100334 c1791000 c0293c58 00000000 c0293c54 c0293ca0 
7f20: 00000040 00000d2c c0357f64 c0357f38 c01887d8 c01883f8 c0357f68 c0293ca0 
7f40: 00000000 c0293c94 c0293c54 00000d2c fffffff7 c026bd4c c0357f90 c0357f68 
7f60: c0188968 c0188730 0000012c c0283048 c0356000 c0283020 00000008 c0283220 
7f80: c0283020 c0357fc4 c0357f94 c0042f7c c01888c4 c028322c 00000032 c0283220 
7fa0: c0356000 c0347eb0 c0042e74 fffffffc 00000000 00000000 c0357ff4 c0357fc8 
7fc0: c0053614 c0042e80 00000001 ffffffff ffffffff 00000000 00000000 00000000 
7fe0: 00000000 00000000 00000000 c0357ff8 c003f918 c0053514 c027d7c8 c027d7cc 
Backtrace: 
[<c0023d20>] (__bug+0x0/0x2c) from [<c005e530>] (wakeup_next_waiter+0x140/0x208)
[<c005e3f0>] (wakeup_next_waiter+0x0/0x208) from [<c01e7e98>] (rt_spin_lock_slowunlock+0x60/0xb8)
[<c01e7e38>] (rt_spin_lock_slowunlock+0x0/0xb8) from [<c01e87ac>] (rt_spin_unlock+0x10/0x14)
  r6 = C0381A80  r5 = C13A6600  r4 = C13A6704 
[<c01e879c>] (rt_spin_unlock+0x0/0x14) from [<bf105e54>] (irttp_data_indication+0x60/0xc4 [irda])
[<bf105df4>] (irttp_data_indication+0x0/0xc4 [irda]) from [<bf0f6804>] (irlmp_data_indication+0x80/0x94 [irda])
  r7 = C0381A80  r6 = C3DFC383  r5 = C1B764A0  r4 = C1B764A0
[<bf0f6784>] (irlmp_data_indication+0x0/0x94 [irda]) from [<bf0f97bc>] (irlmp_link_data_indication+0x1a4/0x378 [irda])
  r4 = C17901C0 
[<bf0f9618>] (irlmp_link_data_indication+0x0/0x378 [irda]) from [<bf0f9afc>] (irlap_data_indication+0x44/0x58 [irda])
[<bf0f9ab8>] (irlap_data_indication+0x0/0x58 [irda]) from [<bf0fe64c>] (irlap_state_nrm_s+0x5dc/0x7f8 [irda])
[<bf0fe070>] (irlap_state_nrm_s+0x0/0x7f8 [irda]) from [<bf0fb9e4>] (irlap_do_event+0x68/0x18c [irda])
[<bf0fb97c>] (irlap_do_event+0x0/0x18c [irda]) from [<bf100518>] (irlap_driver_rcv+0x1f0/0xd34 [irda])
[<bf100328>] (irlap_driver_rcv+0x0/0xd34 [irda]) from [<c0188630>] (netif_receive_skb+0x244/0x338)
[<c01883ec>] (netif_receive_skb+0x0/0x338) from [<c01887d8>] (process_backlog+0xb4/0x194)
[<c0188724>] (process_backlog+0x0/0x194) from [<c0188968>] (net_rx_action+0xb0/0x210)
[<c01888b8>] (net_rx_action+0x0/0x210) from [<c0042f7c>] (ksoftirqd+0x108/0x1cc)
[<c0042e74>] (ksoftirqd+0x0/0x1cc) from [<c0053614>] (kthread+0x10c/0x138)
[<c0053508>] (kthread+0x0/0x138) from [<c003f918>] (do_exit+0x0/0x8b0)
  r8 = 00000000  r7 = 00000000  r6 = 00000000  r5 = 00000000
  r4 = 00000000 
Code: e1a01000 e59f000c eb006772 e3a03000 (e5833000)

After which I've dumped tasks with a sysrq, and here's where the pppd was:

pppd          D [c15d4340] C01E67B8     0  1718      1          4847  1333 (L-TLB)
[<c01e63a0>] (__schedule+0x0/0x7e8) from [<c01e6c7c>] (schedule+0x54/0x124)
[<c01e6c28>] (schedule+0x0/0x124) from [<c003fe08>] (do_exit+0x4f0/0x8b0)
  r5 = C15D4340  r4 = C112DAE8 
[<c003f918>] (do_exit+0x0/0x8b0) from [<c002416c>] (die+0x29c/0x2e8)
[<c0023ed0>] (die+0x0/0x2e8) from [<c0025b9c>] (__do_kernel_fault+0x70/0x80)
[<c0025b2c>] (__do_kernel_fault+0x0/0x80) from [<c0025d30>] (do_page_fault+0x60/0x214)
  r7 = 00000000  r6 = C0267C3C  r5 = C15D4340  r4 = C0267BCC
[<c0025cd0>] (do_page_fault+0x0/0x214) from [<c0026000>] (do_DataAbort+0x3c/0xa4)
[<c0025fc4>] (do_DataAbort+0x0/0xa4) from [<c001fac0>] (__dabt_svc+0x40/0x60)
  r8 = C0327DA0  r7 = 40000013  r6 = C1116D00  r5 = C112DAC8
  r4 = FFFFFFFF 
[<c0023d20>] (__bug+0x0/0x2c) from [<c01e84fc>] (rt_spin_lock_slowlock+0x1e4/0x24c)
[<c01e8318>] (rt_spin_lock_slowlock+0x0/0x24c) from [<c01e8798>] (__lock_text_start+0x10/0x14)
[<c01e8788>] (__lock_text_start+0x0/0x14) from [<bf12aec4>] (ppp_unregister_channel+0x3c/0xe4 [ppp_generic])
[<bf12ae88>] (ppp_unregister_channel+0x0/0xe4 [ppp_generic]) from [<bf130180>] (dev_irnet_close+0x68/0x84 [irnet])
  r7 = C173CF04  r6 = C17FC764  r5 = 00000000  r4 = C107E000
[<bf130118>] (dev_irnet_close+0x0/0x84 [irnet]) from [<c008e544>] (__fput+0x194/0x1c8)
  r5 = C1B7D860  r4 = 00000008 
[<c008e3b0>] (__fput+0x0/0x1c8) from [<c008e5b0>] (fput+0x38/0x3c)
  r8 = 00000000  r7 = C03AF320  r6 = 00000000  r5 = C03AF320
  r4 = C1B7D860 
[<c008e578>] (fput+0x0/0x3c) from [<c008c1e8>] (filp_close+0x5c/0x88)
[<c008c18c>] (filp_close+0x0/0x88) from [<c003f174>] (put_files_struct+0x9c/0xdc)
  r6 = C03AF328  r5 = 00000007  r4 = 00000007 
[<c003f0d8>] (put_files_struct+0x0/0xdc) from [<c003fa80>] (do_exit+0x168/0x8b0)
[<c003f918>] (do_exit+0x0/0x8b0) from [<c002416c>] (die+0x29c/0x2e8)
[<c0023ed0>] (die+0x0/0x2e8) from [<c0025b9c>] (__do_kernel_fault+0x70/0x80)
[<c0025b2c>] (__do_kernel_fault+0x0/0x80) from [<c0025d30>] (do_page_fault+0x60/0x214)
  r7 = C16DB5A0  r6 = C0267C3C  r5 = C15D4340  r4 = C0267BCC
[<c0025cd0>] (do_page_fault+0x0/0x214) from [<c0026000>] (do_DataAbort+0x3c/0xa4)
[<c0025fc4>] (do_DataAbort+0x0/0xa4) from [<c001fac0>] (__dabt_svc+0x40/0x60)
  r8 = C13A6704  r7 = C112C000  r6 = C112DDEC  r5 = C112DD8C
  r4 = FFFFFFFF 
[<c0023d20>] (__bug+0x0/0x2c) from [<c005f118>] (task_blocks_on_rt_mutex+0x22c/0x290)
[<c005eeec>] (task_blocks_on_rt_mutex+0x0/0x290) from [<c01e848c>] (rt_spin_lock_slowlock+0x174/0x24c)
[<c01e8318>] (rt_spin_lock_slowlock+0x0/0x24c) from [<c01e8798>] (__lock_text_start+0x10/0x14)
[<c01e8788>] (__lock_text_start+0x0/0x14) from [<bf103d64>] (irttp_run_tx_queue+0x7c/0x1d4 [irda])
[<bf103ce8>] (irttp_run_tx_queue+0x0/0x1d4 [irda]) from [<bf103fe4>] (irttp_data_request+0x128/0x4f8 [irda])
  r8 = BF120664  r7 = 00000002  r6 = C13A6600  r5 = C0381800
  r4 = C0381800 
[<bf103ebc>] (irttp_data_request+0x0/0x4f8 [irda]) from [<bf1311bc>] (ppp_irnet_send+0x134/0x238 [irnet])
[<bf131088>] (ppp_irnet_send+0x0/0x238 [irnet]) from [<bf12a264>] (ppp_channel_push+0x58/0xc8 [ppp_generic])
  r7 = C1116D00  r6 = C0381800  r5 = C1116C00  r4 = C1116C04
[<bf12a20c>] (ppp_channel_push+0x0/0xc8 [ppp_generic]) from [<bf12a40c>] (ppp_write+0x138/0x178 [ppp_generic])
  r7 = 00050AA6  r6 = C1116C00  r5 = 00000012  r4 = C0E94E60
[<bf12a2d4>] (ppp_write+0x0/0x178 [ppp_generic]) from [<c008cde0>] (vfs_write+0xac/0x18c)
[<c008cd34>] (vfs_write+0x0/0x18c) from [<c008cf88>] (sys_write+0x4c/0x7c)
[<c008cf3c>] (sys_write+0x0/0x7c) from [<c001ff40>] (ret_fast_syscall+0x0/0x2c)
  r8 = C00200E4  r7 = 00000004  r6 = 00000008  r5 = 00050AA6
  r4 = 00000012

Don't know if it's related or is just a consequence from the Original 
Oops. Yes, after the first one there came further ones.

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
