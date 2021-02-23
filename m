Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461A1C433DB
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Feb 2021 05:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0432064E3F
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Feb 2021 05:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhBWFNU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 23 Feb 2021 00:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhBWFNT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 Feb 2021 00:13:19 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29829C06174A
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 21:12:39 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id l19so2610838qvz.2
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 21:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=jJowrZBMR5o/BjZobPEJCMUkXnlm+MeJZzH2affwNz4=;
        b=Qb/Ox6sTbpF60c6WGx8A3YiJ6jKEiqmQcb1HJNb91Xr4Z8ImeqUhip9topsPEzR4t2
         p51Y6zQm/IbACr0NBEsvZeVfpUAiVlqXVKHN7uPlgDvSIeFJywu0wuvOMReE2nXiFVmG
         w3XRTX8JF3uj7dTfvOgSRI76reNrASrC+g6+7qASJgT8+x6Jpd4yCPE1qDQbE61Hwm8M
         gBxDiIxh/XS6RrUWB3imhcIfIShpcRix+cBq3jay8ykawfwGQ2IeIQH/E3t7NRoty0Z8
         BAbTuYzoBtEFqbhbA9nzHnS/dnEtJ1+tf8a69VzmLyWfk5vpGD+xDqDczCzIwCkIbhCh
         0NDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=jJowrZBMR5o/BjZobPEJCMUkXnlm+MeJZzH2affwNz4=;
        b=iUR6qe3olvf5vdwtoEQ3q+UQcRYJx8NYN7W60308gNWzu3qqFic34We+rtxxWFHRer
         IoyZhpwzB2Jg2Y7GKkY+k2+Q0+c30pbmaVy3YVuP3NlmMqlnmrdr0xNvHrFnYPWxr7FQ
         GMSrJEAJ0orb4X06wk3xE+5/Y5lPXxhwAGJSuizsB8OWvbR6Oy6sOWH7qdVhZbBexdzR
         4UfuOCyesjutb95PpWUPMWx58PO8Sv+qUChAb++Z1slusN1pGkj9YjhzUusr1dN8Ha8N
         j5fD9tQ6D6QF7tivR5V9kLlB8Q97l9pdOe9QFGaBPfr1jm/Y2TPYsxSA/w5xWcQh4Tex
         waAw==
X-Gm-Message-State: AOAM532qcmglzUN4Zt89V8oUpfyGp98OEHdBgWoAAdUrkhkgQs+jh7N1
        Q7wEgKxNXHh810plsrFFAN4=
X-Google-Smtp-Source: ABdhPJwsmfgWDDQ7YoeaNQ4SutqDg7Hnd/Hv/wPlH9z7+WQhwKdBwRaLPWJlLfkjgZi6A9fzVbkNbQ==
X-Received: by 2002:a05:6214:452:: with SMTP id cc18mr24235747qvb.26.1614057157494;
        Mon, 22 Feb 2021 21:12:37 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id d20sm6528015qkb.88.2021.02.22.21.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 21:12:37 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 23 Feb 2021 00:12:32 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Jonathan Schwender <schwenderjonathan@gmail.com>
cc:     williams@redhat.com, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 1/2] cyclictest: Move main pid setaffinity handling into
 a function
In-Reply-To: <20210222152833.8758-3-schwenderjonathan@gmail.com>
Message-ID: <df363168-378c-d2ff-2fb-477171bbd086@redhat.com>
References: <20210222152833.8758-1-schwenderjonathan@gmail.com> <20210222152833.8758-3-schwenderjonathan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 22 Feb 2021, Jonathan Schwender wrote:

> Move error handling for setting the affinity of the main pid
> into a separate function.
> This prevents duplicating the code in the next commit,
> where the main thread pid can be restricted to one of
> two bitmasks depending on the passed parameters.
> 
> Signed-off-by: Jonathan Schwender <schwenderjonathan@gmail.com>
> ---
>  src/cyclictest/cyclictest.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index c3d45f3..3cd592d 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1749,6 +1749,16 @@ static void write_stats(FILE *f, void *data)
>  	fprintf(f, "  }\n");
>  }
>  
> +static void set_main_thread_affinity(struct bitmask* cpumask) {
> +	int res;
> +
> +	errno = 0;
> +	res = numa_sched_setaffinity(getpid(), cpumask);
> +	if (res != 0)
> +		warn("Couldn't setaffinity in main thread: %s\n", strerror(errno));
> +}
> +
> +

Maybe this would be better in src/lib/rt-numa.c ?
Note your brace style is inconsistent with the rest of the suite.
We try to follow the linux kernel style, where it makes sense.

>  int main(int argc, char **argv)
>  {
>  	sigset_t sigset;
> @@ -1778,13 +1788,7 @@ int main(int argc, char **argv)
>  
>  	/* Restrict the main pid to the affinity specified by the user */
>  	if (affinity_mask) {
> -		int res;
> -
> -		errno = 0;
> -		res = numa_sched_setaffinity(getpid(), affinity_mask);
> -		if (res != 0)
> -			warn("Couldn't setaffinity in main thread: %s\n", strerror(errno));
> -
> +		set_main_thread_affinity(affinity_mask);
>  		if (verbose)
>  			printf("Using %u cpus.\n",
>  				numa_bitmask_weight(affinity_mask));
> -- 
> 2.29.2
> 
> 
