From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 14/14] tracing/selftest: Add test to test hist
 trigger between kernel event and trace_marker
Date: Wed, 16 May 2018 10:09:59 -0400
Message-ID: <20180516100959.677fed4b@gandalf.local.home>
References: <20180514205845.017925650@goodmis.org>
        <20180514205959.393826165@goodmis.org>
        <20180516091153.GC30309@danjae.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Yann Ylavic <ylavic.dev@gmail.com>,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Namhyung Kim <namhyung@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180516091153.GC30309@danjae.aot.lge.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 16 May 2018 18:11:53 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

 
> > +echo "Test histogram kernel event to trace_marker latency histogram trigger"
> > +
> > +echo 'latency u64 lat' > synthetic_events
> > +echo 'hist:keys=pid:ts0=common_timestamp.usecs' > events/sched/sched_waking/trigger
> > +echo 'hist:keys=common_pid:lat=common_timestamp.usecs-$ts0:onmatch(ftrace.print).latency($lat)' > events/ftrace/print/trigger  
> 
> Shouldn't it be "onmatch(sched.sched_waking)" ?

Ug, yes! Cut-and-paste fail :-p

I tested this my hand and did it correctly, but instead of
cut-and-pasting the command line, I cut and pasted the other test and
updated it.

Thanks for reviewing Namhyung!

-- Steve
