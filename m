From: Till Straumann <strauman@slac.stanford.edu>
Subject: Re: How to unblock a thread from  a hard isr (IRQF_NO_THREAD)
Date: Thu, 08 Nov 2012 22:28:53 -0600
Message-ID: <509C8685.3000704@slac.stanford.edu>
References: <509C3220.2050601@slac.stanford.edu> <20121109040810.GD1718@beefymiracle.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Josh Cartwright <josh.cartwright@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from quarantine.alumni.tu-berlin.de ([130.149.4.13]:52965 "EHLO
	mailbox.alumni.tu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751454Ab2KIE25 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 8 Nov 2012 23:28:57 -0500
In-Reply-To: <20121109040810.GD1718@beefymiracle.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thanks, that's helpful.

Wouldn't it also be possible to make my own version of
prepare_to_wait()/finish_wait()/wake_up() etc. which internally
use a raw spinlock instead of a normal one?

- Till

On 11/08/2012 10:08 PM, Josh Cartwright wrote:
> On Thu, Nov 08, 2012 at 04:28:48PM -0600, Till Straumann wrote:
>> Hello list.
>>
>> I have a driver which is designed to do most work in user-space.
>> The ISR is really simple. It just ACKs/clears the interrupt and
>> then should unblock a waiting thread.
>> It seems overkill (and costs me about 5-10us) to use a threaded
>> interrupt in such a case (hard isr unblocks a kthread whose only
>> 'work' is unblocking another (user) thread).
>>
>> I have found some references where users try to do a similar
>> thing via UIO
>> (e.g.,
>> http://article.gmane.org/gmane.linux.rt.user/7372/
>> http://article.gmane.org/gmane.linux.rt.user/7676)
>>
>> However, the succinct answer was along the line 'that can't work with UIO'.
>>
>> IMHO it would be very helpful to get a more detailed explanation
>> as to why it doesn't work (i.e., what things you are and are not
>> allowed to do from a hard-isr under RT_PREEMPT). I suspect it is
>> because UIO calls routines such as 'kill_fasync' which use
>> ordinary (as opposed to raw) spinlocks which means that the
>> caller could be preempted (under RT_PREEMPT), right?
> Correct.  Not just kill_fasync(), but the use of
> wake_up_interruptible() as well (and maybe others).
>
>> What *is* the recommended mechanism to wake up a thread from
>> a hard-isr?
> I'd suggest you look at the hrtimer_sleeper code for an example of
> process wakeup done in hardirq context.  (hint, the low-level answer to
> your question is wake_up_process()).
>
>     Josh

