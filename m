From: Wolfgang Wallner <Wolfgang.Wallner@br-automation.com>
Subject: Re: Question regarding 'sched: RT throttling activated'
Date: Tue, 11 Sep 2012 17:34:12 +0200
Message-ID: <OF6683632B.9200AAEB-ONC1257A76.0053E7B9-C1257A76.00558786@br-automation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: John Kacur <jkacur@redhat.com>,
	Josef Baumgartner <Josef.Baumgartner@br-automation.com>,
	Mike Galbraith <efault@gmx.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail2.br-automation.com ([213.33.116.61]:62123 "EHLO
	mail2.br-automation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757408Ab2IKPeP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Sep 2012 11:34:15 -0400
In-Reply-To: 
References: 
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

thanks for your feedback.

>> The line with "sched: RT throttling activated" is the one I'm interested in.
>> I don't know what it means, and searching for this term did not turn up much.

> What kind of a search? A grep of "RT\ throttling" would have found it.

Sorry, I was not aware of this (I'm not used to working with kernel sources), I did a web search for "sched: RT throttling activated".
I will consider greping the kernel sources next time (to be clear: you did mean a grep in the kernel sources?).

> Likely realtime task went gaga.  Kernel or userspace doesn't matter.

>> My questions are now:
>> 
>> * What does this logging entry mean?
>>    Could you please point me to some information about RT throttling
>> so that I can understand what's it about?

> With stock settings, it means realtime task[s] consumed > 95% of the
> throttle interval (1s), so the throttle activated, allowing SCHED_NORMAL
> tasks to have a sip of CPU, to let you try to save the box from nutty RT
> CPU hogs.  See kernel/sched_rt.c.

I think if the application turns into a cpu hog, this would be visible in a sched_switch ftrace.
Thus, I added the line tracing_off(); in kernel/sched_rt.c at the place where the "sched: RT throttling activated" string is printed and recompiled my kernel. I will let the sched_switch tracing run togheter with my application until tomorrow and hopefully see in the trace what's wrong.

I did not change the default throttling settings. Thus, the error should be visible in the resulting trace about 0.95 seconds before the end of the trace.

Is this approach reasonable? Any other suggestions? 

> BTW, there have been a few throttle fixes since then that you'll likely
> want to backport.  I don't have a list handy, but they're easy to find
> with git.

Thanks for the tip, I will have a look at it.
Will it be enough to watch out for changes in sched_rt.c or is throttling also handled elsewhere?

regards, Wolfgang


-----linux-rt-users-owner@vger.kernel.org schrieb: ----- 
An: John Kacur <jkacur@redhat.com>
Von: Mike Galbraith 
Gesendet von: linux-rt-users-owner@vger.kernel.org
Datum: 11.09.2012 15:20
Kopie: Wolfgang Wallner <Wolfgang.Wallner@br-automation.com>, linux-rt-users@vger.kernel.org, Josef Baumgartner <Josef.Baumgartner@br-automation.com>
Betreff: Re: Question regarding 'sched: RT throttling activated'


On Tue, 2012-09-11 at 14:10 +0200, John Kacur wrote:
> 
> On Tue, 11 Sep 2012, Wolfgang Wallner wrote:
> 
> > Hello all,
> > 
> > I have a few questions about the logging entry "sched: RT throttling
> activated" which I observe, and hope this is the correct place to
> ask :)
> > I will start by describing how i come to see this logging entry:
> > 
> > I use an industrial PC with an 2.6.33 RT PREEMP kernel...

BTW, there have been a few throttle fixes since then that you'll likely
want to backport.  I don't have a list handy, but they're easy to find
with git.

-Mike

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html