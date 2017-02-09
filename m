From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 00/21] tracing: Inter-event (e.g. latency) support
Date: Thu, 9 Feb 2017 14:57:29 -0500
Message-ID: <20170209145729.7b176e98@gandalf.local.home>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
        <20170209081327.0f0f4db4e5cb8f1b9be25338@kernel.org>
        <1486602862.2871.62.camel@tzanussi-mobl.amr.corp.intel.com>
        <20170209231837.c29ad7da3f1e73a1f8a245f4@kernel.org>
        <1486660712.2871.107.camel@tzanussi-mobl.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Masami Hiramatsu <mhiramat@kernel.org>, tglx@linutronix.de,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1486660712.2871.107.camel@tzanussi-mobl.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 09 Feb 2017 11:18:32 -0600
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> I think it might make a lot of sense at this point to actually create a
> system-wide list of active triggers e.g. tracing/events/triggers or
> something like that.  It's something I've kind of wanted anyway, and
> would be really useful if not indispensable for this.  Actually, I
> thought it might even be nice to have some kind of mini-fs or something
> making it easy to group sets of related triggers and enable and
> disable/remove them as a group, but a simple list would suffice too...

Note, (new) trace-cmd does this for you (by querying all trigger files).

# echo 'stacktrace if COMM ~ "system*"' > /debug/tracing/events/syscalls/sys_enter_open/trigger
# trace-cmd stat

Events:
  (none enabled)

Triggers:
  syscalls:sys_enter_open "stacktrace:unlimited if COMM ~ "system*""

Tracing is enabled



-- Steve
