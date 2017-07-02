From: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Subject: Re: [PATCH 04/32] ring-buffer: Redefine the unimplemented RINGBUF_TIME_TIME_STAMP
Date: Sun, 2 Jul 2017 01:51:51 -0700
Message-ID: <CAEi0qNkpAvySnz8K2dEH4A9S3M3b6auzayOR55L+S1KEoEU3ZQ@mail.gmail.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com> <6272b132695d1404c64430f9c81a9365a1686dee.1498510759.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, vedang.patel@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6272b132695d1404c64430f9c81a9365a1686dee.1498510759.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Jun 26, 2017 at 3:49 PM, Tom Zanussi
<tom.zanussi@linux.intel.com> wrote:
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
>  include/linux/ring_buffer.h |  12 ++---
>  kernel/trace/ring_buffer.c  | 107 +++++++++++++++++++++++++++++++-------------
>  2 files changed, 83 insertions(+), 36 deletions(-)
>
> diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> index 28e3472..74bc276 100644
> --- a/include/linux/ring_buffer.h
> +++ b/include/linux/ring_buffer.h
> @@ -36,10 +36,12 @@ struct ring_buffer_event {
>   *                              array[0] = time delta (28 .. 59)
>   *                              size = 8 bytes
>   *
> - * @RINGBUF_TYPE_TIME_STAMP:   Sync time stamp with external clock
> - *                              array[0]    = tv_nsec
> - *                              array[1..2] = tv_sec
> - *                              size = 16 bytes
> + * @RINGBUF_TYPE_TIME_STAMP:   Absolute timestamp
> + *                              Same format as TIME_EXTEND except that the
> + *                              value is an absolute timestamp, not a delta
> + *                              event.time_delta contains bottom 27 bits
> + *                              array[0] = top (28 .. 59) bits
> + *                              size = 8 bytes
>   *

Let's also change it here in ring_buffer.c?

enum {
        RB_LEN_TIME_EXTEND = 8,
        RB_LEN_TIME_STAMP = 16,    <- change to 8
};


>   * <= @RINGBUF_TYPE_DATA_TYPE_LEN_MAX:
>   *                             Data record
> @@ -56,12 +58,12 @@ enum ring_buffer_type {
>         RINGBUF_TYPE_DATA_TYPE_LEN_MAX = 28,
>         RINGBUF_TYPE_PADDING,
>         RINGBUF_TYPE_TIME_EXTEND,
> -       /* FIXME: RINGBUF_TYPE_TIME_STAMP not implemented */
>         RINGBUF_TYPE_TIME_STAMP,
>  };
>
>  unsigned ring_buffer_event_length(struct ring_buffer_event *event);
>  void *ring_buffer_event_data(struct ring_buffer_event *event);
> +u64 ring_buffer_event_time_stamp(struct ring_buffer_event *event);
>
>  /*
>   * ring_buffer_discard_commit will remove an event that has not
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index f544738..df848f0 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -42,6 +42,8 @@ int ring_buffer_print_entry_header(struct trace_seq *s)
>                          RINGBUF_TYPE_PADDING);
>         trace_seq_printf(s, "\ttime_extend : type == %d\n",
>                          RINGBUF_TYPE_TIME_EXTEND);
> +       trace_seq_printf(s, "\ttime_stamp : type == %d\n",
> +                        RINGBUF_TYPE_TIME_STAMP);
>         trace_seq_printf(s, "\tdata max type_len  == %d\n",
>                          RINGBUF_TYPE_DATA_TYPE_LEN_MAX);
>
> @@ -147,6 +149,9 @@ enum {
>  #define skip_time_extend(event) \
>         ((struct ring_buffer_event *)((char *)event + RB_LEN_TIME_EXTEND))
>
> +#define extended_time(event) \
> +       (event->type_len >= RINGBUF_TYPE_TIME_EXTEND)
> +
>  static inline int rb_null_event(struct ring_buffer_event *event)
>  {
>         return event->type_len == RINGBUF_TYPE_PADDING && !event->time_delta;
> @@ -187,10 +192,8 @@ static void rb_event_set_padding(struct ring_buffer_event *event)
>                 return  event->array[0] + RB_EVNT_HDR_SIZE;
>
>         case RINGBUF_TYPE_TIME_EXTEND:
> -               return RB_LEN_TIME_EXTEND;
> -
>         case RINGBUF_TYPE_TIME_STAMP:
> -               return RB_LEN_TIME_STAMP;
> +               return RB_LEN_TIME_EXTEND;

And then this change can be dropped. Or a new single enum can be
defined for both TIME_EXTEND and TIME_STAMP and then used.

thanks,

-Joel
