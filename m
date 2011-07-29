From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [ANNOUNCE] 3.0-rt6 (kgdb working)
Date: Fri, 29 Jul 2011 08:57:31 -0700
Message-ID: <4E32D86B.70301@linux.intel.com>
References: <alpine.LFD.2.02.1107282213000.31246@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Jason Wessel <jason.wessel@windriver.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:62613 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752108Ab1G2P6i (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Jul 2011 11:58:38 -0400
In-Reply-To: <alpine.LFD.2.02.1107282213000.31246@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 07/28/2011 02:43 PM, Thomas Gleixner wrote:
> Dear RT Folks,
> 
> I'm pleased to announce the 3.0-rt6 release.
> 
> Changes versus 3.0-rt4 (I pushed out a rt5 w/o announce)
> 
>   * pin_cpu fix (Yong Zhang)
> 
>   * Various compile fixes (Yong Zhang & myself)
> 
>   * Serial fix for omap
> 
>   * Clocksource lockless watchdog reset
> 
>   * Reenabled CONFIG_RCU_BOOST (problem is unreproducible and maybe
>     related to NO_HZ, which is still disabled. Paul is working on it!)
> 
>   * KGDB work^Whackaround (Jason Wessel)
> 
>     The kgdb workaround is really a hack and wants to be replaced by a
>     proper overhaul for the console/tty maze.
>     See: kgb-serial-hackaround.patch

I just confirmed that this resolves the issue I was seeing while trying
to single step through futex_requeue() on a 2 socket E5680.

Thanks Thomas and Jason,

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel
