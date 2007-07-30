From: Dragan Noveski <perodog@gmx.net>
Subject: wrong system time with 2.6.22.1-rt9
Date: Mon, 30 Jul 2007 17:33:11 +0200
Message-ID: <46AE04B7.80102@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:37643 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756147AbXG3Ndb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jul 2007 09:33:31 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

hi to the list,
since i managed to compile my kernel with high-res-timer and tickless 
option (2.6.21 series), the system time is always displaying wrong time, 
so if it is 2 o'clock, the time showed will be 4 o'clock.
for being able to run stable with high-res.timers and tickless option, i 
configured the acpi stuff as explained in 
'http://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO'.
if i adjust the time now in the bios or via gnome-control-center, on the 
next reboot the time again will be wrong.
i do not realize any other issues with the 2.6.22.1-rt9, it runs very 
smooth and stable, although my setup is not that much complicated 
(ibm-thinkpad-R50e, rme-multiface, debian-lenny).
i could provide you every information you think it could help to resolve 
that clock issue, so if any one has any idea, just ask me and i will 
answer everything about the configuration here.

cheers,
doc
