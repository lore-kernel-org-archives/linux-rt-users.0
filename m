From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 3.14.36-rt34 kernel crash on imx6
Date: Mon, 27 Apr 2015 13:54:23 -0400
Message-ID: <20150427135423.641d8a49@gandalf.local.home>
References: <552F7406.1030806@geral.com>
	<5534C848.4010809@geral.com>
	<20150423163219.3c354d19@gandalf.local.home>
	<20150424070209.GI19431@pengutronix.de>
	<553DF0C6.2060500@geral.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
	<u.kleine-koenig@pengutronix.de>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Alexandre COFFIGNAL <acoffignal@geral.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0125.hostedemail.com ([216.40.44.125]:53998 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932817AbbD0Ry0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 27 Apr 2015 13:54:26 -0400
In-Reply-To: <553DF0C6.2060500@geral.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 27 Apr 2015 10:18:14 +0200
Alexandre COFFIGNAL <acoffignal@geral.com> wrote:

> Hello,
>=20
> Le 24/04/2015 09:02, Uwe Kleine-K=C3=B6nig a =C3=A9crit :
> > Helo,
> >
> > On Thu, Apr 23, 2015 at 04:32:19PM -0400, Steven Rostedt wrote:
> >> On Mon, 20 Apr 2015 11:35:04 +0200
> >> Alexandre COFFIGNAL <acoffignal@geral.com> wrote:
> >>> we are running PREEMPT_RT 3.14.36-rt34 on a imx6 board which work=
s really fine.
> >>> But we see the following trace when we run this very simple app o=
ver ssh :
> >> I tried to see if I could reproduce this on my ARM board, but my
> >> snowball board is dead, and my beaglebone white, for some reason w=
ont
> >> boot 3.14 (vanilla or -rt).
> > Another thing to try is 3.14.36 without -rt.
> >
> > Best regards
> > Uwe
> >
> >
> Thank you for your prompt reply.
>=20
> I tried to see if I could reproduce this on 3.14.39-rt37 and 3.14.36 =
without -rt=20

OK, so this is not an -rt issue, it's mainline.


> , and both still crashes. But if I send console msg into a netcat
> pipe,  ./gtest_msg_kernel_oops | nc 192.168.44.180 1234, i don't get
> the crash message anymore.
>=20

Don't know.

-- Steve

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
