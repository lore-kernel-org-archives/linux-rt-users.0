Return-Path: <SRS0=5pzl=R4=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF8AC43381
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Mar 2019 11:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3282087E
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Mar 2019 11:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553513856;
	bh=sABU5pJFeKsGZzAfz8LSKtGwlpZiWNFGphElSw14hmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qd9EWkxemuxIq+JVfsr2+25dIg4e5zkaZFLgDd4UCKF1nbJZaW2JyBC5h76FUc0z3
	 2uGp5+WcIGpTy+KCzmiJMvDQznWB/kwMDDozsAcTHCMJIwz5drRmZ/sX3CdsdsGCtz
	 99Ni1avap0Ufu5dO2azaMgJieOlYy3wpPu0ivExM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730993AbfCYLhb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:37:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44627 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730730AbfCYLha (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 25 Mar 2019 07:37:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id y13so103693pfm.11;
        Mon, 25 Mar 2019 04:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VeB+s6gWFMe8AMsJYz9XJ7GxfqU/tchEME0t2nEdTkc=;
        b=j5Wi1G2g73H6BjfoopYU/Cs+92FhE9yb6X/i+cpoc/k5EqGF9WmSQjFF27UoK5iKiY
         wkU3c6Vzpe0JHvQF3Mu08ovywIwswyRTRD7hMFyy/aWQo8xuAP/wahXezgJHik40x26y
         TVa/BoSyuNVpMdkyqFaMFEb21Sw7fyk4zbuHE+UGKr3tjrj946n9iQfGhcqooSTY9L+X
         tEl+pxuM6LYEeXokxk54+5hW6QLGtr1lcTOH05t/RiEfANriQu/mAK7Gy06qQjkrRGzF
         rVLSpmzzVOXXNnlukxOf/YMFzXtCFzgQIe5AvaPbC0iNFReIy0+IMB7oPfyFvPmrZcm8
         ahXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=VeB+s6gWFMe8AMsJYz9XJ7GxfqU/tchEME0t2nEdTkc=;
        b=ohZgWrhwHZGgcfBCHFsyiIEwqimhbK5xguJS0dFS92s9mq5sb5UirL59L1XVhb+H+2
         G3+g5Ddpw8mPCpuSxmTUdrV62b5GiWVH7Z7bS+/uxvuXzxLSHk5ZgF7b9T8kYKqWMlmU
         kCd5upV5XxgYixCXHWWI2HbbO1qcLOzZb7i3Y4ULAZoimVNSNXH3J93HLJuxwfQEODlH
         m4iJxvjP0/yv7TFjwfqjDwsM3kFeO4mbPdGqrGgmatvV8Abd2v3yMjcpbhJPrj1vJfuC
         tFs46pF3Nc0OJr+iPNu0PvyT2Pea6elUp3/ZZUmyXkRZdxEk1MKCSmo8rBQLRdT9LJO/
         FgRw==
X-Gm-Message-State: APjAAAXBGmvoq0RYabkkQwsSyXuzwqpryfRC66DREhPbzzo6TwHfrS5O
        gjoXggvmoWf19TdX6loCCbs=
X-Google-Smtp-Source: APXvYqzW9PuUq4Fjo5ChWDXBx07b4hPLjXXjWCoo7+LTwfQMy26YlLkJJmdgfDQmjuROex8M2N3+wg==
X-Received: by 2002:a65:4344:: with SMTP id k4mr22478900pgq.20.1553513849985;
        Mon, 25 Mar 2019 04:37:29 -0700 (PDT)
Received: from google.com ([2401:fa00:d:10:75ad:a5d:715f:f6d8])
        by smtp.gmail.com with ESMTPSA id i79sm33798306pfj.28.2019.03.25.04.37.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 04:37:28 -0700 (PDT)
Date:   Mon, 25 Mar 2019 20:37:23 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v4 04/11] tracing: Use tracing error_log with trace event
 filters
Message-ID: <20190325111724.GB211529@google.com>
References: <cover.1553268040.git.tom.zanussi@linux.intel.com>
 <f0895856a61d95aba80f9668d6828234d33b5d7c.1553268040.git.tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f0895856a61d95aba80f9668d6828234d33b5d7c.1553268040.git.tom.zanussi@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Tom,

On Fri, Mar 22, 2019 at 10:34:30AM -0500, Tom Zanussi wrote:
> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Use tracing_log_err() from the new tracing error_log mechanism to send
> filter parse errors to tracing/error_log.
> 
> With this change, users will be able to see filter errors by looking
> at tracing/error_log.
> 
> The same errors will also be available in the filter file, as
> expected.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  kernel/trace/trace_events_filter.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index ade606c33231..3a1ed8631aa0 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -66,7 +66,8 @@ static const char * ops[] = { OPS };
>  	C(INVALID_FILTER,	"Meaningless filter expression"),	\
>  	C(IP_FIELD_ONLY,	"Only 'ip' field is supported for function trace"), \
>  	C(INVALID_VALUE,	"Invalid value (did you forget quotes)?"), \
> -	C(NO_FILTER,		"No filter found"),
> +	C(ERRNO,		"Error"),				\
> +	C(NO_FILTER,		"No filter found")
>  
>  #undef C
>  #define C(a, b)		FILT_ERR_##a
> @@ -76,7 +77,7 @@ enum { ERRORS };
>  #undef C
>  #define C(a, b)		b
>  
> -static char *err_text[] = { ERRORS };
> +static const char *err_text[] = { ERRORS };
>  
>  /* Called after a '!' character but "!=" and "!~" are not "not"s */
>  static bool is_not(const char *str)
> @@ -947,8 +948,10 @@ static void append_filter_err(struct filter_parse_error *pe,
>  	if (pe->lasterr > 0) {
>  		trace_seq_printf(s, "\n%*s", pos, "^");
>  		trace_seq_printf(s, "\nparse_error: %s\n", err_text[pe->lasterr]);
> +		tracing_log_err("event filter parse error", filter->filter_string, err_text, pe->lasterr, pe->lasterr_pos);
>  	} else {
>  		trace_seq_printf(s, "\nError: (%d)\n", pe->lasterr);
> +		tracing_log_err("event filter parse error", filter->filter_string, err_text, FILT_ERR_ERRNO, 0);

These lines are too long, could you please wrap?
Otherwise, the whole series look good to me.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


>  	}
>  	trace_seq_putc(s, 0);
>  	buf = kmemdup_nul(s->buffer, s->seq.len, GFP_KERNEL);
> -- 
> 2.14.1
> 
