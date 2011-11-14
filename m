From: Darcy Watkins <dwatkins@tranzeo.com>
Subject: rtmutex grabbed twice by same context in network code
Date: Mon, 14 Nov 2011 14:41:24 -0800
Message-ID: <1321310484.10018.74.camel@tr-pentomino>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.tranzeo.com ([64.114.87.10]:28143 "EHLO mail2.tranzeo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756536Ab1KNWl0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Nov 2011 17:41:26 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

Anyone have insight into the kernel crash below?

[ 3430.868677] ------------[ cut here ]------------
[ 3430.868723] kernel BUG at /home/darcy/workspace/marzen/prod-1.4_D04/kernel/linux-3.0/kernel/rtmutex.c:724!
[ 3430.868766] Oops: Exception in kernel mode, sig: 5 [#1]
[ 3430.868787] PREEMPT Taihushui
[ 3430.868809] Modules linked in: ebtable_nat ssMacDrv adi9352_3Drv ieee802_16d sharkDrv hal ws_pci cryptoSoft cryptoReg services logDrv ebt_rule_id e]
[ 3430.869006] NIP: c02ab8ac LR: c02ab850 CTR: c02472f4
[ 3430.869040] REGS: c0e07980 TRAP: 0700   Tainted: P             (3.0.8-rt23+)
[ 3430.869065] MSR: 00029030 <EE,ME,CE,IR,DR>  CR: 88042082  XER: 00000000
[ 3430.869123] TASK = c1a0b1f0[1730] 'rx_proc' THREAD: c0e06000
[ 3430.869146] GPR00: 00000001 c0e07a30 c1a0b1f0 00000000 c1a0b1f0 00000000 00000001 4ec1739e 
[ 3430.869200] GPR08: c1a0b1f0 c1a0b1f0 c1a0b1f0 c1a0b1f1 88042088 1001ff8c 01ff8e00 00000001 
[ 3430.869256] GPR16: 0000003d c02472f4 c03269f4 00000001 c04c143c c04c123c c04c103c c04c05e0 
[ 3430.869311] GPR24: 00200200 c04c0e3c 00000000 00000000 c0e06000 c03962cc c1a0b1f0 c1a77590 
[ 3430.869399] NIP [c02ab8ac] rt_spin_lock_slowlock+0xc0/0x2ac
[ 3430.869438] LR [c02ab850] rt_spin_lock_slowlock+0x64/0x2ac
[ 3430.869460] Call Trace:
[ 3430.869495] [c0e07a30] [c02ab850] rt_spin_lock_slowlock+0x64/0x2ac (unreliable)
[ 3430.869559] [c0e07a90] [c0247320] tcp_delack_timer+0x2c/0x244
[ 3430.869602] [c0e07ab0] [c0041238] run_timer_softirq+0x148/0x284
[ 3430.869654] [c0e07b10] [c00399f4] __do_softirq_common+0x100/0x1c8
[ 3430.869699] [c0e07b50] [c003a124] local_bh_enable+0xb8/0x110
[ 3430.869746] [c0e07b70] [c01fae00] dev_queue_xmit+0x208/0x4d8
[ 3430.869789] [c0e07ba0] [c022d408] ip_finish_output+0x174/0x38c
[ 3430.869828] [c0e07bc0] [c022daa4] ip_local_out+0x38/0x4c
[ 3430.869867] [c0e07bd0] [c022df00] ip_queue_xmit+0x130/0x398
[ 3430.869914] [c0e07c00] [c0242f54] tcp_transmit_skb+0x3ac/0x914
[ 3430.869958] [c0e07c60] [c023d214] __tcp_ack_snd_check+0x6c/0xb8
[ 3430.870004] [c0e07c80] [c0241d48] tcp_rcv_established+0x430/0x6c4
[ 3430.870046] [c0e07cb0] [c024956c] tcp_v4_do_rcv+0xd8/0x1cc
[ 3430.870083] [c0e07ce0] [c0249dcc] tcp_v4_rcv+0x76c/0x840
[ 3430.870122] [c0e07d10] [c0227f84] ip_local_deliver_finish+0x148/0x298
[ 3430.870161] [c0e07d30] [c022783c] ip_rcv_finish+0x114/0x3e0
[ 3430.870203] [c0e07d50] [c01f7830] __netif_receive_skb+0x3c0/0x42c
[ 3430.870562] [c0e07da0] [c77d762c] cs_rx+0x170/0x468 [ssMacDrv]
[ 3430.870918] [c0e07ee0] [c77e39c8] pdu_proc_task+0x7c0/0xdcc [ssMacDrv]
[ 3430.871011] [c0e07fc0] [c755d8e8] task_init_2_6+0xe4/0x180 [services]
[ 3430.871061] [c0e07ff0] [c000d2b8] kernel_thread+0x4c/0x68
[ 3430.871086] Instruction dump:
[ 3430.871107] 8361004c 83810050 83a10054 83c10058 83e1005c 38210060 4e800020 801f0008 
[ 3430.871160] 5400003c 7fc00278 7c000034 5400d97e <0f000000> 7c0000a6 5400045e 7c000124 


ssMacDrv module, rx_proc thread, cs_rx are part of a wimax radio driver
I am building from source.  cs_rx() takes received net PDUs after
unpacked and/or defragmented from the over-the-air PDUs (802.16).  It is
sort of equivalent to a non-NAPI ether device driver calling
netif_receive_skb() to pass each received net PDU into the network
stack.

Somewhere inside the net stack, an rtmutex is being grabbed twice.  It
doesn't appear to be my code doing it, so either I am just triggering a
bug with my use case, or my code is providing an environment/context
that the network stack doesn't like to be invoked under.

Any ideas that would help me converge on this quicker would be
appreciated, (especially those intimately familiar with all the wrapper
macros and inlines that obscure the call trace).

I think I want it to NOT try to do the __do_softirq_common,
run_timer_softirq and tcp_delack_timer part under the context of my
thread.

Notes: no change after updating to 3.0.9-rt25
       worked OK using 2.6.33.9-rt31
       powerpc 405 based embedded device
       buildroot based rootfs/distro

Regards,

Darcy

