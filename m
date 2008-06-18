From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH][resubmit] x86: enable preemption in delay
Date: Wed, 18 Jun 2008 09:55:18 +0200
Message-ID: <20080618075518.GD4135@elte.hu>
References: <200805252108.25011.mitov@issp.bas.bg> <200806091911.21850.mitov@issp.bas.bg> <20080609161606.GA24841@elte.hu> <200806152058.17142.mitov@issp.bas.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>, akpm@osdl.org,
	Clark Williams <clark.williams@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andi Kleen <andi-suse@firstfloor.org>
To: Marin Mitov <mitov@issp.bas.bg>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:60878 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064AbYFRHz4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Jun 2008 03:55:56 -0400
Content-Disposition: inline
In-Reply-To: <200806152058.17142.mitov@issp.bas.bg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


* Marin Mitov <mitov@issp.bas.bg> wrote:

> Why not something like that (do keep in mind I am not an expert :-):
> 
> static void delay_tsc(unsigned long loops)
> {
> 	get and store the mask of allowed cpus;
> 	/*     prevent the migration   */
> 	set the mask of allowed cpus to the current cpu only;
> 	/*     is it possible? could it be guaranteed?    */
> 	loop for the delay;
> 	restore the old mask of allowed cpus;
> }
> 
> You have got the idea. Could it be realized? Is it more expensive than 
> the current realization? So, comments, please.

hm, changing/saving/restorig cpus_allowed is really considered a 'heavy' 
operation compared to preempt_disable(). On a 4096 CPUs box cpus_allowed 
is 4096 bits which is half a kilobyte ...

preempt_disable()/enable() on the other hand only touches a single 
variable, (thread_info->preempt_count which is an u32)

	Ingo
