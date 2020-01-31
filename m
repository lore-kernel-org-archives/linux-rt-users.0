Return-Path: <SRS0=6AJS=3U=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC17C2D0DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 31 Jan 2020 17:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960C421734
	for <linux-rt-users@archiver.kernel.org>; Fri, 31 Jan 2020 17:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awJJlzex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgAaRtD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 31 Jan 2020 12:49:03 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:46693 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgAaRtD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 31 Jan 2020 12:49:03 -0500
Received: by mail-il1-f196.google.com with SMTP id t17so6818509ilm.13;
        Fri, 31 Jan 2020 09:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AdMtncNmA+XGHRE6Yq/CeU6F5P0FIh6be3Vb0VSzfoQ=;
        b=awJJlzexA7Dn4LO0Pt/cWg80olwMs4C+cHEcR8arMlDEOEc9eWR4hH5qDgfq0lHtIg
         uODn5fGMO5vm+xpa8fJ6sA/HD232O4W/F4rEPp3LsAc0OfIjgPukdiIeIpG2Fx8C8Xe8
         crEXjXijtqv61neTkAarwFuHsCUbXTzqCh6mBZ3ASVOQP9XGzWjFLq71lrynrdqPQOiA
         HIob3cXpkkjqxGV/+xTdTOwamT/gBi39m5ac+a4a3lsIBjbJ+EP0iQyG+CzY+lwBVsA7
         cTM7Fvseh+zJq7qS7TT0e5TlNO8F/F9AxHyuuFT8+yIGXjE0dYxxEasrLlImZGjyMJCK
         dCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AdMtncNmA+XGHRE6Yq/CeU6F5P0FIh6be3Vb0VSzfoQ=;
        b=rx2AcMlgnFIl6Olomy8FPFmG1eQOrt3IWSl3aNnFT0bdKr9KQCmkdAgwCDGaXRcQ3P
         Z0pRCPFeieLz5l6+tBSdSGLfia+jul5BY/ZrT/TDjnQ1iEbrSdCrPiGdGUWqdHYP3ffl
         84siH26H9+CkltuTnHnOhrysPANMEfEPcFQ4Ruu1u5z5yX1obXcxJNik5zVL4nUrK+TC
         Varq2iL9ji5rglLTVBfWWI8K0W6snLXF5ihpezNUD6drUC1q68eBXcTpitxIL5aXNCnO
         wu5IWgAk2WHsF7H2ERKFdmL3TrHvWKUMmmgDNE4CzNz60dXz7WBpht+9hZmRweYO0TZk
         bmyQ==
X-Gm-Message-State: APjAAAUWZ/EgQ8MaWwjxj8xp8xBsTUehI1V9Cw0D0GHTEqlcasWGlmQ3
        ljgkUst5hGNBtXgcND/hwEfgT3Aa
X-Google-Smtp-Source: APXvYqyKW54/2z/prSdnjBj0OQt21rJgP64D5OWekkdNglmgCeH2Ed51f859d0rWjv0J5onx6/7BPw==
X-Received: by 2002:a92:5f45:: with SMTP id t66mr10875595ilb.28.1580492942755;
        Fri, 31 Jan 2020 09:49:02 -0800 (PST)
Received: from tzanussi-mobl ([2601:246:3:ceb0:d4c1:8f5f:7b14:ce46])
        by smtp.googlemail.com with ESMTPSA id v10sm2558131iol.85.2020.01.31.09.49.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Jan 2020 09:49:02 -0800 (PST)
Message-ID: <1580492941.24839.5.camel@gmail.com>
Subject: Re: [PATCH v4 06/12] tracing: Change trace_boot to use synth_event
 interface
From:   Tom Zanussi <tzanussi@gmail.com>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Date:   Fri, 31 Jan 2020 11:49:01 -0600
In-Reply-To: <94f1fa0e31846d0bddca916b8663404b20559e34.1580323897.git.zanussi@kernel.org>
References: <cover.1580323897.git.zanussi@kernel.org>
         <94f1fa0e31846d0bddca916b8663404b20559e34.1580323897.git.zanussi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Steve,

