Return-Path: <SRS0=WKTr=4A=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1EDC2BA83
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Feb 2020 03:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C159B20848
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Feb 2020 03:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581477863;
	bh=eJmpv/9emvl4U42z26/Ej+ix4SfxVzqXcun+o2B6v7A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wHdFpJYYeAtKzG0iPjr/CTgiVaep8Rzxn0IqRDkYo2ZyYHLjHB4+pKbtQGZ9WavUz
	 inG8FwPDhgS+/Z4WQQAAYQ9ZnwcQw07AlcRbhPfillMMToX1nvGG+vCtKMxUWbRZlb
	 Y+xxARRn1W0hdioCaMjb6h8irSbqoI5cqZMZrnNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgBLDYT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 11 Feb 2020 22:24:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:37176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727641AbgBLDYT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 11 Feb 2020 22:24:19 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ED0920842;
        Wed, 12 Feb 2020 03:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581477858;
        bh=eJmpv/9emvl4U42z26/Ej+ix4SfxVzqXcun+o2B6v7A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CBDJzVDPMWYstppj582gWcSahu1YId7El5AR/G4gm4tNq7Wpny+5V1Bnx/9k/fCqH
         3YmH+djtRGcghmUiFulrt5l0U71avVA/ahOa8ULghNOYBJvQ1BzQonorj9p/9wHyQs
         TgR+F5rfHsq6adYPKZUYqpDmPR/GuXNOGoHAjvkY=
Date:   Wed, 12 Feb 2020 12:24:15 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, artem.bityutskiy@linux.intel.com,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 2/3] tracing: Don't return -EINVAL when tracing soft
 disabled synth events
Message-Id: <20200212122415.6dd7d33c19d1eeddae0ccfb8@kernel.org>
In-Reply-To: <df5d02a1625aff97c9866506c5bada6a069982ba.1581374549.git.zanussi@kernel.org>
References: <cover.1581374549.git.zanussi@kernel.org>
        <df5d02a1625aff97c9866506c5bada6a069982ba.1581374549.git.zanussi@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 10 Feb 2020 17:06:49 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> There's no reason to return -EINVAL when tracing a synthetic event if
> it's soft disabled - treat it the same as if it were hard disabled and
> return normally.
> 
> Have synth_event_trace() and synth_event_trace_array() just return
> normally, and have synth_event_trace_start set the trace state to
> disabled and return.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks,

> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> ---
>  kernel/trace/trace_events_hist.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index a546ffa14785..99a02168599b 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1828,7 +1828,8 @@ int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
>  	 * called directly by the user, we don't have that but we
>  	 * still need to honor not logging when disabled.
>  	 */
> -	if (!(file->flags & EVENT_FILE_FL_ENABLED))
> +	if (!(file->flags & EVENT_FILE_FL_ENABLED) ||
> +	    trace_trigger_soft_disabled(file))
>  		return 0;
>  
>  	event = file->event_call->data;
> @@ -1836,9 +1837,6 @@ int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
>  	if (n_vals != event->n_fields)
>  		return -EINVAL;
>  
> -	if (trace_trigger_soft_disabled(file))
> -		return -EINVAL;
> -
>  	fields_size = event->n_u64 * sizeof(u64);
>  
>  	/*
> @@ -1918,7 +1916,8 @@ int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
>  	 * called directly by the user, we don't have that but we
>  	 * still need to honor not logging when disabled.
>  	 */
> -	if (!(file->flags & EVENT_FILE_FL_ENABLED))
> +	if (!(file->flags & EVENT_FILE_FL_ENABLED) ||
> +	    trace_trigger_soft_disabled(file))
>  		return 0;
>  
>  	event = file->event_call->data;
> @@ -1926,9 +1925,6 @@ int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
>  	if (n_vals != event->n_fields)
>  		return -EINVAL;
>  
> -	if (trace_trigger_soft_disabled(file))
> -		return -EINVAL;
> -
>  	fields_size = event->n_u64 * sizeof(u64);
>  
>  	/*
> @@ -2017,7 +2013,8 @@ int synth_event_trace_start(struct trace_event_file *file,
>  	 * trace case, we save the enabed state upon start and just
>  	 * ignore the following data calls.
>  	 */
> -	if (!(file->flags & EVENT_FILE_FL_ENABLED)) {
> +	if (!(file->flags & EVENT_FILE_FL_ENABLED) ||
> +	    trace_trigger_soft_disabled(file)) {
>  		trace_state->enabled = false;
>  		goto out;
>  	}
> @@ -2026,11 +2023,6 @@ int synth_event_trace_start(struct trace_event_file *file,
>  
>  	trace_state->event = file->event_call->data;
>  
> -	if (trace_trigger_soft_disabled(file)) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -
>  	fields_size = trace_state->event->n_u64 * sizeof(u64);
>  
>  	/*
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
