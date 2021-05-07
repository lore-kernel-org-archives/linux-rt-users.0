Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87417C433B4
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51AB460232
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238345AbhEGQlb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 12:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238373AbhEGQlX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 12:41:23 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD563C061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 09:40:22 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id q6so5110513qvb.2
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 09:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=JqHl8XucqgspSBKkpUb95VvNlP7Y5c0RzKxFvF0yQwU=;
        b=Ml9h0LZD+PicfrPrihOTrT9uVtTyNsiWHuIsQpMZJBMa18FypB6tUOuFGU3IUxz4+m
         3qoY4nskQXqQr2SZkmct9AIIS4vfs6DhcO4SJaj7io5HVC9wt6AiPNotoLNIKvOXTtmH
         xDr6ARPCfKkeUc5kqYYjWEO8kZAMiOQj/H0wI/x4Q3eO1Vuhi7OueJU40EJvICrJICni
         s8G1b3KrJdGiSFv6xPeNu/J2mQlgBYi0x3YbxncZpbN1zU54KsYbMRBmVo/dBp4CwI6I
         8OWru/RBo+UAW/Ew4uyXxuXG7+j408b4uu2A2DQ51FalyJxYtZ6dg5QzW4pKSeXoIESm
         vj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=JqHl8XucqgspSBKkpUb95VvNlP7Y5c0RzKxFvF0yQwU=;
        b=HqOrfRHWiZ42F7AVqCYR6EgSD+yNuTwQaMgEd6lpRvibV6RFDf9GkX72M3pjLrntAJ
         YfxX5304sDkxKt4ykEqGTqJpInfBEXw8QC/RbNlNzRnyMjk26YLgrb1/RzcEVO0eIPeE
         DS2k5tCad7uf1xhsd9BCzI7zTPDWKAdpHFkieci+dxUUsMv5o1T65uWcVe9NY4CdtYc6
         VtvLuHdsaQ9+yY/T/5j2AM2GcHdfxTHm4EJO2Cwa49XCsHk9ARDZLCWeWSXXzvHmo0yo
         sSWphy9ffrzwBgtHxZWOd6T3tkVJopMEeBDp0KaUiHomTHI3U7oCsWF99dB1BtxBtLof
         qx/w==
X-Gm-Message-State: AOAM5319MXKzGk8MxDUo8UUAvovmlFNUxFHkvxoE3R/1Rom66pjjLTZu
        QiMv2nTqP3tta+0mzIghvzo=
X-Google-Smtp-Source: ABdhPJwT9yTHosnWTDQIp+aqgmYxw7Pt2koOwQIVZex///lqMZ5nSb4ZwCn25QPW3GXngWGijy1cBg==
X-Received: by 2002:a0c:f54e:: with SMTP id p14mr10416487qvm.44.1620405622092;
        Fri, 07 May 2021 09:40:22 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id y1sm3073132qkp.21.2021.05.07.09.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:40:21 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 12:40:20 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 15/33] rt-util: Introduce rt_test_start()
In-Reply-To: <20210320183829.1318-16-dwagner@suse.de>
Message-ID: <5a3db222-117-ce6c-4b89-ccf717be19c@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-16-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sat, 20 Mar 2021, Daniel Wagner wrote:

