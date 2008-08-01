From: Matthew Smith <matt@smiffytech.com>
Subject: 2.6.25.8-rt7 Bugs
Date: Fri, 01 Aug 2008 13:37:00 +0930
Message-ID: <48928BE4.6030509@smiffytech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from prospero.kbc.net.au ([150.101.97.167]:59690 "EHLO
	prospero.kbc.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbYHAEOQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 1 Aug 2008 00:14:16 -0400
Received: from [10.10.10.212] (brutus_ii [10.10.10.212])
	by prospero.kbc.net.au (Postfix) with ESMTP id 0EF939C038
	for <linux-rt-users@vger.kernel.org>; Fri,  1 Aug 2008 13:37:01 +0930 (CST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Folks

I am trying to run 2.6.25.8-rt7, patched via the RT version of ketchup
on my ThinkPad (Core2Duo CPU) to provide a low-latency base for audio
applications (Jack, Rosegarden, Hydrogen, Zynaddsubfx).

Jack is throwing xruns and, on boot, I am seeing a load of bugs (the
actually say BUG) so I have been advised to post my bugs here.  Here's
my dmesg:

<http://www.smiffysplace.com/files/dmesg_rt_20080801>

And my kernel configuration:

<http://www.smiffysplace.com/files/kconfig_rt_20080801>

Have I configured something wrong, or is this a real bug?  I'm quite
happy to try other kernel versions but don't want to move to a 2.6.26 as
there are other driver issues that affect me and don't really want to go
any older than the Gentoo-patched 2.6.23 that I am running for general
use (I'm dual-booting to the RT kernel).

Just in case it's relevant, I can't disable ACPI; this machine has
either a design or a manufacturing fault - if I don't manually set the
fan to run at full speed all the time, the GPU (I think) overheats and
the whole thing locks up.

Cheers

M

-- 
Matthew Smith
Smiffytech - Technology Consulting & Web Application Development
Business: http://www.smiffytech.com/
Personal: http://www.smiffysplace.com/
LinkedIn: http://www.linkedin.com/in/smiffy

