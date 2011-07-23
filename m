From: hermann <brummer-@web.de>
Subject: Re: [ANNOUNCE] 3.0-rt1
Date: Sat, 23 Jul 2011 06:08:52 +0200
Message-ID: <1311394132.2343.15.camel@box>
References: <1311265361.2323.6.camel@box>
	 <alpine.LFD.2.02.1107211932440.2702@ionos>
	 <alpine.LFD.2.02.1107211942420.2702@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fmmailgate03.web.de ([217.72.192.234]:60827 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737Ab1GWEIz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Jul 2011 00:08:55 -0400
In-Reply-To: <alpine.LFD.2.02.1107211942420.2702@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

Build fail here with

  CC      arch/x86/kernel/early_printk.o
arch/x86/kernel/early_printk.c:188:17: error: conflicting types for
=E2=80=98early_vprintk=E2=80=99
include/linux/printk.h:95:13: note: previous declaration of
=E2=80=98early_vprintk=E2=80=99 was here
make[3]: *** [arch/x86/kernel/early_printk.o] Fehler 1
make[2]: *** [arch/x86/kernel] Fehler 2
make[1]: *** [arch/x86] Fehler 2

it build here when I declare early_vprintk in printk.h as=20
asmlinkage void early_vprintk(const char *fmt, va_list args);

System:    Host box Kernel 3.0.0-rc7-rt0 i686 (32 bit gcc 4.5.2)=20
           Desktop Xfce 4.8.2 (Gtk 2.24.4) Distro Debian GNU/Linux
wheezy/sid
Machine:   System Hewlett-Packard product hp workstation version
x2100/2600
           Mobo Hewlett-Packard model HP WMTA System Board version A03
Bios Phoenix version JG.W1.04US date 07/26/2002
CPU:       Single core Intel Pentium 4 CPU (-UP-) cache 512 KB flags
(sse sse2) bmips 5184.7 clocked at 2600.00 MHz=20

regards
hermann

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
