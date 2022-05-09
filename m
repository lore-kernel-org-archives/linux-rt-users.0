Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F89C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 May 2022 19:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240392AbiEITJN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 9 May 2022 15:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbiEITJL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 9 May 2022 15:09:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23F582A265
        for <linux-rt-users@vger.kernel.org>; Mon,  9 May 2022 12:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652123116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SCMld57oF9Kp8V3jqJgO5qCThNahlGVXl6RcwON3BaY=;
        b=JmSdUjNlKSsfk4V6EnEk9TJsFJAYcLzSY7q2sLqFenDxwjl/U1hxau10o/uppCWQ8XQ4s3
        A9ErApb6bbcdRtLdAKAVjkGSqMr2UgONSJWLEhYF+ZaBX9KmE1IhzO9JVJ0neYjOWV2MDb
        13LVGIRLIcN3jXcwRA6B7i2abNWqMwU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-KC8ZRufyPDu2CU39S39uig-1; Mon, 09 May 2022 15:05:15 -0400
X-MC-Unique: KC8ZRufyPDu2CU39S39uig-1
Received: by mail-qt1-f199.google.com with SMTP id a28-20020ac8435c000000b002f3bc1cbd08so10884071qtn.18
        for <linux-rt-users@vger.kernel.org>; Mon, 09 May 2022 12:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=SCMld57oF9Kp8V3jqJgO5qCThNahlGVXl6RcwON3BaY=;
        b=WtE5ODL7DiQcVjXiAk0tmj9mvTgZm5H/DGjZPqxWUA9lbEQBRwyFlThklMe2QIFEXk
         usjEoMpT6acC8N+rj9h4emNTowc3ksFmlIYgIj9yfnOpm4/VB8/73FRvwAPXYVeNhJvm
         yxmquhrCuBA9j/x+/UmKX5LCr1T8iAKfON2mt5oVZyfA+9Ng5x1AYovxLtpDiDnGw2Lw
         2AbZ4MXzv1SUlw92TqkrzsaFDyrNYQ9Zaoq2Rdy1HPJ819f3CqIDlMOd4uBY99mt/wFv
         d8uffCWBC3lnh5aHl2wkXIzqIXiPhq95xqD0FIDe+yYj5IwT1SrsZhff6A6uRZ0ZMRa9
         ClMQ==
X-Gm-Message-State: AOAM530BupyV+0v0jA19gUHYLC7QWLxDVkIn8EgHaaC0IJp6OK99QOwG
        3Aj/XAi+EnDdRLchUHFjWtQLMQv/khgXhfhcEXzsF+vru/jzDusocyJXWDyFN9K1Z+XEZDytmoo
        Afma1TuCN2uWniB/e1Pr9BsHgXwE=
X-Received: by 2002:ac8:5913:0:b0:2f3:a402:1054 with SMTP id 19-20020ac85913000000b002f3a4021054mr16633786qty.513.1652123113585;
        Mon, 09 May 2022 12:05:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMmUXRaZkGC60OMDwP+gLItKGBaKhdZIQto79AVL2ipF1n+ZYEBBK3sMqHCWi+wMlHoQ23Hw==
X-Received: by 2002:ac8:5913:0:b0:2f3:a402:1054 with SMTP id 19-20020ac85913000000b002f3a4021054mr16633716qty.513.1652123113061;
        Mon, 09 May 2022 12:05:13 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-93.dsl.bell.ca. [184.147.143.93])
        by smtp.gmail.com with ESMTPSA id b24-20020ac86bd8000000b002f39b99f692sm7763167qtt.44.2022.05.09.12.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 12:05:12 -0700 (PDT)
Date:   Mon, 9 May 2022 15:05:11 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Yihao Wu <wuyihao@linux.alibaba.com>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 2/2] hackbench: Add af_inet mode besides af_unix and
 pipe
In-Reply-To: <20220428103726.108597-3-wuyihao@linux.alibaba.com>
Message-ID: <8950ed98-c3be-4658-a27f-df78c6dfe67e@redhat.com>
References: <20220428103726.108597-1-wuyihao@linux.alibaba.com> <20220428103726.108597-3-wuyihao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 28 Apr 2022, Yihao Wu wrote:

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
>  src/hackbench/hackbench.c | 57 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/src/hackbench/hackbench.c b/src/hackbench/hackbench.c
> index b9b0af6..030342f 100644
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
>  			if ((datasize = atoi(optarg)) <= 0) {
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
> 2.18.2
> 
> 

Sure, this seems like a good idea. If I understand correctly, it doesn't 
change the default way that hackbench is run today without the option. 
I'll take this, but it doesn't apply correctly today, probably 
because it assumes that your first patch was applied. Could you regenerate 
this patch, against the current code without your first patch, and I'll 
apply it then.

Thanks

John

