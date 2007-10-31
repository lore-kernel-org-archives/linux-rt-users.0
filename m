From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.23.1-rt5 rtc lost interrupt
Date: Wed, 31 Oct 2007 12:31:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710311229020.17607@gandalf.stny.rr.com>
References: <47289310.4000506@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Dragan Noveski <perodog@gmx.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:62402 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754100AbXJaQbF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 31 Oct 2007 12:31:05 -0400
In-Reply-To: <47289310.4000506@gmx.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



--
When I'm asked what language is my mother tongue,
I simply answer "C".

On Wed, 31 Oct 2007, Dragan Noveski wrote:

> hallo list, yesterday strange thing happened here.
> i am running 2.6.23.1-rt5, and actually it is running good, but
> yesterday partially my keyboard stopped working. usually if i press any
> key (inside of xterm) and do not release, but keep pressed, the
> letter/sign will be printed all the time again and again as long as i
> release the key.
> something like:
>
> aaaaaaaaaaaaaaaaaaaaa

What X drivers are you running (hopefully not nVidia or some other
proprietary module).

>
> but yesterday, if i was holding the key, the letter got displayed on the
> screen just one time.
> if i released and pressed again, one more time.....
> so i was not able to press only one time a key and hold to get sth like
> these:
>
> ........................
>
> than in /var/log/system i found this lines:
>
>
> Oct 30 21:22:37 murija2 kernel: rtc: lost 8 interrupts
> Oct 30 21:22:50 murija2 kernel: rtc: lost 4 interrupts
> Oct 30 21:22:50 murija2 kernel: rtc: lost 20 interrupts

Unfortunately, this gives me no clue to what went wrong. Perhaps, you have
a high priority process running somewhere that is keeping things from
running.

What type of system is this? SMP?

>
> this also appeared in dmesg.
>
> is this explained so that someone is able to understand?
> does any one has an idea what went wrong here?
>
> after a reboot the keyboard was working as usually again and the issue
> did not happened again since them.
>
> hope to get some suggestions/answers?!
>

I can't figure out much with the current info.

-- Steve
