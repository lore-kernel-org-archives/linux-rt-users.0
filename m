From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v2 00/40] tracing: Inter-event (e.g. latency) support
Date: Tue, 19 Sep 2017 13:44:28 -0500
Message-ID: <1505846668.29775.13.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
         <20170919123113.499b59b1@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170919123113.499b59b1@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Steve,

On Tue, 2017-09-19 at 12:31 -0400, Steven Rostedt wrote:
> On Tue,  5 Sep 2017 16:57:12 -0500
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> > Hi,
> > 
> > This is V2 of the inter-event tracing patchset.
> > 
> 
> Hi Tom,
> 
> I was wondering if you had a v3 ready? I would like to get it into the
> next merge window, but I would also like it to be in linux-next early,
> which means we need the next version rather soon (hopefully that will
> be the last version).
> 

Yeah, it's almost ready.  At this point, I've addressed all the comments
except for:

 - PATCH v2 25/40] tracing: Add support for dynamic tracepoints

 which I need to do a little bit of research on to figure out what
exactly I need to do there.

I was also kind of looking for a couple patches from you to fold in
which you had mentioned you were going to send for:

 -  [PATCH v2 35/40] tracing: Reverse the order event_mutex/trace_types_lock are taken
 -  [PATCH v2 40/40] tracing: Add trace_event_buffer_reserve() variant that allows recursion

I've been using the trace_recursive_lock() patch you posted in place of
the latter and it's working fine.  :-)

Tom

> -- Steve