It looks like you missed this patch when you pulled the other ones into
 for-next.

Tom

On Wed, 2020-01-29 at 12:59 -0600, Tom Zanussi wrote:
> Have trace_boot_add_synth_event() use the synth_event interface.
> 
> Also, rename synth_event_run_cmd() to synth_event_run_command() now
> that trace_boot's version is gone.
> 
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_boot.c        | 31 ++++++++++++----------------
> ---
>  kernel/trace/trace_events_hist.c |  9 ++-------
>  2 files changed, 14 insertions(+), 26 deletions(-)
> 
> diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
> index 2f616cd926b0..8f40de349db1 100644
> --- a/kernel/trace/trace_boot.c
> +++ b/kernel/trace/trace_boot.c
> @@ -133,38 +133,31 @@ trace_boot_add_kprobe_event(struct xbc_node
> *node, const char *event)
>  #endif
>  
>  #ifdef CONFIG_HIST_TRIGGERS
> -extern int synth_event_run_command(const char *command);
> -
>  static int __init
>  trace_boot_add_synth_event(struct xbc_node *node, const char *event)
>  {
> +	struct dynevent_cmd cmd;
>  	struct xbc_node *anode;
> -	char buf[MAX_BUF_LEN], *q;
> +	char buf[MAX_BUF_LEN];
>  	const char *p;
> -	int len, delta, ret;
> +	int ret;
>  
> -	len = ARRAY_SIZE(buf);
> -	delta = snprintf(buf, len, "%s", event);
> -	if (delta >= len) {
> -		pr_err("Event name is too long: %s\n", event);
> -		return -E2BIG;
> -	}
> -	len -= delta; q = buf + delta;
> +	synth_event_cmd_init(&cmd, buf, MAX_BUF_LEN);
> +
> +	ret = synth_event_gen_cmd_start(&cmd, event, NULL);
> +	if (ret)
> +		return ret;
>  
>  	xbc_node_for_each_array_value(node, "fields", anode, p) {
> -		delta = snprintf(q, len, " %s;", p);
> -		if (delta >= len) {
> -			pr_err("fields string is too long: %s\n",
> p);
> -			return -E2BIG;
> -		}
> -		len -= delta; q += delta;
> +		ret = synth_event_add_field_str(&cmd, p);
> +		if (ret)
> +			return ret;
>  	}
>  
> -	ret = synth_event_run_command(buf);
> +	ret = synth_event_gen_cmd_end(&cmd);
>  	if (ret < 0)
>  		pr_err("Failed to add synthetic event: %s\n", buf);
>  
> -
>  	return ret;
>  }
>  #else
> diff --git a/kernel/trace/trace_events_hist.c
> b/kernel/trace/trace_events_hist.c
> index 5a910bb193e9..22cd7ecdfb92 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1752,12 +1752,7 @@ static int create_or_delete_synth_event(int
> argc, char **argv)
>  	return ret == -ECANCELED ? -EINVAL : ret;
>  }
>  
> -int synth_event_run_command(const char *command)
> -{
> -	return trace_run_command(command,
> create_or_delete_synth_event);
> -}
> -
> -static int synth_event_run_cmd(struct dynevent_cmd *cmd)
> +static int synth_event_run_command(struct dynevent_cmd *cmd)
>  {
>  	struct synth_event *se;
>  	int ret;
> @@ -1787,7 +1782,7 @@ static int synth_event_run_cmd(struct
> dynevent_cmd *cmd)
>  void synth_event_cmd_init(struct dynevent_cmd *cmd, char *buf, int
> maxlen)
>  {
>  	dynevent_cmd_init(cmd, buf, maxlen, DYNEVENT_TYPE_SYNTH,
> -			  synth_event_run_cmd);
> +			  synth_event_run_command);
>  }
>  EXPORT_SYMBOL_GPL(synth_event_cmd_init);
>  
