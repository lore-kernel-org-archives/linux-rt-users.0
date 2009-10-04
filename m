From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: slab_irq_enable is receiving corrupted / deleted list entries
Date: Sun, 4 Oct 2009 19:08:05 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0910041905040.2646@localhost.localdomain>
References: <20091002144711.GF3466@uudg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>, dmarlin@redhat.com
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:44612 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752175AbZJDRJA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 4 Oct 2009 13:09:00 -0400
In-Reply-To: <20091002144711.GF3466@uudg.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Luis,

On Fri, 2 Oct 2009, Luis Claudio R. Goncalves wrote:

> Hello,
> 
> The function slab_irq_enable is receiving list entries that are already
> deleted. In fact, they seem to be corrupted as entry->next is pointing
> to LIST_POISON1, meaning that it was already deleted but entry->prev
> points to a valid address.
> 
> This email has debug data I have collected, the original report and the
> patch I used to gather data. That was observed on 2.6.31-rt11.

The debug output is not really helpful. It tells us that we are
looking at a list corruption. 

Can you please add tracing_off() to that error code path and try to
reproduce the problem with the function tracer enabled ? That might us
give an idea what fiddled with that list entry.

Thanks,

	tglx
