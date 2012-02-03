From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: infinite spin in RT when booting with DHCP on
Date: Fri, 03 Feb 2012 11:43:47 -0500
Message-ID: <1328287427.5882.159.camel@gandalf.stny.rr.com>
References: <4F292FE0.7090302@digi.com>
	 <201202021338.44950.tim.sander@hbm.com>
	 <20120202201336.GF25594@pengutronix.de> <4F2BB59C.4080206@digi.com>
	 <20120203103520.GI25594@pengutronix.de> <4F2C07EE.10408@digi.com>
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
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:50261 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757061Ab2BCQnt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 Feb 2012 11:43:49 -0500
In-Reply-To: <4F2C07EE.10408@digi.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2012-02-03 at 17:14 +0100, Hector Palacios wrote:

> This commit was not merged to mainline kernel. So I tried again with 2.6.35.14 with 
> Freescale's BSP and Uwe's patch and reverted commit bac5b435 for verification. The 
> problem was reproducible so the above patch solves it.
> Do you see any caveat with this commit? If not maybe it should make its way to mainline.

I would definitely push this towards mainline. Can you apply it to the
-rt patch too. I bet you it fixes it there too.

I wont add it unless it either goes into mainline, or Thomas takes it
into the 3.2-rt release. That's the stable-rt rule.

-- Steve


