Return-Path: <SRS0=vVbJ=US=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46965C31E5B
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 Jun 2019 15:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDD721881
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 Jun 2019 15:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNs1tbap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfFSPsN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:48:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55052 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbfFSPsN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 Jun 2019 11:48:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id g135so2358026wme.4
        for <linux-rt-users@vger.kernel.org>; Wed, 19 Jun 2019 08:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=hYA+E+wNEovjsPuVCl4cORiOyNs+aY39rxeSOO/+kms=;
        b=JNs1tbapE8H6nX5fDV0SZf3lu7GPm36r0EP1fbD8pDYqJHkWqfZStaG9+ND0C0ez36
         Pskzn3c9MHzbt1G3yGD6mx09qD25qDY+hKyA5cvvj8sapeZW1N101I8HKyVn4jdGtydk
         kAI46yokYughhAqzLQd6ESyd2RfS4MKemzpK+kwLexhKykpHsM3lCBHBa8zsmJLE7KEt
         JoY0NbdpkeHwwWhB+XcxUt4wuNW2wrag2jZD4hFovAYI+uxPRHvvaajDfWO5SHBU5DC6
         LpcxcrRuCxSyqI5Pvo4FBQk2XZ8Wg2lLGYI9lITVHbVKZdkFh2VBUuqsM84LpoCuvZ2c
         GU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=hYA+E+wNEovjsPuVCl4cORiOyNs+aY39rxeSOO/+kms=;
        b=bgc9TRfbXSFz0YID1Sb35mJn/Et+RuPJjJSagdhopG37J9GmUD496gph5aEPyGtuLX
         OWdNagu/4NSUHV2mKMPi2pEkK8xs1EVYdaKHhNeRWUmP1o39XETnukYsG4GKKh5YJn8g
         jIQOE7SvMVoujzYsjayQp4JRcfMO2wu3H/RJhefYGnBbZVxmj/jWYvfX1xRH9Tpxf08s
         vpBQqZ6Y8a4/Y48IZqODpsa/SLSg5q0jUl+q4SDCeA7AvlHaDIuuKb+aHWbh7/Fp3kNp
         GZfaTTtU3vYdq+ePBX8dVDRy79hkubbrrq2vyDEz3hjl6s9TjfIf0tbrbTKYZHOfOYso
         7CvA==
X-Gm-Message-State: APjAAAVuVZbra9IXqPuUpYm1y2l9noC93VwpXUP8Y+TqjXmma/JVKwxD
        xWhpgPHzoQCJkKamm1Uf3u0=
X-Google-Smtp-Source: APXvYqyAQtYelzNaNMkqSJLLzNlwsOCBw7t+j1zqZxcL5Av8m7+9Kghb5cYXul/tjkcRGft4kiaxHQ==
X-Received: by 2002:a1c:f712:: with SMTP id v18mr9666059wmh.143.1560959291337;
        Wed, 19 Jun 2019 08:48:11 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id v204sm2300407wma.20.2019.06.19.08.48.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 08:48:10 -0700 (PDT)
Date:   Wed, 19 Jun 2019 17:48:09 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Kurt Kanzenbach <kurt@linutronix.de>
cc:     Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 3/6] rt-tests: deadline: Remove duplicated gettid()
 code
In-Reply-To: <20190618103841.27249-4-kurt@linutronix.de>
Message-ID: <alpine.LFD.2.21.1906191747000.12022@planxty>
References: <20190618103841.27249-1-kurt@linutronix.de> <20190618103841.27249-4-kurt@linutronix.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 18 Jun 2019, Kurt Kanzenbach wrote:

> gettid() is already implemented in the library code. Use that code instead.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  src/sched_deadline/cyclicdeadline.c | 6 ++----
>  src/sched_deadline/deadline_test.c  | 6 ++----
>  2 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 2b83665cab66..17786db45612 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -33,8 +33,6 @@
>  #define CPUSET_ALL	"my_cpuset_all"
>  #define CPUSET_LOCAL	"my_cpuset"
>  
> -#define gettid() syscall(__NR_gettid)
> -
>  typedef unsigned long long u64;
>  typedef unsigned int u32;
>  typedef int s32;
> @@ -755,7 +753,7 @@ void *run_deadline(void *data)
>  	attr.sched_runtime = sd->runtime_us * 1000;
>  	attr.sched_deadline = sd->deadline_us * 1000;
>  
> -	printf("thread[%ld] runtime=%lldus deadline=%lldus\n",
> +	printf("thread[%d] runtime=%lldus deadline=%lldus\n",
>  	       gettid(), sd->runtime_us, sd->deadline_us);
>  
>  	pthread_barrier_wait(&barrier);
> @@ -1195,7 +1193,7 @@ int main (int argc, char **argv)
>  		system("cat /sys/fs/cgroup/cpuset/my_cpuset/tasks");
>  	}
>  
> -	printf("main thread %ld\n", gettid());
> +	printf("main thread %d\n", gettid());
>  
>  	pthread_barrier_wait(&barrier);
>  	printf("fail 2 %d\n", fail);
> diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
> index c3b9dceb5209..e2898de328bb 100644
> --- a/src/sched_deadline/deadline_test.c
> +++ b/src/sched_deadline/deadline_test.c
> @@ -51,6 +51,7 @@
>  #include <linux/unistd.h>
>  #include <linux/magic.h>
>  
> +#include <rt-utils.h>
>  #include <rt-sched.h>
>  
>  /**
> @@ -103,9 +104,6 @@ static void usage(char **argv)
>  #define CPUSET_ALL	"my_cpuset_all"
>  #define CPUSET_LOCAL	"my_cpuset"
>  
> -/* Define the system call interfaces */
> -#define gettid() syscall(__NR_gettid)
> -
>  typedef unsigned long long u64;
>  typedef unsigned int u32;
>  typedef int s32;
> @@ -1267,7 +1265,7 @@ void *run_deadline(void *data)
>  	attr.sched_runtime = sched_data->runtime_us * 1000;
>  	attr.sched_deadline = sched_data->deadline_us * 1000;
>  
> -	printf("thread[%ld] runtime=%lldus deadline=%lldus loops=%lld\n",
> +	printf("thread[%d] runtime=%lldus deadline=%lldus loops=%lld\n",
>  	       gettid(), sched_data->runtime_us,
>  	       sched_data->deadline_us, sched_data->loops_per_period);
>  
> -- 
> 2.11.0
> 
> 

If anyone objects because they are actively using systems that don't have 
gettid() in the library, please speak-up, for now this is in 
unstable/devel/latest-devel
 Signed-off-by: John Kacur <jkacur@redhat.com>
