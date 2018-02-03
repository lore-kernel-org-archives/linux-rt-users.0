From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 00/18] [ANNOUNCE] Dynamically created function based
 events
Date: Sat, 3 Feb 2018 16:17:32 -0500
Message-ID: <20180203161732.4a65c66b@gandalf.local.home>
References: <20180202230458.840252014@goodmis.org>
        <261141691.15507.1517677454208.JavaMail.zimbra@efficios.com>
        <20180203140217.2382df69@gandalf.local.home>
        <20180203205207.mpob4w6eyehhg2ky@ast-mbp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-trace-users <linux-trace-users@vger.kernel.org>,
        acme <acme@kernel.org>, Clark Williams <williams@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, bristot <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Namhyung Kim <namhyung@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <20180203205207.mpob4w6eyehhg2ky@ast-mbp>
Sender: linux-trace-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 3 Feb 2018 12:52:08 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> It's a user space job.

BTW, I asked around at DevConf.cz, and nobody I talked with (besides
Arnaldo), have used eBPF. The "path to hello world" is quite high. This
interface is extremely simple to use, and one doesn't need to install
LLVM or other tools to interface with it.

I used the analogy, that eBPF is like C, and this is like Bash. One is
much easier to get "Hello World!" out than the other.

So personally, this is something I know I would use (note, I have
never used eBPF either). But if I'm the only one to use this
interface then I'll stop here (and not bother with the function graph
return interface). If others think this would be helpful, I would ask
them to speak up now.

Thanks,

-- Steve
