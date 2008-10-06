From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: PF_HARDIRQ used in preempt-realtime-core.patch
Date: Mon, 06 Oct 2008 17:11:53 -0400
Message-ID: <48EA7F19.90908@windriver.com>
References: <20081006194928.GA14183@windriver.com> <1223324413.17348.47.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, rostedt@goodmis.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:59256 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761AbYJFVMM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Oct 2008 17:12:12 -0400
In-Reply-To: <1223324413.17348.47.camel@sven.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sven-Thorsten Dietrich wrote:
> On Mon, 2008-10-06 at 15:49 -0400, Paul Gortmaker wrote:
>   
>> I noticed that preempt-realtime-core.patch does this to hardirq.h:
>>
>> -#define in_irq()               (hardirq_count())
>> -#define in_softirq()           (softirq_count())
>> -#define in_interrupt()         (irq_count())
>> +#define in_irq()       (hardirq_count() || (current->flags & PF_HARDIRQ))
>> +#define in_softirq()   (softirq_count() || (current->flags & PF_SOFTIRQ))
>> +#define in_interrupt() (irq_count())
>>
>> I was thinking that in order to have better patch bisection for future
>> hard/softirq segmentation, that this chunk would be better suited to
>> live in preempt-irqs-core.patch (where PF_HARDIRQ is introduced).
>>
>> That would reduce the preempt-realtime-core.patch for hardirq.h to just
>> one line, if we drop the whitespace shuffling in there at the same time.
>>
>> I can send diffs of the existing 26rt9 patches, but I'm not sure how useful
>> folks would find diffs of diffs (if any at all.).  Since it doesn't
>> impact the actual code base of the resulting patched tree, the other
>> option is to just ignore it for 26 but keep it in mind for the future.
>>
>>     
>
> Hi Paul,
>
> at the risk of speaking out of turn here, I know that there is a history
> of cleanup attempts, that have not succeeded.
>   

Yes,  I've seen some of that history and have no interest in repeating
it.  From the beginning I was trying to determine what would be the
most use to folks, and trying to avoid anything that I thought could be
in any way antagonistic to the folks doing the real work on RT.

> That being said, it might be in the best interest of avoiding wasted
> effort, or additional frustration, to keep cleanups as separate patches,
> at least until we have some kind of response from Steven or Thomas.
>   

I agree completely, and hence that was my original underlying goal with the
carry forward -- to bring the patches forward in a form that kept them as
close to the originals as possible.   Any new patches that I had to add in
order to get things to compile/boot I've kept as tail patches on the end,
and I'll continue to keep them there.

I just wanted to give a heads up on this as I happened to notice it while
reading over the patches, and since threaded IRQ support is a recent
area of interest.   I'd feel guilty seeing it, but then just saying nothing.

If a 26rt10 appears with a change like this in it, then I'll make the same
change in the carry forward patches I've done.  Otherwise I'll leave things
located exactly where they are in the carry forward series.

Thanks for the feedback, it helps me to know that I wasn't completely
off base with my original thoughts of how to do something that might
be useful in the end.

Paul.
