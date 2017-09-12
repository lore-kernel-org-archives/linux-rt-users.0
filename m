From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 00/40] tracing: Inter-event (e.g. latency) support
Date: Tue, 12 Sep 2017 10:50:03 +0900
Message-ID: <20170912105003.860ff7b4cd9bfd3e4d1796b1@kernel.org>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1504642143.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue,  5 Sep 2017 16:57:12 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> Hi,
> 
> This is V2 of the inter-event tracing patchset.
> 
> There are too many changes to list in detail, most of them directly
> addressing input from V1, but here are the major changes from V1
> (thanks to everyone who reviewed V1 and thanks to both Vedang Patel
> and Baohong Liu for their contributions and included patches):
[..]

> 
>  Documentation/trace/events.txt      |  431 ++++
>  include/linux/ring_buffer.h         |   17 +-
>  include/linux/trace_events.h        |   24 +-
>  include/linux/tracepoint-defs.h     |    1 +
>  kernel/trace/ring_buffer.c          |  126 +-
>  kernel/trace/trace.c                |  205 +-
>  kernel/trace/trace.h                |   25 +-
>  kernel/trace/trace_events.c         |   51 +-
>  kernel/trace/trace_events_hist.c    | 4472 +++++++++++++++++++++++++++++++----
>  kernel/trace/trace_events_trigger.c |   53 +-
>  kernel/trace/trace_kprobe.c         |   18 +-
>  kernel/trace/trace_probe.c          |   86 -
>  kernel/trace/trace_probe.h          |    7 -
>  kernel/trace/trace_uprobe.c         |    2 +-
>  kernel/trace/tracing_map.c          |  229 +-
>  kernel/trace/tracing_map.h          |   20 +-
>  kernel/tracepoint.c                 |   18 +-
>  17 files changed, 5073 insertions(+), 712 deletions(-)

There seems no Makefile and Kconfig changes. Would this mean
we just need CONFIG_HIST_TRIGGERS=y to enable it?

I think you'd better update the HIST_TRIGGER's description
so that user can notice which should be enabled for inter-event
tracing.

Thank you,



-- 
Masami Hiramatsu <mhiramat@kernel.org>
