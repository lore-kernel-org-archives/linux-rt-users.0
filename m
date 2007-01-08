From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: 2.6.20-rc4-rt0: i386 assembler in kernel/sys.c
Date: Mon, 8 Jan 2007 17:30:27 +0100
Message-ID: <20070108163027.GD5098@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:41514 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751599AbXAHRYS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Jan 2007 12:24:18 -0500
Received: from leda.ptxnet.pengutronix.de ([10.1.0.71])
	by metis.extern.pengutronix.de with esmtp (Exim 3.36 #1 (Debian))
	id 1H3xOI-0008Gw-00
	for <linux-rt-users@vger.kernel.org>; Mon, 08 Jan 2007 17:30:30 +0100
Received: from sha by leda.ptxnet.pengutronix.de with local (Exim 4.63)
	(envelope-from <sha@localhost.localdomain>)
	id 1H3xOF-0001qM-5K
	for linux-rt-users@vger.kernel.org; Mon, 08 Jan 2007 17:30:27 +0100
To: linux-rt-users@vger.kernel.org
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi all,

Looks like some debug code accidently leaked into this kernel/sys.c:

	if (option == 9998) {
		int i;
		for (i = 0; i < arg2; i++)
			asm ("movl $0x12341234, %%eax; movl %%eax, %%cr3":::"eax");
		return 1;
	}
	if (option == 9999) {
		int i;
		for (i = 0; i < arg2; i++)
			asm (".byte 0x0f, 0x01, 0xc1");
		return 0;
	}

In include/linux/irqflags.h safe_halt changed from a macro to a static
inline function which results in tons of warnings for architectures
other than x86[-64]:

include/linux/irqflags.h:99: warning: implicit declaration of function 'raw_safe_halt'

Apart from these two issues 2.6.20-rc4-rt0 seems to run on my arm
system.

Sascha

-- 
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
