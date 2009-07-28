From: "Pilhofer, Frank" <fpilhofe@mc.com>
Subject: Real-Time Clocks and POSIX
Date: Tue, 28 Jul 2009 13:21:48 -0400
Message-ID: <0DEF6B92D4B25D479DDA432440101F33C96F33@CHM-EMAIL1.ad.mc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from iris-63.mc.com ([63.96.239.141]:32815 "EHLO mc.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753717AbZG1RcS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 28 Jul 2009 13:32:18 -0400
Content-class: urn:content-classes:message
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,
 
I'm looking into real-time clocks.  I'm wondering why the POSIX
clock_* and timer_* APIs are not used for RTCs.  E.g., I expected
that you would be able to just use:

  struct timespec now;
  clock_gettime (MY_RTC_DEVICE, &now);

to read the time from a RTC device.  There even appears to be an easy
way to register auxiliary clocks in kernel/posix-timers.c.

Instead, Documentation/rtc.txt describes the "ioctl" API that is to
be used instead.

Is there a motivation for not using the POSIX functions for RTCs?
Or is there a code path between the two that I did not see?

Thank you,
Frank
