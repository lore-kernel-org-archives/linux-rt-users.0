From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Suggesting to include timerfd patch
Date: Wed, 08 Feb 2012 00:15:09 -0500
Message-ID: <1328678109.2200.116.camel@gandalf.stny.rr.com>
References: <CAFQPvXf7JS98_FH_nwHsEa0WX7H6QT8vBAJwo2Yt-r--aO6mcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sankara Muthukrishnan <sankara.m@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:35004 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846Ab2BHFPL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 8 Feb 2012 00:15:11 -0500
In-Reply-To: <CAFQPvXf7JS98_FH_nwHsEa0WX7H6QT8vBAJwo2Yt-r--aO6mcA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2012-02-07 at 22:56 -0600, Sankara Muthukrishnan wrote:
> Steven,
> 
> Could you please include the patch that Thomas suggested for the
> timerfd hangs in the email thread (link below), if Thomas is fine with
> the patch? I did verify that that patch fixed the hangs that I saw on
> a panda board (ARM Cortex A9 dual core).
> 
> http://marc.info/?l=linux-rt-users&m=132753755612168&w=2
> 

Hi Sankara,

I follow the same stable rules that the stable mainline follows. I will
not add any patch to the stable release that is not in either mainline,
or in Thomas's -rt development branch. This keeps the stable tree from
forking and getting a fix that is not upstream. A fix to stable that is
not included upstream, may be forgotten about.

If Thomas adds it, or if this patch is in mainline (which it is
obviously not, as it is -rt specific), then I will be happy to apply it.

Thanks,

-- Steve

