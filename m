Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8787C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Sep 2021 15:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC08E60F36
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Sep 2021 15:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbhINPjH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 Sep 2021 11:39:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35752 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232656AbhINPjH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Sep 2021 11:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631633869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kEwNNaVZK0asgScZJ8TwVVyP9JiuU8iwMBlOqjwr5d0=;
        b=KUFt80pohzZmXbB5yCqQa+2uId2BcK6Wmv7qAt+cq4Fh+TarnepGyl962cpQilgSRVTg+P
        lnlMNNrVD3U+WCyv7I97Ehqjr5VSNJ0RNJRc9lD3tXMg77f0y1Kh1QFreLREjbwWUKT0gO
        vicsQJxv66xmf/lx7EmkUK3VY49QPWM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-tl7OLN_OPYShpPWPa9qVnA-1; Tue, 14 Sep 2021 11:37:48 -0400
X-MC-Unique: tl7OLN_OPYShpPWPa9qVnA-1
Received: by mail-qk1-f197.google.com with SMTP id k9-20020a05620a138900b003d59b580010so46836024qki.18
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2021 08:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=kEwNNaVZK0asgScZJ8TwVVyP9JiuU8iwMBlOqjwr5d0=;
        b=Wt6c98yV2M9m5KMk2JfylwiM+zkPlna3MTtiJ3/Tw5ngo7B1CTSPOO++YJco55RSo7
         PZv1JeD7Q6oaScKcIV9O4SLOzcXXAWP+QVHygrDPpzYZSIAMkpAEx1XY3kIqdlIEmmEF
         Hvg9juXgLZwk6oZEeJYhwncK/rRwdM5mHGXbbjMSL+f42BlHpNwyle5gLbAxuSy3QiQs
         98mbxzqLExOSANBEV/175OXhM11XQM5IUpiQgZFKYvmpVTJtYIill0EWcJbQXffmxVbA
         TItvmKtc0MT/Up7L2eKF+qUT9GVYWueL3tuVMHi0vr334ZZnGfI6zulTk2bE9UatGWLY
         wsag==
X-Gm-Message-State: AOAM531AX8qSwNCu/7FujrP3gnNMzwkwG6CXlhSfFxolDoNpVXZn9yQC
        lgG4DLLrdxYH9eVuQ56iaIFO85RsbOoTBMdMj1kWs5gB458Q6l9lf8vLLPLM1uk2G0e6uxizELw
        QPPFbcK66alDQHbk0xA55tqXo1YA=
X-Received: by 2002:a05:620a:1354:: with SMTP id c20mr5521156qkl.335.1631633867697;
        Tue, 14 Sep 2021 08:37:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjn2b1sisw8oFTtIUcd5Xjj2iJi9ceTG7aNUgSfVrOqrWDCRVol9opPNAMQFRBa5dXM4kthg==
X-Received: by 2002:a05:620a:1354:: with SMTP id c20mr5521135qkl.335.1631633867521;
        Tue, 14 Sep 2021 08:37:47 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id n5sm6263455qtp.35.2021.09.14.08.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 08:37:46 -0700 (PDT)
Date:   Tue, 14 Sep 2021 11:37:45 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     lleshchi@redhat.com
cc:     williams@redhat.com, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rt-tests: Add missing option F to optstring
In-Reply-To: <20210913192951.650464-1-lleshchi@redhat.com>
Message-ID: <454ee891-e650-35c4-323c-adcc2ddc692e@redhat.com>
References: <20210913192951.650464-1-lleshchi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 13 Sep 2021, lleshchi@redhat.com wrote:

> From: Leah Leshchinsky <lleshchi@redhat.com>
> 
> The cyclictest help output lists -F as the short version of the
> --fifo option, yet calling cyclictest -F produces an error"
> cyclictest: invalid option --'F'".
> This patch adds -F as a valid argument.
> 
> Signed-off-by: Leah Leshchinsky <lleshchi@redhat.com>
> ---
>  src/cyclictest/cyclictest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index a08c91d..f8f7dbc 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1011,7 +1011,7 @@ static void process_options(int argc, char *argv[], int max_cpus)
>  			{"posix_timers",     no_argument,	NULL, OPT_POSIX_TIMERS },
>  			{NULL, 0, NULL, 0 },
>  		};
> -		int c = getopt_long(argc, argv, "a::A::b:c:d:D:h:H:i:l:MNo:p:mqrRsSt::uvD:x",
> +		int c = getopt_long(argc, argv, "a::A::b:c:d:D:F:h:H:i:l:MNo:p:mqrRsSt::uvD:x",
>  				    long_options, &option_index);
>  		if (c == -1)
>  			break;
> -- 
> 2.27.0
> 
> 

Thanks
Signed-off-by: John Kacur <jkacur@redhat.com>

