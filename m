From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 00/18] [ANNOUNCE] Dynamically created function based
 events
Date: Mon, 5 Feb 2018 10:10:11 -0500
Message-ID: <20180205101011.720f9493@gandalf.local.home>
References: <20180202230458.840252014@goodmis.org>
        <261141691.15507.1517677454208.JavaMail.zimbra@efficios.com>
        <CA+55aFz1=qWvnJ2271SGwuezwQRBA2nZp8_BxFyR-R0VKKgXRw@mail.gmail.com>
        <292744194.15823.1517758204087.JavaMail.zimbra@efficios.com>
        <CA+55aFwtCP3Nf86jwNFzdRy_m0GZWH5U2KBDutPDh1ZVATHLYg@mail.gmail.com>
        <20180205100930.GH2249@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-trace-users <linux-trace-users@vger.kernel.org>,
        acme <acme@kernel.org>, Clark Williams <williams@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, bristot <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <20180205100930.GH2249@hirez.programming.kicks-ass.net>
Sender: linux-trace-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 5 Feb 2018 11:09:31 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> As a run-around, Steve then suggested to decouple the trace-hook from
> the actual trace-event. Let the scheduler only provide the hook, nothing
> else. And then allow users to create their own events with the specific
> data they need for their specific use-case.

Actually, we can make the raw tracepoint callback no longer 'notrace',
and then we can extend all tracepoints as well with this.

One issue I hit was the structure randomization for security. If the
structures are randomized, it becomes much more difficult to find
specific aspects of task_struct.

-- Steve
