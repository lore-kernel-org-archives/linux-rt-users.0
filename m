From: David Miller <davem@davemloft.net>
Subject: Re: BUG in 2.6.20-rt8
Date: Sat, 24 Feb 2007 22:37:44 -0800 (PST)
Message-ID: <20070224.223744.59470086.davem@davemloft.net>
References: <20070225050212.GA17258@linux.vnet.ibm.com>
	<20070225062747.GA13432@elte.hu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: paulmck@linux.vnet.ibm.com, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: mingo@elte.hu
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:57653
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S932988AbXBYGhq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 25 Feb 2007 01:37:46 -0500
In-Reply-To: <20070225062747.GA13432@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>
Date: Sun, 25 Feb 2007 07:27:47 +0100

> 
> * Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> 
> > I got the following running stock 2.6.20-rt8 on an 4-CPU 1.8GHz 
> > Opteron box.  The machine continued to run a few rounds of kernbench 
> > and LTP. Looks a bit scary -- a tasklet was "stolen" from 
> > __tasklet_action().
> > 
> > Thoughts?  In the meantime, kicking it off again to see if it repeats.
> 
> > BUG: at kernel/softirq.c:559 __tasklet_action()
> 
> this seems to happen very sporadically. Seems to happen more likely on 
> hyperthreading CPUs. It is very likely caused by the 
> redesign-tasklet-locking-to-be-sane patch below - which is a quick hack 
> of mine from early -rt days. Can you see any obvious bug in it? The 
> cmpxchg logic is certainly a bit ... tricky, locking-wise.

Ingo, please don't use cmpxchg() in generic code, we support several
processors that simply cannot do it.

Instead of saying "it's just something special in -rt for now", take
it out now so that what you do eventually push upstream does get
tested.

Thanks.
