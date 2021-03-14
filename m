Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1025BC433E6
	for <linux-rt-users@archiver.kernel.org>; Sun, 14 Mar 2021 22:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0B0264E84
	for <linux-rt-users@archiver.kernel.org>; Sun, 14 Mar 2021 22:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhCNWqG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 14 Mar 2021 18:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhCNWpw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 14 Mar 2021 18:45:52 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF03C061574
        for <linux-rt-users@vger.kernel.org>; Sun, 14 Mar 2021 15:45:52 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id m186so13383461qke.12
        for <linux-rt-users@vger.kernel.org>; Sun, 14 Mar 2021 15:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=pExZomSvBxJVfYbx0vvot4AAiI4o/R9P9noaeWNfwEA=;
        b=FFsBaDOH1hGyVTG93wupWbMtrgBBwnspMcfrvDmSgh/fqiE3yUFcf5uDfnWShbwOx+
         QPc0Mdk4I9PinG8tGyybS6T/oG+ch/dg0I8yeokiIWYegpXS4/RQCmXmkLINOCMroPsv
         OCk9oiTuUNfEYwNAcRb0IIzmgpatP4SAamFD7S0WGmNpQU+P4aCaeKIbPpiPUQ9WhPom
         P8D8ScWdSdm381Jtjj0wdBQruo8bqPkBM3SCDBgPbwgHAkeNSNYo6rTSFBMuZ1LSyK0M
         ZeJfjsMdI86PMytTGGIZ9BTySLqC1KTFS/0O6huEQx5NU9wTrihUErXY5pj5mfi+lF1h
         5gNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=pExZomSvBxJVfYbx0vvot4AAiI4o/R9P9noaeWNfwEA=;
        b=lK3ofCM0ik0tQKnFD6xxewmZ1HMD+J6L7oiV+FjnWPvdc33nv9GmecQhHYHPkQ2cEn
         VBDIq+5AfmgQ5zapMlWfUwGzjSLvjDomAkiOzGTsOQ3XXb/KtZzxxzPTJPKuUpvTgWKr
         kz3wGPu5lssC9Q4h52LvoI3LVchrh8axDCCgO02kDDM2ZobeJgLZoTvKgOMyPP/DqPEZ
         ia9gKisznxbrFCS8rVjjaohgGILnpNWKJnwsYbqyoloXcerBgoJu5bHNE9lWfNV7mMML
         DLa/JqAjLjCKOcrTl6s8ghmfBKn0lXFKQt7McnQt86e+TMKb029mY2GJPYgEYrI8E7C4
         R7wg==
X-Gm-Message-State: AOAM530NhxAu5GOo/nCf5n9Mh5dh/TktJWvWrwhiUdoQRUl6dUVGi1kO
        +bLLBmKNgeGa/r84r7p3+mE=
X-Google-Smtp-Source: ABdhPJzBAPoGsdgy/UhrVsXWI2zV51fvWWYwJaWD3dCiNEuZ44Zoko96mU3oKv4ZOpO8baomc37ftQ==
X-Received: by 2002:a05:620a:53d:: with SMTP id h29mr22355398qkh.29.1615761951525;
        Sun, 14 Mar 2021 15:45:51 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id v7sm5780427qtw.51.2021.03.14.15.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 15:45:51 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Sun, 14 Mar 2021 18:45:50 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v2 02/14] cyclicdeadline.c: Fix printf format
 specifier
In-Reply-To: <20210305073500.17926-3-dwagner@suse.de>
Message-ID: <95637c30-bba4-25e4-f342-26871a8260@redhat.com>
References: <20210305073500.17926-1-dwagner@suse.de> <20210305073500.17926-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 5 Mar 2021, Daniel Wagner wrote:

> The fields are not uint64 just longs, update the printf format
> specifiers.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/sched_deadline/cyclicdeadline.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 33bac8cda898..d7aa9bb5d269 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -18,7 +18,6 @@
>  #include <errno.h>
>  #include <signal.h>
>  #include <getopt.h>
> -#include <inttypes.h>
>  
>  #include <sys/syscall.h>
>  #include <sys/types.h>
> @@ -976,9 +975,9 @@ static void write_stats(FILE *f, void *data)
>  	for (i = 0; i < nr_threads; i++) {
>  		s = &sd[i].stat;
>  		fprintf(f, "    \"%u\": {\n", i);
> -		fprintf(f, "	 \"cycles\": %" PRIu64 ",\n", s->cycles);
> -		fprintf(f, "	 \"min\": %" PRIu64 ",\n", s->min);
> -		fprintf(f, "	 \"max\": %" PRIu64 ",\n", s->max);
> +		fprintf(f, "	 \"cycles\": %ld,\n", s->cycles);
> +		fprintf(f, "	 \"min\": %ld,\n", s->min);
> +		fprintf(f, "	 \"max\": %ld\n", s->max);
>  		fprintf(f, "	 \"avg\": %.2f\n", s->avg/s->cycles);
>  		fprintf(f, "    }%s\n", i == nr_threads - 1 ? "" : ",");
>  	}
> -- 
> 2.30.1
> 
> 

This has also already been added before.

John
