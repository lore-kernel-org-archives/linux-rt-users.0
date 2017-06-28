From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH 00/32]  tracing: Inter-event (e.g. latency) support
Date: Wed, 28 Jun 2017 14:09:31 -0500
Message-ID: <1498676971.27662.28.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
         <cover.1498510759.git.tom.zanussi@linux.intel.com>
         <20170628232144.faa4b925cab7a9b3d563fb6d@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:25693 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751495AbdF1TJy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Jun 2017 15:09:54 -0400
In-Reply-To: <20170628232144.faa4b925cab7a9b3d563fb6d@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Masami,

On Wed, 2017-06-28 at 23:21 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Mon, 26 Jun 2017 17:49:01 -0500
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> > This patchset adds support for 'inter-event' quantities to the trace
> > event subsystem.  The most important example of inter-event quantities
> > are latencies, or the time differences between two events.
> > 
> 
> Thank you for your great work!
> I'm playing this and found some issues.
> 
> (1) new event format
> ----
> # echo "wakeup_latency u64 lat; pid_t pid; int prio" > synthetic_events 
> # cat /sys/kernel/debug/tracing # cat events/synthetic/wakeup_latency/format 
> name: wakeup_latency
> ID: 972
> format:
> 	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
> 	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
> 	field:unsigned char common_preempt_count;	offset:3;	size:1;signed:0;
> 	field:int common_pid;	offset:4;	size:4;	signed:1;
> 
> 	field:u64 lat;	offset:16;	size:8;	signed:0;
> 	field:pid_t pid;	offset:24;	size:4;	signed:1;
> 	field:int prio;	offset:32;	size:4;	signed:1;
> 
> print fmt: "lat: 0x%08lx, pid: 0x%08lx, prio: 0x%08lx", ((u64)(REC->lat)), ((u64)(REC->pid)), ((u64)(REC->prio))
> ----
> Here, IMO, this format would be better "lat=0x%08lx pid=0x%08lx prio=0x%08lx" so that perf-script can parse it correctly.
> 

OK, will change it.

> (2) lockdep found a dead lock case
> When I added a histogram trigger, it happened.
> ----
> # echo 'hist:keys=pid:ts0=$common_timestamp.usecs' >>  /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
> [33967.672485] 
> [33967.673117] ======================================================
> [33967.673117] WARNING: possible circular locking dependency detected
> [33967.673117] 4.12.0-rc5+ #1 Not tainted
> [33967.673117] ------------------------------------------------------

Yeah, will fix this and anything else similar, thanks for pointing it
out.

Tom

