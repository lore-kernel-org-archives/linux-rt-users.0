Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DB7C433E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Jan 2021 23:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C8DF23B31
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Jan 2021 23:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbhAVXqn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 22 Jan 2021 18:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbhAVXqY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 22 Jan 2021 18:46:24 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDDCC061793
        for <linux-rt-users@vger.kernel.org>; Fri, 22 Jan 2021 15:45:31 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id az16so3539936qvb.5
        for <linux-rt-users@vger.kernel.org>; Fri, 22 Jan 2021 15:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=CyKqyl/do6AHwLUXVmL/dvakPeF8Rkq/VTVR12Osbs4=;
        b=lZn5z2o0tBJbmLBgo/kPGrXqbIvi+gcKmYryT5yFjmDIE2uPwAgBCnevOXM79uGkc4
         kSC5U7skMrh06I/pfaaFeRYug7m7VfjvGn8xBQpjD7F+zogbjkHJCYDEnkfBeHsEhKZ6
         uVJud8doD7YHe9cVWDxW+kVQreOXqkdtC8tGCRduv9YSo2ij9ecjDvms8SBgUy7CAbWG
         KeSB5jl8zjuC4tebbMbTpvLRyvHwp3Ur3ox2fmV7fa87GE/iQ430oVfkgOoSpFnLTab0
         m+wKWzmsPJn5xCejJ1FybNLGKC8IksdiodpJjU8iwJcWh3ilUrM4GK4Dnz3TrAtDJQUt
         UQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=CyKqyl/do6AHwLUXVmL/dvakPeF8Rkq/VTVR12Osbs4=;
        b=YP1Xn8vNnKasO/JIKvcknWiXmL1j0e5MR6i/Swao73553uhGSfaUX2wKj29nfVTDiQ
         Td3oh9sE7Ah2BGoeRvCFKzuHWycBk4eLb1SC2RK5xYy5S1nBdlIZkqd1NohEhP+ziilh
         SCO9aKAG8+O+zDC2m7XxBNw89oWVQ7xif0Yga2n+yosRZNImeu/dAavR/RWD/wXBw8pA
         Krtlga1YqvGZksFvJ0lFXH5MPAgEQFq72ji+lV4tk3qIKEo5VyQFjpEoyos8Bca4VmkY
         C8p8YJ4yx2ph7pk4prx5VH8Miw+Z8rRzMJs546zcC/Irv74oqpzYrp8/fmH/GBWw3XbW
         clrQ==
X-Gm-Message-State: AOAM532sH/838YK5G8JMqOnPFH94ZUgj1KhtQcdr/4AHvoSgTBrwz0yi
        Yq1TsW+MY8sG1/ImkIg/7bY=
X-Google-Smtp-Source: ABdhPJwXeWRWVGxjtcHuE0gaiu/J7MyNf3Ef823+BfZwGe53roURop/AqbBM4yl0VbnKxVfmsKXzpw==
X-Received: by 2002:a05:6214:1023:: with SMTP id k3mr6589610qvr.21.1611359130353;
        Fri, 22 Jan 2021 15:45:30 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id o187sm7459343qkd.70.2021.01.22.15.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 15:45:29 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 22 Jan 2021 18:45:28 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Jonathan Schwender <schwenderjonathan@gmail.com>
cc:     williams@redhat.com, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] cyclictest: Fix --affinity when intermediate CPUs are
 offline
In-Reply-To: <20210114115030.92296-1-schwenderjonathan@gmail.com>
Message-ID: <ad94b4bd-b7e-1b42-6de8-615477d5a1fa@redhat.com>
References: <20210114115030.92296-1-schwenderjonathan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 14 Jan 2021, Jonathan Schwender wrote:

> Use max_cpus = sysconf(_SC_NPROCESSORS_CONF) to determine the number of
> the maximum CPU (+1).
> The cpu_for_thread_*() functions check the first max_cpus bits
> in the cpuset / cpumask.
> This fixes failing to set the affinity to CPUs >= num_online_cpus,
> if some intermediate CPU is offline, e.g. on an AMD system
> with nosmt.
> 
> Signed-off-by: Jonathan Schwender <schwenderjonathan@gmail.com>
> ---
>  src/cyclictest/cyclictest.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index f38c453..b104e4c 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1741,7 +1741,8 @@ int main(int argc, char **argv)
>  	int signum = SIGALRM;
>  	int mode;
>  	int cpu;
> -	int max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
> +	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
> +	int online_cpus = sysconf(_SC_NPROCESSORS_ONLN);
>  	int i, ret = -1;
>  	int status;
>  
> @@ -1750,8 +1751,10 @@ int main(int argc, char **argv)
>  	if (check_privs())
>  		exit(EXIT_FAILURE);
>  
> -	if (verbose)
> +	if (verbose) {
>  		printf("Max CPUs = %d\n", max_cpus);
> +		printf("Online CPUs = %d\n", online_cpus);
> +	}
>  
>  	/* Restrict the main pid to the affinity specified by the user */
>  	if (affinity_mask != NULL) {
> -- 
> 2.29.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

Thanks
