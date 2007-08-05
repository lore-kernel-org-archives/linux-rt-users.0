From: Steven Rostedt <rostedt@goodmis.org>
Subject: [BUG  RT] - rcupreempt.c:133 on 2.6.23-rc1-rt7
Date: Sun, 05 Aug 2007 00:51:24 -0400
Message-ID: <1186289484.636.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:39058 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbXHEEvi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Aug 2007 00:51:38 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Why is it, that every time I go to write examples for my chapter in a
book, that I hit a bug!

I got this on bootup of my Thinkpad G41 running SMP.

Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
WARNING: at kernel/rcupreempt.c:133 __rcu_read_lock()
 [<c010557a>] show_trace_log_lvl+0x35/0x54
 [<c01061bd>] show_trace+0x2c/0x2e
 [<c01061e8>] dump_stack+0x29/0x2b
 [<c01660d9>] __rcu_read_lock+0x13f/0x14e
 [<c02f61fd>] ip_local_deliver+0x73/0x2b6
 [<c02f5e74>] ip_rcv+0x2d8/0x5ee
 [<c02d4324>] netif_receive_skb+0x2b7/0x3fc
 [<c02d68b4>] process_backlog+0xb0/0x148
 [<c02d6b6a>] net_rx_action+0xe0/0x1dd
 [<c01311a8>] ksoftirqd+0x126/0x240
 [<c013f9d2>] kthread+0x44/0x69
 [<c0105147>] kernel_thread_helper+0x7/0x10
 =======================


I don't have time to look further now, and it's something that isn't
easily reproducible (Well, it happened once out of two boots). If you
need me to look further, or need a config or dmesg (I have both), then
just give me a holler.

-- Steve
