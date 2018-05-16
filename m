From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 10/14] tracing: Document trace_marker triggers
Date: Wed, 16 May 2018 11:26:28 -0400
Message-ID: <20180516112628.7f6970e0@gandalf.local.home>
References: <20180514205845.017925650@goodmis.org>
        <20180514205958.769987842@goodmis.org>
        <1526334427.26800.15.camel@tzanussi-mobl.amr.corp.intel.com>
        <20180516095534.676d7938@gandalf.local.home>
        <1526484147.11544.6.camel@tzanussi-mobl.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Yann Ylavic <ylavic.dev@gmail.com>,
        linux-rt-users@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526484147.11544.6.camel@tzanussi-mobl.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 16 May 2018 10:22:27 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> Sure, but noticed in the new version you just posted, that this line is
> still in there for your second example:
> 
> + # echo '!hist:keys=common_pid:vals=hitcount:lat=common_timestamp.usecs-$ts0:sort=hitcount:size=2048:clock=global:onmatch(sched.sched_switch).latency($lat) if buf == "end"' > events/ftrace/print/trigger
> 
> Did you intend that, or am I missing something?

No, I am. From my reply, you can see I skipped it. I totally missed
that comment. I'll update that too.


> 
> Anyway, you have my
> 
> Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Thanks!

-- Steve
