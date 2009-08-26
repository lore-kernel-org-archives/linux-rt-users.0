From: Christoph Lameter <cl@linux-foundation.org>
Subject: Re: RFC: THE OFFLINE SCHEDULER
Date: Wed, 26 Aug 2009 15:15:49 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0908261509580.9933@gentwo.org>
References: <4A943A00.9080609@nortel.com> <1251264700.7538.1178.camel@twins> <1251282598.3514.20.camel@raz> <alpine.DEB.1.10.0908260943090.9924@gentwo.org> <1251297910.1791.22.camel@maxim-laptop> <1251298443.4791.7.camel@raz> <1251300625.18584.18.camel@twins>
 <alpine.DEB.1.10.0908261136590.9933@gentwo.org> <1251302598.18584.31.camel@twins> <alpine.DEB.1.10.0908261211340.9933@gentwo.org> <20090826180407.GA13632@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Zijlstra <peterz@infradead.org>,
	raz ben yehuda <raziebe@gmail.com>,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	Chris Friesen <cfriesen@nortel.com>,
	Mike Galbraith <efault@gmx.de>, riel@redhat.com,
	andrew motron <akpm@linux-foundation.org>,
	wiseman@macs.biu.ac.il, lkml <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751682AbZHZTQN@vger.kernel.org>
In-Reply-To: <20090826180407.GA13632@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 26 Aug 2009, Ingo Molnar wrote:

> The thing is, you have cut out (and have not replied to) this
> crutial bit of what Peter wrote:
>
> > > The past year or so you've been whining about the tick latency,
> > > and I've seen exactly _0_ patches from you slimming down the
> > > work done in there, even though I pointed out some obvious
> > > things that could be done.
>
> ... which pretty much settles the issue as far as i'm concerned. If
> you were truly interested in a constructive solution to lower
> latencies in Linux you should have sent patches already for the low
> hanging fruits Peter pointed out.

The noise latencies were already reduced in years earlier to the mininum
(f.e. the work on slab queue cleaning). Certainly more could be done there
but that misses the point.

The point of the OFFLINE scheduler is to completely eliminate the
OS disturbances by getting rid of *all* OS processing on some cpus.

For some reason scheduler developers seem to be threatened by this idea
and they go into bizarre lines of arguments to avoid the issue. Its simple
and doable and the scheduler will still be there after we do this.
