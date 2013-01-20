From: John Morris <john@zultron.com>
Subject: Detecting PREEMPT_RT
Date: Sat, 19 Jan 2013 18:13:20 -0600
Message-ID: <50FB36A0.7000702@zultron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from kayako.ext.zultron.com ([67.18.89.240]:37451 "EHLO
	kayako.ext.zultron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389Ab3ATAni (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 19 Jan 2013 19:43:38 -0500
Received: from norman.zultron.com (norman.zultron.com [192.168.7.8])
	by kayako.ext.zultron.com (Postfix) with ESMTP id 0CEA837F32
	for <linux-rt-users@vger.kernel.org>; Sat, 19 Jan 2013 18:13:23 -0600 (CST)
Received: from caps.zultron.com (unknown [192.168.7.243])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by norman.zultron.com (Postfix) with ESMTP id 37F6D80243
	for <linux-rt-users@vger.kernel.org>; Sat, 19 Jan 2013 18:13:58 -0600 (CST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi list,

I'm part of a project that recently added PREEMPT_RT support (as well as
Xenomai) to LinuxCNC/EMC2.

The next sub-project is a 'universal binary'.  The LCNC real-time module
will run some checks to determine what RT systems, if any, are available
on the running kernel, and then load the appropriate RT support module.

We wish to distinguish between PREEMPT_RT and non-RT kernels because
LCNC must confirm that the kernel really does have realtime
capabilities, if that's what the user expects, and print big warning
messages if not.  LCNC drives machines that weigh many tons and spins
spindles at 24k RPM, so this is important!

The RT PREEMPT HOWTO discusses checking the kernel here:

https://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO#Checking_the_Kernel

One method is to use string matching against the kernel version, which
I'm a bit suspicious of.

An improvement, figure 7 suggests using string matching against the
process list in search of kernel thread names matching '[softirq-foo]'.

Figure 8 show how to check /proc/interrupts on older kernels, but 9
states this doesn't work for newer kernels, so this isn't an option.

We haven't found /proc/config.gz in any vendor-provided PREEMPT_RT
kernels, so that is not an option either.

So, is string matching against the process list the best detection
method, or is there something I've missed?

	John