> For the JSON output records a timestamp when the test ended.
> Let's introduce a new API to record a timestamp when the test
> starts. We could put this into rt_init() but in this case we
> would meassure also the time test needs to setup or warm up.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/include/rt-utils.h |  2 ++
>  src/lib/rt-utils.c     | 34 ++++++++++++++++++++++++----------
>  2 files changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
> index 115791c55185..42c2772262db 100644
> --- a/src/include/rt-utils.h
> +++ b/src/include/rt-utils.h
> @@ -82,6 +82,8 @@ static inline int64_t calctime(struct timespec t)
>  
>  void rt_init(int argc, char *argv[]);
>  
> +void rt_test_start(void);
> +
>  void rt_write_json(const char *filename,
>  		   void (*cb)(FILE *, void *),
>  		   void *data);
> diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
> index f736a3449bf7..efb5d1d9e866 100644
> --- a/src/lib/rt-utils.c
> +++ b/src/lib/rt-utils.c
> @@ -30,6 +30,7 @@
>  
>  #define  TRACEBUFSIZ  1024
>  #define  MAX_COMMAND_LINE 4096
> +#define  MAX_TS_SIZE 64
>  
>  static char debugfileprefix[MAX_PATH];
>  static char *fileprefix;
> @@ -37,6 +38,7 @@ static int trace_fd = -1;
>  static int tracemark_fd = -1;
>  static __thread char tracebuf[TRACEBUFSIZ];
>  static char test_cmdline[MAX_COMMAND_LINE];
> +static char ts_start[MAX_TS_SIZE];
>  
>  /*
>   * Finds the tracing directory in a mounted debugfs
> @@ -514,17 +516,32 @@ void rt_init(int argc, char *argv[])
>  	}
>  }
>  
> +static void get_timestamp(char *tsbuf)
> +{
> +	struct timeval tv;
> +	struct tm *tm;
> +	time_t t;
> +
> +	gettimeofday(&tv, NULL);
> +	t = tv.tv_sec;
> +	tm = localtime(&t);
> +	/* RFC 2822-compliant date format */
> +	strftime(tsbuf, MAX_TS_SIZE, "%a, %d %b %Y %T %z", tm);
> +}
> +
> +void rt_test_start(void)
> +{
> +	get_timestamp(ts_start);
> +}
> +
>  void rt_write_json(const char *filename,
>  		  void (*cb)(FILE *, void *),
>  		  void *data)
>  {
>  	unsigned char buf[1];
>  	struct utsname uts;
> -	struct timeval tv;
> -	char tsbuf[64];
> -	struct tm *tm;
> +	char ts_end[MAX_TS_SIZE];
>  	FILE *f, *s;
> -	time_t t;
>  	size_t n;
>  	int rt = 0;
>  
> @@ -536,11 +553,7 @@ void rt_write_json(const char *filename,
>  			err_exit(errno, "Failed to open '%s'\n", filename);
>  	}
>  
> -	gettimeofday(&tv, NULL);
> -	t = tv.tv_sec;
> -	tm = localtime(&t);
> -	/* RFC 2822-compliant date format */
> -	strftime(tsbuf, sizeof(tsbuf), "%a, %d %b %Y %T %z", tm);
> +	get_timestamp(ts_end);
>  
>  	s = fopen("/sys/kernel/realtime", "r");
>  	if (s) {
> @@ -557,7 +570,8 @@ void rt_write_json(const char *filename,
>  	fprintf(f, "  \"file_version\": 1,\n");
>  	fprintf(f, "  \"cmdline:\": \"%s\",\n", test_cmdline);
>  	fprintf(f, "  \"rt_test_version:\": \"%1.2f\",\n", VERSION);
> -	fprintf(f, "  \"finished\": \"%s\",\n", tsbuf);
> +	fprintf(f, "  \"start_time\": \"%s\",\n", ts_start);
> +	fprintf(f, "  \"end_time\": \"%s\",\n", ts_end);
>  	fprintf(f, "  \"sysinfo\": {\n");
>  	fprintf(f, "    \"sysname\": \"%s\",\n", uts.sysname);
>  	fprintf(f, "    \"nodename\": \"%s\",\n", uts.nodename);
> -- 
> 2.30.2
> 
> 

I don't really like this. I think it looks "good" in the json output, but
I don't think it is providing any kind of meaningful data. My fear is that 
users will try to assign some kind of significance to these numbers in 
relation to the tests.

I'm letting it in anyway, maybe people will tell me I'm wrong and they 
like it, but recording my objection for now anyway.

Signed-off-by: John Kacur <jkacur@redhat.com>
