From: Alexandre COFFIGNAL <acoffignal@geral.com>
Subject: Re: 3.14.36-rt34 kernel crash on imx6
Date: Mon, 27 Apr 2015 10:18:14 +0200
Message-ID: <553DF0C6.2060500@geral.com>
References: <552F7406.1030806@geral.com> <5534C848.4010809@geral.com>
 <20150423163219.3c354d19@gandalf.local.home>
 <20150424070209.GI19431@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailhost.geral.com ([37.58.166.5]:8333 "EHLO mailhost.geral.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752871AbbD0IST (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 27 Apr 2015 04:18:19 -0400
In-Reply-To: <20150424070209.GI19431@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

Le 24/04/2015 09:02, Uwe Kleine-K=F6nig a =E9crit :
> Helo,
>
> On Thu, Apr 23, 2015 at 04:32:19PM -0400, Steven Rostedt wrote:
>> On Mon, 20 Apr 2015 11:35:04 +0200
>> Alexandre COFFIGNAL <acoffignal@geral.com> wrote:
>>> we are running PREEMPT_RT 3.14.36-rt34 on a imx6 board which works =
really fine.
>>> But we see the following trace when we run this very simple app ove=
r ssh :
>> I tried to see if I could reproduce this on my ARM board, but my
>> snowball board is dead, and my beaglebone white, for some reason won=
t
>> boot 3.14 (vanilla or -rt).
> Another thing to try is 3.14.36 without -rt.
>
> Best regards
> Uwe
>
>
Thank you for your prompt reply.

I tried to see if I could reproduce this on 3.14.39-rt37 and 3.14.36 wi=
thout -rt , and both still crashes. But if I send console msg into a ne=
tcat pipe,  ./gtest_msg_kernel_oops | nc 192.168.44.180 1234, i don't g=
et the crash message anymore.

 =20
Best regards
Alexandre


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
