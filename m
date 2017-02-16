From: Julia Cartwright <julia@ni.com>
Subject: Re: Regression on rt kernel while using POSIX timers
Date: Wed, 15 Feb 2017 20:05:16 -0600
Message-ID: <20170216020516.GB1733@jcartwri.amer.corp.natinst.com>
References: <1486579285.29816.105.camel@intel.com>
 <20170210190708.gkx5pzxnd6uhfczn@linutronix.de>
 <1487011713.17279.27.camel@intel.com>
 <20170215165447.zr4k5rmenwvormdk@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Cc: "Patel, Vedang" <vedang.patel@intel.com>,
        "ranshalit@gmail.com" <ranshalit@gmail.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "Hart, Darren" <darren.hart@intel.com>
To: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:51521 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751588AbdBPCFe (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Feb 2017 21:05:34 -0500
Content-Disposition: inline
In-Reply-To: <20170215165447.zr4k5rmenwvormdk@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Feb 15, 2017 at 05:54:47PM +0100, bigeasy@linutronix.de wrote:
> On 2017-02-13 18:48:33 [+0000], Patel, Vedang wrote:
> > I am getting very similar results even if I change the priority of
> > ktimersoftd to 99. Are there any recent rt patches which might have
> > changed the behaviour of POSIX timers? 
> 
> I had this running
> 
> |~# cyclictest -t1 -p 80 -i 500 -l 100000
> |# /dev/cpu_dma_latency set to 0us
> |policy: fifo: loadavg: 627.48 661.98 543.65 406/2254 18149          
> |
> |T: 0 (16148) P:80 I:500 C: 100000 Min:      5 Act:   11 Avg:   11 Max: 23
> 
> on a AMD-A10 box and the latest v4.9-RT. This does not look that bad.
> From tracing it doesn't look too good either. The -m option should be
> your friend. Since the cyclictest isn't pinned to a CPU and I have four
> of them, the scheduler decides to migrate cyclictest on each wake up.
> yay. cyclictest itself gets woken up via a signal from the
> ktimersoftirq.

Perhaps a separate off-shoot topic, but has there been significant
changes in v4.9 upstream (or v4.9-rt) which impact how often migration
is performed?  We've seen what appears to be much more aggressive
migration of SCHED_FAIR tasks, (aggressive in the sense that more
threads are migrated more often), which appears to cause contention on
rq-locks impacting latencies in the wake_up paths.

We're still working to further characterize at this point....hopefully
more information forthcoming.

   Julia
