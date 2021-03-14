Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646A7C433E0
	for <linux-rt-users@archiver.kernel.org>; Sun, 14 Mar 2021 22:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32F0A64E55
	for <linux-rt-users@archiver.kernel.org>; Sun, 14 Mar 2021 22:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhCNWpf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 14 Mar 2021 18:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhCNWpZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 14 Mar 2021 18:45:25 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE29C061574
        for <linux-rt-users@vger.kernel.org>; Sun, 14 Mar 2021 15:45:25 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id h7so1147227qtx.3
        for <linux-rt-users@vger.kernel.org>; Sun, 14 Mar 2021 15:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=PeMBGWLJPR4cN6jB+d6waYarRiiJoKUkRmtRzL9bcLI=;
        b=BqOe1FuR6g5DI4y7669pdwN3h0ZFI130cSkApfFUH4dZ9MCNH8fjwBRTSyLfSU++HT
         ReqQCLDqNArja11y6knq9tvnSR/G3hzAvp9aOk48NwR979RN6br+IFPynZIyveyWp5e8
         jUP5RJPrI/jD49vhVE+85Z2ZO5UdTfCqDsAR94bNeA6cZchMtUqE+KAjEoWuhfRjQDVw
         dxGVX2d//QWX5KGZjQR7qZYKA71R3OFa006jgRzAegcdRUZdYylZoR3aEYPoZHBirF+R
         j30yXJpxt9TsP6Qgmu2AkStuIKQFhWzBFW3hNN/MDQFXHUT2gwfwoxAMU8mAnMkxFN7z
         Xkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=PeMBGWLJPR4cN6jB+d6waYarRiiJoKUkRmtRzL9bcLI=;
        b=c1Wj6ptYAzXTztiF+ejpF6Bbbw2E7TTDo24+NLB/WRGPEG5dJlj6wMz/62BqVCdVTe
         wihzi3nNdp2T37yTuoxWzWYoU8OweEjAfdB+R5nZRJm4XDK3tH/UECykkOKAIQQY972u
         eiyCC9EkJ1MlekVb7VrCRS8uTgjsbfVLRDD4O5xDCGPH5jzRWEkwdumYIZLbt5F2rh7Y
         X/adO0UrddU76ocTd+1NBS7ynm3o6TzDhNj0OrIzdlapV0yOddkFvKztp9WyYM4FRgpl
         5cWn4tX9bRjrjQPS//0lZ3lGYDuvquowhED8iwmBpJs4zAKAtfHtiDFVQTW+/ydalcNO
         Be/Q==
X-Gm-Message-State: AOAM533YvEHNrrIZilsl1X/v6nN4wkeHk2ITyOkbdrsIrYzWsT6wovfq
        mSI+NhnG9U/XK5mP9dhVW/gHQRhAhO8=
X-Google-Smtp-Source: ABdhPJzmFMwu5vhjWxzZ/hbg25u493hWWYRJKlB1j8l5aY3kvTQ4JxmU0J6aOlrGYwDSSNNmfffnEQ==
X-Received: by 2002:ac8:bc7:: with SMTP id p7mr12450447qti.207.1615761924355;
        Sun, 14 Mar 2021 15:45:24 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id z8sm5424236qtn.12.2021.03.14.15.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 15:45:24 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Sun, 14 Mar 2021 18:45:16 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v2 01/14] cyclictest: Fix printf format
 specifier
In-Reply-To: <20210305073500.17926-2-dwagner@suse.de>
Message-ID: <1c4293d8-5c7f-e6e0-cd48-67b240c08d59@redhat.com>
References: <20210305073500.17926-1-dwagner@suse.de> <20210305073500.17926-2-dwagner@suse.de>
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
>  src/cyclictest/cyclictest.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 157047837259..c43dd7cbbd64 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -11,7 +11,6 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <stdint.h>
> -#include <inttypes.h>
>  #include <stdarg.h>
>  #include <unistd.h>
>  #include <fcntl.h>
> @@ -1751,15 +1750,15 @@ static void write_stats(FILE *f, void *data)
>  			if (s->hist_array[j] == 0)
>  				continue;
>  			fprintf(f, "%s", comma ? ",\n" : "\n");
> -			fprintf(f, "        \"%u\": %" PRIu64, j, s->hist_array[j]);
> +			fprintf(f, "        \"%u\": %ld", j, s->hist_array[j]);
>  			comma = 1;
>  		}
>  		if (comma)
>  			fprintf(f, "\n");
>  		fprintf(f, "      },\n");
> -		fprintf(f, "      \"cycles\": %" PRIu64 ",\n", s->cycles);
> -		fprintf(f, "      \"min\": %" PRIu64 ",\n", s->min);
> -		fprintf(f, "      \"max\": %" PRIu64 ",\n", s->max);
> +		fprintf(f, "      \"cycles\": %ld,\n", s->cycles);
> +		fprintf(f, "      \"min\": %ld,\n", s->min);
> +		fprintf(f, "      \"max\": %ld,\n", s->max);
>  		fprintf(f, "      \"avg\": %.2f,\n", s->avg/s->cycles);
>  		fprintf(f, "      \"cpu\": %d,\n", par[i]->cpu);
>  		fprintf(f, "      \"node\": %d\n", par[i]->node);
> -- 
> 2.30.1
> 
> 

This had already been added before

John
