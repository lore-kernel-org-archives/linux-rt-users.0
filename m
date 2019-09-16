Return-Path: <SRS0=2ve0=XL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0299CC4CECD
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Sep 2019 21:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4C8206C2
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Sep 2019 21:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJfPZvXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732139AbfIPV5l (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:57:41 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41540 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfIPV5l (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 Sep 2019 17:57:41 -0400
Received: by mail-qt1-f193.google.com with SMTP id x4so1793880qtq.8;
        Mon, 16 Sep 2019 14:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Ccc5Jr2QV+dOoQlnYyIyk/hz3hUrFlu+neqQ9MdiY6A=;
        b=SJfPZvXRHOyHLug4T5pKOWWNG8GmP4VZJqNOBzyjt6SnKx6azbNhYvA8F7G52Gvs0m
         Bhe4965m76h9pCmdiu6U8aaHPUGSrbeRqK+xiXgwKWxo7qFHZdWCT88dWKn9rWLMxAUJ
         F5y4vFaj1ivW4aisdEp2sSJw2Msn2z4hbNh4Rp3U/iXFrM2rz9X+DCh9+Q80tlQWU1jB
         C0mgyB8CfsWHaajpyARVJVI9hDR8/KnftG2DEP5wj5hx4WLKtNpUQR0+Qxje7bitXZVi
         3wQqsDFHnYaF7LkLo2B7N9XPx1NOWh1PduM7EHl5rYNPRn9Ne0zb8UvVIGHBB2IGfPmo
         IMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=Ccc5Jr2QV+dOoQlnYyIyk/hz3hUrFlu+neqQ9MdiY6A=;
        b=ruqohVR2Ww7QT5HAfj+Hr9cztl0gNNhI1Avy3PI47R3KjZz8L4SWpwwjnbY4AcwfPb
         4C1IfadguywXyP9vcAIrxImsXTQynGRzl48h88eO1AHsh3LXoxsQOgqTrvMhmRJVE11w
         U+CSqw2OlfZiZIw334ydsM5uVBQj6x0eYzyZwSsi/7YzlkoP5UednpQFMMvQzToCwuxv
         Pnp0iXWg9sMe92fQQGZapn90LTO/8jZYOzXdjWcn4ox6DOV7ZiJ/JW/WWYk8168KM0rZ
         2GLDvlSRp/I1lcpzsIXKfOrkYgfX7ON3Ch+GkoqdOUXUrfxQDxXirnhHj7Nc8k4+rAXT
         HMnw==
X-Gm-Message-State: APjAAAX/Us2mgU7ARIWhee9dCAXcRnhwjNJrPq0x+ctOD3skZV/p2qL7
        oTx46NRbYSIMROxz6eG0XxK1fWhoIQU=
X-Google-Smtp-Source: APXvYqzK+H8rGcqTB+tAD4Ns84Z2t8gAXWILWjdB+3inuJaScvpYOUyF612wHtmv7+rzERXHxHyg6g==
X-Received: by 2002:ac8:73c7:: with SMTP id v7mr668647qtp.106.1568671060313;
        Mon, 16 Sep 2019 14:57:40 -0700 (PDT)
Received: from planxty (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id v7sm145239qte.29.2019.09.16.14.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 14:57:39 -0700 (PDT)
Date:   Mon, 16 Sep 2019 23:57:32 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Sultan Alsawaf <sultan@kerneltoast.com>
cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        sebastian@breakpoint.cc, tglx@linutronix.de, rostedt@goodmis.org
Subject: Re: [PATCH] rt-tests: backfire: Don't include asm/uaccess.h
 directly
In-Reply-To: <20190903191321.6762-1-sultan@kerneltoast.com>
Message-ID: <alpine.LFD.2.21.1909162356500.10273@planxty>
References: <20190903191321.6762-1-sultan@kerneltoast.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 3 Sep 2019, Sultan Alsawaf wrote:

> From: Sultan Alsawaf <sultan@kerneltoast.com>
> 
> Architecture-specific uaccess.h headers can have dependencies on
> linux/uaccess.h (i.e., VERIFY_WRITE), so it cannot be included directly.
> Since linux/uaccess.h includes asm/uaccess.h, just do that instead.
> 
> This fixes compile errors with certain kernels and architectures.
> 
> Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
> ---
>  src/backfire/backfire.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/backfire/backfire.c b/src/backfire/backfire.c
> index aaf9c4a..a8ac9f5 100644
> --- a/src/backfire/backfire.c
> +++ b/src/backfire/backfire.c
> @@ -30,8 +30,8 @@
>  #include <linux/miscdevice.h>
>  #include <linux/proc_fs.h>
>  #include <linux/spinlock.h>
> +#include <linux/uaccess.h>
>  
> -#include <asm/uaccess.h>
>  #include <asm/system.h>
>  
>  #define BACKFIRE_MINOR MISC_DYNAMIC_MINOR
> -- 
> 2.23.0
> 
> 

Signed-off-by: John Kacur <jkacur@redhat.com>
But please in the future
1. Don't cc lkml on this
2. Include the maintainers in your patch

Thanks
