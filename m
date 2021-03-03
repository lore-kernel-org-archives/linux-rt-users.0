Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBB5C433E9
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77ADF64DDA
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355271AbhCDAWA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344291AbhCDABp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 3 Mar 2021 19:01:45 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0618C0613DE
        for <linux-rt-users@vger.kernel.org>; Wed,  3 Mar 2021 15:29:40 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id x13so6724381qvj.7
        for <linux-rt-users@vger.kernel.org>; Wed, 03 Mar 2021 15:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=bXS0vMYo033fzJ2aCD4IMNCcu24hRsRoRxEuih/Roto=;
        b=iu1IYx39i9/Ewj5csc8qGiAVs1nXtM6G2pAXwaYxg56Smzow+7Aaikj9xB3yUzkdQZ
         LaajcpVmYs11EmJb0q0eVOQSyQJl9Y6m6qKhQnVDkH20Bi98024L0rMyOE9W3CgITgtC
         T1zrEfpzwWlzthKEBmsCx46pE1BrN70DJuIQLUtx8K4szreSPqzwF0m+Yz7umabsre+M
         omDq1+n80M4tXi7FohAySd28N/N8nzqOrU10hy+U6nAVIDIVHA91Lx9PoYDAgNIlw3ZX
         TSaDyjT5bcvP2+ddOUQap+mrRAjpUM5X11clUeZAyvSI/9AmSIQqJDYU1c4jueNeb2lr
         4d6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=bXS0vMYo033fzJ2aCD4IMNCcu24hRsRoRxEuih/Roto=;
        b=WnpUpWr4+UgjIqIovkrBTpzxFHKys5dtLmAObMiYSmmhYPzjKUZEEKDUDzfkrXc5Zg
         zEHhimMHT/Lyv1RLClM2IwUbM9WCWMrdCLIMsc3tWVoyXHGkq5b/TTEweK1IK0XL0Mx0
         oWiJUUU5At6vDax8zc/SnInei7FGu2DZszq9vcMTbaLN0L7BCt2WeeB0Vrk0/l8N9r9X
         ezN8E+WuibSNJJqQycID8zjFQehGKfzwpipNnSrTERKaYtp3vJ4XS+B5EyQL0z0lwWOL
         eOFmnLVQeRufwWRy5Ukyk3IGYINge5QhwgntdzEgIco1MTESwQc8nJPqAlVWrkWs/+SD
         rPQg==
X-Gm-Message-State: AOAM532ARkbL4rO/Qq+hkLUXtBgXOVMmnGull/bOZ4FrbXCyWIWmaUCg
        Ckph19x1x5KerwoRLplynTU=
X-Google-Smtp-Source: ABdhPJzxj5mfppDyMJVIcrOARKj1vhQZ+LC6Qoxh24LHPA5EAfVLpPpjlFFBx8FAFrLU8hNG5o6O4w==
X-Received: by 2002:a05:6214:a91:: with SMTP id ev17mr1666628qvb.59.1614814179825;
        Wed, 03 Mar 2021 15:29:39 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id b27sm7385226qkl.102.2021.03.03.15.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 15:29:39 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Wed, 3 Mar 2021 18:29:38 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v1 1/2] cyclictest: Fix printf format
 specifier
In-Reply-To: <20210219163340.6290-2-dwagner@suse.de>
Message-ID: <5aceca7a-8a79-6d30-e233-5868b17f638a@redhat.com>
References: <20210219163340.6290-1-dwagner@suse.de> <20210219163340.6290-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 19 Feb 2021, Daniel Wagner wrote:

> The fields are not uint64 just longs, update the printf format
> specifiers.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/cyclictest/cyclictest.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index c3d45f3ae31b..da502d426a8c 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1732,15 +1732,15 @@ static void write_stats(FILE *f, void *data)
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
> 2.30.0
> 
> 
    Also Reported-by: Signed-off-by: Christian Eggers <ceggers@arri.de>
    Signed-off-by: John Kacur <jkacur@redhat.com>

