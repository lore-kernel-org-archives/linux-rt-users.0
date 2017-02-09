From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 00/21] tracing: Inter-event (e.g. latency) support
Date: Wed, 8 Feb 2017 21:14:31 -0500
Message-ID: <20170208211431.467477f5@grimm.local.home>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
        <20170208150109.5919a2ea@gandalf.local.home>
        <1486596530.2871.22.camel@tzanussi-mobl.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1486596530.2871.22.camel@tzanussi-mobl.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 08 Feb 2017 17:28:50 -0600
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> On Wed, 2017-02-08 at 15:01 -0500, Steven Rostedt wrote:
> > On Wed,  8 Feb 2017 11:24:56 -0600
> > Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> >   
> > >     # echo 'wakeup_latency lat=sched_switch:wakeup_lat \
> > >                            pid=sched_switch:woken_pid \
> > >                            prio=sched_switch:woken_prio' >> \
> > >             /sys/kernel/debug/tracing/synthetic_events  
> > 
> > I applied all your patches, did the above and then:
> > 
> >  BUG: unable to handle kernel NULL pointer dereference at 0000000000000034
> >  IP: free_synthetic_event+0x46/0xb0
> >  PGD 0 
> >    
> 
> OK, well, the problem is actually the '\' 'continuation' characters in
> the above string.  I'll fix that properly, but in the meantime, removing
> those chars in the documentation strings will let you try it out i.e.
> 
> # echo 'wakeup_latency lat=sched_switch:wakeup_lat pid=sched_switch:woken_pid prio=sched_switch:woken_prio' >> /sys/kernel/debug/tracing/synthetic_events

Ah, OK. Yeah, I did a cut and paste when entering it.

-- Steve
