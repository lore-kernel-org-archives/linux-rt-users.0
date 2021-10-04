Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90E8C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 Oct 2021 11:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29756120D
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 Oct 2021 11:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbhJDLlR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 4 Oct 2021 07:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhJDLlR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Oct 2021 07:41:17 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58311C061745
        for <linux-rt-users@vger.kernel.org>; Mon,  4 Oct 2021 04:39:28 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 133so16269855pgb.1
        for <linux-rt-users@vger.kernel.org>; Mon, 04 Oct 2021 04:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OrXHn8V7EpZzeIadLMXmXykPrFfUSb8U/HifxFi/aqg=;
        b=PFuQC01aK58Uv3YUC5JETBF/ZCrgKrQQnW9n/UXi7Sd9a0G3X+d0E9/TFN9snhhZEJ
         i28EbiAWn0/wqlvjeCjdClBGnYwBezrQCX7vgxp/akdq/IVHE3ZYKLXZsrJeEksvsNfO
         MesQn0tJdftTUgVXVhV++I3HNiJuEVpG6e22kdYPNdAFxvH3eXnv6naPN87tM5rck3pD
         3D4TsfhWoi0VtBwODpdAHKpTdfHIYsHx47AuLMZ2EWvF8W3GTvdA6KGi2JrwvjwV1kuz
         JWejbRNSO4ZHWNh7WZv82mMngzRSdBJEMWJUMQc19wqUEEcZfKZaVeJrHDFN54eCylP4
         I5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=OrXHn8V7EpZzeIadLMXmXykPrFfUSb8U/HifxFi/aqg=;
        b=ZB+O+AbZXFyM6S1sKn/W6qsj1BcAsXDxDykdBG8kkf7MGYTepeBaupJBEE3bziP7bi
         p36SRcjICgrtJDe3g432dG3PvPl388gi1GxpXC6T1RbJoZI3VcLYJOwb03zMBnYNs6Dd
         BN3vKnMczSlxsVld6WSbz6aEr0uEOIvpWf8IrZszrmaPiE33a3r86WQS/8l5FaCyBvXK
         H0tCkZaLVH+3x+j99eYvKUf/DmwUuTL+3uQjR9IuQazlRgo4HIyr1Iy2/zBJiTY/fn6M
         CsZWUik4eoCprYzjdFl5bGHnEVeNjGzj/Tbh7w8EDozupBSZRFotLT9eq53l+A0Olxep
         rIQQ==
X-Gm-Message-State: AOAM533e+hzyGURibeLQZSbhHcl/VkiA4Zn1CrqqUQZjq/QIwAP+m1e+
        dZCJSe/ayDEBrHh/4/FTOBo7G6J+kZw=
X-Google-Smtp-Source: ABdhPJznKHWq4BNmfDEYnoxHzpRIyZzATcb5P7thoOEmMGH9DE9OD7KRB+1lhVRt30bSo5e+xqoRpQ==
X-Received: by 2002:aa7:9596:0:b0:43e:48:dbeb with SMTP id z22-20020aa79596000000b0043e0048dbebmr23927380pfj.77.1633347567673;
        Mon, 04 Oct 2021 04:39:27 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id j13sm13677056pff.213.2021.10.04.04.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 04:39:27 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     RT <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Pierre FICHEUX <pierre.ficheux@smile.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Luis Goncalves <lgoncalv@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>
Subject: Re: [PATCH 3/3] rt-tests: cyclictest: Add --default-system option
References: <20211001172937.13060-1-jkacur@redhat.com>
        <20211001172937.13060-3-jkacur@redhat.com>
Date:   Mon, 04 Oct 2021 20:39:24 +0900
In-Reply-To: <20211001172937.13060-3-jkacur@redhat.com> (John Kacur's message
        of "Fri, 1 Oct 2021 13:29:37 -0400")
Message-ID: <87sfxh2f4j.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

John Kacur <jkacur@redhat.com> writes:

> This patch add the long option --default-system
> --default-system runs cyclictest without attempting any tuning.
> Power management is not suppressed so cyclictest measures the system as
> it is configured.
>
> This is effectively the same as --laptop, but makes it clear to the user
> what is done and why.
>
> Signed-off-by: John Kacur <jkacur@redhat.com>

