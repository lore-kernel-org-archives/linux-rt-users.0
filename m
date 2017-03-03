From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Regression on rt kernel while using POSIX timers
Date: Fri, 3 Mar 2017 22:09:56 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1703032202240.3691@nanos>
References: <1486579285.29816.105.camel@intel.com> <20170210190708.gkx5pzxnd6uhfczn@linutronix.de> <1487011713.17279.27.camel@intel.com> <20170215165447.zr4k5rmenwvormdk@linutronix.de> <20170216020516.GB1733@jcartwri.amer.corp.natinst.com>
 <1487212458.10966.7.camel@intel.com> <1487727789.28401.17.camel@intel.com> <20170301152230.mjoi44so6t5qy3q2@linutronix.de> <472B70D9-E1AF-4D14-BE79-ABAAC74BA4DB@gmail.com> <1488424982.29259.32.camel@intel.com>
 <20170303194159.GD29100@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "Patel, Vedang" <vedang.patel@intel.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "tlsmith3777@gmail.com" <tlsmith3777@gmail.com>,
        "ranshalit@gmail.com" <ranshalit@gmail.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "Hart, Darren" <darren.hart@intel.com>
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:51735 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbdCCVer (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Mar 2017 16:34:47 -0500
In-Reply-To: <20170303194159.GD29100@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 3 Mar 2017, Julia Cartwright wrote:
> 
> Without PREEMPT_RT_FULL enabled, the critical section is executed with
> "raw" spinlocks, and is therefore non-preemptible.  However, with
> RT_FULL, the preemptibility of the section leads to the "bounce".
> 
> That should make it clear why ktimersoftd would be PI boosted, as well.
> 
> Now, it isn't clear to me why the affinitized scenario appears to make
> this happen more frequently...  Nor do I have a handle on what to do to
> fix this (if anything).

The point here is:

perf stat taskset 1 cyclictest -t1

will make the control thread of cyclictest affine to cpu 0 and also the
measuring thread. perf stat counts the context switches of both.

CPU 0
cyclictest-control

--> Interrupt

ksoftirqd

cyclictest-measure
  rearm timer
  sleep

cyclictest-control

....

versus a non affine scenario

CPU0   	     	    CPU1		CPU2
cyclictest-control  interrupt
		    ksoftirqd	-->	cyclictest-measure
		    			   rearm timer
					   sleep
					
					interrupt
		    cyclicttest <--	ksoftirqd
		    -measure		

Thanks,

	tglx
