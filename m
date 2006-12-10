From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.19-rt11 boot failure
Date: Sun, 10 Dec 2006 09:02:15 +0100
Message-ID: <20061210080215.GA12359@elte.hu>
References: <60535.192.168.1.8.1165699722.squirrel@www.rncbc.org> <1165700275.24604.350.camel@localhost.localdomain> <457B5ABE.4080709@rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:35549 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760377AbWLJIED (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 10 Dec 2006 03:04:03 -0500
To: Rui Nuno Capela <rncbc@rncbc.org>
Content-Disposition: inline
In-Reply-To: <457B5ABE.4080709@rncbc.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> >> Sorry for the interrupt, but all my 2.6.19-rt11 builds very fail 
> >> early on boot. It doesn't matter if its UP or SMP. This is a sample 
> >> of what I could capture on one case via serial console:
> > 
> > Can you please disable CONFIG_HPET_TIMER ?
> 
> Yes, sorry :) now it boots and runs apparently fine.
> 
> I always had HPET_TIMER enabled until now. Ok, last time I tried was 
> on 2.6.19-rt6.  Somehow I've failed to know or simply missed whether 
> HPET it's supposed to be off on PREEMPT_RT kernels. Maybe some simple 
> heads-up would be welcome :)

by -rt12 time we'll hopefully be able to get HPET back into working 
order again.

> Notice that lately I have both HIGH_RES_TIMERS and NO_HZ enabled. Is 
> there any sense on having those options mutually exclusive with 
> HPET_TIMER ?

nope, it's a regression.

	Ingo
