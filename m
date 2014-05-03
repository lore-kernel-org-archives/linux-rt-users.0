From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [patch 0/6] 3.14-rt1 fixes
Date: Sat, 3 May 2014 10:32:57 +0200
Message-ID: <20140503083257.GA16242@opentech.at>
References: <1399029159.5233.124.camel@marge.simpson.net> <5363840B.6020402@pavlinux.ru> <1399031023.5233.145.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pavel@pavlinux.ru, RT <linux-rt-users@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:35380 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920AbaECIll (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 3 May 2014 04:41:41 -0400
Content-Disposition: inline
In-Reply-To: <1399031023.5233.145.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 02 May 2014, Mike Galbraith wrote:

> On Fri, 2014-05-02 at 15:39 +0400, Pavel Vasilyev wrote: 
> > 02.05.2014 15:12, Mike Galbraith ??????????:
> > > The following patches are fixes that fell out of testing rt1.  Patches
> > > 1-4 are intended to be folded into existing patches, 5-6 are
> > > replacements.
> > >
> > > fold:
> > > 1/6 - preempt-lazy-support.patch
> > > 2/6 - x86-preempt-lazy.patch
> > > 3/6 - hotplug-light-get-online-cpus.patch
> > > 4/6 - stomp-machine-raw-lock.patch
> > >
> > > replace:
> > > 5/6 - (prep)
> > > 6/6 - stomp-machine-deal-clever-with-stopper-lock.patch
> > >
> > > drop: (buggy - calls migrate_disable() _after_ maybe blocking)
> > > migrate_disable-pushd-down-in-atomic_dec_and_spin_lo.patch
> > 
> > 
Why would calling migrate_disable be buggy after blocking ?
at that point any per cpu data is not yet being accessed so its perfectly fine
to

  lock->block
   -> migrate 
    -> unblock->lock 
     -> migrate_disable on a new CPU
      -> access per_cpu object
     -> migrate_enable
  -> unlock

what problems would there be ?

thx!
hofrat

