From: Jean-Denis Girard <jd.girard@sysnux.pf>
Subject: Re: [ANNOUNCE] v4.4.4-rt11
Date: Fri, 11 Mar 2016 15:56:59 -1000
Message-ID: <56E3776B.9030200@sysnux.pf>
References: <20160309135142.GF10517@linutronix.de>
 <nbq16a$7li$1@ger.gmane.org> <20160311171446.GB3815@breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-pro1.mana.pf ([202.3.225.198]:36519 "EHLO
	smtp-pro1.mana.pf" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbcCLB5E (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Mar 2016 20:57:04 -0500
In-Reply-To: <20160311171446.GB3815@breakpoint.cc>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

Le 11/03/2016 07:14, Sebastian Andrzej Siewior a =C3=A9crit :
> This looks promising. Can you check if IRQ 16 is used by another
> peripherals? While we need get rid fo the warning I am curious if it
> works on boards which chare the timer with UART or something.

Here are the interrupts, I hope this is what you want:
jdg@arietta:~$ cat /proc/interrupts
           CPU0
 16:     145825  atmel-aic   1 Level     at91_rtc, ttyS0
 17:   45661872  atmel-aic  17 Level     tc_clkevt
 18:      72014  atmel-aic  20 Level     at_hdmac
 19:          0  atmel-aic  21 Level     at_hdmac
 23:    2541144  atmel-aic  12 Level     f0008000.mmc
 26:          0  atmel-aic  10 Level     f8014000.i2c
 27:          0  atmel-aic  19 Level     at91_adc
 28:          0  atmel-aic  14 Level     f0004000.spi
 31:          1  atmel-aic  22 Level     ehci_hcd:usb1, ohci_hcd:usb2
Err:          0


The Arietta has been working fine for a couple of days with this kernel=
:
jdg@arietta:~$ uname -r
4.4.4-rt11
jdg@arietta:~$ uptime
 14:30:06 up 2 days,  4:04,  1 user,  load average: 0.00, 0.02, 0.05


Thanks,
--=20
Jean-Denis Girard

SysNux                Syst=C3=A8mes   Linux   en   Polyn=C3=A9sie   fra=
n=C3=A7aise
http://www.sysnux.pf/ T=C3=A9l: +689 40.50.10.40 / GSM: +689 87.79.75.2=
7
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
