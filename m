Return-Path: <SRS0=WKTr=4A=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0ECCC352A4
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Feb 2020 03:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A630920842
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Feb 2020 03:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581478623;
	bh=mrjYyFRjFzdaPIzF8UAPN9Z17EZbUe8X+O1lmZW/Dg4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KxS0Mq3iPcZATTPulXLXaeMjcoRDEg9PD3ZQ1a3IwiKxUEdfju7NTvcBahoBxTLa4
	 1eqUympIZlqnZoLVMBqCAipubHkyToq3CIZTF5H4u4EuTzMozVbyogL6wKn2+GU45y
	 EmaxamwPacFJ4aiuC8dtefQg24apsYZYJnmfY1AI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgBLDhB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 11 Feb 2020 22:37:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727602AbgBLDhB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 11 Feb 2020 22:37:01 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B59882073C;
        Wed, 12 Feb 2020 03:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581478620;
        bh=mrjYyFRjFzdaPIzF8UAPN9Z17EZbUe8X+O1lmZW/Dg4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fujIsgxXXld96YbhFeWSBiRvaof1HSb4n6zIuM1D3MaFXYJVXcosGEaoRpEhvRLOv
         NbMmNBKbWKMpaLzFs2EZx3IGePfRuYUI+1RDzzMoyMzDc2sTU/hfnvGtjsrDC0etTd
         V5XIpFpfX2tUkr/a8Qow8k1SGPaalcO+8lFIWUtY=
Date:   Wed, 12 Feb 2020 12:36:56 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, artem.bityutskiy@linux.intel.com,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 3/3] tracing: Consolidate trace() functions
Message-Id: <20200212123656.e47e6e5c9bba8add2dc926c1@kernel.org>
In-Reply-To: <b1f3108d0f450e58192955a300e31d0405ab4149.1581374549.git.zanussi@kernel.org>
References: <cover.1581374549.git.zanussi@kernel.org>
        <b1f3108d0f450e58192955a300e31d0405ab4149.1581374549.git.zanussi@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Tom,

On Mon, 10 Feb 2020 17:06:50 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> Move the checking, buffer reserve and buffer commit code in
> synth_event_trace_start/end() into inline functions
> __synth_event_trace_start/end() so they can also be used by
> synth_event_trace() and synth_event_trace_array(), and then have all
> those functions use them.
> 
> Also, change synth_event_trace_state.enabled to disabled so it only
> needs to be set if the event is disabled, which is not normally the
> case.

I have some comments :)

> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 99a02168599b..65b54d6a1422 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1791,6 +1791,60 @@ void synth_event_cmd_init(struct dynevent_cmd *cmd, char *buf, int maxlen)
>  }
>  EXPORT_SYMBOL_GPL(synth_event_cmd_init);
>  
> +static inline int
> +__synth_event_trace_start(struct trace_event_file *file,
> +			  struct synth_event_trace_state *trace_state)
> +{
> +	int entry_size, fields_size = 0;
> +	int ret = 0;
> +
> +	/*
> +	 * Normal event tracing doesn't get called at all unless the
> +	 * ENABLED bit is set (which attaches the probe thus allowing
> +	 * this code to be called, etc).  Because this is called
> +	 * directly by the user, we don't have that but we still need
> +	 * to honor not logging when disabled.  For the the iterated
> +	 * trace case, we save the enabed state upon start and just
> +	 * ignore the following data calls.
> +	 */
> +	if (!(file->flags & EVENT_FILE_FL_ENABLED) ||
> +	    trace_trigger_soft_disabled(file)) {
> +		trace_state->disabled = true;
> +		ret = -ENOENT;

If the state.disabled is set, I think __synth_event_trace_start() might
be better to return 0 because all caller change the result.

> +		goto out;
> +	}
> +
> +	trace_state->event = file->event_call->data;
> +
> +	fields_size = trace_state->event->n_u64 * sizeof(u64);
> +
> +	/*
> +	 * Avoid ring buffer recursion detection, as this event
> +	 * is being performed within another event.
> +	 */
> +	trace_state->buffer = file->tr->array_buffer.buffer;
> +	ring_buffer_nest_start(trace_state->buffer);
> +
> +	entry_size = sizeof(*trace_state->entry) + fields_size;
> +	trace_state->entry = trace_event_buffer_reserve(&trace_state->fbuffer,
> +							file,
> +							entry_size);
> +	if (!trace_state->entry) {
> +		ring_buffer_nest_end(trace_state->buffer);
> +		ret = -EINVAL;
> +	}
> +out:
> +	return ret;
> +}
> +
> +static inline void
> +__synth_event_trace_end(struct synth_event_trace_state *trace_state)
> +{

Should we check trace_state->disabled here too?

> +	trace_event_buffer_commit(&trace_state->fbuffer);
> +
> +	ring_buffer_nest_end(trace_state->buffer);
> +}
> +
>  /**
>   * synth_event_trace - Trace a synthetic event
>   * @file: The trace_event_file representing the synthetic event
> @@ -1812,69 +1866,38 @@ EXPORT_SYMBOL_GPL(synth_event_cmd_init);
>   */
>  int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
>  {
> -	struct trace_event_buffer fbuffer;
> -	struct synth_trace_event *entry;
> -	struct trace_buffer *buffer;
> -	struct synth_event *event;
> +	struct synth_event_trace_state state;
>  	unsigned int i, n_u64;
> -	int fields_size = 0;
>  	va_list args;
> -	int ret = 0;
> -
> -	/*
> -	 * Normal event generation doesn't get called at all unless
> -	 * the ENABLED bit is set (which attaches the probe thus
> -	 * allowing this code to be called, etc).  Because this is
> -	 * called directly by the user, we don't have that but we
> -	 * still need to honor not logging when disabled.
> -	 */
> -	if (!(file->flags & EVENT_FILE_FL_ENABLED) ||
> -	    trace_trigger_soft_disabled(file))
> -		return 0;
> -
> -	event = file->event_call->data;
> -
> -	if (n_vals != event->n_fields)
> -		return -EINVAL;
> -
> -	fields_size = event->n_u64 * sizeof(u64);
> -
> -	/*
> -	 * Avoid ring buffer recursion detection, as this event
> -	 * is being performed within another event.
> -	 */
> -	buffer = file->tr->array_buffer.buffer;
> -	ring_buffer_nest_start(buffer);
> +	int ret;
>  
> -	entry = trace_event_buffer_reserve(&fbuffer, file,
> -					   sizeof(*entry) + fields_size);
> -	if (!entry) {
> -		ret = -EINVAL;
> -		goto out;
> +	ret = __synth_event_trace_start(file, &state);
> +	if (ret) {


And here, we can check "if (ret || state.disabled)" then

> +		if (ret == -ENOENT)
> +			ret = 0; /* just disabled, not really an error */

We don't need this check.

> +		return ret;
>  	}
>  
>  	va_start(args, n_vals);
> -	for (i = 0, n_u64 = 0; i < event->n_fields; i++) {
> +	for (i = 0, n_u64 = 0; i < state.event->n_fields; i++) {
>  		u64 val;
>  
>  		val = va_arg(args, u64);
>  
> -		if (event->fields[i]->is_string) {
> +		if (state.event->fields[i]->is_string) {
>  			char *str_val = (char *)(long)val;
> -			char *str_field = (char *)&entry->fields[n_u64];
> +			char *str_field = (char *)&state.entry->fields[n_u64];
>  
>  			strscpy(str_field, str_val, STR_VAR_LEN_MAX);
>  			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
>  		} else {
> -			entry->fields[n_u64] = val;
> +			state.entry->fields[n_u64] = val;
>  			n_u64++;
>  		}
>  	}
>  	va_end(args);
>  
> -	trace_event_buffer_commit(&fbuffer);
> -out:
> -	ring_buffer_nest_end(buffer);
> +	__synth_event_trace_end(&state);
>  
>  	return ret;
>  }
> @@ -1901,62 +1924,31 @@ EXPORT_SYMBOL_GPL(synth_event_trace);
>  int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
>  			    unsigned int n_vals)
>  {
> -	struct trace_event_buffer fbuffer;
> -	struct synth_trace_event *entry;
> -	struct trace_buffer *buffer;
> -	struct synth_event *event;
> +	struct synth_event_trace_state state;
>  	unsigned int i, n_u64;
> -	int fields_size = 0;
> -	int ret = 0;
> -
> -	/*
> -	 * Normal event generation doesn't get called at all unless
> -	 * the ENABLED bit is set (which attaches the probe thus
> -	 * allowing this code to be called, etc).  Because this is
> -	 * called directly by the user, we don't have that but we
> -	 * still need to honor not logging when disabled.
> -	 */
> -	if (!(file->flags & EVENT_FILE_FL_ENABLED) ||
> -	    trace_trigger_soft_disabled(file))
> -		return 0;
> -
> -	event = file->event_call->data;
> -
> -	if (n_vals != event->n_fields)
> -		return -EINVAL;
> -
> -	fields_size = event->n_u64 * sizeof(u64);
> -
> -	/*
> -	 * Avoid ring buffer recursion detection, as this event
> -	 * is being performed within another event.
> -	 */
> -	buffer = file->tr->array_buffer.buffer;
> -	ring_buffer_nest_start(buffer);
> +	int ret;
>  
> -	entry = trace_event_buffer_reserve(&fbuffer, file,
> -					   sizeof(*entry) + fields_size);
> -	if (!entry) {
> -		ret = -EINVAL;
> -		goto out;
> +	ret = __synth_event_trace_start(file, &state);
> +	if (ret) {
> +		if (ret == -ENOENT)
> +			ret = 0; /* just disabled, not really an error */

Ditto.

> +		return ret;
>  	}
>  
> -	for (i = 0, n_u64 = 0; i < event->n_fields; i++) {
> -		if (event->fields[i]->is_string) {
> +	for (i = 0, n_u64 = 0; i < state.event->n_fields; i++) {
> +		if (state.event->fields[i]->is_string) {
>  			char *str_val = (char *)(long)vals[i];
> -			char *str_field = (char *)&entry->fields[n_u64];
> +			char *str_field = (char *)&state.entry->fields[n_u64];
>  
>  			strscpy(str_field, str_val, STR_VAR_LEN_MAX);
>  			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
>  		} else {
> -			entry->fields[n_u64] = vals[i];
> +			state.entry->fields[n_u64] = vals[i];
>  			n_u64++;
>  		}
>  	}
>  
> -	trace_event_buffer_commit(&fbuffer);
> -out:
> -	ring_buffer_nest_end(buffer);
> +	__synth_event_trace_end(&state);
>  
>  	return ret;
>  }
> @@ -1993,55 +1985,17 @@ EXPORT_SYMBOL_GPL(synth_event_trace_array);
>  int synth_event_trace_start(struct trace_event_file *file,
>  			    struct synth_event_trace_state *trace_state)
>  {
> -	struct synth_trace_event *entry;
> -	int fields_size = 0;
> -	int ret = 0;
> +	int ret;
>  
> -	if (!trace_state) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> +	if (!trace_state)
> +		return -EINVAL;
>  
>  	memset(trace_state, '\0', sizeof(*trace_state));
>  
> -	/*
> -	 * Normal event tracing doesn't get called at all unless the
> -	 * ENABLED bit is set (which attaches the probe thus allowing
> -	 * this code to be called, etc).  Because this is called
> -	 * directly by the user, we don't have that but we still need
> -	 * to honor not logging when disabled.  For the the iterated
> -	 * trace case, we save the enabed state upon start and just
> -	 * ignore the following data calls.
> -	 */
> -	if (!(file->flags & EVENT_FILE_FL_ENABLED) ||
> -	    trace_trigger_soft_disabled(file)) {
> -		trace_state->enabled = false;
> -		goto out;
> -	}
> -
> -	trace_state->enabled = true;
> +	ret = __synth_event_trace_start(file, trace_state);
> +	if (ret == -ENOENT)
> +		ret = 0; /* just disabled, not really an error */

We can also skip this tweak.

Thank you,

>  
> -	trace_state->event = file->event_call->data;
> -
> -	fields_size = trace_state->event->n_u64 * sizeof(u64);
> -
> -	/*
> -	 * Avoid ring buffer recursion detection, as this event
> -	 * is being performed within another event.
> -	 */
> -	trace_state->buffer = file->tr->array_buffer.buffer;
> -	ring_buffer_nest_start(trace_state->buffer);
> -
> -	entry = trace_event_buffer_reserve(&trace_state->fbuffer, file,
> -					   sizeof(*entry) + fields_size);
> -	if (!entry) {
> -		ring_buffer_nest_end(trace_state->buffer);
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -
> -	trace_state->entry = entry;
> -out:
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(synth_event_trace_start);
> @@ -2074,7 +2028,7 @@ static int __synth_event_add_val(const char *field_name, u64 val,
>  		trace_state->add_next = true;
>  	}
>  
> -	if (!trace_state->enabled)
> +	if (trace_state->disabled)
>  		goto out;
>  
>  	event = trace_state->event;
> @@ -2209,9 +2163,7 @@ int synth_event_trace_end(struct synth_event_trace_state *trace_state)
>  	if (!trace_state)
>  		return -EINVAL;
>  
> -	trace_event_buffer_commit(&trace_state->fbuffer);
> -
> -	ring_buffer_nest_end(trace_state->buffer);
> +	__synth_event_trace_end(trace_state);
>  
>  	return 0;
>  }
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
