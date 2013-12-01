From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Re: [ANNOUNCE] 3.12.1-rt4
Date: Mon, 02 Dec 2013 02:25:16 +0400
Message-ID: <529BB74C.4000702@pavlinux.ru>
References: <20131116194633.GD11518@linutronix.de> <20131122211119.GL8698@linutronix.de>
Reply-To: pavel@pavlinux.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from imp02.mtu.ru ([62.5.255.19]:51826 "EHLO imp02.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841Ab3LAW0L (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 1 Dec 2013 17:26:11 -0500
In-Reply-To: <20131122211119.GL8698@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

------------[ cut here ]------------
WARNING: CPU: 1 PID: 10 at kernel/time/tick-sched.c:191 0xffffffff8107bac6()
NO_HZ FULL will not work with unstable sched clock
Modules linked in:
CPU: 1 PID: 10 Comm: rcuop/0 Not tainted 3.12.2-rt4 #3
Hardware name: TYAN Computer Corp. S2895/S2895, BIOS 2004Q3 11/18/2008
 0000000000000009 ffff88027fc83ea8 ffffffff81501a58 0000000000000039
 ffff88027fc83ef8 ffff88027fc83ee8 ffffffff8102f992 0000000000012700
ata3.00: configured for UDMA/100
 ffff88027fc8d580 0000000000000001 ffff880272894020 ffff88027fc0d700
Call Trace:
 <IRQ>  [<ffffffff81501a58>] 0xffffffff81501a58
 [<ffffffff8102f992>] 0xffffffff8102f992
 [<ffffffff8102fa61>] 0xffffffff8102fa61
 [<ffffffff8107bac6>] 0xffffffff8107bac6
 [<ffffffff8107c8f4>] 0xffffffff8107c8f4
 [<ffffffff8103405d>] 0xffffffff8103405d
 [<ffffffff81006fff>] 0xffffffff81006fff
 [<ffffffff815085f7>] 0xffffffff815085f7
 <EOI>  [<ffffffff81007083>] ? 0xffffffff81007083
 [<ffffffff81506865>] ? 0xffffffff81506865
 [<ffffffff81095961>] ? 0xffffffff81095961
 [<ffffffff81095860>] ? 0xffffffff81095860
 [<ffffffff8104d0dd>] 0xffffffff8104d0dd
 [<ffffffff8104d030>] ? 0xffffffff8104d030
 [<ffffffff8150763c>] 0xffffffff8150763c
 [<ffffffff8104d030>] ? 0xffffffff8104d030
---[ end trace 53ca152639ff2a59 ]---


