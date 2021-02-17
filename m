Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935B9C433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Feb 2021 03:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 632B964DF3
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Feb 2021 03:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhBQDvT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Feb 2021 22:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhBQDvR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Feb 2021 22:51:17 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EE4C061574
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Feb 2021 19:50:36 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id q85so11620052qke.8
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Feb 2021 19:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=5FayjuKnsvHQ8LhLNEfFTMGhkQgM6HhLrr8rePHUltI=;
        b=K1WaPDmSLtybiIAq4hldp8KoocHNlLc56CFsvjosOtdrnhCUxYtwsTvNE8OEvs5yyE
         lDrV1UarA4qejAeO5RQdZCmPkqRH8FRNUGBNnz0c8PKFOzLobYBtTEnIHm6ucL6CYkeD
         ksXjn77cA5y34StsyTwKzDoJSiYfAYBS7ac7UtajpigCqA6/S3KpCyfBQdbuVijbTIn1
         W4R/u1B+z3IM7LUgchTXkYX7Lae+c00UBibPkpglz7XgRvNPrpICpX/h0eu7rAzDhAk5
         It4q01wgAVL9kkAnQWoYRGXKsS7DckEyzmldPsttXpqfCzVJ2YfaqUK4ZSWYjhsFNj7i
         9+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=5FayjuKnsvHQ8LhLNEfFTMGhkQgM6HhLrr8rePHUltI=;
        b=NdMNw7zXeF660N1886HQ/hrm7ybo0B7nUYBnbk3gZSnKCcNCZ7MiK/LKjO2ANwZ6C/
         4fIUL4RMLwuewytHn6HsSBkmGxsTF2/8jI+jLy7j1HdNuVp53VGR7GT+mmg0rv6eO73c
         rj7GDD1UdNLkc9s8E7CEIYqXwHepkPS5DRwdcBl9oTJi9mRs2tQXenBJFEzBSnPyFoZt
         6yxDG+LI/7dZAugbl2M9/iyBw1pU39RRaLax/mgz1w3vZzJyTZ555Koi9iL2oIUUEygr
         KPYI5t7nz/gIxAYY4waVH8nx8WjoZWp1B8rClIt/5ZcLZI7PDFTftuDDft/jZyQDn93L
         Z1kg==
X-Gm-Message-State: AOAM5330xq1+NdU7BXRsAWLFvpH1oiwBd7Dq4vkJw8wN0jmNMkCiu/HV
        nQJ9Mpnt09oaD2Yj+GhSeaE=
X-Google-Smtp-Source: ABdhPJyw/+P2DmsPG7DqXlpedx5Bp3MsQcZS5z2M9JN5GFllRohLCLD24JXHp+QU2pDovhwzFiV8OA==
X-Received: by 2002:a05:620a:24cd:: with SMTP id m13mr23342079qkn.273.1613533836222;
        Tue, 16 Feb 2021 19:50:36 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id b7sm786691qkj.115.2021.02.16.19.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 19:50:35 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 16 Feb 2021 22:50:35 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v5 03/13] rt-utils: Add JSON common header output
 helper
In-Reply-To: <20210210175118.19709-4-dwagner@suse.de>
Message-ID: <77cba51a-d7d-4f5b-3faa-222ec1328be8@redhat.com>
References: <20210210175118.19709-1-dwagner@suse.de> <20210210175118.19709-4-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 10 Feb 2021, Daniel Wagner wrote:

