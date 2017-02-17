From: Mike Galbraith <efault@gmx.de>
Subject: Re: [RT] lockdep munching nr_list_entries like popcorn
Date: Fri, 17 Feb 2017 21:55:47 +0100
Message-ID: <1487364947.2871.3.camel@gmx.de>
References: <1487224986.5258.45.camel@gmx.de>
         <alpine.DEB.2.20.1702160933420.3543@nanos>
         <1487235000.5258.48.camel@gmx.de>
         <alpine.DEB.2.20.1702161001100.3543@nanos>
         <20170216110618.GC6557@twins.programming.kicks-ass.net>
         <1487256179.28442.8.camel@gmx.de>
         <20170216145354.unz44uocud4ybrfq@linutronix.de>
         <1487268380.15359.4.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487268380.15359.4.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2017-02-16 at 19:06 +0100, Mike Galbraith wrote:
> On Thu, 2017-02-16 at 15:53 +0100, Sebastian Andrzej Siewior wrote:
> > On 2017-02-16 15:42:59 [+0100], Mike Galbraith wrote:
> > > 
> > > Weeell, I'm trying to cobble something kinda like that together using
> > > __RT_SPIN_INITIALIZER() instead, but seems mean ole Mr. Compiler NAKs
> > > the PER_CPU_DEP_MAP_INIT() thingy.
> > > 
> > >   CC      mm/swap.o
> > > mm/swap.c:54:689: error: braced-group within expression allowed only
> > > inside a function
> > 
> > so this is what I have now. I need to get the `static' symbol working
> > again and PER_CPU_DEP_MAP_INIT but aside from that it seems to do its
> > job.
> 
> ...
> 
> Yeah, works, I should be able to do an ltp run with stock lockdep
> settings without it taking it's toys and going home in a snit. 
> 
> berio:/sys/kernel/debug/tracing/:[0]# !while
> while sleep 60; do tail -1 trace; done
>            <...>-10315 [064] d...1..   226.953935: add_lock_to_list.isra.24.constprop.42: nr_list_entries: 14223
>                w-13148 [120] d...111   287.414978: add_lock_to_list.isra.24.constprop.42: nr_list_entries: 14465
>                w-16492 [089] d...111   347.128742: add_lock_to_list.isra.24.constprop.42: nr_list_entries: 14653
> (starts kbuild loop)
>  btrfs-transacti-1964  [016] d...1..   411.101549: add_lock_to_list.isra.24.constprop.42: nr_list_entries: 17011
>            <...>-100268 [127] d...112   472.271769: add_lock_to_list.isra.24.constprop.42: nr_list_entries: 18153
>                w-18864 [011] d...1..   534.386443: add_lock_to_list.isra.24.constprop.42: nr_list_entries: 18543
>            <...>-50390 [035] dN..2..   597.794164: add_lock_to_list.isra.24.constprop.42: nr_list_entries: 18765
>            <...>-80098 [127] d...111   659.912145: add_lock_to_list.isra.24.constprop.42: nr_list_entries: 18977
>        checkproc-11123 [017] d...1..   721.483463: add_lock_to_list.isra.24.constprop.42: nr_list_entries: 19247
>           -0     [055] d..h5..   782.685953: add_lock_to_list.isra.24.constprop.42: nr_list_entries: 19383
>            <...>-93632 [055] d...111   835.527817: add_lock_to_list.isra.24.constprop.42: nr_list_entries: 19441

And now Thomas's patch.  Spiffiness.  Now to start ltp.

berio:/sys/kernel/debug/tracing/:[0]# !while 
while sleep 60; do tail -1 trace; done
           <...>-12462 [105] d...1..   211.489528: add_lock_to_list.isra.24.constprop.42: nr_list_entries: 12847
 btrfs-transacti-3136  [002] d...211   272.672777: add_lock_to_list.isra.24.constprop.42: nr_list_entries: 12947
 irq/155-eth2-Tx-4495  [096] dN..213   332.035236: add_lock_to_list.isra.24.constprop.42: nr_list_entries: 13001
(starts kbuild loop)
           <...>-44245 [087] d...114   396.892748: add_lock_to_list.isra.24.constprop.42: nr_list_entries: 13917
           <...>-105411 [067] dN..211   457.708259: add_lock_to_list.isra.24.constprop.42: nr_list_entries: 14367
               w-21800 [113] dN..2..   519.231735: add_lock_to_list.isra.24.constprop.42: nr_list_entries: 14449
         modpost-31558 [020] d....11   576.065855: add_lock_to_list.isra.24.constprop.42: nr_list_entries: 14601
   kworker/dying-11860 [133] d...112   637.170497: add_lock_to_list.isra.24.constprop.42: nr_list_entries: 14679
           <...>-118853 [055] d....11   703.884755: add_lock_to_list.isra.24.constprop.42: nr_list_entries: 14759
           <...>-52143 [090] d...1..   767.624735: add_lock_to_list.isra.24.constprop.42: nr_list_entries: 14813
           <...>-71788 [126] d...1..   829.160330: add_lock_to_list.isra.24.constprop.42: nr_list_entries: 14857
  kworker/u289:5-2991  [002] d...1..   892.402939: add_lock_to_list.isra.24.constprop.42: nr_list_entries: 14883
              sh-15106 [008] d...211   953.172196: add_lock_to_list.isra.24.constprop.42: nr_list_entries: 14937
> 
