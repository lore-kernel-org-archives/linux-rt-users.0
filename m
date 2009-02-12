From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch] generic-ipi: remove kmalloc, cleanup
Date: Thu, 12 Feb 2009 13:36:11 +0100
Message-ID: <1234442171.23438.266.camel@twins>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain>
	 <20090212005032.GA4788@nowhere> <20090212021257.GB4697@nowhere>
	 <20090212081801.GA22979@elte.hu> <20090212081923.GA26838@elte.hu>
	 <1234430564.23438.205.camel@twins>  <20090212100756.GA12790@elte.hu>
	 <1234433770.23438.210.camel@twins>  <1234440554.23438.264.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Frederic Weisbecker <fweisbec@gmail.com>,
	Thomas Gleixner <tglx@tglx.de>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Carsten Emde <ce@ceag.ch>,
	Clark Williams <williams@redhat.com>,
	rusty <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:49333 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756561AbZBLMeV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Feb 2009 07:34:21 -0500
In-Reply-To: <1234440554.23438.264.camel@twins>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2009-02-12 at 13:09 +0100, Peter Zijlstra wrote:


> @@ -137,8 +137,10 @@ void generic_smp_call_function_interrupt(void)
>  			 */
>  			smp_wmb();
>  			data->csd.flags &= ~CSD_FLAG_WAIT;
> -		}
> -		if (data->csd.flags & CSD_FLAG_ALLOC)
> +		} else if (data->csd.flags & CSD_FLAG_LOCK) {
> +			smp_wmb();
> +			data->csd.flags &= ~CSD_FLAG_LOCK;
> +		} else if (data->csd.flags & CSD_FLAG_ALLOC)
>  			call_rcu(&data->rcu_head, rcu_free_call_data);
>  	}
>  	rcu_read_unlock();

Hmm, I think this bit ought to go in rcu_free_call_data(), otherwise we
can have that same race again..

I'd better put a comment in on why we use RCU here.
