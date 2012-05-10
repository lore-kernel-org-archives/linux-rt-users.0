From: Remy Bohmer <linux@bohmer.net>
Subject: Re: Using patch-2.6.33.7.2-rt30 increases latency and CPU usage?
Date: Thu, 10 May 2012 11:46:26 +0200
Message-ID: <CANqCtQJsr6xV9aU5LbXuOOtYTvcHT6113cy0+6smKBtZAdcRGA@mail.gmail.com>
References: <joemui$6v0$1@dough.gmane.org>
	<joepd0$e4f$1@dough.gmane.org>
	<4FAAEBF3.10907@netacquire.com>
	<joetve$hm5$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42424 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758342Ab2EJJq2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 10 May 2012 05:46:28 -0400
Received: by bkcji2 with SMTP id ji2so1079873bkc.19
        for <linux-rt-users@vger.kernel.org>; Thu, 10 May 2012 02:46:27 -0700 (PDT)
In-Reply-To: <joetve$hm5$1@dough.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

2012/5/10 Grant Edwards <grant.b.edwards@gmail.com>:
> On 2012-05-09, Joachim Achtzehnter <joachima@netacquire.com> wrote:
>> Grant Edwards wrote:
> Unfortunately, the requirements are a bit fuzzy -- I've got an ISR
> deadline of about 20us that I'm trying to meet [I wouldn't mind a
> little chat with the person who designed _that_ requirement into the
> hardware]. =A0What I don't know is how hard that deadline is. =A0With=
 the
> RT patch (and without IRQF_NODELAY), I miss the deadline most of the
> time (I'd guess about 80% of the time).
>
> Without RT or with RT and IRQF_NODELAY, it looks like I meet the
> deadline maybe 98% of the time (under test conditions). =A0What I don=
't
> know is if once the deadline is missed it matters weather it's missed
> by 50us or by 250us [or if 98% is going to be anywhere close to
> acceptible, for that matter].

Given my experience with these cores and the RT patch: This 20usec is
too close. There are some places in the code that have interrupt
disable section of about 30usec (also process ctx-switch cache flush
have high impact)
So, I expect you will not get this very robust.
If the 20usec requirement is hard, you can also look at using an FIQ.

Kind regards,

Remy
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
