From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 3.18] ring-buffer: Mark irq_work as HARD_IRQ to prevent
 deadlocks
Date: Thu, 16 Apr 2015 17:33:23 +0200
Message-ID: <552FD643.8070408@linutronix.de>
References: <552FC1FE.4020406@siemens.com>	<552FC6B1.1040000@linutronix.de>	<552FC72A.8060709@siemens.com> <20150416111041.66043164@gandalf.local.home> <552FD55F.8000105@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44490 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbbDPPd0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 16 Apr 2015 11:33:26 -0400
In-Reply-To: <552FD55F.8000105@siemens.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 04/16/2015 05:29 PM, Jan Kiszka wrote:
> My patch is definitely not OK. It causes
> 
> [  380.372579] BUG: scheduling while atomic: trace-cmd/2149/0x00010004
> ...
> [  380.372604] Call Trace:
> [  380.372610]  <IRQ>  [<ffffffff81607694>] dump_stack+0x50/0x9f
> [  380.372613]  [<ffffffff8160413c>] __schedule_bug+0x59/0x69
> [  380.372615]  [<ffffffff8160a1d5>] __schedule+0x675/0x800
> [  380.372617]  [<ffffffff8160a394>] schedule+0x34/0xa0
> [  380.372619]  [<ffffffff8160bf7d>] rt_spin_lock_slowlock+0xcd/0x290
> [  380.372621]  [<ffffffff8160d8b5>] rt_spin_lock+0x25/0x30
> [  380.372623]  [<ffffffff8108fe39>] __wake_up+0x29/0x60

right. you must not take any sleeping locks in the hardirq context :)
This works for the no-hz-work thingy. It grabs raw locks and may cancel
one hrtimer which is marked irqsafe.

Sebastian
