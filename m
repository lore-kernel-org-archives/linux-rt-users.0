From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v3 4/7] tracing: Add conditional snapshot
Date: Fri, 10 Aug 2018 16:02:25 +0900
Message-ID: <20180810070225.GC479@sejong>
References: <cover.1533753152.git.tom.zanussi@linux.intel.com>
 <d16a83f8320015c6d7cb6659e554bebe03eaabec.1533753152.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
To: Tom Zanussi <zanussi@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d16a83f8320015c6d7cb6659e554bebe03eaabec.1533753152.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Aug 09, 2018 at 09:34:14AM -0500, Tom Zanussi wrote:
> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Currently, tracing snapshots are context-free - they capture the ring
> buffer contents at the time the tracing_snapshot() function was
> invoked, and nothing else.  Additionally, they're always taken
> unconditionally - the calling code can decide whether or not to take a
> snapshot, but the data used to make that decision is kept separately
> from the snapshot itself.
> 
> This change adds the ability to associate with each trace instance
> some user data, along with an 'update' function that can use that data
> to determine whether or not to actually take a snapshot.  The update
> function can then update that data along with any other state (as part
> of the data presumably), if warranted.
> 
> Because snapshots are 'global' per-instance, only one user can enable
> and use a conditional snapshot for any given trace instance.  To
> enable a conditional snapshot (see details in the function and data
> structure comments), the user calls tracing_snapshot_cond_enable().
> Similarly, to disable a conditional snapshot and free it up for other
> users, tracing_snapshot_cond_disable() should be called.
> 
> To actually initiate a conditional snapshot, tracing_snapshot_cond()
> should be called.  tracing_snapshot_cond() will invoke the update()
> callback, allowing the user to decide whether or not to actually take
> the snapshot and update the user-defined data associated with the
> snapshot.  If the callback returns 'true', tracing_snapshot_cond()
> will then actually take the snapshot and return.
> 
> This scheme allows for flexibility in snapshot implementations - for
> example, by implementing slightly different update() callbacks,
> snapshots can be taken in situations where the user is only interested
> in taking a snapshot when a new maximum in hit versus when a value
> changes in any way at all.  Future patches will demonstrate both
> cases.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---

[SNIP]
> @@ -1741,9 +1788,16 @@ static inline bool event_command_needs_rec(struct event_command *cmd_ops)
>  	return cmd_ops->flags & EVENT_CMD_FL_NEEDS_REC;
>  }
>  
> +typedef bool (*cond_update)(struct trace_array *tr, void *cond_data);
> +

I think it's better having "fn_t" suffix like 'cond_update_fn_t'.

Thanks,
Namhyung


>  extern int trace_event_enable_disable(struct trace_event_file *file,
>  				      int enable, int soft_disable);
>  extern int tracing_alloc_snapshot(void);
> +extern void tracing_snapshot_cond(struct trace_array *tr, void *cond_data);
> +extern int tracing_snapshot_cond_enable(struct trace_array *tr, void *cond_data, cond_update update);
> +
> +extern int tracing_snapshot_cond_disable(struct trace_array *tr);
> +extern void *tracing_cond_snapshot_data(struct trace_array *tr);
>  
>  extern const char *__start___trace_bprintk_fmt[];
>  extern const char *__stop___trace_bprintk_fmt[];
