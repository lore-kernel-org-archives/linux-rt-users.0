From: Dragan Noveski <perodog@gmx.net>
Subject: 2.6.23.1-rt5 rtc lost interrupt
Date: Wed, 31 Oct 2007 14:37:04 +0000
Message-ID: <47289310.4000506@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:53943 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754530AbXJaNjz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 31 Oct 2007 09:39:55 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

hallo list, yesterday strange thing happened here.
i am running 2.6.23.1-rt5, and actually it is running good, but 
yesterday partially my keyboard stopped working. usually if i press any 
key (inside of xterm) and do not release, but keep pressed, the 
letter/sign will be printed all the time again and again as long as i 
release the key.
something like:

aaaaaaaaaaaaaaaaaaaaa

but yesterday, if i was holding the key, the letter got displayed on the 
screen just one time.
if i released and pressed again, one more time.....
so i was not able to press only one time a key and hold to get sth like 
these:

........................

than in /var/log/system i found this lines:


Oct 30 21:22:37 murija2 kernel: rtc: lost 8 interrupts
Oct 30 21:22:50 murija2 kernel: rtc: lost 4 interrupts
Oct 30 21:22:50 murija2 kernel: rtc: lost 20 interrupts

this also appeared in dmesg.

is this explained so that someone is able to understand?
does any one has an idea what went wrong here?

after a reboot the keyboard was working as usually again and the issue 
did not happened again since them.

hope to get some suggestions/answers?!

cheers,
doc
