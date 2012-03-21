From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Different priorities for different softirqs
Date: Wed, 21 Mar 2012 09:59:53 -0400
Message-ID: <1332338393.23924.35.camel@gandalf.stny.rr.com>
References: <013401cd0763$1bd93970$538bac50$@gmx.com>
	 <20120321130824.GC6028@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Christian Meier <chmeie@gmx.com>, linux-rt-users@vger.kernel.org
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:17053 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031058Ab2CUN7y (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Mar 2012 09:59:54 -0400
In-Reply-To: <20120321130824.GC6028@uudg.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2012-03-21 at 10:08 -0300, Luis Claudio R. Goncalves wrote:
> he examples there are from older kernels (probably 2.6.18 and 2.6.23).
> Several changes happened since then, to the kernels and even to the general
> model of the RT patch. Among these changes, more than once softirqs have
> been folded inside ksoftirqd and later unfolded. As of now, they are folded
> and it seems to have helped to minimize a performance loss someone (tglx?)
> observed in the early 3.0.x-rt days.

I discussed this in Chemnitz, and will be working to at least pull the
timer softirq out into its own thread.

We need to look at this again and see how we can fix it in a clean
fashion.

-- Steve


