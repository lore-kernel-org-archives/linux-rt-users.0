From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: Using patch-2.6.33.7.2-rt30 increases latency and CPU usage?
Date: Thu, 10 May 2012 08:53:20 -0500
Message-ID: <20120510135320.GA9568@grante>
References: <joemui$6v0$1@dough.gmane.org>
 <joepd0$e4f$1@dough.gmane.org>
 <4FAAEBF3.10907@netacquire.com>
 <joetve$hm5$1@dough.gmane.org>
 <CANqCtQJsr6xV9aU5LbXuOOtYTvcHT6113cy0+6smKBtZAdcRGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:63742 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754122Ab2EJNx0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 10 May 2012 09:53:26 -0400
Received: by qabj40 with SMTP id j40so637420qab.1
        for <linux-rt-users@vger.kernel.org>; Thu, 10 May 2012 06:53:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANqCtQJsr6xV9aU5LbXuOOtYTvcHT6113cy0+6smKBtZAdcRGA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, May 10, 2012 at 11:46:26AM +0200, Remy Bohmer wrote:
> 2012/5/10 Grant Edwards <grant.b.edwards@gmail.com>:
>
>> Unfortunately, the requirements are a bit fuzzy -- I've got an ISR
>> deadline of about 20us that I'm trying to meet [I wouldn't mind a
>> little chat with the person who designed _that_ requirement into the
>> hardware]. =A0What I don't know is how hard that deadline is. =A0Wit=
h the
>> RT patch (and without IRQF_NODELAY), I miss the deadline most of the
>> time (I'd guess about 80% of the time).
>=20
> Given my experience with these cores and the RT patch: This 20usec is
> too close.

That's pretty much what I've decided.

> There are some places in the code that have interrupt disable section
> of about 30usec (also process ctx-switch cache flush have high
> impact)
>
> So, I expect you will not get this very robust.
>
> If the 20usec requirement is hard, you can also look at using an FIQ.

Does the normal AT91 kernel not use FIQs at all?  If so, I might be
able to dedicate the FIQ to this function and have it happen without
the Linux kernel knowing about it (or affecting it).  Any
communication between it and a normal user-task would have to be
handled carefully...

--=20
Grant
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
