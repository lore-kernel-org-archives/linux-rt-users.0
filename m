From: Tom Cook <tom.k.cook@gmail.com>
Subject: Re: Tracers+cyclictest causing kernel oops
Date: Mon, 27 May 2013 22:23:53 +0100
Message-ID: <CAFSh4Uw2+d_mOoY0b63JODwjXnq=H0oZia1XMEDW6KXV87NR5Q@mail.gmail.com>
References: <CAFSh4UwgZJD0YGi8GRtAW4APqWkyf2a+v31zgL2Bu3zfVZg6gw@mail.gmail.com>
	<CAFSh4UzfxuTrsUCX9gsm10KRhJB9APLs8DJihxWai1ysdhMiXg@mail.gmail.com>
	<20130503160546.GF8230@linutronix.de>
	<CAFSh4UwD5yyJrtKwUaOX-uiUuzVf7YaDbM4vbZ1EFZBf6F1JHg@mail.gmail.com>
	<519B57A7.1010901@linutronix.de>
	<CAFSh4UzaOcbD456e408Qw4F=Ynt1WCXwrUx7ekC1GKLZRkFznw@mail.gmail.com>
	<20130527080248.GE11166@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vb0-f51.google.com ([209.85.212.51]:38465 "EHLO
	mail-vb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab3E0VXy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 27 May 2013 17:23:54 -0400
Received: by mail-vb0-f51.google.com with SMTP id x16so4976343vbf.10
        for <linux-rt-users@vger.kernel.org>; Mon, 27 May 2013 14:23:53 -0700 (PDT)
In-Reply-To: <20130527080248.GE11166@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, May 27, 2013 at 9:02 AM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
[snip]
> What are you using fiqs for? AFAIK they are not well supported in
> mainline Linux even.

You're well on the way to plumbing the depths of my ignorance.  This
is just me applying the RT patches to the raspberrypi linux tree.  The
nearest I can figure out an answer to your question is this, in
arch/arm/kernel/fiqasm.S, in __set_fiq_regs:

@@@@@@@@@@@@@@@ hack: enable the fiq here to keep usb driver happy
        and     r1, #~PSR_F_BIT
@@@@@@@@@@@@@@@ endhack: (need to find better place for this to happen)

It uses the dwc_otg driver, but reports have it that the match of
hardware to driver is not wonderful.

Regards,
Tom
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
