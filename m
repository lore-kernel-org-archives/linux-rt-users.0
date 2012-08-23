From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: linux rt 3.4.8-rt16 and nv 302.17, and system freezes, does nvidia strike again?
Date: Thu, 23 Aug 2012 02:26:52 -0700
Message-ID: <E6340573-E735-4322-9D05-1F5CC33E039A@thebigcorporation.com>
References: <CAOLSsAw3QG40xSokZ8spMa1_J81n2L9fb2g68jEo-r0iCMP8gA@mail.gmail.com> <1345264436.8439.15.camel@marge.simpson.net> <20120818070110.GA26476@dlc-dt.home> <CAOLSsAwG-KNdOwWxGSQmRA8mrA+mTvCgDLS4oneYOsguk8mzDQ@mail.gmail.com> <20120818110637.GA30911@dlc-dt.home> <CAOLSsAx3z9CY1Y8H6TqfFMJ49OS0E2XrE6LXKp5MZn-JF-86uw@mail.gmail.com>
Mime-Version: 1.0 (iPhone Mail 8C148)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "David L. Craig" <dlc@radix.net>, Javier Sanz <jsanza@gmail.com>,
	MikeGalbraith <efault@gmx.de>,
	RT <linux-rt-users@vger.kernel.org>
To: Javier Sanz <jsanza@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35295 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757160Ab2HWJ1I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 23 Aug 2012 05:27:08 -0400
Received: by pbbrr13 with SMTP id rr13so1072877pbb.19
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Aug 2012 02:27:07 -0700 (PDT)
In-Reply-To: <CAOLSsAx3z9CY1Y8H6TqfFMJ49OS0E2XrE6LXKp5MZn-JF-86uw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Can you use a product other than NVidia?

It's a free market:

Use what works, reject what doesn't.

Sven-Thorsten Dietrich 
415 4804180

On Aug 23, 2012, at 1:47, Javier Sanz <jsanza@gmail.com> wrote:

> Hello,
> 
> I can understand that there are many problems, nvidia drivers, rt
> kernel, and no collaboration between those involved, thereby
> ultimately harms the opensource community, etc., And in my case, the
> main thing is that I have no knowledge to fix them, or help to be
> corrected, for now all I can ask for help and hope someone help me.
> 
> For example, how I can see where the problem occurs? because there is
> no trace in the files of nvidia, the dmesg, nowhere ...
> how can i get a document to help people to find theses problems? which
> files affected, boots modes, etc ...  show to people that there are a
> way to damm nvidia drivers ...
> 
> You say that there is a message,
> [6.993495] Disabling lock debugging due to kernel taint
> 
> how do you get it ? have you sent this information any nvidia  forums?
> no answer?  how can we fix it ?
> 
> Yesterday, testing with kernel 3.4.9-rt17 with nvidia 304.37 drivers
> ... nvidia gt 240 ...  all blocked .. i am at same point ...
> 
> So, what is the next step? mails? forums?
> 
> What do you suggest?
> 
> TX
> 
> 
> 2012/8/18 David L. Craig <dlc.usa@gmail.com>:
>> On 12Aug18:1152+0200, Javier Sanz wrote:
>> 
>>> Yes, i got the same problem, black screen, no mouse, no keyboard ...
>>> i didnt  change any config file from X or nvidia ... only rt patch
>>> applied  ...  :(
>>> I'll try with nvidia 304.37 ... no patch required ? ... i'll test ...
>>> 
>>> thank you
>> 
>> Just to be sure you didn't misunderstand the situation,
>> I do not have any rt kernel working with nvidia
>> except the Linux Mint Debian XFCE 13 distribution.
>> Debian considers this an important bug but nVidia's
>> assessment is unknown to date.
>> 
>> Perhaps another rt-kernel lister can offer a quality
>> suggestion about a likely fruitful approach to finding
>> people able and willing to dig into what the kern.log
>> shows is going on and direct further resolution
>> activities.  Such people are probably rt-kernel and/or
>> nVidia developers.  I could probably do it myself after
>> three months of nothing but working on it (including
>> in my sleep ;-) ).  I'd hazard a guess the following
>> has a lot to do with the problem:
>> 
>> [    6.993495] Disabling lock debugging due to kernel taint
>> 
>> I don't know what the long-term outlook for nVidia market
>> share in the FLOSS area is.  I saw hardware acceleration
>> is apparently required for GNOME Unity.  That's good for
>> the hardware vendors, I suppose, but problematic for folks
>> who take the L in FLOSS very seriously.  I think we all
>> wish the vendors would choose to make these problems go
>> away by distributing their source.  As RMS says, they
>> won't if they don't have to, so we shouldn't be pragmatic,
>> just say no thank you.  Can I live without FlightGear?
>> Why should I have to, nVidia (BTW, I was given your
>> hardware--I wouldn't buy it)?  If the gamers really are
>> becoming Windows 8 refugees, I guess there's hope for the
>> future.  But if the governments start locking up systems
>> programming, doling out practioner licenses, and making
>> libre software illegal, then not.
>> 
>> But to hopefully get back on topic, I have the impression
>> I NEED the rt kernel because FG frame updates get
>> behind without it.  I've heard JACK audio works well
>> enough without rt these days (but I don't believe it
>> yet--soon enough I will be able to prove it to myself,
>> unless I get a job).
>> --
>> May the LORD God bless you exceedingly abundantly!
>> 
>> Dave_Craig______________________________________________
>> "So the universe is not quite as you thought it was.
>> You'd better rearrange your beliefs, then.
>> Because you certainly can't rearrange the universe."
>> __--from_Nightfall_by_Asimov/Silverberg_________________
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
