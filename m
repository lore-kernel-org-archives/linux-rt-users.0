Return-Path: <SRS0=xga9=7L=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4405CC433E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 May 2020 14:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2054920776
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 May 2020 14:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590763134;
	bh=r3IR5wTG6blqu/HXWSUH/x6RS+YkKCO3b1zLTpAHh7U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=HZP54XwcnA791GbEp4IYNuzYDXdfwEgSduO7v8HXOqROL+rJ0rNZJxX+2L4nDT715
	 szMnievRVncuNFi7EqRgEuLZ0/qiXHm/gOflHAoFnxp0TvADlyavDox5iugDN103zE
	 iRX2sFT2L6LVsw2VdpBHEtdbntkzH+5QalsBf2W4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgE2Oiv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 29 May 2020 10:38:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbgE2Oiu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 29 May 2020 10:38:50 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03B1A2072D;
        Fri, 29 May 2020 14:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590763129;
        bh=r3IR5wTG6blqu/HXWSUH/x6RS+YkKCO3b1zLTpAHh7U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1T7LEEYui0yfxnPlntXA5d3Zb9SlS72e16dm/GC/uRWSwldhBfWEdcXjZ9hEW9MAS
         tGob/NUV/dEHLIs0KGnD2IK91VS8HSXDoZYIxfdii6huE92JIriwJHfYKwNSFlDn1O
         HDI6Csuvn+x4CB9qPFdKHvTDf39jpyTBi7NVqHhs=
Date:   Fri, 29 May 2020 23:38:45 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selftests/ftrace: Distinguish between hist and
 synthetic event checks
Message-Id: <20200529233845.25d975c6b23d62da1dfb75cb@kernel.org>
In-Reply-To: <af36c539006ef2768114b4ed38e6b054f7c7a3bd.1590693308.git.zanussi@kernel.org>
References: <cover.1590693308.git.zanussi@kernel.org>
        <af36c539006ef2768114b4ed38e6b054f7c7a3bd.1590693308.git.zanussi@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Tom,

On Thu, 28 May 2020 14:32:38 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> With synthetic events now a separate config item as a result of
> 'tracing: Move synthetic events to a separate file', tests that use
> both need to explicitly check for hist trigger support rather than
> relying on hist triggers to pull in synthetic events.
> 
> Add an additional hist trigger check to all the trigger tests that now
> require it, otherwise they'll fail if synthetic events but not hist
> triggers are enabled.

OK, this looks good to me. And if you don't want to repeat it,
you can also put the check function into the test.d/functions.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> ---
>  .../trigger/inter-event/trigger-field-variable-support.tc    | 5 +++++
>  .../trigger/inter-event/trigger-inter-event-combined-hist.tc | 5 +++++
>  .../trigger/inter-event/trigger-multi-actions-accept.tc      | 5 +++++
>  .../trigger/inter-event/trigger-onmatch-action-hist.tc       | 5 +++++
>  .../trigger/inter-event/trigger-onmatch-onmax-action-hist.tc | 5 +++++
>  .../test.d/trigger/inter-event/trigger-onmax-action-hist.tc  | 5 +++++
>  .../trigger/inter-event/trigger-snapshot-action-hist.tc      | 5 +++++
>  .../test.d/trigger/inter-event/trigger-trace-action-hist.tc  | 5 +++++
>  8 files changed, 40 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
> index 77be6e1f6e7b..e232059a8ab2 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
> @@ -17,6 +17,11 @@ if [ ! -f synthetic_events ]; then
>      exit_unsupported
>  fi
>  
> +if [ ! -f events/sched/sched_process_fork/hist ]; then
> +    echo "hist trigger is not supported"
> +    exit_unsupported
> +fi
> +
>  echo "Test field variable support"
>  
>  echo 'wakeup_latency u64 lat; pid_t pid; int prio; char comm[16]' > synthetic_events
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
> index f3eb8aacec0e..07cfcb8157b6 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
> @@ -17,6 +17,11 @@ if [ ! -f synthetic_events ]; then
>      exit_unsupported
>  fi
>  
> +if [ ! -f events/sched/sched_process_fork/hist ]; then
> +    echo "hist trigger is not supported"
> +    exit_unsupported
> +fi
> +
>  echo "Test create synthetic event"
>  
>  echo 'waking_latency  u64 lat pid_t pid' > synthetic_events
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc
> index d281f056f980..73e413c2ca26 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc
> @@ -17,6 +17,11 @@ if [ ! -f synthetic_events ]; then
>      exit_unsupported
>  fi
>  
> +if [ ! -f events/sched/sched_process_fork/hist ]; then
> +    echo "hist trigger is not supported"
> +    exit_unsupported
> +fi
> +
>  echo "Test multiple actions on hist trigger"
>  echo 'wakeup_latency u64 lat; pid_t pid' >> synthetic_events
>  TRIGGER1=events/sched/sched_wakeup/trigger
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
> index a708f0e7858a..ebe0ad827f9f 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
> @@ -17,6 +17,11 @@ if [ ! -f synthetic_events ]; then
>      exit_unsupported
>  fi
>  
> +if [ ! -f events/sched/sched_process_fork/hist ]; then
> +    echo "hist trigger is not supported"
> +    exit_unsupported
> +fi
> +
>  echo "Test create synthetic event"
>  
>  echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
> index dfce6932d8be..2a2ef767249e 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
> @@ -17,6 +17,11 @@ if [ ! -f synthetic_events ]; then
>      exit_unsupported
>  fi
>  
> +if [ ! -f events/sched/sched_process_fork/hist ]; then
> +    echo "hist trigger is not supported"
> +    exit_unsupported
> +fi
> +
>  echo "Test create synthetic event"
>  
>  echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
> index 0035995c2194..98d73bfb0296 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
> @@ -17,6 +17,11 @@ if [ ! -f synthetic_events ]; then
>      exit_unsupported
>  fi
>  
> +if [ ! -f events/sched/sched_process_fork/hist ]; then
> +    echo "hist trigger is not supported"
> +    exit_unsupported
> +fi
> +
>  echo "Test create synthetic event"
>  
>  echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
> index f546c1b66a9b..01b01b9c4e07 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
> @@ -12,6 +12,11 @@ if [ ! -f set_event ]; then
>      exit_unsupported
>  fi
>  
> +if [ ! -f events/sched/sched_process_fork/hist ]; then
> +    echo "hist trigger is not supported"
> +    exit_unsupported
> +fi
> +
>  if [ ! -f snapshot ]; then
>      echo "snapshot is not supported"
>      exit_unsupported
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
> index 8021d60aafec..c3baa486aeb4 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
> @@ -17,6 +17,11 @@ if [ ! -f synthetic_events ]; then
>      exit_unsupported
>  fi
>  
> +if [ ! -f events/sched/sched_process_fork/hist ]; then
> +    echo "hist trigger is not supported"
> +    exit_unsupported
> +fi
> +
>  grep -q "trace(<synthetic_event>" README || exit_unsupported # version issue
>  
>  echo "Test create synthetic event"
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
