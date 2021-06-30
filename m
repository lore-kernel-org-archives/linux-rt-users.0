Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C98CC11F67
	for <linux-rt-users@archiver.kernel.org>; Wed, 30 Jun 2021 03:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 640EC61941
	for <linux-rt-users@archiver.kernel.org>; Wed, 30 Jun 2021 03:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbhF3DHS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 29 Jun 2021 23:07:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40817 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232417AbhF3DHR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 29 Jun 2021 23:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625022289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wR2F691pVWEOfGma77XGVLchrm58RTSaYYG8SEqGaZA=;
        b=gFp7cGxFmV8rMRabC+kZsgNM0n0qLFmcrE4P7nks87/kNmNkzPfqgsKvkhYUnCN5TVmrd7
        Ioe48mdFCNQOf0oI23XjFEjsSq2OGkEZYonzbSDnzej95tS3CwtKyZg1nLgW/tc9Yk3WlN
        mqSNDv7ENLlkoAk4HU8weQ1WZZRd2ic=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-qwD6eRX2Oam-nQfJFmJlbQ-1; Tue, 29 Jun 2021 23:04:47 -0400
X-MC-Unique: qwD6eRX2Oam-nQfJFmJlbQ-1
Received: by mail-il1-f199.google.com with SMTP id z12-20020a92cd0c0000b02901ee7a23aa0cso1012480iln.5
        for <linux-rt-users@vger.kernel.org>; Tue, 29 Jun 2021 20:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=wR2F691pVWEOfGma77XGVLchrm58RTSaYYG8SEqGaZA=;
        b=GU7I/8NVvyHzNaxatMl/gmn0GTez7av2Kc0uDWobZBuR1PKfk/DkrhrIXuzXGJ8ZGU
         q/IhR9ttjF6bKFKVg3ksj3f3E9ulEaGSYOCk5xf2FOwNIxXTZVcVY2OtLdPgoDGWH+Eg
         uLdjaCKFxlYo+MiGKTAmqcA2+8VLA1J9bH334HXtw3hWGybjv57y+00UTH77fEaaziVL
         Qgg1qlnc4/e/uzh5UPpSJcC/drXfcGSxO9IvVqVrGychQaKJKQLEclIuqbIigaFDQBbG
         5/KcR7P4yxp/MoMCUV7hpliCaYh8ro1JPwhUJqdaWgLWehIPj/IcZdtEvxfUMgdLv/VA
         HRFQ==
X-Gm-Message-State: AOAM530WS5+LzzwhlFqteZtNAsphRSjWRb9lFrW/0S7/AGBSUitTIkd7
        PpOYcQMQTH9ScGOLPifqY7WzqF8swtSZcowqIRqNhf5PviJRzHCeKj3xXlPQhuYnvgqMolnHK+h
        ns6SfvVMuI4CjRmcCp2Vc4vUwSk8=
X-Received: by 2002:a92:7111:: with SMTP id m17mr23335366ilc.178.1625022287342;
        Tue, 29 Jun 2021 20:04:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxccrvDh/q+SgyfV1xtzSr3tdxjmeQH3RkjdK5C9XnmbtHLZ8zndAcuDkQ+yXyyzfSsa5wEKA==
X-Received: by 2002:a92:7111:: with SMTP id m17mr23335355ilc.178.1625022287235;
        Tue, 29 Jun 2021 20:04:47 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-156.dsl.bell.ca. [174.88.120.156])
        by smtp.gmail.com with ESMTPSA id t8sm11661454iog.21.2021.06.29.20.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 20:04:46 -0700 (PDT)
Date:   Tue, 29 Jun 2021 23:04:43 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH rt-tests v1 1/2] rt-utils: Call get_timestmap() in
 rt_init()
In-Reply-To: <20210628201203.30974-2-dwagner@suse.de>
Message-ID: <6d3b8012-5358-4094-aaef-a0f632fe8947@redhat.com>
References: <20210628201203.30974-1-dwagner@suse.de> <20210628201203.30974-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 28 Jun 2021, Daniel Wagner wrote:

> Move the get_timestamp() from rt_test_start() to rt_init(). The idea
> of rt_test_start() was to get the start timestamp right before the
> 'main loop' for the test starts. At least for cyclictest the
> rt_test_start() was placed wrongly so that the first test cycle could
> hit the pagefault when strftime() wrote into the tsbuf.
> 
> We don't have an exact semantic description what start test timestamp
> means, so the simplest thing to avoid any further problems with it, is
> to take the timestamp right at the beginning when the program
> starts. Most test programs have a very short setup phase anyway.
> 
> Reported-by: Mike Galbraith <efault@gmx.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/lib/rt-utils.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
> index d264c348ad42..11f386098867 100644
> --- a/src/lib/rt-utils.c
> +++ b/src/lib/rt-utils.c
> @@ -490,6 +490,19 @@ void disable_trace_mark(void)
>  	close_tracemark_fd();
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
>  void rt_init(int argc, char *argv[])
>  {
>  	int offset = 0;
> @@ -514,24 +527,12 @@ void rt_init(int argc, char *argv[])
>  
>  		offset += len + 1;
>  	}
> -}
>  
> -static void get_timestamp(char *tsbuf)
> -{
> -	struct timeval tv;
> -	struct tm *tm;
> -	time_t t;
> -
> -	gettimeofday(&tv, NULL);
> -	t = tv.tv_sec;
> -	tm = localtime(&t);
> -	/* RFC 2822-compliant date format */
> -	strftime(tsbuf, MAX_TS_SIZE, "%a, %d %b %Y %T %z", tm);
> +	get_timestamp(ts_start);
>  }
>  
>  void rt_test_start(void)
>  {
> -	get_timestamp(ts_start);
>  }
>  
>  void rt_write_json(const char *filename, int return_code,
> -- 
> 2.32.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

