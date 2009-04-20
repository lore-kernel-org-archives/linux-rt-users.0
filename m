From: tom smith <tsmithtree@gmail.com>
Subject: Kernel Panic: Early exception with 2.6.29.1-rt8 on x86_64
Date: Mon, 20 Apr 2009 01:44:08 -0600
Message-ID: <e743c9de0904200044j1f71310ar122c8ea1fdcd2649@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:38073 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562AbZDTHoL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 20 Apr 2009 03:44:11 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi, I'm using kernel 2.6.29.1 without the rt patch and it works fine,
but with the rt8 patch I recieve a kernel panic immediately after the
bootloader. Both were using the same configuration with the exception
of the realtime preemption options. I previously used 2.6.26.8-rt16
iirc and it worked fine, with the same configuration as well. early
printk is enabled. I have uploaded my .config, lspci, dmesg from a
working kernel, and the crash output from the kernel.
http://www.persuasiveigloo.com/linux/ Thanks for reading, if you think
any other outputs/configs would be helpful to debug this issue I will
gladly upload them. please cc me as I am off list for linux-kernel
