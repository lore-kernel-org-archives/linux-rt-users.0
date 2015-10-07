From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 4/4] cyclictest: move redefine of CPUSET back to uclib
Date: Wed, 7 Oct 2015 12:28:30 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1510071228080.14006@riemann>
References: <1444122503-8112-1-git-send-email-haustad@cisco.com> <1444122503-8112-4-git-send-email-haustad@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: Henrik Austad <haustad@cisco.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33554 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbbJGK2e (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Oct 2015 06:28:34 -0400
Received: by wiclk2 with SMTP id lk2so206307956wic.0
        for <linux-rt-users@vger.kernel.org>; Wed, 07 Oct 2015 03:28:33 -0700 (PDT)
In-Reply-To: <1444122503-8112-4-git-send-email-haustad@cisco.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Tue, 6 Oct 2015, Henrik Austad wrote:

> This was mistakenly included in the #ifdef in 88af643971b9 (android:
> adjust target for android). Moved back into the correct #ifdef-entry.
> 
> Cc: Clark Williams <williams@redhat.com>
> Cc: John Kacur <jkacur@redhat.com>
> Signed-off-by: Henrik Austad <haustad@cisco.com>
> ---
>  src/cyclictest/cyclictest.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index b52cabd..87a2d7e 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -80,6 +80,11 @@ int sched_setaffinity (__pid_t __pid, size_t __cpusetsize,
>  	return -EINVAL;
>  }
>  
> +#undef CPU_SET
> +#undef CPU_ZERO
> +#define CPU_SET(cpu, cpusetp)
> +#define CPU_ZERO(cpusetp)
> +
>  #endif
>  
>  #ifdef NO_PTHREAD_SETAFFINITY
> @@ -89,11 +94,6 @@ static inline int pthread_setaffinity_np(pthread_t thread, size_t cpusetsize,
>      return sched_setaffinity(0, cpusetsize, cpuset);
>  }
>  
> -#undef CPU_SET
> -#undef CPU_ZERO
> -#define CPU_SET(cpu, cpusetp)
> -#define CPU_ZERO(cpusetp)
> -
>  #else
>  extern int clock_nanosleep(clockid_t __clock_id, int __flags,
>  			   __const struct timespec *__req,
> -- 
> 1.9.1
> 
> --

Signed-off-by: John Kacur <jkacur@redhat.com>
