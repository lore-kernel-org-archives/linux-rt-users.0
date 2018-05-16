From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 13/14] tracing/selftest: Add selftests to test
 trace_marker histogram triggers
Date: Wed, 16 May 2018 10:06:06 -0400
Message-ID: <20180516100606.0ecf2e56@gandalf.local.home>
References: <20180514205845.017925650@goodmis.org>
        <20180514205959.230719465@goodmis.org>
        <20180516220716.60174e9edd8d9f970fcd37e1@kernel.org>
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
        Namhyung Kim <namhyung@kernel.org>,
        Yann Ylavic <ylavic.dev@gmail.com>,
        linux-rt-users@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180516220716.60174e9edd8d9f970fcd37e1@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 16 May 2018 22:07:16 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker.tc  
> 
> But this test actually kicks histogram, maybe
> trigger-trace-marker-hist.tc will be better, since we may need to add
> a simpler testcase just for checking whether trace-marker works with
> some actions (e.g. enable/disable other events).

OK, will update that file. Thanks for reviewing.

-- Steve
