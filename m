From: Xianghua Xiao <xiaoxianghua@gmail.com>
Subject: PREEMPT_RT (2.6.33-rt17) disabled printk-to-console after
	console_init
Date: Tue, 18 May 2010 08:13:33 -0500
Message-ID: <AANLkTimxLHngWamPvWt-htGoZ7Nub72rvJAnmGtw4Eqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Gleixner <tglx@linutronix.de>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:36858 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756199Ab0ERNUY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 18 May 2010 09:20:24 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I would like to have printk output to my ttyS0 console all the time,
with 2.6.33-rt17, after kernel is booted up with all messages shown
normally on the serial port until I login in, from this point on, all
printk messages go to 'dmesg(log_buf)' fine, but I could never get
them shown up on serial console anymore. I tried adjust
/proc/sys/kernel/printk etc none helped.

Switch PREEMPT_RT to PREEMPT_VOLUNTARY and reboot, now everything
works, i.e. I can see printk on my console after I login.

Look at the RT patch itself, I do find some changes to printk itself,
however I'm unsure what is causing this(i.e printk not going to
console after login).

Thanks,
Xianghua
