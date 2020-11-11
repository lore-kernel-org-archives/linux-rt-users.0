Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DDBC388F7
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Nov 2020 02:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67A61221F1
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Nov 2020 02:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftBtxqNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgKKCah (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Nov 2020 21:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgKKCag (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Nov 2020 21:30:36 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882A1C0613D1
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Nov 2020 18:30:35 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id u4so402466qkk.10
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Nov 2020 18:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=yL5dNrTkKhoGGA0jrFhCnSZm758bBHqyiH42zP8GcQg=;
        b=ftBtxqNm9uejnB37sfdTER1hfk6TyPH6ZozWFrfYDtsq13AjNUX3yyg5R54zXsxPoO
         yUZHavTWxfaACfeBOl9UhcsGiRSCbD9Xa0O55WWpUvyMcbXDn3yA3tRr+5B3AsYpogWP
         MyfI55lQ/KGi79YcowP7QU1pDvGdgFMCrKgtjvYhP9G9BAmX2LOVygIaO0wXKUIUBtHL
         2AmVx3eeYJsJuH8XdF04UpKYAmNf0rcFNBHWikY+hTFMRusXQ65hECA0+Ifxjd3+NnTa
         8g3tLH7TlfVe6qA4vtIQUBnyWnW8D1Jt1AZpnilf+NBwGucBfmUUblnvxP68/orW0Cmk
         VxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=yL5dNrTkKhoGGA0jrFhCnSZm758bBHqyiH42zP8GcQg=;
        b=XrgcxejxUtDS7Irb/AyZ9o59XsW/6Sl1tdOrAAwqo/vkzamHmRnMzw+hrcm36pCnqF
         p+lKE30ksKLj1l+nscBr0BSxdDWDgpcw3DJr9dYj9liBVnuWNtlwhMRRvrKBdFheZDFp
         5u9NYyQ0YQlVvkin8dQ2BjFqz4WP6LJ7aX5qxdS5HdZbCXEQ+/7kuVOgc+zpajLXPyRG
         3NEXtpQzi9GU5tcply9w36OyymKE7lvcI36XhjUjYMudSMEcRtUgXfXBAvhoG80UaMsm
         oU9TbexGB0MbCG5ExcnOVwva7QoB+D6j+aOKIAeK7WCfqCuiuuBUfrkyAF9SSAe42c3+
         1tbA==
X-Gm-Message-State: AOAM5317kmOeLWhfLltgT0pVdxvPxAcxudnqkkIS4YPM80UwysWVs6gP
        VWIKgragO+fjJYH2d2MV7PT3fxnrtnlk+A==
X-Google-Smtp-Source: ABdhPJyDPNjxWypLkHwxyTGVBGAU914RMsPGHt0VEOtNl4pvn8W6Qah6aOC2zCTccKXjotNXTq+8tA==
X-Received: by 2002:a05:620a:22c9:: with SMTP id o9mr23116758qki.286.1605061834825;
        Tue, 10 Nov 2020 18:30:34 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id 9sm763861qty.30.2020.11.10.18.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 18:30:34 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 10 Nov 2020 21:30:32 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Kurt Kanzenbach <kurt@linutronix.de>
cc:     Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 2/4] rt-tests: rt-utils: Add function to close trace
 fds
In-Reply-To: <20201107095843.11909-3-kurt@linutronix.de>
Message-ID: <34356ea8-f95c-d61c-b012-b7762abc85b6@redhat.com>
References: <20201107095843.11909-1-kurt@linutronix.de> <20201107095843.11909-3-kurt@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sat, 7 Nov 2020, Kurt Kanzenbach wrote:

> Currently the trace fds are not closed. Add a function for it.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  src/include/rt-utils.h |  1 +
>  src/lib/rt-utils.c     | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
> index 4ed1cbc53ece..c6fb220cdb0a 100644
> --- a/src/include/rt-utils.h
> +++ b/src/include/rt-utils.h
> @@ -31,6 +31,7 @@ int parse_time_string(char *val);
>  
>  void enable_trace_mark(void);
>  void tracemark(char *fmt, ...) __attribute__((format(printf, 1, 2)));
> +void disable_trace_mark(void);
>  
>  #define MSEC_PER_SEC		1000
>  #define USEC_PER_SEC		1000000
> diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
> index 85d41b9542a2..a30e1e4ce436 100644
> --- a/src/lib/rt-utils.c
> +++ b/src/lib/rt-utils.c
> @@ -390,6 +390,15 @@ static void open_tracemark_fd(void)
>  	}
>  }
>  
> +static void close_tracemark_fd(void)
> +{
> +	if (tracemark_fd > 0)
> +		close(tracemark_fd);
> +
> +	if (trace_fd > 0)
> +		close(trace_fd);
> +}
> +
>  static int trace_file_exists(char *name)
>  {
>  	struct stat sbuf;
> @@ -437,3 +446,8 @@ void enable_trace_mark(void)
>  	debugfs_prepare();
>  	open_tracemark_fd();
>  }
> +
> +void disable_trace_mark(void)
> +{
> +	close_tracemark_fd();
> +}
> -- 
> 2.26.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
