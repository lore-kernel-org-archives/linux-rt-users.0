From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 3.10-rt] tick-sched: fix inadvertent enabling of
 interrupts
Date: Mon, 16 Feb 2015 17:51:16 +0100
Message-ID: <20150216165116.GF21649@linutronix.de>
References: <1400263823-59227-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38843 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163AbbBPQvT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Feb 2015 11:51:19 -0500
Content-Disposition: inline
In-Reply-To: <1400263823-59227-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Paul Gortmaker | 2014-05-16 14:10:23 [-0400]:

>which is just a sanity check to ensure irqs are disabled in
>run_posix_cpu_timers().  The debug lock splat is more informative
>since it points right at tick_check_oneshot_change as the culprit
>who re-enabled interrupts [which in turn has called the
>tick_nohz_switch_to_nohz before returning].
>
>This isn't a problem on mainline, since there, the call path is
>clearly limited to softirq context as follows:
>
>    run_timer_softirq
>     --> hrtimer_run_pending
>          --> tick_check_oneshot_change
>               --> tick_nohz_switch_to_nohz
>
>On rt, there is also only one call path, and since we know irqs
>are off for it, we can delete the local_irq ops vs making them
>the save/restore variants.  Insert a BUG_ON, since as above
>we'll bug anyway later on if we screw this up.  And fix up
>the comments to match the way -rt does things.

I reverted one patch in v3.18 release and we are back to this path
softirq path on -RT as well. I got to think how to proceed in future.
Maybe I keep that nohz / highres check as is since it.
However I tried to boot the way you said in KVM and I did not trigger
the splat.

>Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Sebastian
