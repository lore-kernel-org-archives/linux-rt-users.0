From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Query about might_sleep()
Date: Wed, 26 Feb 2014 21:55:06 -0500
Message-ID: <20140226215506.246b9124@gandalf.local.home>
References: <CALY8T6p-=jxix2Hr+HTHitcutzn33ETV2zFtStPkWttca5o9dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: doug lkml <doug.lkml@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.228]:63012 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754482AbaB0CzI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Feb 2014 21:55:08 -0500
In-Reply-To: <CALY8T6p-=jxix2Hr+HTHitcutzn33ETV2zFtStPkWttca5o9dA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 26 Feb 2014 12:25:53 +0530
doug lkml <doug.lkml@gmail.com> wrote:

> for example
> 
>  __might_sleep
>  rt_spin_lock
> some_fucnction() --> which has a
> local_irq_save(flags)/local_irq_irqrestore(flags).
> 
> This could be a potential bug right?

Not that I see.

In -rt, we convert all spin_locks() into rt_mutex() which means they
might sleep on contention. We do not convert raw_spin_locks(), they
stay the same both in mainline and -rt.

The following is OK:

  rt_mutex()
    __might_sleep()
    some_function()
      local_irq_save()
      local_irq_restore()

Indention show what calls what.

But if you have:

  local_irq_save()
  some_function();
    rt_mutex();
  local_irq_restore();

Now the above *is* a bug.

Is that what you are asking?

-- Steve
