From: "Nikita V. Youshchenko" <yoush@cs.msu.su>
Subject: Re: kernel 2.6.33.7-rt29 problem
Date: Fri, 15 Oct 2010 11:24:46 +0400
Message-ID: <201010151124.47930@zigzag.lvk.cs.msu.su>
References: <594976.7463.qm@web114205.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users linux-rt-users <linux-rt-users@vger.kernel.org>
To: Primus Mutasingwa <pmutasingwa@yahoo.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gate.lvk.cs.msu.su ([158.250.17.1]:45960 "EHLO
	mail.lvk.cs.msu.su" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756163Ab0JOHYw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Oct 2010 03:24:52 -0400
In-Reply-To: <594976.7463.qm@web114205.mail.gq1.yahoo.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> I am looking for suggestions on how to resolve this problem. Why doesnt
> the thread run ?
> Why is the system locked up ?
> Is there any tools included in the kernel that can allow me to debug
> this ?

I guess the system locked up because some of your code (user-space or 
kernel-space) runs at too high priority, and consumes too much CPU.

For debugging, I suggest to temporary drop priorities of all your 
components to something below 80, and increase priority of your debugging 
environment to something above 80. If you access the board over serial, 
then 'debugging environment' likely includes serial interrupt and your 
shell process, maybe something more - need to check.

After that, you should still be able to communicate with the system when 
your failure event happens. Then use e.g. strace or gdb to find out what 
is going on.

Nikita
