Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBE7C43334
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Jun 2022 16:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiFXQ21 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 Jun 2022 12:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiFXQ2Z (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Jun 2022 12:28:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1A2C4CD6F
        for <linux-rt-users@vger.kernel.org>; Fri, 24 Jun 2022 09:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656088103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T2IOouq0ipdZCPv2ze1hobTKYo5lSpowU+n7BMoJGDk=;
        b=T5O6DTVlXy2v/gZJJGAzo96qHlgbp96fqLQJq2aoB4hRIEmVdVNDI36lnV3LVnEsxuJwEm
        cOKdqk0zRLlihoFOn89uqScQAc4c7vfIXW+UVnPbO92/uUm0D8wLUZTmdI9vI2oZrjmVO3
        4OzHs4+BVLA99LCnwkSjAdyq7AOiae4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-438-kHk_hpJhPeSmyesPvdZJJA-1; Fri, 24 Jun 2022 12:28:21 -0400
X-MC-Unique: kHk_hpJhPeSmyesPvdZJJA-1
Received: by mail-qk1-f198.google.com with SMTP id y8-20020a05620a44c800b006a6f8cd53cbso3162223qkp.5
        for <linux-rt-users@vger.kernel.org>; Fri, 24 Jun 2022 09:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=T2IOouq0ipdZCPv2ze1hobTKYo5lSpowU+n7BMoJGDk=;
        b=Fnc8BFG4hXXml9EIOMiB1g9rBq6KEEJ0DKpvuUZYIgaO/2CyR0PDMyaEMxUhJnn2lw
         4MuvIb5bjXfLf7WWM4A/EcxSshuddbuRsLwfz1882P7giupHBQ0amNcuVQ4gR97wROC7
         +LNlWttql7zF60TDlM2sDv+yThpWZxBG2ToaFoTWfz0WrseoWyjiogN5SS+pjb7jjUt5
         Pvmc8SCh+PhU2r+T0WwTp/+eOqz9iDrR2fIipf/NnWURU3wT0hw/mg7zpY/yG607JJvW
         QCj7UH8dIOIU3LZOaxY83OcyfW3HXxjyfxmQmSNxSIgUlvig6EesCFGbTQc2MysY/wMX
         fnPg==
X-Gm-Message-State: AJIora/0Ahl9ULDYkBC4IHNS4uHGMcxdStK8NfkYYoD50UNJzqQqNAoK
        Ur6VSGUBbkrBXcdfuChYS2r2kPLj2yRYj8vl036rQRAtuLOfyr5lgCdrqnnARcxle5OexgH2KWh
        aYQe1OgwIcUu6xTvacCoJu4G71/g=
X-Received: by 2002:a0c:e486:0:b0:470:8ee8:8e7 with SMTP id n6-20020a0ce486000000b004708ee808e7mr5965182qvl.22.1656088101398;
        Fri, 24 Jun 2022 09:28:21 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tD37RPHezwJodgXS+TzT6o8vPy1t3gy5IeowgkDWovjxcA8RfKAXjijKonWmWJgbSgkiaOUw==
X-Received: by 2002:a0c:e486:0:b0:470:8ee8:8e7 with SMTP id n6-20020a0ce486000000b004708ee808e7mr5965154qvl.22.1656088101145;
        Fri, 24 Jun 2022 09:28:21 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-93.dsl.bell.ca. [184.147.143.93])
        by smtp.gmail.com with ESMTPSA id i10-20020a05622a08ca00b003050032703fsm1681108qte.64.2022.06.24.09.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 09:28:20 -0700 (PDT)
Date:   Fri, 24 Jun 2022 12:28:19 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Yihao Wu <wuyihao@linux.alibaba.com>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v3] hackbench: Add af_inet mode besides af_unix and
 pipe
In-Reply-To: <20220523155515.3649-1-wuyihao@linux.alibaba.com>
Message-ID: <1913eaa4-f6ea-8b2-d091-5671b71ab13a@redhat.com>
References: <c5a3d153-0fe5-4155-9115-a636dea35af2@linux.alibaba.com> <20220523155515.3649-1-wuyihao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 23 May 2022, Yihao Wu wrote:

