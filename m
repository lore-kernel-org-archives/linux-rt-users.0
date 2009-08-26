From: Ingo Molnar <mingo@elte.hu>
Subject: Re: RFC: THE OFFLINE SCHEDULER
Date: Wed, 26 Aug 2009 23:08:12 +0200
Message-ID: <20090826210812.GA22765@elte.hu>
References: <1251297910.1791.22.camel@maxim-laptop> <1251298443.4791.7.camel@raz> <1251300625.18584.18.camel@twins> <alpine.DEB.1.10.0908261136590.9933@gentwo.org> <1251302598.18584.31.camel@twins> <alpine.DEB.1.10.0908261211340.9933@gentwo.org> <20090826180407.GA13632@elte.hu> <alpine.DEB.1.10.0908261509580.9933@gentwo.org> <20090826193252.GA14721@elte.hu> <alpine.DEB.1.10.0908261627110.5554@gentwo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Zijlstra <peterz@infradead.org>,
	raz ben yehuda <raziebe@gmail.com>,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	Chris Friesen <cfriesen@nortel.com>,
	Mike Galbraith <efault@gmx.de>, riel@redhat.com,
	andrew motron <akpm@linux-foundation.org>,
	wiseman@macs.biu.ac.il, lkml <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org
To: Christoph Lameter <cl@linux-foundation.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:46727 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548AbZHZVIl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Aug 2009 17:08:41 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0908261627110.5554@gentwo.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


* Christoph Lameter <cl@linux-foundation.org> wrote:

> > to have sharp teeth nor any apparent poison fangs) - i simply 
> > concur with the reasons Peter listed that it is a technically 
> > inferior solution.
> 
> Ok so you are saying that the reduction of OS latencies will make 
> the processor completely available and have no disturbances like 
> OFFLINE scheduling?

I'm saying that your lack of trying to reduce even low-hanging-fruit 
latency sources that were pointed out to you fundamentally destroys 
your credibility in claiming that they are unfixable for all 
practical purposes.

Or, to come up with a car analogy: it's a bit as if at a repair shop 
you complained that your car has a scratch on its cooler grid that 
annoys you, and you insisted that it be outfitted with a new diesel 
engine which needs no cooler grid (throwing away the nice Hemi block 
it has currently) - and ignored the mechanic's opinion that he loves 
the Hemi and that to him the scratch looks very much like bird-sh*t 
and that a proper car wash might do the trick too ;-)

> Peter has not given a solution to the problem. Nor have you.

What do you mean by 'has given a solution' - a patch?

Peter mentioned a few things that you can try to reduce the 
worst-case latency of the timer tick.

Peter also implemented the hr-tick solution (CONFIG_SCHED_HRTICK) - 
it's mostly upstream but disabled because it had problems - if you 
are interested in improving this area you can fix and complete it.

That would benefit ordinary Linux users too, not just rare isolation 
apps.

	Ingo
