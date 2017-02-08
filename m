From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [RFC][PATCH 00/21] tracing: Inter-event (e.g. latency) support
Date: Wed, 08 Feb 2017 17:28:50 -0600
Message-ID: <1486596530.2871.22.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
         <20170208150109.5919a2ea@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40740 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752047AbdBHX3S (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Feb 2017 18:29:18 -0500
In-Reply-To: <20170208150109.5919a2ea@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2017-02-08 at 15:01 -0500, Steven Rostedt wrote:
> On Wed,  8 Feb 2017 11:24:56 -0600
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> >     # echo 'wakeup_latency lat=sched_switch:wakeup_lat \
> >                            pid=sched_switch:woken_pid \
> >                            prio=sched_switch:woken_prio' >> \
> >             /sys/kernel/debug/tracing/synthetic_events
> 
> I applied all your patches, did the above and then:
> 
>  BUG: unable to handle kernel NULL pointer dereference at 0000000000000034
>  IP: free_synthetic_event+0x46/0xb0
>  PGD 0 
>  

OK, well, the problem is actually the '\' 'continuation' characters in
the above string.  I'll fix that properly, but in the meantime, removing
those chars in the documentation strings will let you try it out i.e.

# echo 'wakeup_latency lat=sched_switch:wakeup_lat pid=sched_switch:woken_pid prio=sched_switch:woken_prio' >> /sys/kernel/debug/tracing/synthetic_events

Tom


