From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.23.8-rt11, tasks freezing
Date: Wed, 21 Nov 2007 09:11:48 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0711210905530.767@gandalf.stny.rr.com>
References: <200711211250.39265.juuso.alasuutari@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Juuso Alasuutari <juuso.alasuutari@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:53419 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbXKUOLw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Nov 2007 09:11:52 -0500
In-Reply-To: <200711211250.39265.juuso.alasuutari@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


On Wed, 21 Nov 2007, Juuso Alasuutari wrote:

> Hi,
>
> I use vanilla kernels with realtime-preempt patches on a Core 2 E6600 running
> 32-bit Linux. Kernels up to 2.6.22.1-rt9 work fine, but I'm experiencing
> strange freezing of some tasks with 2.6.23.8-rt11. (Actually all 2.6.23
> rt-kernels I've so far tried hang the same way.)

Could you try 2.6.23-rc8-rt1 and see if it hangs?
If not, then try 2.6.23-rc9-rt1, if that doesn't hang then try
2.6.23-rc9-rt2.

Reason being is that we've implemented a new RCU preempt logic. -rc8-rt1
doesn't have it. -rc9-rt1 has it, and -rc9-rt2 has RCU preempt boosting.
I'd like to see if this is what is causing your problems.

>
> The system boots up nicely and seems to be running properly, until something
> tips it off and some commands begin to get "jammed". What seems to trigger it
> is accessing the hard disk, for instance doing something like `grep -r
> foo /var`. When it happens the desktop seems mostly responsive, but trying to
> run commands like `ls` will freeze the terminal. Other commands will succeed,
> for instance `ps aux` works as usual.
>
> Alt-SysRq-w shows more than one blocked pdflush task, as well as metalog and
> whatever commands have become "jammed" so far, like `ls`.
>
> I'll be happy to post more information, I just need to know what. I'd attach
> my .config here, but I can't access the computer from where I'm at the
> moment.

You can send me the .config off list. Also, if possible, the output of
dmesg, sysrq-t and your sysrq-w as well as (try this last because it
sometimes hangs the box hard) sysrq-L

Thanks,

-- Steve
