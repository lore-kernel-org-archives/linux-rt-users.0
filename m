From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [PATCH] rcu: Eliminate softirq processing from rcutree
Date: Sat, 25 Jan 2014 06:20:26 +0100
Message-ID: <1390627226.3625.18.camel@marge.simpson.net>
References: <20131221193900.GA8427@linutronix.de>
	 <1387681647.5412.25.camel@marge.simpson.net>
	 <1387702631.5412.101.camel@marge.simpson.net>
	 <1387773533.5369.16.camel@marge.simpson.net>
	 <1387775559.5369.20.camel@marge.simpson.net>
	 <20140124194642.GA29981@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:58312 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbaAYFUi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 25 Jan 2014 00:20:38 -0500
In-Reply-To: <20140124194642.GA29981@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2014-01-24 at 20:46 +0100, Sebastian Andrzej Siewior wrote: 
> * Mike Galbraith | 2013-12-23 06:12:39 [+0100]:
> 
> >P.S.
> >
> >virgin -rt7 doing tbench 64 + make -j64
> >
> >[   97.907960] perf samples too long (3138 > 2500), lowering kernel.perf_event_max_sample_rate to 50000
> >[  103.047921] perf samples too long (5544 > 5000), lowering kernel.perf_event_max_sample_rate to 25000
> >[  181.561271] perf samples too long (10318 > 10000), lowering kernel.perf_event_max_sample_rate to 13000
> >[  184.243750] INFO: NMI handler (perf_event_nmi_handler) took too long to run: 1.084 msecs
> >[  248.914422] perf samples too long (19719 > 19230), lowering kernel.perf_event_max_sample_rate to 7000
> >[  382.116674] NOHZ: local_softirq_pending 10
> This is block
> 
> >[  405.201593] perf samples too long (36824 > 35714), lowering kernel.perf_event_max_sample_rate to 4000
> >[  444.704185] NOHZ: local_softirq_pending 08
> >[  444.704208] NOHZ: local_softirq_pending 08
> >[  444.704579] NOHZ: local_softirq_pending 08
> >[  444.704678] NOHZ: local_softirq_pending 08
> >[  444.705100] NOHZ: local_softirq_pending 08
> >[  444.705980] NOHZ: local_softirq_pending 08
> >[  444.705994] NOHZ: local_softirq_pending 08
> >[  444.708315] NOHZ: local_softirq_pending 08
> >[  444.710348] NOHZ: local_softirq_pending 08
> 
> and this is RX. Is your testcase heavy disk-io or heavy disk-io +
> network?

Yeah.

-Mike

