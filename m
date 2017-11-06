From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v4 06/37] ring-buffer: Redefine the unimplemented
 RINGBUF_TYPE_TIME_STAMP
Date: Mon, 6 Nov 2017 14:09:53 +0900
Message-ID: <20171106050953.GA7557@sejong>
References: <cover.1509395595.git.tom.zanussi@linux.intel.com>
 <8927a4736dc6f602079d0797b60d3bf7a5d2d9d7.1509395595.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:35429 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbdKFFJ4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 6 Nov 2017 00:09:56 -0500
Content-Disposition: inline
In-Reply-To: <8927a4736dc6f602079d0797b60d3bf7a5d2d9d7.1509395595.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Tom,

On Mon, Oct 30, 2017 at 03:51:48PM -0500, Tom Zanussi wrote:
> RINGBUF_TYPE_TIME_STAMP is defined but not used, and from what I can
> gather was reserved for something like an absolute timestamp feature
> for the ring buffer, if not a complete replacement of the current
> time_delta scheme.
> 
> This code redefines RINGBUF_TYPE_TIME_STAMP to implement absolute time
> stamps.  Another way to look at it is that it essentially forces
> extended time_deltas for all events.
> 
> The motivation for doing this is to enable time_deltas that aren't
> dependent on previous events in the ring buffer, making it feasible to
> use the ring_buffer_event timetamps in a more random-access way, for
> purposes other than serial event printing.
> 
> To set/reset this mode, use tracing_set_timestamp_abs() from the
> previous interface patch.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---

[SNIP]
> @@ -2220,13 +2246,16 @@ static void rb_inc_iter(struct ring_buffer_iter *iter)
>  }
>  
>  /* Slow path, do not inline */
> -static noinline struct ring_buffer_event *
> +static struct noinline ring_buffer_event *

struct noinline?  Looks like a mistake..

Thanks,
Namhyung


> -rb_add_time_stamp(struct ring_buffer_event *event, u64 delta)
> +rb_add_time_stamp(struct ring_buffer_event *event, u64 delta, bool abs)
>  {
> -	event->type_len = RINGBUF_TYPE_TIME_EXTEND;
> +	if (abs)
> +		event->type_len = RINGBUF_TYPE_TIME_STAMP;
> +	else
> +		event->type_len = RINGBUF_TYPE_TIME_EXTEND;
>  
> -	/* Not the first event on the page? */
> -	if (rb_event_index(event)) {
> +	/* Not the first event on the page, or not delta? */
> +	if (abs || rb_event_index(event)) {
>  		event->time_delta = delta & TS_MASK;
>  		event->array[0] = delta >> TS_SHIFT;
>  	} else {
