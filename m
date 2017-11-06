From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v4 06/37] ring-buffer: Redefine the unimplemented
 RINGBUF_TYPE_TIME_STAMP
Date: Mon, 06 Nov 2017 09:52:33 -0600
Message-ID: <1509983553.27629.2.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1509395595.git.tom.zanussi@linux.intel.com>
         <8927a4736dc6f602079d0797b60d3bf7a5d2d9d7.1509395595.git.tom.zanussi@linux.intel.com>
         <20171106050953.GA7557@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Namhyung Kim <namhyung@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171106050953.GA7557@sejong>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Namhyung,

On Mon, 2017-11-06 at 14:09 +0900, Namhyung Kim wrote:
> Hi Tom,
> 
> On Mon, Oct 30, 2017 at 03:51:48PM -0500, Tom Zanussi wrote:
> > RINGBUF_TYPE_TIME_STAMP is defined but not used, and from what I can
> > gather was reserved for something like an absolute timestamp feature
> > for the ring buffer, if not a complete replacement of the current
> > time_delta scheme.
> > 
> > This code redefines RINGBUF_TYPE_TIME_STAMP to implement absolute time
> > stamps.  Another way to look at it is that it essentially forces
> > extended time_deltas for all events.
> > 
> > The motivation for doing this is to enable time_deltas that aren't
> > dependent on previous events in the ring buffer, making it feasible to
> > use the ring_buffer_event timetamps in a more random-access way, for
> > purposes other than serial event printing.
> > 
> > To set/reset this mode, use tracing_set_timestamp_abs() from the
> > previous interface patch.
> > 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
> 
> [SNIP]
> > @@ -2220,13 +2246,16 @@ static void rb_inc_iter(struct ring_buffer_iter *iter)
> >  }
> >  
> >  /* Slow path, do not inline */
> > -static noinline struct ring_buffer_event *
> > +static struct noinline ring_buffer_event *
> 
> struct noinline?  Looks like a mistake..
> 

Yeah, it is, not sure how that could have even happened, sheesh.  Thanks
for pointing it out,

Tom
