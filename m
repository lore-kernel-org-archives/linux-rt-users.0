Return-Path: <SRS0=sIfm=UM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAC0C46477
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Jun 2019 15:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 393A720896
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Jun 2019 15:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qUykEepC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732905AbfFMPKd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:10:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52791 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732309AbfFMNvq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 Jun 2019 09:51:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so10319667wms.2
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Jun 2019 06:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=SQzvqBHOAeUj+ylwtiHKTAthTJEhDHuR0q2QtC7G0No=;
        b=qUykEepCMUJEYWk4vDRex9C+25eZVdDmpnztkWNOdoOtp1MHzrLLzDuPMGNrRl8/Ux
         jFzQCFBdeHl70ffNEZly2YWKqmp3EcotgHX19f75p+GJ3oD0hSGONIa6cxstC5bRoI2w
         y01qAqYED/W+eL7DjZa7ho9QeL2S5Xq2eooLwhmSw2radQqqCeECFwG/Nj3qN6uVOirb
         5tI6vR1VjcdsiDm7r/6q0NzYly1CsHDFHe3hZwdc9ekCw23VQVtH9Fs7VTY/OacbVGAK
         E3ZxNYXtgVNnUv7ziUpmyXERxoY6TOIPCw9xOFdcAKig+YWqvSLWqipzD+njKNqx3XRS
         irOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=SQzvqBHOAeUj+ylwtiHKTAthTJEhDHuR0q2QtC7G0No=;
        b=gCa2xdm2R88faLXexOMClxF8c+Y0mVdZJIK4ZdVFDFR5FuVUjo6PQca2E1bJ2lWV9+
         xZuyK0FdfDYF0nQUd1jqgrGtrxPbeiMFfY/tJyuMGbT9jbZefSBhB0JZQvUkjlaCt6J8
         JJ83x+emWzE3joTcE8LD0S2+kB4tuID0R7RcP0QpPwEb8+8xFqLUONZDA37B6uKVp2fu
         8fsp2/KdlQi1pcmjpn4ayc+Q9Gc3ZyootOrZB8zlKtA/qvFTtbcjRBCfSe9C7MJd7s5U
         Lyg88+uq8WkCvP/Ol4+PlFqMOS0Y40IM9/nNad5vZzLzTIH3Q0Ooy1EJNaZ9hIVCrqGN
         F9Sw==
X-Gm-Message-State: APjAAAVzWndDnA6kIAHodHSYG0rq8cgejEJt/yxnxWHfHUo/ZYuFSZ9b
        lmMx03vVbDi03ofKJhAiys2HWpdz9es=
X-Google-Smtp-Source: APXvYqzmx1gwhsZ8vJ/EtEE7h3Q1BCFQIjyy4T20iVW4geYFCCWOF/uYdBhUQxxSKSFAdBoMT0fp5w==
X-Received: by 2002:a7b:c144:: with SMTP id z4mr4122428wmi.50.1560433904250;
        Thu, 13 Jun 2019 06:51:44 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id l9sm3656418wrt.13.2019.06.13.06.51.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 06:51:43 -0700 (PDT)
Date:   Thu, 13 Jun 2019 15:51:37 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Daniel Wagner <wagi@monom.org>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 02/12] queuelat: Use clock syscall for ARM 32 bit
In-Reply-To: <20190605160617.22987-3-wagi@monom.org>
Message-ID: <alpine.LFD.2.21.1906131550540.8187@planxty>
References: <20190605160617.22987-1-wagi@monom.org> <20190605160617.22987-3-wagi@monom.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 5 Jun 2019, Daniel Wagner wrote:

> CPUs such as Cortex-M8 don't have a rdtsc instruction. Fallback using
> a syscall.
> 
> Signed-off-by: Daniel Wagner <wagi@monom.org>
> ---
>  src/queuelat/queuelat.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/src/queuelat/queuelat.c b/src/queuelat/queuelat.c
> index 3b291f168768..a5525e41776a 100644
> --- a/src/queuelat/queuelat.c
> +++ b/src/queuelat/queuelat.c
> @@ -7,6 +7,7 @@
>  #include <stdio.h>
>  #include <unistd.h>
>  #include <signal.h>
> +#include <time.h>
>  
>  #define NSEC_PER_SEC 1000000000
>  
> @@ -249,6 +250,8 @@ typedef unsigned long long cycles_t;
>  typedef unsigned long long usecs_t;
>  typedef unsigned long long u64;
>  
> +#if defined __x86_64__ || defined __i386__
> +
>  #ifdef __x86_64__
>  #define DECLARE_ARGS(val, low, high)    unsigned low, high
>  #define EAX_EDX_VAL(val, low, high)     ((low) | ((u64)(high) << 32))
> @@ -270,7 +273,25 @@ static inline unsigned long long __rdtscll(void)
>          return EAX_EDX_VAL(val, low, high);
>  }
>  
> -#define rdtscll(val) do { (val) = __rdtscll(); } while (0)
> +#define gettick(val) do { (val) = __rdtscll(); } while (0)
> +
> +#elif defined __arm__
> +
> +static inline unsigned long long __clock_gettime(void)
> +{
> +	struct timespec now;
> +	int ret;
> +
> +	ret = clock_gettime(CLOCK_MONOTONIC, &now);
> +	if (ret < 0)
> +		return 0;
> +
> +	return now.tv_nsec;
> +}
> +
> +#define gettick(val) do { (val) = __clock_gettime(); } while (0)
> +
> +#endif
>  
>  static void init_buckets(void)
>  {
> @@ -348,9 +369,9 @@ static void run_n(int n)
>  
>  	memmove(dest, src, n);
>  	for (i = 0; i < loops; i++) {
> -		rdtscll(b);
> +		gettick(b);
>  		memmove(dest, src, n);
> -		rdtscll(a);
> +		gettick(a);
>  		delta = (a - b) * cycles_to_ns;
>  		account(delta);
>  	}
> @@ -446,9 +467,9 @@ void main_loop(void)
>  		int ret;
>  		int nr_packets_fill;
>  
> -		rdtscll(b);
> +		gettick(b);
>  		memmove(dest, src, default_n);
> -		rdtscll(a);
> +		gettick(a);
>  		delta = (a - b) * cycles_to_ns;
>  		account(delta);
>  
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>
