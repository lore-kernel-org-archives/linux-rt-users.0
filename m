From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v2 33/40] tracing: Add hist trigger support for variable
 reference aliases
Date: Fri, 08 Sep 2017 14:41:42 -0500
Message-ID: <1504899702.5276.14.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
         <35c0e47907c9acaa847c83ad0ec3af0092cde250.1504642143.git.tom.zanussi@linux.intel.com>
         <20170908150955.2ea9351e@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:41080 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757010AbdIHTlp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 8 Sep 2017 15:41:45 -0400
In-Reply-To: <20170908150955.2ea9351e@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2017-09-08 at 15:09 -0400, Steven Rostedt wrote:
> On Tue,  5 Sep 2017 16:57:45 -0500
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> > Add support for alias=$somevar where alias can be used as
> > onmatch($alias).
> 
> This change log is very lacking. What exactly is the purpose of alias?
> 
> Sounds like the variable is going undercover.
> 

This was a feature added at the request of a user, who wanted more
flexibility in making naming clearer in certain cases e.g.:

# echo 'hist:keys=next_pid:new_lat=$common_timestamp.usecs' > /sys/kernel/debug/tracing/events/sched/sched_switch/trigger

# echo 'hist:keys=pid:latency=$new_lat:onmatch(sched.sched_switch).wake2($latency,pid)' > /sys/kernel/debug/tracing/events/synthetic/wake1/trigger

I'll add a better description and exampe to the change log for this.

Tom 



