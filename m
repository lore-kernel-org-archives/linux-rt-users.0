From: Remy Bohmer <linux@bohmer.net>
Subject: Re: [ANNOUNCE] 3.0-rt6
Date: Sat, 30 Jul 2011 17:49:32 +0200
Message-ID: <CANqCtQ+VhmfpNZ8Oh_0MR+bZfAeBuowBsK9TyC5iA4B2oLpXfg@mail.gmail.com>
References: <alpine.LFD.2.02.1107282213000.31246@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48816 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118Ab1G3PuG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 30 Jul 2011 11:50:06 -0400
In-Reply-To: <alpine.LFD.2.02.1107282213000.31246@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

2011/7/28 Thomas Gleixner <tglx@linutronix.de>:
> Dear RT Folks,
>
> I'm pleased to announce the 3.0-rt6 release.
>
> Changes versus 3.0-rt4 (I pushed out a rt5 w/o announce)
>
> =A0* pin_cpu fix (Yong Zhang)
>
> =A0* Various compile fixes (Yong Zhang & myself)
>
> =A0* Serial fix for omap
>
> =A0* Clocksource lockless watchdog reset
>
> =A0* Reenabled CONFIG_RCU_BOOST (problem is unreproducible and maybe
> =A0 =A0related to NO_HZ, which is still disabled. Paul is working on =
it!)
>
> =A0* KGDB work^Whackaround (Jason Wessel)
>
> =A0 =A0The kgdb workaround is really a hack and wants to be replaced =
by a
> =A0 =A0proper overhaul for the console/tty maze.
> =A0 =A0See: kgb-serial-hackaround.patch
>
> As I said yesterday, I'm preparing for vanishing from the net.
>
> Please keep on testing and sending patches. Peter Zijlstra kindly
> volunteered to cover for me. He'll pick up stuff and eventually push
> out releases when a reasonable number of sane patches hits his inbox.

I got rt5 booting yesterday on a ARM core (Atmel AT91):
* LCD driver broken, booting stops during initialising driver (seems
to be broken in mainstream too)
* Strange issue with finding files in a directory. (currently checking
if it is RT-patch related.)
* Furthermore, the board feels slow... Can be perception only, need to
check it out...
* The patch (http://www.spinics.net/lists/arm-kernel/msg45022.html)
that solved the problem at https://lkml.org/lkml/2007/11/26/73 is no
longer part of the RT-patch. I Need to test if it is still needed...

Kind regards,

Remy
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
