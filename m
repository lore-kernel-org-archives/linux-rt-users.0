From: doug lkml <doug.lkml@gmail.com>
Subject: Re: Query about might_sleep()
Date: Thu, 27 Feb 2014 09:07:39 +0530
Message-ID: <CALY8T6oeYa1142DsqNw7H5E6NvgrdrzXGhcxMO5=LXR47JheMQ@mail.gmail.com>
References: <CALY8T6p-=jxix2Hr+HTHitcutzn33ETV2zFtStPkWttca5o9dA@mail.gmail.com>
	<20140226215506.246b9124@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ve0-f195.google.com ([209.85.128.195]:59037 "EHLO
	mail-ve0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbaB0Dhk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Feb 2014 22:37:40 -0500
Received: by mail-ve0-f195.google.com with SMTP id jy13so459173veb.6
        for <linux-rt-users@vger.kernel.org>; Wed, 26 Feb 2014 19:37:39 -0800 (PST)
In-Reply-To: <20140226215506.246b9124@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Steven,

> In -rt, we convert all spin_locks() into rt_mutex() which means they
> might sleep on contention. We do not convert raw_spin_locks(), they
> stay the same both in mainline and -rt.
>
> The following is OK:
>
>   rt_mutex()
>     __might_sleep()
>     some_function()
>       local_irq_save()
>       local_irq_restore()
>
> Indention show what calls what.
>
> But if you have:
>
>   local_irq_save()
>   some_function();
>     rt_mutex();
>   local_irq_restore();
>
> Now the above *is* a bug.
>
> Is that what you are asking?
>

I think I quoted my example incorrectly.

I put it across as a stack trace, rather than the way you've put it across.
Here's what I had in mind,

local_irq_save();
  some_function();
      rt_spin_lock() --> this calls __might_sleep
local_irq_restore(); --> In this case there's a bug right?


- Doug
