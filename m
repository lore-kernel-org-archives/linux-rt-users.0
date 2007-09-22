From: "Cliff Brake" <cliff.brake@gmail.com>
Subject: Priority of serial driver
Date: Sat, 22 Sep 2007 14:22:00 -0400
Message-ID: <f96d234e0709221122g36dab213y41645c159d620c8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:53364 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752762AbXIVSWB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 22 Sep 2007 14:22:01 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1405809wah
        for <linux-rt-users@vger.kernel.org>; Sat, 22 Sep 2007 11:22:00 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

I have a system where I am doing the following on a PXA270 ARM system:

An applications is sending and receiving a packet on a serial port
every 40ms.  With 2.6.20, I simply enabled kernel preemption and set
the priority of my application to real-time, and it worked great, no
matter what the system load.

With 2.6.23-rc6, I have enabled CONFIG_HIGH_RES_TIMERS &
CONFIG_PREEMPT.  Scheduling in the real-time application is rock solid
and looking at timing with a scope, and instrumenting the loop in the
application indicates the 40ms is very solid.  However, it seems the
receive data is getting stuck in the serial driver for relatively long
periods of time (>= 40ms), which is a problem in this system.

Is there anything that would have changed between 2.6.20 and
2.6.23-rc6 that would explain this?  What priority do pieces of the
serial driver run at?  Is there any way to make the serial driver run
at high priority so that data is processed in a timely manner?

Thanks,
Cliff

-- 
=======================
Cliff Brake
http://bec-systems.com
