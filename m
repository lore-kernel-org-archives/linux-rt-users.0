From: Juergen Beisert <jbe@pengutronix.de>
Subject: Serieal console on Samsung S3C6410 ARM11 CPU (Was [ANNOUNCE] 3.0.6-rt17)
Date: Sat, 8 Oct 2011 13:26:58 +0200
Message-ID: <201110081326.58731.jbe@pengutronix.de>
References: <alpine.LFD.2.02.1110070046270.3240@ionos>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	"linux-rt-users" <linux-rt-users@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55304 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab1JHL1E (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 8 Oct 2011 07:27:04 -0400
In-Reply-To: <alpine.LFD.2.02.1110070046270.3240@ionos>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas Gleixner wrote:
> I'm pleased to announce the 3.0.6-rt17 release.

I have no idea where to search, but when I'm using the 3.0.6-rt17 on my
Samsung S3C6410 ARM based system, the UART (serial console) does not work as 
expected. Typing only one char at a time is okay. Typing two chars 
immediately makes the system using 100 % CPU load and takes about 2 seconds 
to respond. It seems the interrupt handling is broken in the UART driver, but 
I don't know how to fix it.

This with a simple cursor up (one char to get the last command) and a small 
pause to the next "ENTER" char:

root@mini6410:~ cat /proc/interrupts | grep 18:
 18:    5739107  s3c-uart  s3c6400-uart

Same again:

root@mini6410:~ cat /proc/interrupts | grep 18:
 18:    5739113  s3c-uart  s3c6400-uart

6 interrupts seems reasonable.

Now with cursor up and SPACE immediately, then a pause for ENTER:

root@mini6410:~ cat /proc/interrupts | grep 18:
 18:    5923815  s3c-uart  s3c6400-uart

184702 interrupts looks strange.

jbe

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
