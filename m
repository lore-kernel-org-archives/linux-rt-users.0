From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [RFC][PATCH 03/21] ring-buffer: Add TIME_EXTEND_ABS ring buffer
 type
Date: Wed, 08 Feb 2017 14:55:48 -0600
Message-ID: <1486587348.2871.15.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
         <a27fc1371e12174ee9f806d67d0c60844ebbe04c.1486569306.git.tom.zanussi@linux.intel.com>
         <20170208153200.38be2965@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170208153200.38be2965@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2017-02-08 at 15:32 -0500, Steven Rostedt wrote:
> On Wed,  8 Feb 2017 11:24:59 -0600
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
...
> >  	/*
> >  	 * The event first in the commit queue updates the
> >  	 * time stamp.
> > @@ -2492,8 +2516,7 @@ static inline void rb_event_discard(struct ring_buffer_event *event)
> >  			delta <<= TS_SHIFT;
> >  			delta += event->time_delta;
> >  			cpu_buffer->write_stamp += delta;
> > -		} else
> > -			cpu_buffer->write_stamp += event->time_delta;
> > +		}
> 
> And why is this removed?
> 

Yeah, it doesn't make sense, given that we've returned already.  Looks
like it was just a lineo..

> >  	}
> >  }
> >  
> > @@ -2674,7 +2697,7 @@ int ring_buffer_unlock_commit(struct ring_buffer *buffer,
> >  	 * If this is the first commit on the page, then it has the same
> >  	 * timestamp as the page itself.
> >  	 */
> > -	if (!tail)
> > +	if (!tail && !ring_buffer_time_stamp_abs(cpu_buffer->buffer))
> >  		info->delta = 0;
> >  
> >  	/* See if we shot pass the end of this buffer page */
> > @@ -2752,8 +2775,11 @@ int ring_buffer_unlock_commit(struct ring_buffer *buffer,
> >  	/* make sure this diff is calculated here */
> >  	barrier();
> >  
> > -	/* Did the write stamp get updated already? */
> > -	if (likely(info.ts >= cpu_buffer->write_stamp)) {
> > +	if (ring_buffer_time_stamp_abs(buffer)) {
> > +		info.delta = info.ts;
> > +		rb_handle_timestamp(cpu_buffer, &info);
> > +	} else /* Did the write stamp get updated already? */
> > +		if (likely(info.ts >= cpu_buffer->write_stamp)) {
> 
> OK, please break this patch up into two. Although, I may take it and
> start on it as well ;-)  One with the implementation of the EXTEND_ABS,
> and the other with the setting of the flags.
> 

OK, I'll break it up if I don't see you do anything with it in the
meantime..

Tom
