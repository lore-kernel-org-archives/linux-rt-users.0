From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.2.9-rt17
Date: Thu, 08 Mar 2012 17:27:45 -0500
Message-ID: <1331245665.25686.521.camel@gandalf.stny.rr.com>
References: <alpine.LFD.2.02.1203072225020.2742@ionos>
	 <1331230991.25686.452.camel@gandalf.stny.rr.com>
	 <1331231287.11248.396.camel@twins>
	 <1331232159.25686.456.camel@gandalf.stny.rr.com>
	 <1331235579.11248.402.camel@twins>
	 <1331237441.25686.469.camel@gandalf.stny.rr.com>
	 <1331238369.11248.426.camel@twins>
	 <1331240882.25686.499.camel@gandalf.stny.rr.com>
	 <1331241627.11248.430.camel@twins>
	 <1331241940.25686.502.camel@gandalf.stny.rr.com>
	 <1331242104.11248.432.camel@twins>
	 <1331242574.25686.505.camel@gandalf.stny.rr.com>
	 <1331242625.11248.433.camel@twins>
	 <1331243078.25686.510.camel@gandalf.stny.rr.com>
	 <1331243642.11248.441.camel@twins>
	 <1331244812.25686.518.camel@gandalf.stny.rr.com>
	 <1331245213.11248.446.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:10449 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889Ab2CHW1r (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 8 Mar 2012 17:27:47 -0500
In-Reply-To: <1331245213.11248.446.camel@twins>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2012-03-08 at 23:20 +0100, Peter Zijlstra wrote:

> and with rt-mutex having the equal priority lock stealing this reverts
> to a plain test-and-set lock. There's only a tiny window in which A can
> actually get the lock and that is hampered by B's cpu owning the
> cacheline in exclusive mode.
> 
> I simply cannot see guaranteed progress here.

This can be easily fixed by not having the lateral steal when a lock has
a priority.

-- Steve




