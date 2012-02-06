From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: infinite spin in RT when booting with DHCP on
Date: Mon, 06 Feb 2012 08:27:53 -0500
Message-ID: <1328534873.5882.227.camel@gandalf.stny.rr.com>
References: <4F292FE0.7090302@digi.com>
			 <201202021338.44950.tim.sander@hbm.com>
			 <20120202201336.GF25594@pengutronix.de> <4F2BB59C.4080206@digi.com>
			 <20120203103520.GI25594@pengutronix.de> <4F2C07EE.10408@digi.com>
		 <1328287427.5882.159.camel@gandalf.stny.rr.com>
	 <4F2C1885.8030301@digi.com> <1328290789.5882.166.camel@gandalf.stny.rr.com>
	 <4F2F9478.10809@digi.com>
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
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:55769 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755110Ab2BFN1z (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Feb 2012 08:27:55 -0500
In-Reply-To: <4F2F9478.10809@digi.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2012-02-06 at 09:51 +0100, Hector Palacios wrote:
> On 02/03/2012 06:39 PM, Steven Rostedt wrote:
> > Note that you see that this causes a hang in the system if ksoftirqd is
> > a real time task.
> 
> This is true.
> 
> > Not to mention, that ksoftirqd spins in an infinite
> > loop if the cable isn't connected (regardless of ksoftirqd's priority).
> 
> This is not true. The infinite loop is only hit when ksoftirqd is a real time task. I 
> think you got confused by the different patches we tried. That dirty hack of yours 
> with the workqueue was the one hanging with the cable disconnected. ;o)
> 

I didn't say it was going to hang the box, I said it was going to spin.

With the cable disconnected, did you run top to see if ksoftirqd was
running at near 100%?  It wont lock up the box because ksoftirqd is not
a real time task in mainline.

-- Steve


