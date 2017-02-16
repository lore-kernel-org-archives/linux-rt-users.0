From: Mike Galbraith <efault@gmx.de>
Subject: Re: [RT] lockdep munching nr_list_entries like popcorn
Date: Thu, 16 Feb 2017 19:16:29 +0100
Message-ID: <1487268989.15359.10.camel@gmx.de>
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
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:53458 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932914AbdBPSRJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Feb 2017 13:17:09 -0500
In-Reply-To: <1487268380.15359.4.camel@gmx.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


BTW, this ain't gone.  I'll take a peek.  It doesn't happen in my tree,
seems likely to be because whether running sirqs fully threaded or not,
I don't let one any thread handle what another exists to handle.

[  638.107293] NOHZ: local_softirq_pending 80
[  939.729684] NOHZ: local_softirq_pending 80
[  945.600869] NOHZ: local_softirq_pending 80
[ 1387.101178] NOHZ: local_softirq_pending 80
[ 1387.101343] NOHZ: local_softirq_pending 80
[ 1387.101549] NOHZ: local_softirq_pending 80
[ 1413.313212] NOHZ: local_softirq_pending 80
[ 1413.313305] NOHZ: local_softirq_pending 80
[ 1413.313347] NOHZ: local_softirq_pending 80
> 
