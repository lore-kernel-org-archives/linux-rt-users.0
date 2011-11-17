From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH -rt] memcg: use migrate_disable()/migrate_enable( ) in
 memcg_check_events()
Date: Thu, 17 Nov 2011 12:59:25 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1111171258060.4902@ionos>
References: <alpine.LFD.2.02.1111150050590.4902@ionos> <20111115084059.GA23250@zhy> <20111116091653.GA8692@zhy> <1321452758.4181.18.camel@frodo> <alpine.LFD.2.02.1111161801270.4902@ionos> <20111117030332.GA14492@zhy> <alpine.LFD.2.02.1111171125020.4902@ionos>
 <20111117114451.GC3762@hades>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Yong Zhang <yong.zhang0@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Johannes Weiner <hannes@cmpxchg.org>
To: Luis Henriques <henrix@camandro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111117114451.GC3762@hades>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Luis,

On Thu, 17 Nov 2011, Luis Henriques wrote:

> On Thu, Nov 17, 2011 at 11:25:56AM +0100, Thomas Gleixner wrote:
> > Johannes came up with a different solution. Could you please give it a try?
> 
> Again, I've run a quick test and it looks like this solves the issue.

thanks for testing. That solution is way better than the local_lock
based one.

Thanks,

	tglx
