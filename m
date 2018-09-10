Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:39956 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbeIJVNz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 10 Sep 2018 17:13:55 -0400
Date: Mon, 10 Sep 2018 18:18:55 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: PREEMPT_RT_FULL breaks NO_HZ_FULL (full dynticks)
Message-ID: <20180910161855.g34ui7qzevnamffg@linutronix.de>
References: <20180827033922.GA28188@intel.com>
 <20180830141856.tjvispfgqrnz727b@linutronix.de>
 <20180831081819.GB23052@intel.com>
 <20180831163152.vrrntdy7xsej2kwv@linutronix.de>
 <20180831233019.GK8562@jcartwri.amer.corp.natinst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180831233019.GK8562@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Julia Cartwright <julia@ni.com>
Cc: Ramesh Thomas <ramesh.thomas@intel.com>, linux-rt-users@vger.kernel.org, fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org

On 2018-08-31 18:30:19 [-0500], Julia Cartwright wrote:
> On Fri, Aug 31, 2018 at 06:31:52PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2018-08-31 01:18:20 [-0700], Ramesh Thomas wrote:
> [..]
> > > 2. Timer is armed even though only a single high priority task is running.
> > 
> > something must have armed that timer. The clock_nanosleep() API won't
> > use those new threads but for instance timer_create() / timer_settime()
> > will.
> 
> Did we actually ever solve the "ktimersoftd uselessly woken on every
> tick" problem?

I think so, yes. According to the report the problem does not happen the
first invocation. However the "ktimersoftd uselessly woken on every
tick" problem occurred "always".

>    Julia

Sebastian
