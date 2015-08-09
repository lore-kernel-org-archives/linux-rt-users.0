From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH RT 0/6] Linux 3.14.48-rt49-rc1
Date: Sat, 8 Aug 2015 20:06:59 -0400
Message-ID: <20150809000659.GH5998@windriver.com>
References: <20150806221736.555188732@goodmis.org>
 <20150808231017.GG5998@windriver.com>
 <20150808192346.740ece60@grimm.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:61227 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992728AbbHIAHZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 8 Aug 2015 20:07:25 -0400
Content-Disposition: inline
In-Reply-To: <20150808192346.740ece60@grimm.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

[Re: [PATCH RT 0/6] Linux 3.14.48-rt49-rc1] On 08/08/2015 (Sat 19:23) Steven Rostedt wrote:

> On Sat, 8 Aug 2015 19:10:17 -0400
> Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
> 
> 
> > So we took 20 IRQs in 5s, or 4/s ; not quite the 1/s minimum, but definitely not
> > the HZ/s we'd get w/o NOHZ_FULL.  Re-running it got consistently 18-20 IRQ / 5s.
> 
> OK, so NO_HZ_FULL still isn't great on -rt, but this shows that it
> keeps disturbances much lower than without it.

Here is several runs on vanilla ("make oldconfig" of the -rt .config)
and all else (bootargs, isolation, rcu offload) the same:

--------------------------------------------------
root@testbox:/home/paul# ./t 
 LOC:      86341        740        724        708        694        679        663        649        633        619        545        526        512        494        481        463        448        434        420        404   Local timer interrupts
 LOC:      91349        742        727        708        694        679        663        649        633        619        545        526        512        496        483        465        450        436        423        406   Local timer interrupts
 LOC:      96353        742        727        710        697        709        665        651        635        622        547        528        514        496        483        465        450        436        423        406   Local timer interrupts
root@testbox:/home/paul# ./t 
 LOC:     106188        744        729        712        699        711        667        653        638        624        549        530        514        498        485        467        452        438        425        408   Local timer interrupts
 LOC:     111194        746        729        712        699        711        667        653        638        624        549        530        516        500        487        469        454        440        427        410   Local timer interrupts
 LOC:     116199        746        731        714        701        729        669        655        640        626        551        532        516        500        487        469        454        440        427        410   Local timer interrupts
root@testbox:/home/paul# ./t 
 LOC:     122860        748        733        716        703        731        669        655        640        626        551        532        518        502        489        471        456        442        429        412   Local timer interrupts
 LOC:     127866        748        733        716        703        731        671        657        642        628        553        534        520        504        492        473        456        442        429        412   Local timer interrupts
 LOC:     132872        750        735        718        706        748        671        657        642        628        553        534        520        504        492        473        458        444        431        415   Local timer interrupts
root@testbox:/home/paul# cat /proc/version 
Linux version 3.14.48 (paul@yow-dellw-pg2) (gcc version 4.8.2 (Ubuntu 4.8.2-19ubuntu1) ) #2 SMP PREEMPT Sat Aug 8 19:52:12 EDT 2015
root@testbox:/home/paul# 
--------------------------------------------------

So 30, 18, and 17 per 5s interval.  I'd say that is statisitcally close
enough to -rt on this simple test to call -rt on par with vanilla.

Things might show a difference with more complicated tests, more cores
doing real work etc etc. -- this really is just a simple sanity test
though...  but at least it is a test that we now can pass!

Paul.
--

> 
> Thanks for the report!
> 
> -- Steve
> 
> > 
> > I specifically did NOT unplug and replug cores to "clean" them of tasks; the
> > hotplug code just seems to unstable for that from what I've seen in the past,
> > and by the looks of the irq counts above, there was no need to either.
> > 
> > The rootfs was basically a ubu 14.10 server install (no X11/gfx) -- not that
> > it should matter - so long as other tasks weren't running on the nohz cores.
> > 
> > Paul.
> > --
> > 
> > >
> > > Enjoy,
> > >
> > > -- Steve
> > >
> 
