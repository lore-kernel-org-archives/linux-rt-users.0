From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: X86 Pentium M platform troubles at low temperatures
Date: Tue, 29 Jan 2008 16:04:59 -0800
Message-ID: <1201651499.6344.58.camel@sven.thebigcorporation.com>
References: <ed6c89dc0801251636i13a020e4s68a14b969003568f@mail.gmail.com>
	 <ed6c89dc0801291440l52cabd37w6c85dc5d0b50af29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Jim Beck <4805455@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:23602 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbYA3AFV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Jan 2008 19:05:21 -0500
Received: by rv-out-0910.google.com with SMTP id k20so18200rvb.1
        for <linux-rt-users@vger.kernel.org>; Tue, 29 Jan 2008 16:05:20 -0800 (PST)
In-Reply-To: <ed6c89dc0801291440l52cabd37w6c85dc5d0b50af29@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Tue, 2008-01-29 at 14:40 -0800, Jim Beck wrote:
> Update: the RT patch seems to be irrelevant.  Something that changed
> between 2.6.18 from Suse 10.2 and the vanilla 2.6.24 (not RT patched)
> causes 2.6.24 to fail to boot at cold temperatures.  THis is very
> strange.  It does work at normal temperatures, and Suse 10.2 works
> even at the cold temperatures.  I suppose this is now no longer and
> appropriate subject for RT users.  I will post future replies to the
> normal kernel mailing list.

It sounds like you MAY be hitting some king of race condition 
- AND - 
I would recommend duplicating the problem on another piece of similar
hardware at the same temps first, and there can be all kinds of possible
interactions not related to software causing this behavior:

You may just have cheap components, that flake as the system warms
rapidly from -10 C.

There are nice ovens where you can rapidly cycle the temp, or just stick
the thing in the freezer and put it out in the sunshine a couple of
cycles and see if you can't get it to flake with 10.2 also.

Sven

> 
> On Jan 25, 2008 4:36 PM, Jim Beck <4805455@gmail.com> wrote:
> > This may sound strange, but we have a Pentium M system running
> > 2.6.20-rt5 that fails to boot all the way (fails at spawning mingetty
> > - then various strange behaviors) when the system is at -10 degrees C
> > or less.  Oddly, it works fine if we used *unpatched* Linux.  My only
> > guess can be that there is some hard-coded constants with regards to
> > timers or clocks that somehow comes into play because of  some
> > oscillator frequency change.  I was wondering if any of the authors
> > can comment on any magic numbers or such that might be related to
> > this.
> >
> > Of course I will let you know if I discover that I am crazy in the
> > next few days.  I just wanted to run this by you to see if anyone else
> > had experience with this.
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
