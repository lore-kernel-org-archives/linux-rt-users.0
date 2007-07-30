From: John Sigler <linux.kernel@free.fr>
Subject: Re: System clock frequency offset changes drastically across reboots
Date: Mon, 30 Jul 2007 09:59:48 +0200
Message-ID: <46AD9A74.8070302@free.fr>
References: <46A9DD7A.80104@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: johnstul@us.ibm.com, tglx@linutronix.de
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:40763 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753565AbXG3IAa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jul 2007 04:00:30 -0400
In-Reply-To: <46A9DD7A.80104@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

[ Expanding recipients list ]

John Sigler wrote:

> I'm using 2.6.20.7-rt8 on a P3.

But some ntpd users have reported the problem with mainline kernels and 
different versions.

> I've noticed that the frequency offset of my system clock (computed 
> either by ntpd, or by hand) changes drastically across reboots.
> 
> By drastically, I mean +/- 60 ppm every time I reboot.
> 
> Apparently this is caused by some imprecision in the frequency 
> estimation done in calculate_cpu_khz() (arch/i386/kernel/tsc.c)
> 
> My brutally crude work-around was to skip the computation altogether and 
> hard-code the "correct" value for cpu_khz.
> 
> http://linux.kernel.free.fr/cpu_khz.adlink
> 
> Has this issue been investigated more thoroughly by other users?

Regards.
