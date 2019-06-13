Return-Path: <SRS0=sIfm=UM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C71C31E49
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Jun 2019 15:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE162207E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Jun 2019 15:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0e6XjFu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732747AbfFMPGp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:06:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52853 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732408AbfFMOHk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 Jun 2019 10:07:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so10382402wms.2
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Jun 2019 07:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=n9y7skqorstSbX0FKo8yJS8E7+0ZRsBqS7XYpsq1T54=;
        b=F0e6XjFuR4N2EJwTterkjlxHFhOJtewz3yg7GLa8vGVfOpeS8mkB29GxZwRl7M6D3C
         gBdl+TCZ73BfertSFaB935Ezkm23fOCzM3SvYdL091Mij0nXU5AGgAUKqnJhok64AUu5
         tcbZUh1Y34zcKhIQhnwm59PmGZavzpZkvvE0cNT5VnkYFk/BJl2SZxsDA8yv/h+TS44i
         5djbYLh6+B8Fm5eBJrE2O1F2AjOHl1UVvFUJtn7tS41BvuxzzRETJrTefNQZJFFhzMsl
         b/AMh5ytzucAJzkidnaEqelcq8CQ+FATFJQxHdrfVCaII3DpFBLI9P451QeW7g/ZFM+Y
         aGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=n9y7skqorstSbX0FKo8yJS8E7+0ZRsBqS7XYpsq1T54=;
        b=p18DW9Md/EE/wQKhDbcNDHuCN/0gnE+k0J/0B4TD/bHYTPXJWIG0c1xtteK6VDtcuD
         ogvDgTZ0iw2DjB9kP5BlQz+Pk3DM4W9Wrn5u90r9PuneTOwNT2xptYZcefq6jGckcPn6
         kYVOHRwC9l3ggLCN9EhKr9PnzHJbkU5eaTdwV3Kk/POhZnKCM7CyQWpCEysPgL4bLxSa
         rzelQQR9mjGAFFFmqzfmC+phO/Nq0HynstH+rIYMeZjeKjGSFHfF1yi0o/AOndXFZDTO
         Gfsnn9FpK7vXCX4eUPblUPJhkFkKrC0e2ibYm8Qum72UIcB21WyYNYKWziHMjP3xiDl4
         sNPw==
X-Gm-Message-State: APjAAAWzcBAGg7lfE9BoPQZBLsJXQVF1QYfg3pc1hcrUaLaEX/1229d0
        E4DUW1Z3cS4unUBKkgJUNHyX1I9Kd3w=
X-Google-Smtp-Source: APXvYqx3vBT9H7Ih1LR3AmFKsCFnU8Kv00fln8cAl8vrKfyI1tZRkaOBcr3nEaJYC+44TCCZOts1Tw==
X-Received: by 2002:a1c:9e4d:: with SMTP id h74mr3947267wme.9.1560434857804;
        Thu, 13 Jun 2019 07:07:37 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id p2sm3530510wrx.90.2019.06.13.07.07.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 07:07:35 -0700 (PDT)
Date:   Thu, 13 Jun 2019 16:07:29 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Daniel Wagner <wagi@monom.org>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 05/12] pi_stress: Rename -t command line option to
 -D
In-Reply-To: <20190605160617.22987-6-wagi@monom.org>
Message-ID: <alpine.LFD.2.21.1906131607110.8187@planxty>
References: <20190605160617.22987-1-wagi@monom.org> <20190605160617.22987-6-wagi@monom.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 5 Jun 2019, Daniel Wagner wrote:

> Streamline the duration command line argument for all rt-tests. While
> at it also add man page.
> 
> Signed-off-by: Daniel Wagner <wagi@monom.org>
> ---
>  src/pi_tests/pi_stress.8 |  4 ++++
>  src/pi_tests/pi_stress.c | 11 ++++++-----
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/src/pi_tests/pi_stress.8 b/src/pi_tests/pi_stress.8
> index c92b4bdf5609..475d3c34f135 100644
> --- a/src/pi_tests/pi_stress.8
> +++ b/src/pi_tests/pi_stress.8
> @@ -57,6 +57,10 @@ seconds and then terminate.
>  The number of inversion groups to run. Defaults to 10.
>  .IP \-d|\-\-debug
>  Run in debug mode; lots of extra prints
> +.IP "\-D, \-\-duration=TIME"
> +Specify a length for the test run.
> +.br
> +Append 'm', 'h', or 'd' to specify minutes, hours or days.
>  .IP \-v|\-\-verbose
>  Run with verbose messages
>  .IP \-s|\-\-signal
> diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
> index 543106be8e18..1286370c474b 100644
> --- a/src/pi_tests/pi_stress.c
> +++ b/src/pi_tests/pi_stress.c
> @@ -146,7 +146,7 @@ int lockall = 0;
>  
>  /* command line options */
>  struct option options[] = {
> -	{"duration", required_argument, NULL, 't'},
> +	{"duration", required_argument, NULL, 'D'},
>  	{"verbose", no_argument, NULL, 'v'},
>  	{"quiet", no_argument, NULL, 'q'},
>  	{"groups", required_argument, NULL, 'g'},
> @@ -1027,7 +1027,8 @@ void usage(void)
>  	printf("\t--verbose\t- lots of output\n");
>  	printf("\t--quiet\t\t- suppress running output\n");
>  	printf
> -	    ("\t--duration=<n>- length of the test run in seconds [infinite]\n");
> +	    ("\t--duration=<n>\t- length of the test run in seconds [infinite]\n");
> +	printf("\t\t\t  Append 'm', 'h', or 'd' to specify minutes, hours or days.\n");
>  	printf("\t--groups=<n>\t- set the number of inversion groups [%d]\n",
>  	       ngroups);
>  	printf
> @@ -1322,13 +1323,13 @@ int process_sched_line(const char *arg)
>  void process_command_line(int argc, char **argv)
>  {
>  	int opt;
> -	while ((opt = getopt_long(argc, argv, "+ht:vqi:g:rs:pdVum", options, NULL)) != -1) {
> +	while ((opt = getopt_long(argc, argv, "+hD:vqi:g:rs:pdVum", options, NULL)) != -1) {
>  		switch (opt) {
>  		case 'h':
>  			usage();
>  			exit(0);
> -		case 't':
> -			duration = strtol(optarg, NULL, 10);
> +		case 'D':
> +			duration = parse_time_string(optarg);
>  			break;
>  		case 'v':
>  			verbose = 1;
> -- 
> 2.20.1
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