I suppose this is probably the best that can be done without breaking
compatibility.

One comment about a pre-existing issue in the code below.

> ---
>  src/cyclictest/cyclictest.8 |  3 +++
>  src/cyclictest/cyclictest.c | 15 ++++++++++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index dc0a278f3d30..dcae5b83147f 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -59,6 +59,9 @@ select clock
>  .br
>  1 = CLOCK_REALTIME
>  .TP
> +.B \-\-default\-system
> +Don't attempt to tune the system from cyclictest. Power management is not suppressed. This might give poorer results, but will allow you to discover if you need to tune the system.
> +.TP
>  .B \-d, \-\-distance=DIST
>  Distance of thread intervals in us, default = 500
>  .TP
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 067b75317c9a..cbdc6c11ffe3 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -194,6 +194,7 @@ static int ct_debug;
>  static int use_fifo = 0;
>  static pthread_t fifo_threadid;
>  static int laptop = 0;
> +static int power_management = 0;
>  static int use_histfile = 0;
>  
>  #ifdef ARCH_HAS_SMI_COUNTER
> @@ -256,6 +257,11 @@ static void set_latency_target(void)
>  		return;
>  	}
>  
> +	if (power_management) {
> +		warn("not setting cpu_dma_latency from cyclictest\n");
> +		return;
> +	}
> +
>  	errno = 0;
>  	err = stat("/dev/cpu_dma_latency", &s);
>  	if (err == -1) {
> @@ -820,6 +826,10 @@ static void display_help(int error)
>  	       "-c CLOCK --clock=CLOCK     select clock\n"
>  	       "                           0 = CLOCK_MONOTONIC (default)\n"
>  	       "                           1 = CLOCK_REALTIME\n"
> +	       "         --default-system  Don't attempt to tune the system from cyclictest.\n"
> +	       "                           Power management is not suppressed.\n"
> +	       "                           This might give poorer results, but will allow you\n"
> +	       "                           to discover if you need to tune the system\n"
>  	       "-d DIST  --distance=DIST   distance of thread intervals in us, default=500\n"
>  	       "-D       --duration=TIME   specify a length for the test run.\n"
>  	       "                           Append 'm', 'h', or 'd' to specify minutes, hours or days.\n"
> @@ -947,7 +957,7 @@ static char *policyname(int policy)
>  
>  enum option_values {
>  	OPT_AFFINITY=1, OPT_BREAKTRACE, OPT_CLOCK,
> -	OPT_DISTANCE, OPT_DURATION, OPT_LATENCY,
> +	OPT_DEFAULT_SYSTEM, OPT_DISTANCE, OPT_DURATION, OPT_LATENCY,
>  	OPT_FIFO, OPT_HISTOGRAM, OPT_HISTOFALL, OPT_HISTFILE,
>  	OPT_INTERVAL, OPT_JSON, OPT_MAINAFFINITY, OPT_LOOPS, OPT_MLOCKALL,
>  	OPT_REFRESH, OPT_NANOSLEEP, OPT_NSECS, OPT_OSCOPE, OPT_PRIORITY,
> @@ -976,6 +986,7 @@ static void process_options(int argc, char *argv[], int max_cpus)
>  			{"aligned",          optional_argument, NULL, OPT_ALIGNED },
>  			{"breaktrace",       required_argument, NULL, OPT_BREAKTRACE },
>  			{"clock",            required_argument, NULL, OPT_CLOCK },
> +			{"default-system",   no_argument,       NULL, OPT_DEFAULT_SYSTEM },
>  			{"distance",         required_argument, NULL, OPT_DISTANCE },
>  			{"duration",         required_argument, NULL, OPT_DURATION },
>  			{"latency",          required_argument, NULL, OPT_LATENCY },
> @@ -1061,6 +1072,8 @@ static void process_options(int argc, char *argv[], int max_cpus)
>  		case OPT_CLOCK:
>  			clocksel = atoi(optarg); break;
>  		case 'C':

The case for the short option 'C' should be dropped. It seems to be a
left-over from a previous cleanup. Same for 'E' a bit further down in
the switch statement.

> +		case OPT_DEFAULT_SYSTEM:
> +			power_management = 1; break;
>  		case 'd':
>  		case OPT_DISTANCE:
>  			distance = atoi(optarg); break;
