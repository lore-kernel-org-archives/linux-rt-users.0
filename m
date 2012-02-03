From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: infinite spin in RT when booting with DHCP on
Date: Fri, 03 Feb 2012 12:39:49 -0500
Message-ID: <1328290789.5882.166.camel@gandalf.stny.rr.com>
References: <4F292FE0.7090302@digi.com>
		 <201202021338.44950.tim.sander@hbm.com>
		 <20120202201336.GF25594@pengutronix.de> <4F2BB59C.4080206@digi.com>
		 <20120203103520.GI25594@pengutronix.de> <4F2C07EE.10408@digi.com>
	 <1328287427.5882.159.camel@gandalf.stny.rr.com> <4F2C1885.8030301@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>, Tim Sander <tim.sander@hbm.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"lclaudio@uudg.org" <lclaudio@uudg.org>,
	"efault@gmx.de" <efault@gmx.de>
To: Hector Palacios <hector.palacios@digi.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:36859 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592Ab2BCRjv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 Feb 2012 12:39:51 -0500
In-Reply-To: <4F2C1885.8030301@digi.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2012-02-03 at 18:25 +0100, Hector Palacios wrote:

> > I would definitely push this towards mainline. Can you apply it to the
> > -rt patch too. I bet you it fixes it there too.
> 
> I forgot to say it. Yes, it fixes it in -rt as well.

Great to hear! Tim, can you test this patch out too?

> 
> > I wont add it unless it either goes into mainline, or Thomas takes it
> > into the 3.2-rt release. That's the stable-rt rule.
> 
> There doesn't seem to be a maintainer for this driver... should I take the action of 
> posting this to the mainline kernel list?

I would send a note to LKML asking why this hasn't been included in
mainline, and Cc the following:

Frank Li <Frank.Li@freescale.com>
Zeng Zhaoming <b32542@freescale.com>
David S. Miller <davem@davemloft.net>

And perhaps:

Shawn Guo <shawn.guo@linaro.org>
Xiao Jiang <jgq516@gmail.com>

As they have done some work on the fec driver recently.

You can also Cc myself, Thomas, Tim and Uwe.

Note that you see that this causes a hang in the system if ksoftirqd is
a real time task. Not to mention, that ksoftirqd spins in an infinite
loop if the cable isn't connected (regardless of ksoftirqd's priority).

-- Steve


