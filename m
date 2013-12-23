From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [PATCH] rcu: Eliminate softirq processing from rcutree
Date: Mon, 23 Dec 2013 06:12:39 +0100
Message-ID: <1387775559.5369.20.camel@marge.simpson.net>
References: <20131221193900.GA8427@linutronix.de>
	 <1387681647.5412.25.camel@marge.simpson.net>
	 <1387702631.5412.101.camel@marge.simpson.net>
	 <1387773533.5369.16.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1387773533.5369.16.camel@marge.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2013-12-23 at 05:38 +0100, Mike Galbraith wrote: 
> On Sun, 2013-12-22 at 09:57 +0100, Mike Galbraith wrote: 
> > I'll let the box give
> > RCU something to do for a couple days.  No news is good news.
> 
> Ho ho hum, merry christmas, gift attached.
> 
> I'll beat on virgin -rt7, see if it survives, then re-apply RCU patch
> and retest.  This kernel had nohz_full enabled, along with Sebastian's
> pending -rt fix for same, so RCU patch was not only not running solo,
> box was running a known somewhat buggy config as well.  Box was doing
> endless tbench 64 when it started stalling fwiw.
> 
> -Mike

P.S.

virgin -rt7 doing tbench 64 + make -j64

[   97.907960] perf samples too long (3138 > 2500), lowering kernel.perf_event_max_sample_rate to 50000
[  103.047921] perf samples too long (5544 > 5000), lowering kernel.perf_event_max_sample_rate to 25000
[  181.561271] perf samples too long (10318 > 10000), lowering kernel.perf_event_max_sample_rate to 13000
[  184.243750] INFO: NMI handler (perf_event_nmi_handler) took too long to run: 1.084 msecs
[  248.914422] perf samples too long (19719 > 19230), lowering kernel.perf_event_max_sample_rate to 7000
[  382.116674] NOHZ: local_softirq_pending 10
[  405.201593] perf samples too long (36824 > 35714), lowering kernel.perf_event_max_sample_rate to 4000
[  444.704185] NOHZ: local_softirq_pending 08
[  444.704208] NOHZ: local_softirq_pending 08
[  444.704579] NOHZ: local_softirq_pending 08
[  444.704678] NOHZ: local_softirq_pending 08
[  444.705100] NOHZ: local_softirq_pending 08
[  444.705980] NOHZ: local_softirq_pending 08
[  444.705994] NOHZ: local_softirq_pending 08
[  444.708315] NOHZ: local_softirq_pending 08
[  444.710348] NOHZ: local_softirq_pending 08
[  474.435582] INFO: NMI handler (perf_event_nmi_handler) took too long to run: 1.096 msecs
[  475.994055] perf samples too long (63124 > 62500), lowering kernel.perf_event_max_sample_rate to 2000

Those annoying perf gripes are generic, not -rt.
