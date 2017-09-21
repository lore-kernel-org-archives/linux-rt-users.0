From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 00/40] tracing: Inter-event (e.g. latency) support
Date: Thu, 21 Sep 2017 16:20:27 -0400
Message-ID: <20170921162027.1eb0d8c7@gandalf.local.home>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
        <20170919123113.499b59b1@gandalf.local.home>
        <1505846668.29775.13.camel@tzanussi-mobl.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1505846668.29775.13.camel@tzanussi-mobl.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 19 Sep 2017 13:44:28 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> Yeah, it's almost ready.  At this point, I've addressed all the comments
> except for:
> 
>  - PATCH v2 25/40] tracing: Add support for dynamic tracepoints
> 
>  which I need to do a little bit of research on to figure out what
> exactly I need to do there.

Let me know if you need any help.

> 
> I was also kind of looking for a couple patches from you to fold in
> which you had mentioned you were going to send for:
> 
>  -  [PATCH v2 35/40] tracing: Reverse the order event_mutex/trace_types_lock are taken

OK, I have a stand alone patch that you don't need to fold in that does
this properly. I tested the crap out of it (missed a few places), but
should be good. I'll send that netx.


>  -  [PATCH v2 40/40] tracing: Add trace_event_buffer_reserve() variant that allows recursion

I have this working too, but want to test it a little more before
sending. Once I do, you can add both patches ahead of your series. I
may just apply them to my tree now and start running them through my
formal tests.

> 
> I've been using the trace_recursive_lock() patch you posted in place of
> the latter and it's working fine.  :-)

Thanks!

-- Steve
