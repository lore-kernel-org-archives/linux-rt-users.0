From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -rt] printk: Don't emit console_cpu_notify() for
 CPU_DYING
Date: Wed, 16 Nov 2011 09:19:50 -0500
Message-ID: <1321453190.4181.21.camel@frodo>
References: <20111116094219.GA9281@zhy>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Yong Zhang <yong.zhang0@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:40317 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757829Ab1KPOTx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Nov 2011 09:19:53 -0500
In-Reply-To: <20111116094219.GA9281@zhy>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2011-11-16 at 17:42 +0800, Yong Zhang wrote:
> Otherwise we will get below warning:
> 
> BUG: sleeping function called from invalid context at /build/linux/kernel/rtmutex.c:645
> in_atomic(): 1, irqs_disabled(): 1, pid: 1054, name: migration/9
> no locks held by migration/9/1054.
> irq event stamp: 36
> hardirqs last  enabled at (35): [<ffffffff815f5b50>] _raw_spin_unlock_irq+0x30/0x70
> hardirqs last disabled at (36): [<ffffffff810b7eaf>] stop_machine_cpu_stop+0x8f/0x110
> softirqs last  enabled at (0): [<ffffffff81051b53>] copy_process+0x6d3/0x1640
> softirqs last disabled at (0): [<          (null)>]           (null)
> Pid: 1054, comm: migration/9 Not tainted 3.2.0-rc1-rt2-11312-gbf51260-dirty #12
> Call Trace:

Thomas, doesn't printk not print to serial in atomic contexts? Or did
that change?

-- Steve


