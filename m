From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 13/18] tracing: Add array type to function based events
Date: Sun, 4 Feb 2018 12:50:12 +0900
Message-ID: <20180204125012.562129292eaa1843184c4997@kernel.org>
References: <20180202230458.840252014@goodmis.org>
        <20180202231018.977452228@goodmis.org>
        <20180203225615.6e1a21982335405dad13b99b@kernel.org>
        <20180203102903.070ae30a@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users@vger.kernel.org, linux-trace-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <20180203102903.070ae30a@gandalf.local.home>
Sender: linux-trace-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 3 Feb 2018 10:29:03 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 3 Feb 2018 22:56:15 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > This idea looks good for kprobe events too.
> > I'll try to implement same one :)
> 
> We should have the two re-use the same code.
> 
> In other words, I would like as much code sharing as possible.

Finally it will be, but currently the code base is too far.
I would like to implement it on current code for avoiding
break anything, but refactoring afterwards.

I think current fetch function implementation may be too heavy
with retpoline. I would like to reimplement it with eBPF :)

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
