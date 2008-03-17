From: Juergen Beisert <jbe@pengutronix.de>
Subject: 2.6.24.3-rt3 failure on ARM
Date: Mon, 17 Mar 2008 11:30:56 +0100
Message-ID: <200803171130.56575.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:44306 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751991AbYCQKbD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 17 Mar 2008 06:31:03 -0400
Received: from themisto.extern.pengutronix.de ([83.236.181.29] helo=localhost)
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <jbe@pengutronix.de>)
	id 1JbCcM-0007xB-4s
	for linux-rt-users@vger.kernel.org; Mon, 17 Mar 2008 11:31:01 +0100
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

using 2.6.24.3-rt3 for ARM gives me this error.

[...]
  CHK     include/linux/compile.h
  CC      arch/arm/kernel/process.o
arch/arm/kernel/process.c: In function 'cpu_idle':
arch/arm/kernel/process.c:175: error: implicit declaration of function =
'trace_preempt_exit_idle'
arch/arm/kernel/process.c:180: error: implicit declaration of function =
'trace_preempt_enter_idle'
make[2]: *** [arch/arm/kernel/process.o] Error 1
make[1]: *** [arch/arm/kernel] Error 2

I didn't find any implementation of these functions in the kernel. Do w=
e
need them or can I remove them?

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
