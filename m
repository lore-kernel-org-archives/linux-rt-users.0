From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Regression on rt kernel while using POSIX timers
Date: Mon, 6 Mar 2017 12:29:33 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1703061222150.3561@nanos>
References: <1486579285.29816.105.camel@intel.com>  <20170210190708.gkx5pzxnd6uhfczn@linutronix.de>  <1487011713.17279.27.camel@intel.com>  <20170215165447.zr4k5rmenwvormdk@linutronix.de>  <20170216020516.GB1733@jcartwri.amer.corp.natinst.com>
 <1487212458.10966.7.camel@intel.com> <1487727789.28401.17.camel@intel.com>  <20170301152230.mjoi44so6t5qy3q2@linutronix.de>  <472B70D9-E1AF-4D14-BE79-ABAAC74BA4DB@gmail.com>  <1488424982.29259.32.camel@intel.com>  <20170303194159.GD29100@jcartwri.amer.corp.natinst.com>
  <alpine.DEB.2.20.1703032202240.3691@nanos> <1488584180.29259.76.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "julia@ni.com" <julia@ni.com>,
        "ranshalit@gmail.com" <ranshalit@gmail.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "tlsmith3777@gmail.com" <tlsmith3777@gmail.com>,
        "Hart, Darren" <darren.hart@intel.com>
To: "Patel, Vedang" <vedang.patel@intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:33993 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752673AbdCFL3u (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 6 Mar 2017 06:29:50 -0500
In-Reply-To: <1488584180.29259.76.camel@intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 3 Mar 2017, Patel, Vedang wrote:
> I now have the following concerns and comments:
> 1. real-time kernel vs. Mainline kernel: The real-time kernel is worse
> with POSIX timers than the mainline kernel. This is odd. Is this
> because the softirqs are not the same anymore(Sorry, I am still not
> familiar with what they have become. I deduced the "not the same" part
> from commit messages/comments in code. :))? Also, in https://git.kernel
> .org/cgit/linux/kernel/git/rt/linux-stable-rt.git/commit/?h=v4.4-
> rt&id=4aa7cba57f73acf1e3e4998ae1650965317c2de1, it is mentioned:
> "
> Bring back the softirq split for now, until we fixed the signal
> delivery problem for real.
> "
> What signal delivery problem is being referred to?

The problem with these timers is that the heavy lifting of signal
processing happens in "stolen" context. That means that the work is not
done in the context of the process/thread which armed the timer, but in
softirq context.

What we really want here is the following:

     timer expires()
     	   mark timer expired in thread/process
	   eventually wakeup thread

This is simple to achieve for timers where the signal is directed to a
thread, but it's way more complex for process wide signal delivery.

> 2. In the case the CPU affinity is set, The CPU is shared between
> cyclictest thread and the ktimersoftd thread. So, in the end, 1 CPU
> migration is cheaper than 3 context switches... Is this the right
> analysis? I know this will vary from application to application.

No, migration is not generally cheaper, in most cases its more expensive.

Thanks,

	tglx
