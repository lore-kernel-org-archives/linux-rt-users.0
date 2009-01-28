From: Claus Gindhart <claus.gindhart@kontron.com>
Subject: Realtime capability of ioctl() vs. read() and write()
Date: Wed, 28 Jan 2009 08:34:27 +0100
Message-ID: <200901280834.28139.claus.gindhart@kontron.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: klaus weschmann <klaus.weschmann@kontron.com>,
	Jochen Beier <jochen.beier@kontron.com>
To: linux-rt-users@vger.kernel.org,
	Gerd Koenig <gerd.koenig@kontron.com>,
	Peter Widmann <peter.widmann@kontron.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kontron-modular.com ([213.179.130.140]:17652 "EHLO
	mail.kontron-modular.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbZA1Htt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Jan 2009 02:49:49 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I am running a Linux 2.6.24.7-rt21 Kernel on our HW.

This HW contains a number of IO-Ports, and the drivers for these IO-Ports are 
designed in a way, that various ioctl() function provide the interface to 
these Ports.

Now, i recognized, that processes, which are using such ioctl()'s, absolutely 
do not run in realtime (regardless on the priority). If i cat a huge file to 
a /dev/ttyX device, the process jitters for many milliseconds.

This does NOT happen, if i modify the driver and the user space process to 
access IO's via read() and write() instead of ioctl()'s.

My question is: Is it a known and intended behaviour, that ioctl()'s ruin 
realtime behaviour, and that IO's should only be accessed via read() and 
write() ?
I didnt find any documentation, which would advice me not to use ioctl() in 
realtime applications.

-- 
Mit freundlichen Gruessen / Best regards

Claus Gindhart
SW R&D
Kontron Modular Computers
phone :++49 (0)8341-803-374
mailto:claus.gindhart@kontron-modular.com
http://www.kontron.com
