From: "Chatterjee, Amit" <amit.chatterjee@ti.com>
Subject: 2.6.33-rt6 on Beagle
Date: Fri, 12 Mar 2010 17:47:56 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030D084301@dbde02.ent.ti.com>
References: <alpine.LFD.2.00.1002241740410.4245@localhost.localdomain>
 <alpine.LFD.2.00.1002262041020.4245@localhost.localdomain>
 <alpine.LFD.2.00.1003121124120.22855@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: "linux-rt-users-owner@vger.kernel.org"
	<linux-rt-users-owner@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58105 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932162Ab0CLMSE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 12 Mar 2010 07:18:04 -0500
In-Reply-To: <alpine.LFD.2.00.1003121124120.22855@localhost.localdomain>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,
	I am unable to boot the kernel (as available in this link - http://git.kernel.org/?p=linux/kernel/git/tip/linux-2.6-tip.git;a=shortlog;h=refs/heads/rt/2.6.33) on Beagle board. Kernel is unable to uncompress itself & crashing. Tool chain used is - gcc version 4.4.1 (Sourcery G++ Lite 2009q3-67). I will check with older toolchain & keep it posted.

Regards,
Amit

-----Original Message-----
From: linux-rt-users-owner@vger.kernel.org [mailto:linux-rt-users-owner@vger.kernel.org] On Behalf Of Thomas Gleixner
Sent: Friday, March 12, 2010 4:14 PM
To: LKML
Cc: rt-users; Ingo Molnar; Peter Zijlstra; Steven Rostedt; Clark Williams; nando@ccrma.Stanford.EDU; Carsten Emde; Wu Zhangjin; Nicholas Mc Guire
Subject: [ANNOUNCE] 2.6.33-rt6

We are pleased to announce the next update to our new preempt-rt
series.

For those who wonder about -rt5. It's there as well, but the tag is
more or less a separation point.

Changes from -rt4 to -rt5:

  8fafaf5: v2.6.33-rt5
  f6e20d0: tracing: Define pid functions for all config combinations
  4216e30: vga console: Remove the CON_ATOMIC flag
  7033151: x86: Fix 32bit HIGHMEM=n compile
  c28c2c8: x86: highmem: Remove stale function prototype
  fb301a4: mm: highmem: Fix stale BUG_ON condition

Changes from -rt5 to -rt6:

 af5d4b6: v2.6.33-rt6
 1054085: Merge branch 'rt-2.6.33-queue' of git://dev.lemote.com/rt4ls into rt/2.6.33

 This brings MIPS back into the -RT world! 

  Thanks to Wu Zhangjin !!
 
 Note that the MIPS support is only tested on Loongson hardware so
 your milage with other MIPS incarnations may vary.

Known issues for -rt6:

  - load balancer induced latencies. Can be observed in extreme system
    overload situations (load avg > 1000), so probably not a real
    world issue, but still it shows a weak point.

  - rcu stalls on overload situations caused by exit_io_context() RCU
    read locked section which heavily contends on sleeping locks. Still
    under investigation.

Download locations:
   
   http://www.kernel.org/pub/linux/kernel/projects/rt/

Git development branch:
   git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.git rt/head

Git release branch:
   git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.git rt/2.6.33

Gitweb:
   http://git.kernel.org/?p=linux/kernel/git/tip/linux-2.6-tip.git;a=shortlog;h=rt/2.6.33

Information on the RT patch can be found at:

   http://rt.wiki.kernel.org/index.php/Main_Page
 
To build the 2.6.33-rt6 tree, the following patches should be
applied:

   http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.33.tar.bz2
   http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.33-rt6.bz2

Enjoy !

      tglx
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
