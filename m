From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] generic-ipi: remove kmalloc, cleanup
Date: Sat, 14 Feb 2009 07:46:44 +1030
Message-ID: <200902140746.45320.rusty@rustcorp.com.au>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain> <1234433770.23438.210.camel@twins> <1234440554.23438.264.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Thomas Gleixner <tglx@tglx.de>,
	LKML <linux-kernel@vger.kernel.org>,
	"rt-users" <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Carsten Emde <ce@ceag.ch>, Clark Williams <williams@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:55060 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752336AbZBMXj7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Feb 2009 18:39:59 -0500
In-Reply-To: <1234440554.23438.264.camel@twins>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thursday 12 February 2009 22:39:14 Peter Zijlstra wrote:
> So it put in unconditionally, how about this?
> 
> 
> --
> Subject: generic-smp: remove single ipi fallback for smp_call_function_many()
> 
> In preparation of removing the kmalloc() calls from the generic-ipi code
> get rid of the single ipi fallback for smp_call_function_many().
> 
> Because we cannot get around carrying the cpumask in the data -- imagine
> 2 such calls with different but overlapping masks -- put in a full mask.

OK, if you really want this, please just change it to:
	unsigned long cpumask_bits[BITS_TO_LONGS(CONFIG_NR_CPUS)];

The 'struct cpumask' will be undefined soon when CONFIG_CPUMASK_OFFSTACK=y,
which will prevent assignment and declaration on stack.

I'd be fascinated to see perf numbers once you kill the kmalloc.  Because
this patch will add num_possible_cpus * NR_CPUS/8 bytes to the kernel which
is something we're trying to avoid unless necessary.

Thanks,
Rusty.