> rt_write_json writes the common system information header of the
> rt-test currently executed.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/include/rt-utils.h |  4 ++
>  src/lib/rt-utils.c     | 96 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 100 insertions(+)
> 
> diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
> index 39ddbd9eae29..36af92b170df 100644
> --- a/src/include/rt-utils.h
> +++ b/src/include/rt-utils.h
> @@ -80,4 +80,8 @@ static inline int64_t calctime(struct timespec t)
>  	return time;
>  }
>  
> +void rt_write_json(const char *filename, int argc, char *argv[],
> +		   void (*cb)(FILE *, void *),
> +		   void *data);
> +
>  #endif	/* __RT_UTILS.H */
> diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
> index 321a11b1172d..00907c573d6a 100644
> --- a/src/lib/rt-utils.c
> +++ b/src/lib/rt-utils.c
> @@ -20,6 +20,9 @@
>  #include <sys/stat.h>
>  #include <unistd.h>
>  #include <sys/syscall.h> /* For SYS_gettid definitions */
> +#include <sys/utsname.h>
> +#include <time.h>
> +#include <sys/time.h>
>  
>  #include "rt-utils.h"
>  #include "rt-sched.h"
> @@ -482,3 +485,96 @@ void disable_trace_mark(void)
>  {
>  	close_tracemark_fd();
>  }
> +
> +static char *get_cmdline(int argc, char *argv[])
> +{
> +	char *cmdline;
> +	int len, i;
> +
> +	len = 0;
> +	for (i = 0; i < argc; i++)
> +		len += strlen(argv[i]) + 1;
> +
> +	cmdline = malloc(len);
> +	if (!cmdline)
> +		err_exit(ENOMEM, "Could not copy cmdline");
> +
> +	memset(cmdline, 0, len);
> +	for (i = 0; i < argc;) {
> +		cmdline = strcat(cmdline, argv[i]);
> +		i++;
> +		if (i < argc)
> +			cmdline = strcat(cmdline, " ");
> +	}
> +
> +	return cmdline;
> +}
> +
> +void rt_write_json(const char *filename, int argc, char *argv[],
> +		  void (*cb)(FILE *, void *),
> +		  void *data)
> +{
> +	unsigned char buf[1];
> +	struct utsname uts;
> +	struct timeval tv;
> +	char tsbuf[64];
> +	struct tm *tm;
> +	char *cmdline;
> +	FILE *f, *s;
> +	time_t t;
> +	size_t n;
> +	int rt = 0;
> +
> +	if (!filename || !strcmp("-", filename)) {
> +		f = stdout;
> +	} else {
> +		f = fopen(filename, "w");
> +		if (!f)
> +			err_exit(errno, "Failed to open '%s'\n", filename);
> +	}
> +
> +	cmdline = get_cmdline(argc, argv);
> +	if (!cmdline)
> +		err_exit(ENOMEM, "get_cmdline()");
> +
> +
> +	gettimeofday(&tv, NULL);
> +	t = tv.tv_sec;
> +	tm = localtime(&t);
> +	/* RFC 2822-compliant date format */
> +	strftime(tsbuf, sizeof(tsbuf), "%a, %d %b %Y %T %z", tm);
> +
> +	s = fopen("/sys/kernel/realtime", "r");
> +	if (s) {
> +		n = fread(buf, 1, 1, s);
> +		if (n == 1 && buf[0] == '1')
> +			rt = 1;
> +		fclose(s);
> +	}
> +
> +	if (uname(&uts))
> +		err_exit(errno, "Could not retrieve system information");
> +
> +	fprintf(f, "{\n");
> +	fprintf(f, "  \"file_version\": 1,\n");
> +	fprintf(f, "  \"cmdline:\": \"%s\",\n", cmdline);
> +	fprintf(f, "  \"rt_test_version:\": \"%1.2f\",\n", VERSION);
> +	fprintf(f, "  \"finished\": \"%s\",\n", tsbuf);
> +	fprintf(f, "  \"sysinfo\": {\n");
> +	fprintf(f, "    \"sysname\": \"%s\",\n", uts.sysname);
> +	fprintf(f, "    \"nodename\": \"%s\",\n", uts.nodename);
> +	fprintf(f, "    \"release\": \"%s\",\n", uts.release);
> +	fprintf(f, "    \"version\": \"%s\",\n", uts.version);
> +	fprintf(f, "    \"machine\": \"%s\",\n", uts.machine);
> +	fprintf(f, "    \"realtime\": %d\n", rt);
> +	fprintf(f, "  },\n");
> +
> +	(cb)(f, data);
> +
> +	fprintf(f, "}\n");
> +
> +	free(cmdline);
> +
> +	if (!filename || strcmp("-", filename))
> +		fclose(f);
> +}
> -- 
> 2.30.0
> 
> 

Signed-off-by: John Kacur <jkacur@redhat.com>
