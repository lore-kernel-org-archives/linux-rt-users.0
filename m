Return-Path: <SRS0=vVbJ=US=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A10DC31E5B
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 Jun 2019 15:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4559621897
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 Jun 2019 15:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tnlN+Nyd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfFSPqN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:46:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43546 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfFSPqM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 Jun 2019 11:46:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id p13so3905474wru.10
        for <linux-rt-users@vger.kernel.org>; Wed, 19 Jun 2019 08:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=XS7kZjJARUO3XuUusCIx5aMx3qne9z+lxxxuoBC5vDg=;
        b=tnlN+Nydi/eBSSWDJ1fhP5o9P4pqK+irkiNIp39tMPJoKERB9tKWN93pzXovmFbwJU
         xPyKfzvLigNrfyrNFmILB1trzGXuaYXlOLBDVRRQUR+6komKHe52ZHJbdwc/DA3mSowR
         k7R4qoF+ZYa0GGk3KxKJP/S6t+UOuhj3e3+L3YUrp/MaDvA5TPID0fEMe5SJYj2hA37A
         P7Rj4XRyj/JeJ2a4d6JPcsBeszw+MGZGprc4giEqCtyrkALpQSizZB6dKPz3xSf/LhRs
         2EkmqY0Y8fonxM4GBaQZEtmxsko/VpfzCIG/URm2/1pD4wiJnyYsgF4Lb+zzXyPlaMYI
         QSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=XS7kZjJARUO3XuUusCIx5aMx3qne9z+lxxxuoBC5vDg=;
        b=J5mSYurTRVlupT17BMCBlL4UTd9KEszIWlVzOpqMr7BVj95pDTxKkBpLVBgs8je/7p
         M8ku5d5U/a/Z2sqDiwnmCN5CdKgJL5iAekLPd+lne0705P+ZXtaUdiyCIV24Yt4tgPK1
         Uv6FurTW66mR1pl64vIHr9P8XXHTuUiht/KzvpyhwSBztDPq4zYcIozBuzKQ2HYtVfi7
         LKC71IG5zGvWeVu1iL3z78kSKPi9juCF13ewXtNWNXPvAqa5hSEC5uJz6yet8QBfbrbR
         0PebtAfmvQAAbUmB9pM+TiuiF92WRcbb2XMJw95kCj2fE2ba8/kqSiq6ODUC9/taCRrg
         hSUQ==
X-Gm-Message-State: APjAAAX6rftHAtl2UNPnO2iFTejsOBPzMYZiF6xFLYB2vRz6bkEnHLPA
        /1xHHPnia2ckwzicThLpvDc=
X-Google-Smtp-Source: APXvYqyCuyxpd0pq/8yMrpCO46RUFSXaVgSgBLSVgo6r2BAs9VnppDA9hJlPqIgtyUH/sSbmBPdVnQ==
X-Received: by 2002:adf:afd0:: with SMTP id y16mr88828610wrd.22.1560959170181;
        Wed, 19 Jun 2019 08:46:10 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id t1sm26255072wra.74.2019.06.19.08.46.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 08:46:09 -0700 (PDT)
Date:   Wed, 19 Jun 2019 17:46:01 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Kurt Kanzenbach <kurt@linutronix.de>
cc:     Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 1/6] rt-tests: deadline: Remove duplicated code for
 sched_{set,get}_attr
In-Reply-To: <20190618103841.27249-2-kurt@linutronix.de>
Message-ID: <alpine.LFD.2.21.1906191744060.12022@planxty>
References: <20190618103841.27249-1-kurt@linutronix.de> <20190618103841.27249-2-kurt@linutronix.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 18 Jun 2019, Kurt Kanzenbach wrote:

