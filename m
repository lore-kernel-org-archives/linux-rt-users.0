From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RT] Warning from swake_up_all_locked in rt-4.4.4-rt11
Date: Mon, 14 Mar 2016 09:49:52 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1603140948560.3657@nanos>
References: <20160313225358.4eb9316a@sluggy.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Wagner <wagi@monom.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45562 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755228AbcCNIvT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Mar 2016 04:51:19 -0400
In-Reply-To: <20160313225358.4eb9316a@sluggy.hsv.redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 13 Mar 2016, Clark Williams wrote:

> I'm hitting the WARN_ON(wakes > 2) in $SUBJECT when resuming from suspend on my laptop (quad-core i7 with HT on). Looks like the warning gets hit 36 times on resume. E.g.:
> 
> Call Trace:
>  [<ffffffff813c13c0>] dump_stack+0x65/0x85
>  [<ffffffff810a7572>] warn_slowpath_common+0x82/0xd0
>  [<ffffffff810a76ca>] warn_slowpath_null+0x1a/0x20
>  [<ffffffff810ec8d8>] swake_up_all_locked+0x68/0x80
>  [<ffffffff810ecd40>] complete_all+0x30/0x50
>  [<ffffffff81506328>] device_resume_noirq+0x48/0x190
>  [<ffffffff8150648d>] async_resume_noirq+0x1d/0x50
>  [<ffffffff810ca188>] async_run_entry_fn+0x48/0x130
>  [<ffffffff810c14a9>] process_one_work+0x139/0x480
>  [<ffffffff810c1847>] worker_thread+0x57/0x490
>  [<ffffffff810c17f0>] ? process_one_work+0x480/0x480
>  [<ffffffff810c779d>] kthread+0xed/0x110
>  [<ffffffff810c76b0>] ? kthread_worker_fn+0x150/0x150
> ehci-pci 0000:00:1a.0: System wakeup disabled by ACPI
>  [<ffffffff817b0d0f>] ret_from_fork+0x3f/0x70
>  [<ffffffff810c76b0>] ? kthread_worker_fn+0x150/0x150
> ---[ end trace 0000000000000002 ]---
> 
> This trace (and a similar one with device_resume) happens on all cpus so the
> trace info is kinda jumbled up. I'll try it with WARN_ON_ONCE instead
> tomorrow.

If resume is the only case, then we can filter that out and not worry about it
at all :)

Thanks,

	tglx
