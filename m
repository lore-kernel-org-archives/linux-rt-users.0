From: Dennis Borgmann <dennis.borgmann@googlemail.com>
Subject: [Linux-RT]High CPU-load due to IRQ servicing
Date: Thu, 23 Dec 2010 15:28:48 +0100
Message-ID: <4D135CA0.9020900@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48527 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829Ab0LWO2x (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 23 Dec 2010 09:28:53 -0500
Received: by bwz15 with SMTP id 15so7447926bwz.19
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Dec 2010 06:28:52 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello linux-rt list!

I am using the RT-patchset with a 2.6.33.7-Kernel on a PCEngines
ALIX-Board (AMD Geode 500MHz). In several prior projects, everything
worked fine.

Right now, I am reading four virtual USB ports in parallel
(/dev/ttyUSB0-3) using an own single-threaded program for this. Data is
coming in on each port in intervals as fast as 40ms, each ~550 bytes, at
250.000 BAUD.

The problem I can observe is, that sometimes the CPU load goes up to
100% regarding the servicing of hardware IRQs.

I know, since I observed this via top(1). There is 100% on "hi" for a
some amount of time(<0.5s). Using a program called "itop", I was able to
check the interrupts per second and each time, the CPU gets this high
load, I observe about 1500 interrupts per second on IRQ 0 ("timer").

The result of this is, that my program is frozen for about 300ms, which
destroys the purpose of my software. In addition, the program stops
receiving data from all the four virtual USB ports, but only gets data
from one or two of the ports. So from this point on my program is broken
due to failure within the linux system.

First of all: What could I be doing wrong?
Second: Could this be a real-time bug? Or a bug within the driver I am
using (ftdi.c on FT4232H)?
Third: Could anyone image an improvement by making the software multi
threaded? One thread for each USB-port?

Kind regards for every hint about my problem.
Dennis
