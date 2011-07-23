From: Robin Gareus <robin@gareus.org>
Subject: Re: [ANNOUNCE] 3.0-rt1
Date: Sat, 23 Jul 2011 16:52:36 +0200
Message-ID: <4E2AE034.2000105@gareus.org>
References: <alpine.LFD.2.02.1107222203400.2702@ionos> <201107231629.25322.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Juergen Beisert <jbe@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:53211 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752902Ab1GWOx0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Jul 2011 10:53:26 -0400
In-Reply-To: <201107231629.25322.jbe@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/23/2011 04:29 PM, Juergen Beisert wrote:
> Hi Thomas,
> 
> on ARM (in this case a Samsung S3C2440 based platform) I get:
> 
> kernel/built-in.o: In function `vprintk':
> /home/jb/[...]/linux-3.0/kernel/printk.c:862: undefined reference to `early_vprintk'
> kernel/built-in.o: In function `register_console':
> /home/jb/[...]linux-3.0/kernel/printk.c:1580: undefined reference to `early_console_initialized'
> make[1]: *** [vmlinux] Error 1
> 
> Did I forget something to enable in my kernel config?

I've seen the same error when trying to work around vprintk issue on
i386 with CONFIG_EXPERT=y  CONFIG_EARLY_PRINTK=n

instead of fixing 'printk.c' I've changed 'include/linux/printk.h:95'
 -void early_vprintk(const char *fmt, va_list args);
 +asmlinkage void early_vprintk(const char *fmt, va_list args);

and compiled with CONFIG_EARLY_PRINTK=y. Not sure if that is an option
on ARM.

Herman has reported the latter issue earlier today.

ciao,
robin
