From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 35/40] tracing: Reverse the order
 event_mutex/trace_types_lock are taken
Date: Fri, 8 Sep 2017 16:00:39 -0400
Message-ID: <20170908160039.24ab418c@gandalf.local.home>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
        <4b52f9b1c49599780af1a193736df609b2785a63.1504642143.git.tom.zanussi@linux.intel.com>
        <20170908153135.14725f01@gandalf.local.home>
        <20170908154136.096d49ff@gandalf.local.home>
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
In-Reply-To: <20170908154136.096d49ff@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 8 Sep 2017 15:41:36 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 8 Sep 2017 15:31:35 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Tue,  5 Sep 2017 16:57:47 -0500
> > Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> >   
> > > Change the order event_mutex and trace_types_lock are taken, to avoid
> > > circular dependencies and lockdep spew.
> > > 
> > > Changing the order shouldn't matter to any current code, but does to
> > > anything that takes the event_mutex first and then trace_types_lock.
> > > This is the case when calling tracing_set_clock from inside an event
> > > command, which already holds the event_mutex.    
> > 
> > This is a very scary patch. I'll apply it and run a bunch of tests with
> > lockdep enabled. Let's see what blows up (or not).  
> 
> Boom!
>


> It appears to be caused by instance creation. I'll look at that.

OK, this may be a simple fix. I'll send you a patch to fold in after I
finish testing it.

-- Steve
