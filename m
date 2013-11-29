From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [3.4-rt] backport of completion-use-simple-wait-queues.patch
Date: Fri, 29 Nov 2013 10:11:13 -0500
Message-ID: <5298AE91.6010309@windriver.com>
References: <20131128201029.GA28966@windriver.com> <20131129124931.GA31099@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	<linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:61557 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069Ab3K2PLJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Nov 2013 10:11:09 -0500
In-Reply-To: <20131129124931.GA31099@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 13-11-29 07:49 AM, Sebastian Andrzej Siewior wrote:
> * Paul Gortmaker | 2013-11-28 15:10:29 [-0500]:
> 
>> Hi Steve,
> Hi Paul,
> 
>> Someone tripped over this with usb console:
>>
>>    in_atomic(): 0, irqs_disabled(): 1, pid: 36, name: kworker/1:1
>>    Pid: 36, comm: kworker/1:1 Tainted: G           O 3.4.34-rt40_preempt-rt #1
>>    Call Trace:
>>     [<c105461e>] __might_sleep+0xce/0xf0
>>     [<c14fe24c>] rt_spin_lock+0x1c/0x40
>>     [<c1056f65>] complete+0x25/0x60
>>     [<c14fde10>] ? rt_mutex_lock+0x20/0x50
>>     [<c135e1b0>] usb_stor_blocking_completion+0x10/0x20
>>     [<c13317b7>] usb_poll_irq_flush_helper+0x67/0xf0
>>     [<c1056ad4>] ? migrate_enable+0x74/0x170
>>     [<c10427f7>] process_one_work+0x107/0x410
> 
>  git grep usb_poll_irq_flush_helper
> shows no results in 3.4.61-rt77 and 3.6.11.9-rt42. 

Ah right, my bad.  The original report was on a tree that had Jason
Wessel's polling patches applied:

https://lkml.org/lkml/2010/11/5/195

I didn't immediately clue in that they weren't mainline, and since
I wasn't able to reproduce the breakage locally, well...

Thanks for spotting that.  I guess the completion patch wouldn't hurt
to be in 3.4-rt anyway, but it is more a feature than a fix, it now seems.
[Not sure if Steve is still adding to the v3.4-rt-features branch...]

> The function seems to disable interrups and it completes a usb-storage
> request. This would works on mainline but in -RT those things run in thread
> context (usb-hcd-use-local-irq-nort.patch).
> 
> Depending on what urbs you complete via usb_poll_irq_flush_helper() you
> could deadlock if the urb-complete handler grabs a lock.

I think the sane thing here is for me to tell them to go with the
idea of disabling the usb polling for RT, just like we do for
netpoll/netconsole already in vanilla-rt.

Thanks again for the feedback,
Paul.
