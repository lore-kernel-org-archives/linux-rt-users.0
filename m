From: Pradyumna Sampath <pradysam@gmail.com>
Subject: Re: Kernel module crashed in 2.6.33.7-rt30
Date: Thu, 27 Jan 2011 09:05:02 +0100
Message-ID: <AANLkTinW4koreUTXS_ieXb9wGVUKhebTgLvkfEMP4O6y@mail.gmail.com>
References: <1295941160.4853.0.camel@vikram-pc>
	<20110125162136.GD22005@pengutronix.de>
	<AANLkTikQW6mkV_a6umKY0NnoinD-UnJQK4Gm+kxuKfCa@mail.gmail.com>
	<20110127075904.GJ1147@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Vikram Narayanan <vikram186@gmail.com>,
	linux-rt-users@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:42287 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934Ab1A0IFE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 27 Jan 2011 03:05:04 -0500
Received: by pxi15 with SMTP id 15so217457pxi.19
        for <linux-rt-users@vger.kernel.org>; Thu, 27 Jan 2011 00:05:03 -0800 (PST)
In-Reply-To: <20110127075904.GJ1147@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

2011/1/27 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> [readded linux-rt-users to recipients]
>
> Hello,
>
> On Thu, Jan 27, 2011 at 01:23:47PM +0530, Vikram Narayanan wrote:
>> I have checked my config. DEBUG_BUGVERBOSE is already enabled. Any o=
ther
>> ideas on how to debug this?
>> Can you give an overview of why this happens?
> sorry, I don't have much clue about x86.
<snip ...>

Im remember that at sometime there was a similar thread on LKML
regarding a bug with RT together with nf/iptables. But I presume that
was fixed.

You could lkml archives for that thread or try disabling iptables.

best regards
/prady

--=20
http://www.prady.in
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
