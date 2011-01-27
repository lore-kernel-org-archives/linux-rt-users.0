From: Vikram Narayanan <vikram186@gmail.com>
Subject: Re: Kernel module crashed in 2.6.33.7-rt30
Date: Thu, 27 Jan 2011 14:08:35 +0530
Message-ID: <AANLkTikceiY2yZHBkHbuhUs+mvRhAfHY2hMLmaXMmy=u@mail.gmail.com>
References: <1295941160.4853.0.camel@vikram-pc> <20110125162136.GD22005@pengutronix.de>
 <AANLkTikQW6mkV_a6umKY0NnoinD-UnJQK4Gm+kxuKfCa@mail.gmail.com>
 <20110127075904.GJ1147@pengutronix.de> <AANLkTinW4koreUTXS_ieXb9wGVUKhebTgLvkfEMP4O6y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-rt-users@vger.kernel.org
To: Pradyumna Sampath <pradysam@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49044 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963Ab1A0IjH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 27 Jan 2011 03:39:07 -0500
Received: by fxm20 with SMTP id 20so1874283fxm.19
        for <linux-rt-users@vger.kernel.org>; Thu, 27 Jan 2011 00:39:05 -0800 (PST)
In-Reply-To: <AANLkTinW4koreUTXS_ieXb9wGVUKhebTgLvkfEMP4O6y@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I was using a older version of RT patch. After going through the
thread that you mentioned I moved to the latest one. But still the
crash happens for me.
Also I don't have iptables running in my system.
And another thing is that, my kernel module always stops when it is
trying to acquire a spinlock (spin_lock_irqsave) which is shared with
code in the ISR. Is there any way to see the information about the
lock, like who is holding the lock??

Does this give some insight into my actual problem?

Thanks
Vikram


2011/1/27 Pradyumna Sampath <pradysam@gmail.com>
>
> Hi,
>
> 2011/1/27 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> > [readded linux-rt-users to recipients]
> >
> > Hello,
> >
> > On Thu, Jan 27, 2011 at 01:23:47PM +0530, Vikram Narayanan wrote:
> >> I have checked my config. DEBUG_BUGVERBOSE is already enabled. Any=
 other
> >> ideas on how to debug this?
> >> Can you give an overview of why this happens?
> > sorry, I don't have much clue about x86.
> <snip ...>
>
> Im remember that at sometime there was a similar thread on LKML
> regarding a bug with RT together with nf/iptables. But I presume that
> was fixed.
>
> You could lkml archives for that thread or try disabling iptables.
>
> best regards
> /prady
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
