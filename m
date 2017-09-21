From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v2 00/40] tracing: Inter-event (e.g. latency) support
Date: Thu, 21 Sep 2017 16:11:25 -0500
Message-ID: <1506028285.24518.3.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
         <20170919123113.499b59b1@gandalf.local.home>
         <1505846668.29775.13.camel@tzanussi-mobl.amr.corp.intel.com>
         <20170921162027.1eb0d8c7@gandalf.local.home>
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
Received: from mga09.intel.com ([134.134.136.24]:16447 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751741AbdIUVL4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 21 Sep 2017 17:11:56 -0400
In-Reply-To: <20170921162027.1eb0d8c7@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Steve,

On Thu, 2017-09-21 at 16:20 -0400, Steven Rostedt wrote:
> On Tue, 19 Sep 2017 13:44:28 -0500
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> > Yeah, it's almost ready.  At this point, I've addressed all the comments
> > except for:
> > 
> >  - PATCH v2 25/40] tracing: Add support for dynamic tracepoints
> > 
> >  which I need to do a little bit of research on to figure out what
> > exactly I need to do there.
> 
> Let me know if you need any help.
> 

OK, thanks.

> > 
> > I was also kind of looking for a couple patches from you to fold in
> > which you had mentioned you were going to send for:
> > 
> >  -  [PATCH v2 35/40] tracing: Reverse the order event_mutex/trace_types_lock are taken
> 
> OK, I have a stand alone patch that you don't need to fold in that does
> this properly. I tested the crap out of it (missed a few places), but
> should be good. I'll send that netx.
> 
> 
> >  -  [PATCH v2 40/40] tracing: Add trace_event_buffer_reserve() variant that allows recursion
> 
> I have this working too, but want to test it a little more before
> sending. Once I do, you can add both patches ahead of your series. I
> may just apply them to my tree now and start running them through my
> formal tests.
> 

Thanks for these patches - testing now with the mutex patch you just
sent and the old trace_recursive_lock() patch, hope to have a v3 out
soon.

Tom



