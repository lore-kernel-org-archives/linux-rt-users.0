Return-Path: <SRS0=vVbJ=US=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9443CC31E5B
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 Jun 2019 15:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CBB21881
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 Jun 2019 15:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuZEDy9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfFSPqn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:46:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33041 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfFSPqm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 Jun 2019 11:46:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id h19so4919468wme.0
        for <linux-rt-users@vger.kernel.org>; Wed, 19 Jun 2019 08:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=4FJSOvqEJs1cfYoDMtCIYDwc1f6ico/aQ9HCJmdNkXA=;
        b=EuZEDy9LpXeTQxAouJrqpvvOj7tXX3oVgvdeQ+JwAOqAO6xJxe2aFrZYMDKwW2uJc0
         W3v9Bk3StzVpxW05DO11lW8PJm14EtgZn82njGSSbG28UPnbdtkcOC7jPrKJd/PyO68X
         M7//SabQfyw3393LqHykj2x2A+76OtL7XtSOEfhTY9+RBzfwAsrXo5iAmdpwsSVymv3e
         08jKYrhdfTA6hG/fgFdV3f3aRDsdXoEjFROIXHhP1RRBc6ozKqlYcaLprYB5nizv3sr0
         w+b4UfIVEVv8rmlouIvnIG7MzSC4bZXgp+GjVGmXCnVliLM5f8w/A3RFygfrKrUSKVlj
         d/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=4FJSOvqEJs1cfYoDMtCIYDwc1f6ico/aQ9HCJmdNkXA=;
        b=bFqagB5SJr4yjJ2M5yCGKxs82vRtixmnH4Hf1ESCIdUZpxQXUSJeM94rx9nBclk0Wd
         V6x4mGgie0kYPFHSMCbf9TcKlbBCWPPIdxsq+JffcyGPpCPTV6udVZZ5tOaOk2IsH1I3
         +qMQSE/RGYALib9NL4L9cvbQ56wl9vHIr2HkUr0yK25AAXGkw6z5NZLLmdNxJDz/HTjY
         rV8bLuPzrBZfbxNmazdJD/o+5dI18Vb+CkFvXZdwdik7krjbm5csxkiToMuXb9/Yu/cC
         7QLG2RM0ptyVgLmT1mstlCJHpMibg7FJVb1aKcPl6ELoIOuER57Adjygy+WvZV9wKpDB
         Xdcw==
X-Gm-Message-State: APjAAAUJl9F3vdI4lp2poBcNCO8wLxg8rvPEiaZhgHo3naM4ZbDJAku0
        U7hN/n1aZHED9u5OuW7C5d0CIRGImjk=
X-Google-Smtp-Source: APXvYqyf+V4u71Gfa9OfNejvqPusgikIWgZdWuObfiwZyGQKcjuYXJrj0asHgQvEM7qJWuFEGizudQ==
X-Received: by 2002:a1c:9c0b:: with SMTP id f11mr4081389wme.2.1560959200531;
        Wed, 19 Jun 2019 08:46:40 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id j32sm11748996wrj.43.2019.06.19.08.46.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 08:46:39 -0700 (PDT)
Date:   Wed, 19 Jun 2019 17:46:37 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Kurt Kanzenbach <kurt@linutronix.de>
cc:     Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 2/6] rt-tests: cyclicdeadline: Remove unused getcpu
 code
In-Reply-To: <20190618103841.27249-3-kurt@linutronix.de>
Message-ID: <alpine.LFD.2.21.1906191746200.12022@planxty>
References: <20190618103841.27249-1-kurt@linutronix.de> <20190618103841.27249-3-kurt@linutronix.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 18 Jun 2019, Kurt Kanzenbach wrote:

> The getcpu() system call isn't used in the program. Therefore, it can be
> removed.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  src/sched_deadline/cyclicdeadline.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 754670c4e7d4..2b83665cab66 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -24,16 +24,6 @@
>  #include <rt-utils.h>
>  #include <rt-sched.h>
>  
> -#ifdef __i386__
> -#ifndef __NR_getcpu
> -#define __NR_getcpu			309
> -#endif
> -#else /* x86_64 */
> -#ifndef __NR_getcpu
> -#define __NR_getcpu			309
> -#endif
> -#endif /* i386 or x86_64 */
> -
>  #define _STR(x) #x
>  #define STR(x) _STR(x)
>  #ifndef MAXPATH
> @@ -44,7 +34,6 @@
>  #define CPUSET_LOCAL	"my_cpuset"
>  
>  #define gettid() syscall(__NR_gettid)
> -#define getcpu(cpup, nodep, unused) syscall(__NR_getcpu, cpup, nodep, unused)
>  
>  typedef unsigned long long u64;
>  typedef unsigned int u32;
> -- 
> 2.11.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
