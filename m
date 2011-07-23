From: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: [ANNOUNCE] 3.0-rt1
Date: Sat, 23 Jul 2011 16:29:24 +0200
Message-ID: <201107231629.25322.jbe@pengutronix.de>
References: <alpine.LFD.2.02.1107222203400.2702@ionos>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	"linux-rt-users" <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56436 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909Ab1GWOkz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Jul 2011 10:40:55 -0400
In-Reply-To: <alpine.LFD.2.02.1107222203400.2702@ionos>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Thomas,

on ARM (in this case a Samsung S3C2440 based platform) I get:

kernel/built-in.o: In function `vprintk':
/home/jb/[...]/linux-3.0/kernel/printk.c:862: undefined reference to `early_vprintk'
kernel/built-in.o: In function `register_console':
/home/jb/[...]linux-3.0/kernel/printk.c:1580: undefined reference to `early_console_initialized'
make[1]: *** [vmlinux] Error 1

Did I forget something to enable in my kernel config?

jbe

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
