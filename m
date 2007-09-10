From: Daniel Walker <dwalker@mvista.com>
Subject: Re: v2.6.23-rc4-rt1 / new project URL
Date: Mon, 10 Sep 2007 08:18:12 -0700
Message-ID: <1189437492.14752.1.camel@imap.mvista.com>
References: <1188593944.9647.15.camel@chaos>
	 <1189427714.21778.15.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	RT-Users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760730AbXIJPcH@vger.kernel.org>
In-Reply-To: <1189427714.21778.15.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2007-09-10 at 14:35 +0200, Peter Zijlstra wrote:

> > - simple_irq change (Kevin Hilman): needs more thought
> > - RCU updates (Paul McKenney): needs proper integration
> > - latency tracer changes (Daniel Walker): needs review
> > - PICK_OP changes (Daniel Walker): needs review
> 
> This one seems to have slipped through the cracks:
>   http://lkml.org/lkml/2007/8/16/135

There was a comment in this patch that reads,

+	/*
+	 * all modifications are done under spinlocks
+	 * but this read is not, the unlock acks as a wmb
+	 * for modifications.
+	 */

I you mean "acts" (like an actor) instead of "acks" here right?

Daniel
