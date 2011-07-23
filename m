From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.0-rt1
Date: Sat, 23 Jul 2011 17:00:38 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1107231659420.2702@ionos>
References: <alpine.LFD.2.02.1107222203400.2702@ionos> <201107231629.25322.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Juergen Beisert <jbe@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56109 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928Ab1GWPAk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Jul 2011 11:00:40 -0400
In-Reply-To: <201107231629.25322.jbe@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 23 Jul 2011, Juergen Beisert wrote:

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

No, that's my fault. I merged a late minute debugfeature yesterday and
forgot to enable early_printk on ARM. Will be fixed in -rt2 which i'm
about to release.

Thanks,

	tglx
