From: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Subject: Re: Regression on rt kernel while using POSIX timers
Date: Wed, 1 Mar 2017 16:22:30 +0100
Message-ID: <20170301152230.mjoi44so6t5qy3q2@linutronix.de>
References: <1486579285.29816.105.camel@intel.com>
 <20170210190708.gkx5pzxnd6uhfczn@linutronix.de>
 <1487011713.17279.27.camel@intel.com>
 <20170215165447.zr4k5rmenwvormdk@linutronix.de>
 <20170216020516.GB1733@jcartwri.amer.corp.natinst.com>
 <1487212458.10966.7.camel@intel.com>
 <1487727789.28401.17.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "julia@ni.com" <julia@ni.com>,
        "ranshalit@gmail.com" <ranshalit@gmail.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "Hart, Darren" <darren.hart@intel.com>
To: "Patel, Vedang" <vedang.patel@intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:39861 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751988AbdCAPWr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 Mar 2017 10:22:47 -0500
Content-Disposition: inline
In-Reply-To: <1487727789.28401.17.camel@intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-02-22 01:43:09 [+0000], Patel, Vedang wrote:
> Also, I checked the number of cpu migrations and context switches using
> perf stat. Following are the results for both the cases:
> 
> cyclictest not pinned to CPU: the number of CPU migrations and context
> switches are equal to the number of loops I am running for cyclictest.
> Here, there are a lot of context switches with the ktimersoftd process.
> 
> cyclictest pinned to a CPU: there are very few CPU migrations. But, the
> number of context switches are approximately 3 times the number of
> loops. Most of the context switches are with the swapper (idle)
> process.
> 
> In both the cases, the number of page faults are pretty low (~65).
> 
> I also tried similar experiments with mainline kernel (v4.4.47). The
> number of CPU migrations were pretty low (single digits) for both the
> cases described above. Also, the number of context switches were equal
> to the number of loops provided as an argument to cyclictest.

The hardware interrupt wakes the "timer-softirq" thread. This RT-thread
in turn will wake up your application / cyclictest which uses the
posix-timers. So the priority of this thread is also important. After
the wakeup it is possible that the newer kernel tries migrate the RT
task if possible in order to keep it running as soon as possible. If it
does not migrate it, then either the cyclictest task has to wait or the
"timer-softirq" thread.

> Thanks,
> Vedang Patel
> Software Engineer
> Intel Corporation

Sebastian
