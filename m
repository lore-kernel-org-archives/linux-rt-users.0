From: Tom Cook <tom.k.cook@gmail.com>
Subject: Re: Tracers+cyclictest causing kernel oops
Date: Fri, 21 Jun 2013 12:01:57 +0100
Message-ID: <CAFSh4UwnRG468+T2sCojorf5cxL99QDhzVCpBgHekETyzYO5cg@mail.gmail.com>
References: <CAFSh4UwgZJD0YGi8GRtAW4APqWkyf2a+v31zgL2Bu3zfVZg6gw@mail.gmail.com>
	<CAFSh4UzfxuTrsUCX9gsm10KRhJB9APLs8DJihxWai1ysdhMiXg@mail.gmail.com>
	<20130503160546.GF8230@linutronix.de>
	<CAFSh4UwD5yyJrtKwUaOX-uiUuzVf7YaDbM4vbZ1EFZBf6F1JHg@mail.gmail.com>
	<519B57A7.1010901@linutronix.de>
	<CAFSh4UzaOcbD456e408Qw4F=Ynt1WCXwrUx7ekC1GKLZRkFznw@mail.gmail.com>
	<20130527080248.GE11166@pengutronix.de>
	<CAFSh4Uw2+d_mOoY0b63JODwjXnq=H0oZia1XMEDW6KXV87NR5Q@mail.gmail.com>
	<20130528065336.GI11166@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36263 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757757Ab3FULB5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Jun 2013 07:01:57 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so7660836pab.39
        for <linux-rt-users@vger.kernel.org>; Fri, 21 Jun 2013 04:01:57 -0700 (PDT)
In-Reply-To: <20130528065336.GI11166@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, May 28, 2013 at 7:53 AM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
[snip]
> IIRC the usb driver is vital for the raspberry pi, but can you try to
> unbind the driver before enabling whatever breaks for you?
>
> Something like:
>
>         cd /sys/bus/platform/drivers/dwc_otg
>
> in this directory are probably >=3D1 symlinks on devices. Do
>
>         echo $devicename > unbind
>
> for each of them where devicename is the name of the symlinks.

Unfortunately my root FS is on a USB thumb drive.  There aren't many
options to change this, since the RPi MMC driver is broken under RT
(another thing to look into...)

Tom
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
