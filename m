From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 21/33] tracing: Add support for 'synthetic' events
Date: Wed, 4 Oct 2017 14:08:16 -0400
Message-ID: <20171004140816.64eaa140@gandalf.local.home>
References: <cover.1506105131.git.tom.zanussi@linux.intel.com>
        <779b69521d09ef0b4228170e9a7c0425f1b1e32d.1506105131.git.tom.zanussi@linux.intel.com>
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
In-Reply-To: <779b69521d09ef0b4228170e9a7c0425f1b1e32d.1506105131.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 22 Sep 2017 15:00:01 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:



> +/* This function releases synth_event_mutex */
> +static int unregister_synth_event(struct synth_event *event)
> +{
> +	struct trace_event_call *call = &event->call;
> +	int ret;
> +
> +	mutex_unlock(&synth_event_mutex);
> +	ret = trace_remove_event_call(call);
> +	mutex_lock(&synth_event_mutex);
> +
> +	return ret;
> +}
> +
> +static int remove_synth_event(struct synth_event *event)
> +{
> +	int ret = unregister_synth_event(event);
> +
> +	if (!ret)
> +		list_del(&event->list);
> +
> +	return ret;
> +}
> +


> +/* This function releases synth_event_mutex */
> +static int release_all_synth_events(void)
> +{
> +	struct synth_event *event, *e;
> +	int ret = 0;
> +
> +	mutex_lock(&synth_event_mutex);
> +
> +	list_for_each_entry(event, &synth_event_list, list) {
> +		if (event->ref) {
> +			ret = -EBUSY;
> +			goto out;
> +		}
> +	}
> +
> +	list_for_each_entry_safe(event, e, &synth_event_list, list) {

remove_synth_event() releases synth_event_mutex, which is racy, as more
than one instance can do the deletion.

Perhaps we should remove all the events off the synth_event_list under
the lock, release the lock, and then remove the trace events attached
to them?

-- Steve


> +		ret = remove_synth_event(event);
> +		if (!ret)
> +			free_synth_event(event);
> +	}
> + out:
> +	mutex_unlock(&synth_event_mutex);
> +
> +	return ret;
> +}
> +
> +
