From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 00/18] [ANNOUNCE] Dynamically created function based
 events
Date: Mon, 5 Feb 2018 10:11:07 -0500
Message-ID: <20180205101107.1e4debd2@gandalf.local.home>
References: <20180202230458.840252014@goodmis.org>
        <20180205102359.GV19535@localhost.localdomain>
        <72fc5744-d064-9d0f-bd80-127f4d665580@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
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
        Jiri Olsa <jolsa@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753101AbeBEPLL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 5 Feb 2018 10:11:11 -0500
In-Reply-To: <72fc5744-d064-9d0f-bd80-127f4d665580@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 5 Feb 2018 11:49:31 +0100
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> Isn't this the case of calling tracing functions before calling:
> 
> rcu_irq_enter();

Yes, I'm actually aware of this. I just forgot to deal with it during
development.

Thanks, for reporting.

-- Steve
