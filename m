From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Regression on rt kernel while using POSIX timers
Date: Tue, 7 Mar 2017 18:03:03 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1703071800330.3584@nanos>
References: <1486579285.29816.105.camel@intel.com>   <20170210190708.gkx5pzxnd6uhfczn@linutronix.de>   <1487011713.17279.27.camel@intel.com>   <20170215165447.zr4k5rmenwvormdk@linutronix.de>   <20170216020516.GB1733@jcartwri.amer.corp.natinst.com>  
 <1487212458.10966.7.camel@intel.com> <1487727789.28401.17.camel@intel.com>   <20170301152230.mjoi44so6t5qy3q2@linutronix.de>   <472B70D9-E1AF-4D14-BE79-ABAAC74BA4DB@gmail.com>   <1488424982.29259.32.camel@intel.com>   <20170303194159.GD29100@jcartwri.amer.corp.natinst.com>
  <alpine.DEB.2.20.1703032202240.3691@nanos>  <1488584180.29259.76.camel@intel.com>  <alpine.DEB.2.20.1703061222150.3561@nanos> <1488852108.29259.85.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "ranshalit@gmail.com" <ranshalit@gmail.com>,
        "julia@ni.com" <julia@ni.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "tlsmith3777@gmail.com" <tlsmith3777@gmail.com>,
        "Hart, Darren" <darren.hart@intel.com>
To: "Patel, Vedang" <vedang.patel@intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:43724 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933261AbdCGUlk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 7 Mar 2017 15:41:40 -0500
In-Reply-To: <1488852108.29259.85.camel@intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 7 Mar 2017, Patel, Vedang wrote:
> On Mon, 2017-03-06 at 12:29 +0100, Thomas Gleixner wrote:
> 
> > This is simple to achieve for timers where the signal is directed to
> > a thread, but it's way more complex for process wide signal delivery.
> > 
> So, does this mean that we should be asking people not to use POSIX
> timers until this is corrected?

Well, we always recommended clock_nanosleep() to be used and to avoid
signal based timers when ever possible.

> Also, Is there a way to specify which ktimersoftd thread (essentially
> selecting a particular CPU)to use while creating a timer? Currently,
> the ktimersoftd thread corresponding to the thread on which the CPU is
> running is being used by cyclictest. This would prevent the bounce
> between ktimersoftd and cyclictest thread when both of them are on the
> same CPU.

Nope. This is even more complex than you describe it and no, we definitely
don't want to think about this in the first place.

Thanks,

	tglx

