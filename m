From: doug lkml <doug.lkml@gmail.com>
Subject: Re: Query about might_sleep()
Date: Thu, 27 Feb 2014 09:48:45 +0530
Message-ID: <CALY8T6raZsuChYC1OUV36OYw6fDASLO5rQWTLJy59oOu+9M+DA@mail.gmail.com>
References: <CALY8T6p-=jxix2Hr+HTHitcutzn33ETV2zFtStPkWttca5o9dA@mail.gmail.com>
	<20140226215506.246b9124@gandalf.local.home>
	<CALY8T6oeYa1142DsqNw7H5E6NvgrdrzXGhcxMO5=LXR47JheMQ@mail.gmail.com>
	<20140226225018.47eec511@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ve0-f196.google.com ([209.85.128.196]:55777 "EHLO
	mail-ve0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754712AbaB0ESq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Feb 2014 23:18:46 -0500
Received: by mail-ve0-f196.google.com with SMTP id jw12so886674veb.11
        for <linux-rt-users@vger.kernel.org>; Wed, 26 Feb 2014 20:18:46 -0800 (PST)
In-Reply-To: <20140226225018.47eec511@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>>
>> local_irq_save();
>>   some_function();
>>       rt_spin_lock() --> this calls __might_sleep
>> local_irq_restore(); --> In this case there's a bug right?
>
> Yes, that's a bug. And that's why you'll see a lot of updates in the
> -rt patch with things like: local_irq_save_nort(). And this is also the
> cause of some of the #ifdef CONFIG_PREEMPT_RT_FULL. And what makes this
> change so challenging ;-)

That clarifies my question. Thanks.
