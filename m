From: Christoph Lameter <cl@linux-foundation.org>
Subject: Re: RFC: THE OFFLINE SCHEDULER
Date: Tue, 25 Aug 2009 11:23:51 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0908251122020.26329@gentwo.org>
References: <1250983671.5688.21.camel@raz>  <1251004897.7043.70.camel@marge.simson.net>  <1251018551.3810.35.camel@raz>  <1251012621.14003.71.camel@marge.simson.net> <1251025557.3810.65.camel@raz> <1251021133.14003.172.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: raz ben yehuda <raziebe@gmail.com>, riel@redhat.com, mingo@elte.hu,
	peterz@infradead.org, andrew motron <akpm@linux-foundation.org>,
	wiseman@macs.biu.ac.il, lkml <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755201AbZHYPd5@vger.kernel.org>
In-Reply-To: <1251021133.14003.172.camel@marge.simson.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, 23 Aug 2009, Mike Galbraith wrote:

> The rest, I'll leave off replying to, we're kinda splitting hairs.  I
> don't see a big generic benefit to OFFSCHED or ilk, others do.

No we are not splitting hairs. OFFSCHED takes the OS noise (interrupts,
timers, RCU, cacheline stealing etc etc) out of certain processors. You
cannot run an undisturbed piece of software on the OS right now.
