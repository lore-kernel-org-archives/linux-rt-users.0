From: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Subject: Re: Regression on rt kernel while using POSIX timers
Date: Wed, 15 Feb 2017 17:54:47 +0100
Message-ID: <20170215165447.zr4k5rmenwvormdk@linutronix.de>
References: <1486579285.29816.105.camel@intel.com>
 <20170210190708.gkx5pzxnd6uhfczn@linutronix.de>
 <1487011713.17279.27.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: "ranshalit@gmail.com" <ranshalit@gmail.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "Hart, Darren" <darren.hart@intel.com>
To: "Patel, Vedang" <vedang.patel@intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:47864 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751375AbdBOQyx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Feb 2017 11:54:53 -0500
Content-Disposition: inline
In-Reply-To: <1487011713.17279.27.camel@intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-02-13 18:48:33 [+0000], Patel, Vedang wrote:
> I am getting very similar results even if I change the priority of
> ktimersoftd to 99. Are there any recent rt patches which might have
> changed the behaviour of POSIX timers? 

I had this running

|~# cyclictest -t1 -p 80 -i 500 -l 100000
|# /dev/cpu_dma_latency set to 0us
|policy: fifo: loadavg: 627.48 661.98 543.65 406/2254 18149          
|
|T: 0 (16148) P:80 I:500 C: 100000 Min:      5 Act:   11 Avg:   11 Max: 23

on a AMD-A10 box and the latest v4.9-RT. This does not look that bad.
>From tracing it doesn't look too good either. The -m option should be
your friend. Since the cyclictest isn't pinned to a CPU and I have four
of them, the scheduler decides to migrate cyclictest on each wake up.
yay. cyclictest itself gets woken up via a signal from the
ktimersoftirq.

> Also, are POSIX timers really suited for "real-time" applications?I
> believe a similar question was raised by Ran Shalit a few days back: 
> http://www.spinics.net/lists/linux-rt-users/msg16249.html

So it seems to work with no regression as far as I can tell. Due to the
timersoftirq context switch I would suggest to use clock_nanosleep if
possible.

> Thanks,
> Vedang

Sebastian
