Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFDBC07E99
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 18:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACCE6613C2
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 18:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhGISmm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Jul 2021 14:42:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32767 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229459AbhGISmm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Jul 2021 14:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625855998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SOol4aPFpZDVt62rBAFr2XzsSz4CpalVIifsJc2kf1g=;
        b=fu0oQdt5uITuatUQiWPYEwcb/NkBHyi4evO1pX3aVkCiZiA/9ORICNnsJg57f4i89psxP+
        gkS9QsKWu1p6zPdYWYijBhx6g1PetZJ8d3HwRnajwhDfBoFmizjEuDbbd+zH8b8v+R2xYn
        dLGvqEujo8Ucd34vWejvZMPVAq5jdeQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-DfjbLVlWPxGMnO9nhZcqug-1; Fri, 09 Jul 2021 14:39:56 -0400
X-MC-Unique: DfjbLVlWPxGMnO9nhZcqug-1
Received: by mail-qt1-f197.google.com with SMTP id y14-20020ac85f4e0000b0290250b0317184so6286597qta.21
        for <linux-rt-users@vger.kernel.org>; Fri, 09 Jul 2021 11:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SOol4aPFpZDVt62rBAFr2XzsSz4CpalVIifsJc2kf1g=;
        b=m44tt58+fSL6FVbrHA6PQxvgFoZdcJWo08l4CtthudC2sbGemygnvZ//s2wBmL2V63
         oynKnec70k+aGUkIU4QMMZSnWnNcDS/uapnZPP9MCDWcV0AKbhPihzerOeXEPHtXjG++
         yphLhYkLHoF6tKC//77oAOvud51JAs1fec4mL91T2n77QJ5haipzQaM/IxRX2inD8SbL
         YRUqerdbT2NLTQ2WgVnnns4Ln7fvi0vyI9CXYmyqATNVdh6W8c0LNQ8MQLmn5Oln8776
         f2970tsIAMyJ8clrS8JnFmj46/z9D9LKCk6IdEZfQNIu6kjEciROm5iTJ4/tjfzVmeu6
         ir+A==
X-Gm-Message-State: AOAM531AZLZhFimciXd1Lwg4MYrIIL+1HfVL7WTYnXb8rKzDPhmtEncT
        8JLh3uCUMZn6o915hGKgAvh9J6Jf9XDNJXdzw9RjJh4zKKWf8XSMoHVpmCOkX2xE8jQjuK6qLFF
        qPlLFXsiA09Bb7mFbFuUI5GC20Yk=
X-Received: by 2002:a05:622a:554:: with SMTP id m20mr6414409qtx.179.1625855996474;
        Fri, 09 Jul 2021 11:39:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4q8/CR8WNBnqGfoksFATIRB+ZlCk/+lRRsn/UER/+z6zUTYOsILa4gl/DNiEIUVdCWCVAkA==
X-Received: by 2002:a05:622a:554:: with SMTP id m20mr6414399qtx.179.1625855996288;
        Fri, 09 Jul 2021 11:39:56 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id 5sm2478605qtb.22.2021.07.09.11.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 11:39:55 -0700 (PDT)
Date:   Fri, 9 Jul 2021 14:39:54 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com,
        jkacur@redhat.com
Subject: Re: [PATCH 2/2] oslat: Add trace maker prior starting main thread
Message-ID: <YOiX+lp/PQL136TZ@t490s>
References: <20210709155414.610308-1-nsaenzju@redhat.com>
 <20210709155414.610308-2-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210709155414.610308-2-nsaenzju@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Jul 09, 2021 at 05:54:14PM +0200, Nicolas Saenz Julienne wrote:
> After a long tracing session it's sometimes hard to find the moment
> oslat started. So leave a message in the trace buffer just before the
> main thread starts.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> ---
>  src/oslat/oslat.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index d35be57..20bf02b 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -400,6 +400,10 @@ static void *thread_main(void *arg)
>  	while (g.n_threads_running != g.n_threads)
>  		relax();
>  
> +	if (!g.preheat)
> +		tracemark(false, "%s: Starting thread on CPU %d.\n",
> +			  g.app_name, t->core_i);
> +
>  	frc(&t->frc_start);
>  	doit(t);
>  	frc(&t->frc_stop);
> -- 
> 2.31.1
> 

Not sure how it would help.. but no objection either. :)

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