> We observerved strange performance regression with hackbench, but only with
> its default mode instead of pipe mode. It turned out it was unix domain
> socket to blame rather than the scheduler. Because on older kernels, there
> was a big lock. And modifications to the scheduler made the contension
> worse.
> 
> However pipe mode is much different from the default af_unix mode. So it's
> hard to prove it's really the case. So we think it might be a good idea to
> have af_inet mode for hackbench.
> 
> After implementing it, we compare these three modes. And the result shows
> as what we expect, that only af_unix mode has regression, the others don't.
> This proves adding af_inet mode is valuable.
> 
> Signed-off-by: Yihao Wu <wuyihao@linux.alibaba.com>
> ---
> v1->v2: Drop the first patch
> v2->v3: Fix EOLs in the commit log
> 
>  src/hackbench/hackbench.c | 57 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/src/hackbench/hackbench.c b/src/hackbench/hackbench.c
> index 268c232..18c9284 100644
> --- a/src/hackbench/hackbench.c
> +++ b/src/hackbench/hackbench.c
> @@ -20,11 +20,14 @@
>  #include <string.h>
>  #include <errno.h>
>  #include <unistd.h>
> +#include <sys/ioctl.h>
>  #include <sys/types.h>
>  #include <sys/socket.h>
>  #include <sys/wait.h>
>  #include <sys/time.h>
>  #include <sys/poll.h>
> +#include <netinet/in.h>
> +#include <arpa/inet.h>
>  #include <limits.h>
>  #include <getopt.h>
>  #include <signal.h>
> @@ -46,6 +49,7 @@ static unsigned int fifo = 0;
>  static unsigned int process_mode = PROCESS_MODE;
>  
>  static int use_pipes = 0;
> +static int use_inet = 0;
>  
>  struct sender_context {
>  	unsigned int num_fds;
> @@ -99,6 +103,7 @@ static void print_usage_exit(int error)
>  	       "-h       --help            print this message\n"
>  	       "-l       --loops=LOOPS     how many message should be send\n"
>  	       "-p       --pipe            send data via a pipe\n"
> +	       "-i       --inet            send data via a inet tcp connection\n"
>  	       "-s       --datasize=SIZE   message size\n"
>  	       "-T       --threads         use POSIX threads\n"
>  	       "-P       --process         use fork (default)\n"
> @@ -106,11 +111,52 @@ static void print_usage_exit(int error)
>  	exit(error);
>  }
>  
> +static int inet_socketpair(int fds[2])
> +{
> +	int s1, s2;
> +	struct sockaddr_in sin;
> +	unsigned long ul = 1;
> +
> +	if ((s1 = socket(AF_INET, SOCK_STREAM, 0)) < 0)
> +		barf("socket");
> +	if ((s2 = socket(AF_INET, SOCK_STREAM, 0)) < 0)
> +		barf("socket");
> +
> +	socklen_t len = sizeof(sin);
> +	bzero(&sin, len);
> +	sin.sin_family = AF_INET;
> +	sin.sin_port = 0;
> +	sin.sin_addr.s_addr = inet_addr("127.0.0.1");
> +
> +	if (bind(s1, &sin, len) < 0)
> +		barf("bind");
> +	getsockname(s1, &sin, &len);
> +	if (listen(s1, 10) < 0)
> +		barf("listen");
> +	if (ioctl(s2, FIONBIO, &ul) < 0)
> +		barf("ioctl");
> +	if (ioctl(s1, FIONBIO, &ul) < 0)
> +		barf("ioctl");
> +	connect(s2, &sin, len);
> +	if ((fds[0] = accept(s1, &sin, &len)) < 0)
> +		barf("accept");
> +	ul = 0;
> +	if (ioctl(s2, FIONBIO, &ul) < 0)
> +		barf("ioctl");
> +	fds[1] = s2;
> +	close(s1);
> +
> +	return 0;
> +}
> +
>  static void fdpair(int fds[2])
>  {
>  	if (use_pipes) {
>  		if (pipe(fds) == 0)
>  			return;
> +	} else if (use_inet) {
> +		if (inet_socketpair(fds) == 0)
> +			return;
>  	} else {
>  		if (socketpair(AF_UNIX, SOCK_STREAM, 0, fds) == 0)
>  			return;
> @@ -364,13 +410,14 @@ static void process_options(int argc, char *argv[])
>  			{"help",	no_argument,		NULL, 'h'},
>  			{"loops",	required_argument,	NULL, 'l'},
>  			{"pipe",	no_argument,		NULL, 'p'},
> +			{"inet",	no_argument,		NULL, 'i'},
>  			{"datasize",	required_argument,	NULL, 's'},
>  			{"threads",	no_argument,		NULL, 'T'},
>  			{"processes",	no_argument,		NULL, 'P'},
>  			{NULL, 0, NULL, 0}
>  		};
>  
> -		int c = getopt_long(argc, argv, "f:Fg:hl:ps:TP",
> +		int c = getopt_long(argc, argv, "f:Fg:hl:pis:TP",
>  				    longopts, &optind);
>  		if (c == -1) {
>  			break;
> @@ -402,6 +449,9 @@ static void process_options(int argc, char *argv[])
>  		case 'p':
>  			use_pipes = 1;
>  			break;
> +		case 'i':
> +			use_inet = 1;
> +			break;
>  		case 's':
>  			if (!(argv[optind] && (datasize = atoi(optarg)) > 0)) {
>  				fprintf(stderr, "%s: --datasize|-s requires an integer > 0\n", argv[0]);
> @@ -418,6 +468,11 @@ static void process_options(int argc, char *argv[])
>  			print_usage_exit(1);
>  		}
>  	}
> +
> +	if (use_pipes && use_inet) {
> +		fprintf(stderr, "%s: --pipe|-p and --inet|-i cannot be used together\n", argv[0]);
> +		print_usage_exit(1);
> +	}
>  }
>  
>  void sigcatcher(int sig) {
> -- 
> 2.32.0.604.gb1f3e1269
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

