From: "Jan Sommer" <jan.sommer@s2008.tu-chemnitz.de>
Subject: Preempt-rt on 3.2.23 raspberry pi kernel
Date: Sun, 29 Jul 2012 22:32:08 +0200
Message-ID: <op.wh75zuz8k9j7wf@soja-mo>
References: <op.wh4l2os2k9j7wf@soja-mo> <op.wh75q4qvk9j7wf@soja-mo>
Reply-To: jan.sommer@s2008.tu-chemnitz.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 8bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cora.hrz.tu-chemnitz.de ([134.109.228.40]:40219 "EHLO
	cora.hrz.tu-chemnitz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363Ab2G2UcK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 29 Jul 2012 16:32:10 -0400
Received: from pat.hrz.tu-chemnitz.de ([134.109.133.4] helo=mailbox.hrz.tu-chemnitz.de)
	by cora.hrz.tu-chemnitz.de with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76)
	(envelope-from <jan.sommer@s2008.tu-chemnitz.de>)
	id 1Sva9o-0000dx-R9
	for linux-rt-users@vger.kernel.org; Sun, 29 Jul 2012 22:32:09 +0200
Received: from p54874d83.dip.t-dialin.net ([84.135.77.131] helo=soja-mo)
	by mailbox.hrz.tu-chemnitz.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.76)
	(envelope-from <jsom@mailbox.hrz.tu-chemnitz.de>)
	id 1Sva9o-00059Z-OR
	for linux-rt-users@vger.kernel.org; Sun, 29 Jul 2012 22:32:08 +0200
In-Reply-To: <op.wh75q4qvk9j7wf@soja-mo>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

This probably is related to the this thread
http://comments.gmane.org/gmane.linux.rt.user/8424 but I don't know how to
answer to it as I have just subscribed to the mailinglist.
As Tom I used the 3.2.23 branch for the raspberry pi from bootc
(http://www.bootc.net/projects/raspberry-pi-kernel/) and applied the
rt-patch. Because Tom told about problems with the USB-driver I set up my
system to mount the rootfs via NFS.
The patched kernel boots up fine when using the voluntary, low latency and
basic preempt option but fails to boot after compiling it with the
preempt_full option.
You can find a screenshot (literally ;-) ) of the last kernel
output here: http://imageshack.us/photo/my-images/140/rpikernellog.jpg/

It complains about a certain part of the code within rtmutex.c.

As I'm fairly new to building kernel related things, does anyone has a
suggestion what to do? The problem occurs in both versions of the patch
(rt36 and rt37) and it does not matter if I want to mount the rootfs via
sd-card or NFS (probably because the error appears even before).
At the moment I don't have the chance to hook up a serial cable to the
serial port as I don't have level converters.


Best regards,

        Jan
