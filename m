From: Hector Palacios <hector.palacios@digi.com>
Subject: Re: infinite spin in RT when booting with DHCP on
Date: Fri, 3 Feb 2012 18:25:25 +0100
Message-ID: <4F2C1885.8030301@digi.com>
References: <4F292FE0.7090302@digi.com>	 <201202021338.44950.tim.sander@hbm.com>	 <20120202201336.GF25594@pengutronix.de> <4F2BB59C.4080206@digi.com>	 <20120203103520.GI25594@pengutronix.de> <4F2C07EE.10408@digi.com> <1328287427.5882.159.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>, Tim Sander <tim.sander@hbm.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"lclaudio@uudg.org" <lclaudio@uudg.org>,
	"efault@gmx.de" <efault@gmx.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail45.messagelabs.com ([216.82.241.132]:30967 "EHLO
	mail45.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753596Ab2BCRZa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 Feb 2012 12:25:30 -0500
In-Reply-To: <1328287427.5882.159.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 02/03/2012 05:43 PM, Steven Rostedt wrote:
> On Fri, 2012-02-03 at 17:14 +0100, Hector Palacios wrote:
>
>> This commit was not merged to mainline kernel. So I tried again with=
 2.6.35.14 with
>> Freescale's BSP and Uwe's patch and reverted commit bac5b435 for ver=
ification. The
>> problem was reproducible so the above patch solves it.
>> Do you see any caveat with this commit? If not maybe it should make =
its way to mainline.
>
> I would definitely push this towards mainline. Can you apply it to th=
e
> -rt patch too. I bet you it fixes it there too.

I forgot to say it. Yes, it fixes it in -rt as well.

> I wont add it unless it either goes into mainline, or Thomas takes it
> into the 3.2-rt release. That's the stable-rt rule.

There doesn't seem to be a maintainer for this driver... should I take =
the action of=20
posting this to the mainline kernel list?

Thank you for the help, gentlemen.
--=20
H=E9ctor Palacios
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