> The system calls for sched_get_attr() and sched_set_attr() are already
> implemented. Get rid of the code and use the existing libary.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  src/sched_deadline/cyclicdeadline.c | 36 +------------------
>  src/sched_deadline/deadline_test.c  | 72 ++-----------------------------------
>  2 files changed, 3 insertions(+), 105 deletions(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 47892daf747b..754670c4e7d4 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -22,31 +22,17 @@
>  #include <linux/magic.h>
>  
>  #include <rt-utils.h>
> +#include <rt-sched.h>
>  
>  #ifdef __i386__
> -#ifndef __NR_sched_setattr
> -#define __NR_sched_setattr		351
> -#endif
> -#ifndef __NR_sched_getattr
> -#define __NR_sched_getattr		352
> -#endif
>  #ifndef __NR_getcpu
>  #define __NR_getcpu			309
>  #endif
>  #else /* x86_64 */
> -#ifndef __NR_sched_setattr
> -#define __NR_sched_setattr		314
> -#endif
> -#ifndef __NR_sched_getattr
> -#define __NR_sched_getattr		315
> -#endif
>  #ifndef __NR_getcpu
>  #define __NR_getcpu			309
>  #endif
>  #endif /* i386 or x86_64 */
> -#ifndef SCHED_DEADLINE
> -#define SCHED_DEADLINE		6
> -#endif
>  
>  #define _STR(x) #x
>  #define STR(x) _STR(x)
> @@ -58,8 +44,6 @@
>  #define CPUSET_LOCAL	"my_cpuset"
>  
>  #define gettid() syscall(__NR_gettid)
> -#define sched_setattr(pid, attr, flags) syscall(__NR_sched_setattr, pid, attr, flags)
> -#define sched_getattr(pid, attr, size, flags) syscall(__NR_sched_getattr, pid, attr, size, flags)
>  #define getcpu(cpup, nodep, unused) syscall(__NR_getcpu, cpup, nodep, unused)
>  
>  typedef unsigned long long u64;
> @@ -115,24 +99,6 @@ struct sched_data {
>  	char buff[BUFSIZ+1];
>  };
>  
> -struct sched_attr {
> -	u32 size;
> -
> -	u32 sched_policy;
> -	u64 sched_flags;
> -
> -	/* SCHED_NORMAL, SCHED_BATCH */
> -	s32 sched_nice;
> -
> -	/* SCHED_FIFO, SCHED_RR */
> -	u32 sched_priority;
> -
> -	/* SCHED_DEADLINE */
> -	u64 sched_runtime;
> -	u64 sched_deadline;
> -	u64 sched_period;
> -};
> -
>  static int shutdown;
>  
>  static pthread_barrier_t barrier;
> diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
> index b01e3f27e00f..c3b9dceb5209 100644
> --- a/src/sched_deadline/deadline_test.c
> +++ b/src/sched_deadline/deadline_test.c
> @@ -51,6 +51,8 @@
>  #include <linux/unistd.h>
>  #include <linux/magic.h>
>  
> +#include <rt-sched.h>
> +
>  /**
>   * usage - show the usage of the program and exit.
>   * @argv: The program passed in args
> @@ -82,43 +84,6 @@ static void usage(char **argv)
>  	exit(-1);
>  }
>  
> -/*
> - * sched_setattr() and sched_getattr() are new system calls. We need to
> - * hardcode it here.
> - */
> -#if defined(__i386__)
> -
> -#ifndef __NR_sched_setattr
> -#define __NR_sched_setattr		351
> -#endif
> -#ifndef __NR_sched_getattr
> -#define __NR_sched_getattr		352
> -#endif
> -
> -#elif defined(__x86_64__)
> -
> -#ifndef __NR_sched_setattr
> -#define __NR_sched_setattr		314
> -#endif
> -#ifndef __NR_sched_getattr
> -#define __NR_sched_getattr		315
> -#endif
> -
> -#endif /* i386 or x86_64 */
> -
> -#if !defined(__NR_sched_setattr)
> -# error "Your arch does not support sched_setattr()"
> -#endif
> -
> -#if !defined(__NR_sched_getattr)
> -# error "Your arch does not support sched_getattr()"
> -#endif
> -
> -/* If not included in the headers, define sched deadline policy numbe */
> -#ifndef SCHED_DEADLINE
> -#define SCHED_DEADLINE		6
> -#endif
> -
>  #define _STR(x) #x
>  #define STR(x) _STR(x)
>  
> @@ -140,45 +105,12 @@ static void usage(char **argv)
>  
>  /* Define the system call interfaces */
>  #define gettid() syscall(__NR_gettid)
> -#define sched_setattr(pid, attr, flags) syscall(__NR_sched_setattr, pid, attr, flags)
> -#define sched_getattr(pid, attr, size, flags) syscall(__NR_sched_getattr, pid, attr, size, flags)
>  
>  typedef unsigned long long u64;
>  typedef unsigned int u32;
>  typedef int s32;
>  
>  /**
> - * struct sched_attr - get/set attr system call descriptor.
> - *
> - * This is the descriptor defined for setting SCHED_DEADLINE tasks.
> - * It will someday be in a header file.
> - *
> - * The fields specific for deadline:
> - *
> - *  @sched_policy: 6 is for deadline
> - *  @sched_runtime: The runtime in nanoseconds
> - *  @sched_deadline: The deadline in nanoseconds.
> - *  @sched_period: The period, if different than deadline (not used here)
> - */
> -struct sched_attr {
> -	u32 size;
> -
> -	u32 sched_policy;
> -	u64 sched_flags;
> -
> -	/* SCHED_NORMAL, SCHED_BATCH */
> -	s32 sched_nice;
> -
> -	/* SCHED_FIFO, SCHED_RR */
> -	u32 sched_priority;
> -
> -	/* SCHED_DEADLINE */
> -	u64 sched_runtime;
> -	u64 sched_deadline;
> -	u64 sched_period;
> -};
> -
> -/**
>   * struct sched_data - the descriptor for the threads.
>   *
>   * This is the descriptor that will be passed as the thread data.
> -- 
> 2.11.0
> 

Signed-off-by: John Kacur <jkacur@redhat.com>
