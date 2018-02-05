From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 01/18] tracing: Add function based events
Date: Mon, 5 Feb 2018 10:00:50 -0500
Message-ID: <20180205100050.75c04497@gandalf.local.home>
References: <20180202230458.840252014@goodmis.org>
        <20180202231017.160509978@goodmis.org>
        <20180205082423.GB1253@krava>
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
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Jiri Olsa <jolsa@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752937AbeBEPAy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 5 Feb 2018 10:00:54 -0500
In-Reply-To: <20180205082423.GB1253@krava>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 5 Feb 2018 09:24:23 +0100
Jiri Olsa <jolsa@redhat.com> wrote:


> should this be done under 'func_event_mutex' ?

Probably.

> 
> I tried and crashed the system by running 2 scripts with:
> 
>   echo 'ip_rcv(u64 skb, u64 dev)' > /sys/kernel/debug/tracing/function_events
>   echo 'SyS_openat(int dfd, string buf, x32 flags, x32 mode)' >> /sys/kernel/debug/tracing/function_events
>   echo 'SyS_open(x8[32] buf, x32 flags, x32 mode)' >> /sys/kernel/debug/tracing/function_events
>

Thanks for testing. I'll fix.

-- Steve
