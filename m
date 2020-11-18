Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E24C5519F
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 21:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C52A4246B8
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 21:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNochpv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgKRVSx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Nov 2020 16:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgKRVSt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Nov 2020 16:18:49 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C61C0613D4
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Nov 2020 13:18:49 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id 199so3321375qkg.9
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Nov 2020 13:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=5TIOr6sP9i/lScX5BpfrIiup/bA96/XgBQi5WZs7jE4=;
        b=MNochpv8lDuTGPOv5E3PbneWzs3VIAgGLybmR5+STi20Zdhw4WJkA2tk6JaSMb6wrw
         Ei7c6TM5HkvQwhWXT0Qof1fMIzQ4rBR+Jscotu6+DKqvJ4jeepYV/DjnvyRRDRxt5ndg
         GaEHKFeLQXoZczlzWNP/rVwNmDPLq4dab8ksEFR7Zjji9oTZgNRKAHCLT1c80xPVuJQH
         bagsfilm4EXIbAx4fUavwGkjTodVJ3ODqF3kRFJlGs4US7aafNV5yJbH5ODpk6OSj7Fr
         bNyMOv1eRTFgeq9mSTTryEIqJMZDrYXt1g1o2zDhtyjVdXe6ZsOfSJdXv6i+6MADA0+s
         78Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=5TIOr6sP9i/lScX5BpfrIiup/bA96/XgBQi5WZs7jE4=;
        b=rJarAs5InEKRXDjKJ8RKcDjeWXFNra4l28zzBhoNb8NyDRetsOfJBPhC1pXlewSZa+
         jM7R6733s6j0GffwlgwBOwiMGk/r3BKDrjtqEapwp0rvkD6gcjlXxtya2S6CeP1HtXau
         2qJCynEumUQOC4snfJcLA7WFloWhiKUcfGQ7iqZCT1c32DbE2Venn1yNdYGNxJry8+lZ
         hHfW7BbskXURSWmJ/PvEpGKk10X6D+jZomPOYn45Kk4/3YJ3BFxFb2ljnZLYbEFJcaJZ
         FQJQJ0Lmw397HleiyHSRFfmdvb0IXB3v8xx7B65njaHJsvqnxkPvAxazMr1bfsM6dKqx
         ceRw==
X-Gm-Message-State: AOAM5305/sK4JHMMyTMsSwWh1pg5lXJ6GfunJPJ6k0+WIutUW8d4Ulwe
        KW1OQLXUjc0JL0YgbRBWfvc=
X-Google-Smtp-Source: ABdhPJwG6APEnQdljat3qNZLeEMV98dlsXy6MWFeU0cfotqUusHEGe0XZ3lOsmHguue27BxG1l7tlg==
X-Received: by 2002:a37:793:: with SMTP id 141mr7579244qkh.215.1605734328289;
        Wed, 18 Nov 2020 13:18:48 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-241.dsl.bell.ca. [174.88.121.241])
        by smtp.gmail.com with ESMTPSA id t133sm17640019qke.82.2020.11.18.13.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 13:18:47 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Wed, 18 Nov 2020 16:18:41 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 6/6] oslat: Use parse_cpumask() from rt-numa.h
In-Reply-To: <20201113210910.21807-7-dwagner@suse.de>
Message-ID: <1529f1b-807e-846-307a-2611875b43a7@redhat.com>
References: <20201113210910.21807-1-dwagner@suse.de> <20201113210910.21807-7-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 13 Nov 2020, Daniel Wagner wrote:

> Use the common parse_cpumask() helper and use struct bitmask directly
> instead transforming it into a CPU_SET first.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/oslat/oslat.c | 55 +++++++++++++++--------------------------------
>  1 file changed, 17 insertions(+), 38 deletions(-)
> 
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index b2aa15001be2..5b7e0d5b5d5c 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -42,6 +42,7 @@
>  #include <sys/syscall.h>
>  
>  #include "rt-utils.h"
> +#include "rt-numa.h"
>  #include "error.h"
>  
>  #ifdef __GNUC__
> @@ -542,37 +543,6 @@ static void usage(int error)
>  	exit(error);
>  }
>  
> -/* TODO: use libnuma? */
> -static int parse_cpu_list(char *cpu_list, cpu_set_t *cpu_set)
> -{
> -	struct bitmask *cpu_mask;
> -	int i, n_cores;
> -
> -	n_cores = sysconf(_SC_NPROCESSORS_CONF);
> -
> -	if (!cpu_list) {
> -		for (i = 0; i < n_cores; i++)
> -			CPU_SET(i, cpu_set);
> -		return n_cores;
> -	}
> -
> -	cpu_mask = numa_parse_cpustring_all(cpu_list);
> -	if (cpu_mask) {
> -		for (i = 0; i < n_cores; i++) {
> -			if (numa_bitmask_isbitset(cpu_mask, i))
> -				CPU_SET(i, cpu_set);
> -		}
> -		numa_bitmask_free(cpu_mask);
> -	} else {
> -		warn("Unknown cpu-list: %s, using all available cpus\n", cpu_list);
> -		for (i = 0; i < n_cores; i++)
> -			CPU_SET(i, cpu_set);
> -	}
> -
> -	return n_cores;
> -}
> -
> -
>  static int workload_select(char *name)
>  {
>  	int i = 0;
> @@ -745,15 +715,18 @@ int main(int argc, char *argv[])
>  {
>  	struct thread *threads;
>  	int i, n_cores;
> -	cpu_set_t cpu_set;
> +	struct bitmask *cpu_set = NULL;
> +	int max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
>  
>  #ifdef FRC_MISSING
>  	printf("This architecture is not yet supported. "
>  	       "Please implement frc() function first for %s.\n", argv[0]);
>  	return 0;
>  #endif
> -
> -	CPU_ZERO(&cpu_set);
> +	if (numa_available() == -1) {
> +		printf("ERROR: Could not initialize libnuma\n");
> +		exit(1);
> +	}
>  
>  	g.app_name = argv[0];
>  	g.rtprio = 0;
> @@ -768,16 +741,22 @@ int main(int argc, char *argv[])
>  
>  	TEST(mlockall(MCL_CURRENT | MCL_FUTURE) == 0);
>  
> -	n_cores = parse_cpu_list(g.cpu_list, &cpu_set);
> +	if (!g.cpu_list)
> +		g.cpu_list = strdup("all");
> +	if (parse_cpumask(g.cpu_list, max_cpus, &cpu_set))
> +		exit(1);
> +	n_cores = numa_bitmask_weight(cpu_set);
>  
> -	TEST(threads = calloc(1, CPU_COUNT(&cpu_set) * sizeof(threads[0])));
> +	TEST(threads = calloc(1, n_cores * sizeof(threads[0])));
>  	for (i = 0; i < n_cores; ++i)
> -		if (CPU_ISSET(i, &cpu_set) && move_to_core(i) == 0)
> +		if (numa_bitmask_isbitset(cpu_set, i) && move_to_core(i) == 0)
>  			threads[g.n_threads_total++].core_i = i;
>  
> -	if (CPU_ISSET(0, &cpu_set) && g.rtprio)
> +	if (numa_bitmask_isbitset(cpu_set, 0) && g.rtprio)
>  		printf("WARNING: Running SCHED_FIFO workload on CPU 0 may hang the thread\n");
>  
> +	numa_bitmask_free(cpu_set);
> +
>  	TEST(move_to_core(g.cpu_main_thread) == 0);
>  
>  	signal(SIGALRM, handle_alarm);
> -- 
> 2.29.2
> 
> 
    minor edit to the message
    Signed-off-by: John Kacur <jkacur@redhat.com>

