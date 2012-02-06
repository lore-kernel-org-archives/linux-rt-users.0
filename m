From: Hector Palacios <hector.palacios@digi.com>
Subject: Re: infinite spin in RT when booting with DHCP on
Date: Mon, 6 Feb 2012 09:51:04 +0100
Message-ID: <4F2F9478.10809@digi.com>
References: <4F292FE0.7090302@digi.com>		 <201202021338.44950.tim.sander@hbm.com>		 <20120202201336.GF25594@pengutronix.de> <4F2BB59C.4080206@digi.com>		 <20120203103520.GI25594@pengutronix.de> <4F2C07EE.10408@digi.com>	 <1328287427.5882.159.camel@gandalf.stny.rr.com> <4F2C1885.8030301@digi.com> <1328290789.5882.166.camel@gandalf.stny.rr.com>
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
Received: from mail51.messagelabs.com ([216.82.241.99]:60817 "EHLO
	mail51.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343Ab2BFJFb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Feb 2012 04:05:31 -0500
In-Reply-To: <1328290789.5882.166.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 02/03/2012 06:39 PM, Steven Rostedt wrote:
> Note that you see that this causes a hang in the system if ksoftirqd =
is
> a real time task.

This is true.

> Not to mention, that ksoftirqd spins in an infinite
> loop if the cable isn't connected (regardless of ksoftirqd's priority=
).

This is not true. The infinite loop is only hit when ksoftirqd is a rea=
l time task. I=20
think you got confused by the different patches we tried. That dirty ha=
ck of yours=20
with the workqueue was the one hanging with the cable disconnected. ;o)

Regards
--=20
H=E9ctor Palacios
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
