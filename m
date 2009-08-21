From: Bo Hansen <bh@newtec.dk>
Subject: Re: hrtimer problem on AT91RM9200
Date: Fri, 21 Aug 2009 14:57:43 +0200
Message-ID: <4A8E99C7.6080106@newtec.dk>
References: <4A8BEF09.2080300@newtec.dk> <20090820195200.GA3331@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pasmtpa.tele.dk ([80.160.77.114]:56893 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754742AbZHUM5o (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Aug 2009 08:57:44 -0400
In-Reply-To: <20090820195200.GA3331@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Uwe,

I cannot find anything in the dmesg or serial output regarding the
WARN_ON_ONCE(...)
I guess the WARN_ON_ONCE(...) should show up in dmesg output?

What puzzles me is that I tried the CONFIG_DEBUG_BUGVERBOSE=3Dy
also when I enabled CONFIG_DEBUG_INFO. When I do
this I don't get the kernel panic. Is this somehow related to the
WARN_ON_ONCE?

Attachments only sent to Uwe - anybody are welcome to get a copy.

Best regards,
Bo


Uwe Kleine-K=F6nig wrote:
> Hello,
>
>  =20
>> PC is at clkevt32k_next_event+0x70/0xac
>>    =20
> This function has a WARN_ON_ONCE(...).  Can you check if this trigger=
s?
>
> Can you provide me a kernel image with CONFIG_DEBUG_INFO=3Dy and a
> matching oops?
>
> Best regards
> Uwe
>
>  =20
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
