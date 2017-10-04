From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 26/33] tracing: Add cpu field for hist triggers
Date: Wed, 4 Oct 2017 15:30:42 -0400
Message-ID: <20171004153042.774573d2@gandalf.local.home>
References: <cover.1506105131.git.tom.zanussi@linux.intel.com>
        <d0180521b36f25cb2c7a5aec4870125dda7764b0.1506105131.git.tom.zanussi@linux.intel.com>
        <20171004141257.5ce2a214@gandalf.local.home>
        <1507144895.14461.18.camel@tzanussi-mobl.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507144895.14461.18.camel@tzanussi-mobl.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 04 Oct 2017 14:21:35 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> Hi Steve,
> 
> On Wed, 2017-10-04 at 14:12 -0400, Steven Rostedt wrote:
> > On Fri, 22 Sep 2017 15:00:06 -0500
> > Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> >   
> > > A common key to use in a histogram is the cpuid - add a new cpu
> > > 'synthetic' field for that purpose.  This field is named cpu rather
> > > than $cpu or $common_cpu because 'cpu' already exists as a special
> > > filter field and it makes more sense to match that rather than add
> > > another name for the same thing.
> > > 
> > > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > > ---
> > >  Documentation/trace/events.txt   | 18 ++++++++++++++++++
> > >  kernel/trace/trace_events_hist.c | 28 +++++++++++++++++++++++++++-
> > >  2 files changed, 45 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/trace/events.txt b/Documentation/trace/events.txt
> > > index 2cc08d4..f36fa00 100644
> > > --- a/Documentation/trace/events.txt
> > > +++ b/Documentation/trace/events.txt
> > > @@ -668,6 +668,24 @@ The following commands are supported:
> > >    The examples below provide a more concrete illustration of the
> > >    concepts and typical usage patterns discussed above.
> > >  
> > > +  'special' event fields
> > > +  ------------------------
> > > +
> > > +  There are a number of 'special event fields' available for use as
> > > +  keys or values in a hist trigger.  These look like and behave as if
> > > +  they were actual event fields, but aren't really part of the event's
> > > +  field definition or format file.  They are however available for any
> > > +  event, and can be used anywhere an actual event field could be.
> > > +  'Special' field names are always prefixed with a '$' character to
> > > +  indicate that they're not normal fields (with the exception of
> > > +  'cpu', for compatibility with existing filter usage):
> > > +
> > > +    $common_timestamp      u64 - timestamp (from ring buffer) associated
> > > +                                 with the event, in nanoseconds.  May be
> > > +				 modified by .usecs to have timestamps
> > > +				 interpreted as microseconds.
> > > +    cpu                    int - the cpu on which the event occurred.
> > > +
> > >  
> > 
> > You were going to update this too.
> >   
> 
> For this one, I originally and confusingly called these 'synthetic'
> event fields even though they had nothing to do with synthetic events (I
> thought of them as 'synthetic' in a different sense, as not being actual
> fields).  So I changed that to 'special' here to avoid the confusion.
> (and I assumed your comment about moving them to the synthetic was due
> to that confusion).
> 
> I took the rest of your comment as saying that these were ok together,
> and in fact it does make sense to me to keep them here as part of this
> patch - because we're now getting more examples of these kinds of
> fields, adding a new section enumerating them starting with the second
> seems to make sense here, especially considering that $common_timestamp
> is mentioned elsewhere in several places in the documentation.

OK, fine with me, I was doing a diff between the series, and missed
that this was slightly updated.

-- Steve
