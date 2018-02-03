From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 13/18] tracing: Add array type to function based events
Date: Sat, 3 Feb 2018 10:29:03 -0500
Message-ID: <20180203102903.070ae30a@gandalf.local.home>
References: <20180202230458.840252014@goodmis.org>
        <20180202231018.977452228@goodmis.org>
        <20180203225615.6e1a21982335405dad13b99b@kernel.org>
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
To: Masami Hiramatsu <mhiramat@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752547AbeBCP3G (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 3 Feb 2018 10:29:06 -0500
In-Reply-To: <20180203225615.6e1a21982335405dad13b99b@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 3 Feb 2018 22:56:15 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> This idea looks good for kprobe events too.
> I'll try to implement same one :)

We should have the two re-use the same code.

In other words, I would like as much code sharing as possible.

-- Steve
