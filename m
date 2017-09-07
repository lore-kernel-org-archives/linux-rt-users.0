From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v2 08/40] ring-buffer: Redefine the unimplemented
 RINGBUF_TIME_TIME_STAMP
Date: Thu, 07 Sep 2017 10:05:46 -0500
Message-ID: <1504796746.13310.6.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
         <ea37886f329f2e23d1e08014d3dc67016d4967a1.1504642143.git.tom.zanussi@linux.intel.com>
         <20170907103510.6626368d@gandalf.local.home>
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
In-Reply-To: <20170907103510.6626368d@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Steve,

On Thu, 2017-09-07 at 10:35 -0400, Steven Rostedt wrote:
> On Tue,  5 Sep 2017 16:57:20 -0500
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> > diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> > index 28e3472..74bc276 100644
> > --- a/include/linux/ring_buffer.h
> > +++ b/include/linux/ring_buffer.h
> > @@ -36,10 +36,12 @@ struct ring_buffer_event {
> >   *				 array[0] = time delta (28 .. 59)
> >   *				 size = 8 bytes
> >   *
> > - * @RINGBUF_TYPE_TIME_STAMP:	Sync time stamp with external clock
> > - *				 array[0]    = tv_nsec
> > - *				 array[1..2] = tv_sec
> > - *				 size = 16 bytes
> > + * @RINGBUF_TYPE_TIME_STAMP:	Absolute timestamp
> > + *				 Same format as TIME_EXTEND except that the
> > + *				 value is an absolute timestamp, not a delta
> > + *				 event.time_delta contains bottom 27 bits
> > + *				 array[0] = top (28 .. 59) bits
> > + *				 size = 8 bytes
> 
> Is it going to be an issue that our time stamp is only 59 bits?
> 
> 2^59 = 576,460,752,303,423,488
> 
> Thus, 2^59 nanoseconds (I doubt we will need to have precision better
> than nanoseconds) = 576,460,752 seconds = 9,607,679 minutes = 160,127
> hours = 6,671 days = 18 years.
> 
> We would be screwed if we trace for more than 18 years. ;-)
> 
> That's why I had it as 16 bytes, to be able to hold a full 64 bit
> timestamp (and still be 8 byte aligned). But since we've gone this long
> without needing this, I'm sure a 59 bit absolute timestamp should be
> good enough.
> 

Yeah, I would think it should be good enough, but then I don't
realistically envision a machine with an 18 year uptime with tracing
enabled, maybe someone else does though. ;-)

> >   *
> >   * <= @RINGBUF_TYPE_DATA_TYPE_LEN_MAX:
> >   *				Data record
> > @@ -56,12 +58,12 @@ enum ring_buffer_type {
> >  	RINGBUF_TYPE_DATA_TYPE_LEN_MAX = 28,
> >  	RINGBUF_TYPE_PADDING,
> >  	RINGBUF_TYPE_TIME_EXTEND,
> > -	/* FIXME: RINGBUF_TYPE_TIME_STAMP not implemented */
> >  	RINGBUF_TYPE_TIME_STAMP,
> >  };
> >  
> >  unsigned ring_buffer_event_length(struct ring_buffer_event *event);
> >  void *ring_buffer_event_data(struct ring_buffer_event *event);
> > +u64 ring_buffer_event_time_stamp(struct ring_buffer_event *event);
> >  
> >  /*
> >   * ring_buffer_discard_commit will remove an event that has not
> 
> 
> 
> 
> > @@ -2488,6 +2519,10 @@ static inline void rb_event_discard(struct ring_buffer_event *event)
> >  {
> >  	u64 delta;
> >  
> > +	/* In TIME_STAMP mode, write_stamp is unused, nothing to do */
> 
> No, we still need to keep the write_stamp updated. Sure, it doesn't use
> it, but I do want to have absolute and delta timestamps working
> together in a single buffer. It shouldn't be one or the other. In fact,
> I plan on using it that way for nested events.
> 
> Maybe for this feature we can let it slide. But I will be working on
> fixing that.
> 

OK, great, thanks.

Tom
