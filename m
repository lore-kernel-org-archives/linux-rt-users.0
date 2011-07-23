From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.0-rt1
Date: Sat, 23 Jul 2011 09:37:32 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1107230936020.2702@ionos>
References: <1311265361.2323.6.camel@box>  <alpine.LFD.2.02.1107211932440.2702@ionos>  <alpine.LFD.2.02.1107211942420.2702@ionos> <1311394132.2343.15.camel@box>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-2009878921-1311406653=:2702"
Cc: linux-rt-users@vger.kernel.org
To: hermann <brummer-@web.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43020 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949Ab1GWHhe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Jul 2011 03:37:34 -0400
In-Reply-To: <1311394132.2343.15.camel@box>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2009878921-1311406653=:2702
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 23 Jul 2011, hermann wrote:

> Hi
> 
> Build fail here with
> 
>   CC      arch/x86/kernel/early_printk.o
> arch/x86/kernel/early_printk.c:188:17: error: conflicting types for
> ‘early_vprintk’
> include/linux/printk.h:95:13: note: previous declaration of
> ‘early_vprintk’ was here
> make[3]: *** [arch/x86/kernel/early_printk.o] Fehler 1
> make[2]: *** [arch/x86/kernel] Fehler 2
> make[1]: *** [arch/x86] Fehler 2
> 
> it build here when I declare early_vprintk in printk.h as 
> asmlinkage void early_vprintk(const char *fmt, va_list args);

Grr, right. That's a 32bit thingy. Fixed for -rt2.

Thanks,

	tglx

--8323328-2009878921-1311406653=:2702--
