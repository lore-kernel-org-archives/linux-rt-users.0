Return-Path: <SRS0=QguH=3K=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DE1C2D0CE
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Jan 2020 16:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C15D21569
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Jan 2020 16:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgAUQxq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:53:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:59348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbgAUQxp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Jan 2020 11:53:45 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F52421569;
        Tue, 21 Jan 2020 16:53:44 +0000 (UTC)
Date:   Tue, 21 Jan 2020 11:53:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 05/12] tracing: Add synth_event_run_command()
Message-ID: <20200121115342.03c0fd72@gandalf.local.home>
In-Reply-To: <646c7f37227e20f3084695aca341892a5ee95fa8.1578688120.git.zanussi@kernel.org>
References: <cover.1578688120.git.zanussi@kernel.org>
        <646c7f37227e20f3084695aca341892a5ee95fa8.1578688120.git.zanussi@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 10 Jan 2020 14:35:11 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Masami Hiramatsu <mhiramat@kernel.org>
> 
> This snippet was taken from v4 of Masami's 'tracing/boot: Add
> synthetic event support' patch.
> 
> >From the original: 'The synthetic node requires "fields" string  
> arraies, which defines the fields as same as tracing/synth_events
> interface.'
> 
> synth_event_run_command() provides the means to execute the synthetic
> event create command using the synthetic event command string.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>

If you base your next series off of my for-next branch, you wont need
this patch.

-- Steve


> ---
>  kernel/trace/trace_events_hist.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 8c9894681100..0886ca6da255 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1390,6 +1390,11 @@ static int create_or_delete_synth_event(int argc, char **argv)
>  	return ret == -ECANCELED ? -EINVAL : ret;
>  }
>  
> +int synth_event_run_command(const char *command)
> +{
> +	return trace_run_command(command, create_or_delete_synth_event);
> +}
> +
>  static int synth_event_create(int argc, const char **argv)
>  {
>  	const char *name = argv[0];

