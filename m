Return-Path: <SRS0=6AJS=3U=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FDFC2D0DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 31 Jan 2020 22:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1792A214D8
	for <linux-rt-users@archiver.kernel.org>; Fri, 31 Jan 2020 22:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgAaWnr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 31 Jan 2020 17:43:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:41244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbgAaWnr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 31 Jan 2020 17:43:47 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20D49214D8;
        Fri, 31 Jan 2020 22:43:46 +0000 (UTC)
Date:   Fri, 31 Jan 2020 17:43:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 1/4] tracing: Consolidate some synth_event_trace code
Message-ID: <20200131174344.5606d154@gandalf.local.home>
In-Reply-To: <d1c8d8ad124a653b7543afe801d38c199ca5c20e.1580506712.git.zanussi@kernel.org>
References: <cover.1580506712.git.zanussi@kernel.org>
        <d1c8d8ad124a653b7543afe801d38c199ca5c20e.1580506712.git.zanussi@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 31 Jan 2020 15:55:31 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> +++ b/kernel/trace/trace_events_hist.c
> @@ -2053,24 +2053,72 @@ int synth_event_trace_start(struct trace_event_file *file,
>  }
>  EXPORT_SYMBOL_GPL(synth_event_trace_start);
>  
> -static int save_synth_val(struct synth_field *field, u64 val,
> +int __synth_event_add_val(const char *field_name, u64 val,

Hmm, shouldn't __synth_event_add_val() still be static?

-- Steve

>  			  struct synth_event_trace_state *trace_state)
>  {
> -	struct synth_trace_event *entry = trace_state->entry;
> +	struct synth_field *field = NULL;
> +	struct synth_trace_event *entry;
> +	struct synth_event *event;
> +	int i, ret = 0;
> +
