From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC][PATCH 03/21] ring-buffer: Add TIME_EXTEND_ABS ring buffer
 type
Date: Fri, 10 Feb 2017 15:04:51 +0900
Message-ID: <20170210060451.GA14705@sejong>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
 <a27fc1371e12174ee9f806d67d0c60844ebbe04c.1486569306.git.tom.zanussi@linux.intel.com>
 <20170208153200.38be2965@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>, <tglx@linutronix.de>,
        <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:53633 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbdBJGE4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Feb 2017 01:04:56 -0500
In-Reply-To: <20170208153200.38be2965@gandalf.local.home>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Feb 08, 2017 at 03:32:00PM -0500, Steven Rostedt wrote:
> On Wed,  8 Feb 2017 11:24:59 -0600
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> > Replace the unused RINGBUF_TYPE_TIME_STAMP ring buffer type with
> > RINGBUF_TYPE_TIME_EXTEND_ABS, which forces extended time_deltas for
> > all events.
> 
> Hmm, I could probably have this be used for nested commits :-/
> 
> > 
> > Having time_deltas that aren't dependent on previous events in the
> > ring buffer makes it feasible to use the ring_buffer_event timetamps
> > in a more random-access way, to be used for purposes other than serial
> > event printing.
> > 
> > To set/reset this mode, use tracing_set_timestamp_abs().
> > 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
> >  include/linux/ring_buffer.h |  12 ++++-
> >  kernel/trace/ring_buffer.c  | 109 ++++++++++++++++++++++++++++++++------------
> >  kernel/trace/trace.c        |  25 +++++++++-
> >  kernel/trace/trace.h        |   2 +
> >  4 files changed, 117 insertions(+), 31 deletions(-)
> > 
> > diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> > index b6d4568..c3a1064 100644
> > --- a/include/linux/ring_buffer.h
> > +++ b/include/linux/ring_buffer.h
> > @@ -36,6 +36,12 @@ struct ring_buffer_event {
> >   *				 array[0] = time delta (28 .. 59)
> >   *				 size = 8 bytes
> >   *
> > + * @RINGBUF_TYPE_TIME_EXTEND_ABS:
> > + *				 Extend the time delta, but interpret it as
> > + *				 absolute, not relative
> > + *				 array[0] = time delta (28 .. 59)

It's not a delta.

> > + *				 size = 8 bytes
> > + *
> >   * @RINGBUF_TYPE_TIME_STAMP:	Sync time stamp with external clock
> 
> I guess you need to nuke this comment too.
> 
> >   *				 array[0]    = tv_nsec
> >   *				 array[1..2] = tv_sec
> > @@ -56,12 +62,12 @@ enum ring_buffer_type {
> >  	RINGBUF_TYPE_DATA_TYPE_LEN_MAX = 28,
> >  	RINGBUF_TYPE_PADDING,
> >  	RINGBUF_TYPE_TIME_EXTEND,
> > -	/* FIXME: RINGBUF_TYPE_TIME_STAMP not implemented */
> > -	RINGBUF_TYPE_TIME_STAMP,
> > +	RINGBUF_TYPE_TIME_EXTEND_ABS,
> >  };
> >  
> >  unsigned ring_buffer_event_length(struct ring_buffer_event *event);
> >  void *ring_buffer_event_data(struct ring_buffer_event *event);
> > +u64 ring_buffer_event_time_stamp(struct ring_buffer_event *event);
> >  
> >  /*
> >   * ring_buffer_discard_commit will remove an event that has not
> > @@ -180,6 +186,8 @@ void ring_buffer_normalize_time_stamp(struct ring_buffer *buffer,
> >  				      int cpu, u64 *ts);
> >  void ring_buffer_set_clock(struct ring_buffer *buffer,
> >  			   u64 (*clock)(void));
> > +void ring_buffer_set_time_stamp_abs(struct ring_buffer *buffer, bool abs);
> > +bool ring_buffer_time_stamp_abs(struct ring_buffer *buffer);
> >  
> >  size_t ring_buffer_page_len(void *page);
> >  
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index a85739e..c9c9a83 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -41,6 +41,8 @@ int ring_buffer_print_entry_header(struct trace_seq *s)
> >  			 RINGBUF_TYPE_PADDING);
> >  	trace_seq_printf(s, "\ttime_extend : type == %d\n",
> >  			 RINGBUF_TYPE_TIME_EXTEND);
> > +	trace_seq_printf(s, "\ttime_extend_abs : type == %d\n",
> > +			 RINGBUF_TYPE_TIME_EXTEND_ABS);
> >  	trace_seq_printf(s, "\tdata max type_len  == %d\n",
> >  			 RINGBUF_TYPE_DATA_TYPE_LEN_MAX);
> >  
> > @@ -186,11 +188,9 @@ static void rb_event_set_padding(struct ring_buffer_event *event)
> >  		return  event->array[0] + RB_EVNT_HDR_SIZE;
> >  
> >  	case RINGBUF_TYPE_TIME_EXTEND:
> > +	case RINGBUF_TYPE_TIME_EXTEND_ABS:
> >  		return RB_LEN_TIME_EXTEND;
> >  
> > -	case RINGBUF_TYPE_TIME_STAMP:
> > -		return RB_LEN_TIME_STAMP;
> > -
> >  	case RINGBUF_TYPE_DATA:
> >  		return rb_event_data_length(event);
> >  	default:
> > @@ -209,7 +209,8 @@ static void rb_event_set_padding(struct ring_buffer_event *event)
> >  {
> >  	unsigned len = 0;
> >  
> > -	if (event->type_len == RINGBUF_TYPE_TIME_EXTEND) {
> > +	if (event->type_len == RINGBUF_TYPE_TIME_EXTEND ||
> > +	    event->type_len == RINGBUF_TYPE_TIME_EXTEND_ABS) {
> 
> Hmm, we could micro-optimize this with:
> 
> 	event->type_len > RINGBUF_TYPE_PADDING
> 
> But it would require comments and/or a wrapper to define it so people
> in the future know what it is doing.

What about

	event->type_len >= RINGBUF_TYPE_TIME_EXTEND

?  I think it's easier to understand what it's doing.

Thanks,
Namhyung

> 
> 
> >  		/* time extends include the data event after it */
> >  		len = RB_LEN_TIME_EXTEND;
> >  		event = skip_time_extend(event);
