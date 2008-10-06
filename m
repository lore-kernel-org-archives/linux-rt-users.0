From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: PF_HARDIRQ used in preempt-realtime-core.patch
Date: Mon, 06 Oct 2008 13:20:13 -0700
Message-ID: <1223324413.17348.47.camel@sven.thebigcorporation.com>
References: <20081006194928.GA14183@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, rostedt@goodmis.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:31441 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbYJFUUQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Oct 2008 16:20:16 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1574532wah.21
        for <linux-rt-users@vger.kernel.org>; Mon, 06 Oct 2008 13:20:15 -0700 (PDT)
In-Reply-To: <20081006194928.GA14183@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2008-10-06 at 15:49 -0400, Paul Gortmaker wrote:
> I noticed that preempt-realtime-core.patch does this to hardirq.h:
> 
> -#define in_irq()               (hardirq_count())
> -#define in_softirq()           (softirq_count())
> -#define in_interrupt()         (irq_count())
> +#define in_irq()       (hardirq_count() || (current->flags & PF_HARDIRQ))
> +#define in_softirq()   (softirq_count() || (current->flags & PF_SOFTIRQ))
> +#define in_interrupt() (irq_count())
> 
> I was thinking that in order to have better patch bisection for future
> hard/softirq segmentation, that this chunk would be better suited to
> live in preempt-irqs-core.patch (where PF_HARDIRQ is introduced).
> 
> That would reduce the preempt-realtime-core.patch for hardirq.h to just
> one line, if we drop the whitespace shuffling in there at the same time.
> 
> I can send diffs of the existing 26rt9 patches, but I'm not sure how useful
> folks would find diffs of diffs (if any at all.).  Since it doesn't
> impact the actual code base of the resulting patched tree, the other
> option is to just ignore it for 26 but keep it in mind for the future.
> 

Hi Paul,

at the risk of speaking out of turn here, I know that there is a history
of cleanup attempts, that have not succeeded.

That being said, it might be in the best interest of avoiding wasted
effort, or additional frustration, to keep cleanups as separate patches,
at least until we have some kind of response from Steven or Thomas.

Sven


> Paul.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

