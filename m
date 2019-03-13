Return-Path: <SRS0=s/eb=RQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6354C43381
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 13:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9492184D
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 13:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfCMNYA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:24:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfCMNX6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Mar 2019 09:23:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EDF62087C;
        Wed, 13 Mar 2019 13:23:57 +0000 (UTC)
Date:   Wed, 13 Mar 2019 09:23:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, tglx@linutronix.de,
        namhyung@kernel.org, bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH 4/7] tracing/probe: Check event/group naming rule at
 parsing
Message-ID: <20190313092355.6f434c9f@gandalf.local.home>
In-Reply-To: <155248009231.10815.12287201787254147977.stgit@devnote2>
References: <155248005229.10815.334731901778152247.stgit@devnote2>
        <155248009231.10815.12287201787254147977.stgit@devnote2>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 13 Mar 2019 21:28:12 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Check event and group naming rule at parsing it instead
> of allocating probes.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_kprobe.c |    7 +------
>  kernel/trace/trace_probe.c  |    8 ++++++++
>  kernel/trace/trace_uprobe.c |    5 +----
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index d47e12596f12..5222fd82e7e4 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -221,7 +221,7 @@ static struct trace_kprobe *alloc_trace_kprobe(const char *group,
>  
>  	tk->rp.maxactive = maxactive;
>  
> -	if (!event || !is_good_name(event)) {
> +	if (!event || !group) {
>  		ret = -EINVAL;
>  		goto error;
>  	}
> @@ -231,11 +231,6 @@ static struct trace_kprobe *alloc_trace_kprobe(const char *group,
>  	if (!tk->tp.call.name)
>  		goto error;
>  
> -	if (!group || !is_good_name(group)) {
> -		ret = -EINVAL;
> -		goto error;
> -	}
> -
>  	tk->tp.class.system = kstrdup(group, GFP_KERNEL);
>  	if (!tk->tp.class.system)
>  		goto error;
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index feae03056f0b..1f0cb4030c0b 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -172,6 +172,10 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
>  			return -E2BIG;
>  		}
>  		strlcpy(buf, event, slash - event + 1);
> +		if (!is_good_name(buf)) {
> +			pr_info("Group name must follow the rule of C identifier\n");

What do you mean by "C identifier"?

-- Steve

> +			return -EINVAL;
> +		}
>  		*pgroup = buf;
>  		*pevent = slash + 1;
>  		event = *pevent;
> @@ -184,6 +188,10 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
>  		pr_info("Event name is too long\n");
>  		return -E2BIG;
>  	}
> +	if (!is_good_name(event)) {
> +		pr_info("Event name must follow the rule of C identifier\n");
> +		return -EINVAL;
> +	}
>  	return 0;
>  }
>
