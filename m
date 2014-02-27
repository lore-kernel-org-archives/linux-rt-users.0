From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Query about might_sleep()
Date: Wed, 26 Feb 2014 22:50:18 -0500
Message-ID: <20140226225018.47eec511@gandalf.local.home>
References: <CALY8T6p-=jxix2Hr+HTHitcutzn33ETV2zFtStPkWttca5o9dA@mail.gmail.com>
	<20140226215506.246b9124@gandalf.local.home>
	<CALY8T6oeYa1142DsqNw7H5E6NvgrdrzXGhcxMO5=LXR47JheMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: doug lkml <doug.lkml@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.230]:8399 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754058AbaB0DuU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Feb 2014 22:50:20 -0500
In-Reply-To: <CALY8T6oeYa1142DsqNw7H5E6NvgrdrzXGhcxMO5=LXR47JheMQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 27 Feb 2014 09:07:39 +0530
doug lkml <doug.lkml@gmail.com> wrote:

> I put it across as a stack trace, rather than the way you've put it across.
> Here's what I had in mind,
> 
> local_irq_save();
>   some_function();
>       rt_spin_lock() --> this calls __might_sleep
> local_irq_restore(); --> In this case there's a bug right?

Yes, that's a bug. And that's why you'll see a lot of updates in the
-rt patch with things like: local_irq_save_nort(). And this is also the
cause of some of the #ifdef CONFIG_PREEMPT_RT_FULL. And what makes this
change so challenging ;-)

-- Steve
