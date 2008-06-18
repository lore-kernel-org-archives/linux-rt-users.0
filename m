From: "Gregory Haskins" <ghaskins@novell.com>
Subject: Re: [PATCH][resubmit] x86: enable preemption in delay
Date: Wed, 18 Jun 2008 06:08:38 -0600
Message-ID: <4858C286.BA47.005A.0@novell.com>
References: <200805252108.25011.mitov@issp.bas.bg>
 <200806091911.21850.mitov@issp.bas.bg> <20080609161606.GA24841@elte.hu>
 <200806152058.17142.mitov@issp.bas.bg> <20080618075518.GD4135@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: "Andi Kleen" <andi-suse@firstfloor.org>,
	"Clark Williams" <clark.williams@gmail.com>,
	"Steven Rostedt" <rostedt@goodmis.org>,
	"Peter Zijlstra" <peterz@infradead.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Linus Torvalds" <torvalds@linux-foundation.org>, <akpm@osdl.org>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	"LKML" <linux-kernel@vger.kernel.org>,
	"linux-rt-users" <linux-rt-users@vger.kernel.org>
To: "Ingo Molnar" <mingo@elte.hu>, "Marin Mitov" <mitov@issp.bas.bg>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sinclair.provo.novell.com ([137.65.248.137]:20819 "EHLO
	sinclair.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137AbYFRMId convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Jun 2008 08:08:33 -0400
In-Reply-To: <20080618075518.GD4135@elte.hu>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>>> On Wed, Jun 18, 2008 at  3:55 AM, in message <20080618075518.GD4135@elte.hu>,
Ingo Molnar <mingo@elte.hu> wrote: 

> * Marin Mitov <mitov@issp.bas.bg> wrote:
> 
>> Why not something like that (do keep in mind I am not an expert :-):
>> 
>> static void delay_tsc(unsigned long loops)
>> {
>> 	get and store the mask of allowed cpus;
>> 	/*     prevent the migration   */
>> 	set the mask of allowed cpus to the current cpu only;
>> 	/*     is it possible? could it be guaranteed?    */
>> 	loop for the delay;
>> 	restore the old mask of allowed cpus;
>> }
>> 
>> You have got the idea. Could it be realized? Is it more expensive than 
>> the current realization? So, comments, please.
> 
> hm, changing/saving/restorig cpus_allowed is really considered a 'heavy' 
> operation compared to preempt_disable(). On a 4096 CPUs box cpus_allowed 
> is 4096 bits which is half a kilobyte ...
> 
> preempt_disable()/enable() on the other hand only touches a single 
> variable, (thread_info->preempt_count which is an u32)
> 
> 	Ingo

FWIW:  I had submitted some "migration disable" patches a while back that would solve this without the cpus_allowed manipulations described here.  Its more expensive than a preempt-disable (but its preemptible), yet its way cheaper (and more correct / less racy) than chaning cpus_allowed.  I could resubmit if there was any interest, though I think Ingo said he didnt like the concept on the first pass.  Anyway, FYI.

-Greg

