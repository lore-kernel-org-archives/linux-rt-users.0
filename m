From: Mike Galbraith <efault@gmx.de>
Subject: Re: RFC: THE OFFLINE SCHEDULER
Date: Tue, 25 Aug 2009 19:56:33 +0200
Message-ID: <1251222993.7023.53.camel@marge.simson.net>
References: <1250983671.5688.21.camel@raz>
	 <1251004897.7043.70.camel@marge.simson.net> <1251018551.3810.35.camel@raz>
	 <1251012621.14003.71.camel@marge.simson.net> <1251025557.3810.65.camel@raz>
	 <1251021133.14003.172.camel@marge.simson.net>
	 <alpine.DEB.1.10.0908251122020.26329@gentwo.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: raz ben yehuda <raziebe@gmail.com>, riel@redhat.com, mingo@elte.hu,
	peterz@infradead.org, andrew motron <akpm@linux-foundation.org>,
	wiseman@macs.biu.ac.il, lkml <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org
To: Christoph Lameter <cl@linux-foundation.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755529AbZHYR4i@vger.kernel.org>
In-Reply-To: <alpine.DEB.1.10.0908251122020.26329@gentwo.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2009-08-25 at 11:23 -0400, Christoph Lameter wrote:
> On Sun, 23 Aug 2009, Mike Galbraith wrote:
> 
> > The rest, I'll leave off replying to, we're kinda splitting hairs.  I
> > don't see a big generic benefit to OFFSCHED or ilk, others do.
> 
> No we are not splitting hairs. OFFSCHED takes the OS noise (interrupts,
> timers, RCU, cacheline stealing etc etc) out of certain processors. You
> cannot run an undisturbed piece of software on the OS right now.

I asked the questions I did out of pure curiosity, and that curiosity
has been satisfied.  It's not that I find it useless or whatnot (or that
my opinion matters to anyone but me;).  I personally find the concept of
injecting an RTOS into a general purpose OS with no isolation to be
alien.  Intriguing, but very very alien.

	-Mike
