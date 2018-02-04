From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 00/18] [ANNOUNCE] Dynamically created function based
 events
Date: Sun, 4 Feb 2018 10:47:30 -0500
Message-ID: <20180204104730.10cc55df@gandalf.local.home>
References: <20180202230458.840252014@goodmis.org>
        <261141691.15507.1517677454208.JavaMail.zimbra@efficios.com>
        <CA+55aFz1=qWvnJ2271SGwuezwQRBA2nZp8_BxFyR-R0VKKgXRw@mail.gmail.com>
        <292744194.15823.1517758204087.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <292744194.15823.1517758204087.JavaMail.zimbra@efficios.com>
Sender: linux-trace-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, 4 Feb 2018 15:30:04 +0000 (UTC)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> This should therefore leave a door open to adding new tracepoints: cases
> where the data gathered is shown to be useful enough for tools targeting
> an audience wider than just kernel developers. To improve over the current
> situation, we should think about documenting some rules about how those
> tools should cope with tracepoints changing over time (event version,
> tools backward compatibility, and so on), and make sure the ABI exposes
> the information required to help tools cope with change.

As I mentioned earlier. If a function based event proves to be useful
enough to pull out information that sysadmins et.al. find beneficial,
than that could be used as an argument to create a normal static
tracepoint for that information.

-- Steve
