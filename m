From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH 00/18] [ANNOUNCE] Dynamically created function based
 events
Date: Sat, 3 Feb 2018 13:30:15 -0800
Message-ID: <20180203213013.b6png725tcehqai3@ast-mbp>
References: <20180202230458.840252014@goodmis.org>
 <261141691.15507.1517677454208.JavaMail.zimbra@efficios.com>
 <20180203140217.2382df69@gandalf.local.home>
 <20180203205207.mpob4w6eyehhg2ky@ast-mbp>
 <20180203160824.42a6c1bb@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-trace-users-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180203160824.42a6c1bb@gandalf.local.home>
Sender: linux-trace-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, Feb 03, 2018 at 04:08:24PM -0500, Steven Rostedt wrote:
> On Sat, 3 Feb 2018 12:52:08 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> > On Sat, Feb 03, 2018 at 02:02:17PM -0500, Steven Rostedt wrote:
> > > 
> > > From those that were asking about having "trace markers" (ie.
> > > Facebook), they told us they can cope with kernel changes.  
> > 
> > There is some misunderstanding here.
> > We never asked for this interface.
> 
> But you wanted trace markers? Just to confirm.

what is a definition of 'trace marker' and how it's better than tracepoint?

> > We're perfectly fine with existing kprobe/tracepoint+bpf.
> 
> OK, so no new development in this was wanted? So the entire talk about
> getting tracepoints into vfs and scheduling wasn't needed?

I don't know who wants tracepoints in vfs.
Improving scheduler tracepoints? yes. definitely,
but it's not a technical problem and cannot be solved by technical means.

> > I don't see how they are any better than kprobes and suffer from the same issues.
> 
> One only needs to look at source code, to add these. You don't need to
> know the specifics of a registers and such. That's a big +. Sure, we
> could add this to kprobes as well. But this also doesn't need the
> kprobe infrastructure.

same goes for kprobes.
with bcc it's even easier. we write tools like:
int kprobe__inet_listen(struct pt_regs *ctx, struct socket *sock, int backlog)
{ 
  struct sock *sk = sock->sk;
  ...
and bcc knows that it needs to add kprobe to inet_listen()
and this function has two arguments of the given types.
Then sock->sk access is automatically replaced with bpf_probe_read, etc, etc.

> Not if you are working in the embedded space and only have busybox as
> your interface.

did you notice bpfd project that does remote kprobe+bpf into an android phone?
or phone is not an embedded space?

> I've already cleaned up several tracepoints that have no path to them.

Great. So you're making the same point as I do that tracepoints can and do change.

