From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 17/18] tracing: Add indirect to indirect access for
 function based events
Date: Mon, 12 Feb 2018 12:23:54 -0500
Message-ID: <20180212122354.1d2fb867@gandalf.local.home>
References: <20180202230458.840252014@goodmis.org>
        <20180202231019.582037880@goodmis.org>
        <20180209051301.GE28206@sejong>
        <20180209104758.093d31ad@gandalf.local.home>
        <20180212021534.GH31513@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users@vger.kernel.org, linux-trace-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        kernel-team@lge.com
To: Namhyung Kim <namhyung@kernel.org>
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <20180212021534.GH31513@sejong>
Sender: linux-trace-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 12 Feb 2018 11:15:34 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> > It should have been:
> > 
> > 		return process_redirects(arg, val, buf);  
> 
> But I think you need to consider data type of the arg when
> dereferencing the last redirect.

What for?

Also this code has also changed. I haven't posted new patches but my
latest is in my git tree in the branch ftrace/dynamic-ftrace-events.

-- Steve
