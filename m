From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: version 0.37 of rt-tests available
Date: Thu, 30 Apr 2009 10:30:07 +0900
Message-ID: <49b7c2350904291830u79c827e6od323164fc19725e6@mail.gmail.com>
References: <20090429155011.09e2218f@torg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gx0-f166.google.com ([209.85.217.166]:40781 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbZD3BaI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 29 Apr 2009 21:30:08 -0400
Received: by gxk10 with SMTP id 10so3234965gxk.13
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Apr 2009 18:30:07 -0700 (PDT)
In-Reply-To: <20090429155011.09e2218f@torg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thank you for thinking about needs of the frace options using cyclictest.

As you said, I think that most rt developers will need ftrace utility based on
command line for tuning internal kernel latencies in their complicated
realtime system.

Maybe, If cyclictest is written by contribution of many developers successfully,
Most peoples will use this cyclictest utility generally.
In special, Interested developers will make gui based
cyclictest(ex:gcyclictest) utility
additionally like gmplayer based on mplayer and tsclient based on rdesktop.

So, I agree with your opinion absoultely.

And, Clark Williams. Is a below remark right?
This year is 2009 as you know.
How about you modify  date info from "(C) 2008-2008 " to "(C) 2008-2009".
(Just my thinking...)

I am happy because you append your name in cyclictest source code.
In gerneal, When some developers want to send their patches and
opinion, They often
find author and maintainer from source code like me.

< cyclictest source file>
 * High resolution timer test software *
 * (C) 2008-2008 Clark Williams <williams@redhat.com>
 * (C) 2005-2007 Thomas Gleixner <tglx@linutronix.de>



2009/4/30 Clark Williams <williams@redhat.com>:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
>
> I've pushed 0.37 of the rt-tests up to my git repo at:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git
>
> tarballs available at:
>
> http://www.kernel.org/pub/linux/kernel/people/clrkwllms/rt-tests/
>
> This version has a couple of fixes from GeunSik Lim
> <geunsik.lim@samsung.com> (man page fixes and two new options for
> wakeup and wakeup_rt tracing).
>
> After seeing that we have a never-ending stream of ftrace tracing
> functions and options available to us, I decided that we need a better
> way to specify the tracers. So I added the --tracer option (which
> accepts the name of a tracing function) and the --traceopt option
> (which accepts tracing options), e.g.:
>
> $ cyclictest -b 500 --tracer=events --traceopts=noraw --traceopts=nohex
>
> I guess I could make traceopts take a comma separated list, but for now
> it was just easier to allow multiple invocations on a command line.
>
> I've left the other tracing options alone for now, since I'm sure people
> have scripts that use them. I wouldn't mind getting rid of them in the
> future though.
>
> Clark
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.10 (GNU/Linux)
>
> iEYEARECAAYFAkn4vYoACgkQHyuj/+TTEp0eRgCgyJy7jg4o7qEGxqlwCoZRqwBq
> Ct4An129sVkC7Md6fokUDpW8QOw03PPR
> =HPJj
> -----END PGP SIGNATURE-----
>



-- 
Regards,
GeunSik Lim
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
