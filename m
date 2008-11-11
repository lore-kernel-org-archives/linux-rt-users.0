From: Juergen Beisert <jbe@pengutronix.de>
Subject: kernel modules and ftrace
Date: Tue, 11 Nov 2008 18:56:30 +0100
Message-ID: <200811111856.31240.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:54672 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752498AbYKKR4i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Nov 2008 12:56:38 -0500
Received: from themisto.extern.pengutronix.de ([83.236.181.29] helo=jupiter.intranet.kreuzholzen.de)
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <jbe@pengutronix.de>)
	id 1KzxTc-0003FX-Ia
	for linux-rt-users@vger.kernel.org; Tue, 11 Nov 2008 18:56:36 +0100
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi list,

when I'm compiling in FTRACE support I get the following output, when I=
 load
the first of a few modules:

-----------------------------------------------------------------------=
------
[...]
***********************************************************************=
******
*                                                                      =
     *
*  REMINDER, the following debugging options are turned on in your .con=
fig: *
*                                                                      =
     *
*        CONFIG_IRQSOFF_TRACER                                         =
     *
*        CONFIG_FTRACE                                                 =
     *
*                                                                      =
     *
*  they may increase runtime overhead and latencies.                   =
     *
*                                                                      =
     *
***********************************************************************=
******
[...]
=46reeing unused kernel memory: 132k init
[...]
of-gpio-wdt watchdog.1: gpio-watchdog driver started using gpio 211.
------------[ cut here ]------------
Badness at kernel/trace/ftrace.c:632
NIP: c00613a4 LR: c0061288 CTR: 00000000
REGS: c187bea0 TRAP: 0700   Not tainted  (2.6.26.7-rt11-ptx-trunk)
MSR: 00021032 <ME,IR,DR>  CR: 42002042  XER: 20000000
TASK =3D c1879ad0[19] 'ftraced' THREAD: c187a000
GPR00: 00000001 c187bf50 c1879ad0 00000002 c02d0118 c02b05ac c0053a60 1=
8aaf80f
GPR08: c02d0000 c02d0000 4800015d c187bf50 0aeac2fc 1006d448 c02d0000 0=
0000001
GPR16: 00000003 5b6cf500 c02e0000 c02d0000 c0260000 c0260000 00000001 c=
00128f0
GPR24: c02dd914 c02d0000 c02b05ac c18590f8 c02d0118 c185b0f8 c306e324 c=
187bf50
NIP [c00613a4] __ftrace_update_code+0x250/0x2d4
LR [c0061288] __ftrace_update_code+0x134/0x2d4
Call Trace:
[c187bf50] [c0061288] __ftrace_update_code+0x134/0x2d4 (unreliable)
[c187bfa0] [c006081c] ftrace_update_code+0x78/0xa4
[c187bfb0] [c00618f0] ftraced+0xa8/0x1bc
[c187bfd0] [c003d840] kthread+0x58/0x98
[c187bff0] [c0011e14] kernel_thread+0x44/0x60
Instruction dump:
7fc4f378 3875c248 4bfc2769 7fc4f378 38748e08 4bff6081 92d3f1bc 4bfffe54
3d20c02d 80090400 7c000034 5400d97e <0f000000> 2f800000 409e0074 3c60c0=
26
ftrace failed to modify [<c306e324>] of_gpio_wdt_probe+0x8/0x294 [of_gp=
io_wdt]
 expected: 48:fa:45:cd actual: 48:00:01:5d replace: 60:00:00:00
-----------------------------------------------------------------------=
------

What does it mean? Anything wrong with my environment or my modules?

BTW: Kernel is 2.6.26-rt11.

Regards,
Juergen

--=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
