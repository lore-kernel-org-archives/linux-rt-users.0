From: Till Straumann <strauman@slac.stanford.edu>
Subject: Re: How to unblock a thread from  a hard isr (IRQF_NO_THREAD)
Date: Thu, 08 Nov 2012 22:50:28 -0600
Message-ID: <509C8B94.2030906@slac.stanford.edu>
References: <509C3220.2050601@slac.stanford.edu> <20121109040810.GD1718@beefymiracle.amer.corp.natinst.com> <509C8685.3000704@slac.stanford.edu> <20121109044237.GE1718@beefymiracle.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Josh Cartwright <josh.cartwright@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailbox.alumni.tu-berlin.de ([130.149.4.13]:53680 "EHLO
	mailbox.alumni.tu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752541Ab2KIEud (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 8 Nov 2012 23:50:33 -0500
In-Reply-To: <20121109044237.GE1718@beefymiracle.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/08/2012 10:42 PM, Josh Cartwright wrote:
> On Thu, Nov 08, 2012 at 10:28:53PM -0600, Till Straumann wrote:
>> Thanks, that's helpful.
>>
>> Wouldn't it also be possible to make my own version of
>> prepare_to_wait()/finish_wait()/wake_up() etc. which internally
>> use a raw spinlock instead of a normal one?
> I believe that what you described used to exist in the form of a
> 'simple' waitqueue, but I don't recall what happened to it.  Maybe
> Thomas can shed some light here.
>
> In general though, if you care about determinism, you'd want to avoid
> the use of such a mechanism unless you can somehow externally provide an
> upper bound on the number of waiters.
>
>    Josh
Of course. However, for the type of synchronization device we are talking
about here (hardirq wakes up a user-land worker) a (hardirq-safe) 
completion-like
device supporting a single waiter only would be good enough.

- Till
