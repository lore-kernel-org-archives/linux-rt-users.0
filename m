From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Problem with the clock framework
Date: Mon, 12 Aug 2013 18:47:40 +0200
Message-ID: <20130812164740.GK23040@linutronix.de>
References: <emaa43c631-f80b-47c3-bd4e-5438822f0ad8@nb-mak>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: RT <linux-rt-users@vger.kernel.org>
To: Matthias Klein <matthias.klein@optimeas.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45137 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755433Ab3HLQrl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 12 Aug 2013 12:47:41 -0400
Content-Disposition: inline
In-Reply-To: <emaa43c631-f80b-47c3-bd4e-5438822f0ad8@nb-mak>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Matthias Klein | 2013-07-11 05:51:03 [+0000]:

> Hello,
Hi Mathias,

>disabled. I tried to use the linux clock framework
>with clk_get() and clk_enable() to enable these clocks. Basically it
>works, but a lot of transmissions get discontinuous:
>after the first 32 bit the SPI clock stops, with a low chip select
>line, and after some milliseconds the remaining bits are transmitted.

Is this -RT releated or do you see the same kind of problem without -RT?
If so you might want to try the arm/spi mailing list.

>It I use the following code to enable these clocks instead of
>clock_enable() everything works:
>
> volatile unsigned int *v_adr = 0;
> v_adr = ioremap_nocache(0x53FD4078, 4); // CCM Clock Gating Register
>4 (CCM_CCGR4)
> *v_adr |= 0xF << 18; // Enable CG9 + CG10
> iounmap(v_adr);
>
>For me it looks like that some type of power managment disables the
>ECSPI clock periodically.
>
>Is there a default behavior for power managment and these clocks, or
>does it depend on the board specific implementation ?

If the driver is using runtime_pm then it might "put" the device which
in turn might disable clocks. This often does not happen right away but
after a while to avoid frequent enable/disable of the device.

>Can you give me some tips for analyze the problem ?

Enable debugging under kernel hacking and maybe some locking / sleeping
while atomic message pop up.

>Best regards,
>
>Matthias

Sebastian
