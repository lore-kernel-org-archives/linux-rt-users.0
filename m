Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C26C001B0
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Aug 2023 18:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjHISuX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 14:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjHISuW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2023 14:50:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1263E51
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 11:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691606976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M3hwuZLsjMaO38wOrc+ida9dV7fTe7F70taOG49zzTM=;
        b=VpH/k/t5JA6pGqpmnyM7ZhVECRq1zonpR3HfCxUihpuiCmCn1YWxezrbCAGMkM90rJvQmK
        L/uLbia7jZ7jCGk2UivtAZTXgeD1oCQHNJoqsrLFBHcafIzLvdVQbtaIXu47ElV8f1LpQJ
        PexA+r/aXw5CSo7n1fYf0acJ/t8XycI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-wDsKdPBHPCqpl-jzRFBS6g-1; Wed, 09 Aug 2023 14:49:34 -0400
X-MC-Unique: wDsKdPBHPCqpl-jzRFBS6g-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-40ff512f8a8so448071cf.3
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Aug 2023 11:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691606974; x=1692211774;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M3hwuZLsjMaO38wOrc+ida9dV7fTe7F70taOG49zzTM=;
        b=gvaTmYe45J4HQTXygzqrqAikCiUY2gDThHOFjtzKNGz8eDtHRt1++4A4fCAA+5lPQS
         cUf5vy1l3znNT55BOk/RD1C9V+rDujfhDcpRNgVF8YsIYhoOjoqfap0Tyr/Ya0eaEuvo
         VXxc3OET8x/QT6NJn3YOmu3/BN3jo7d2ZdWrsg3zyjMEME9jOpc/I19Vm/m4wpkdUCj5
         lWUsdnCpKGz9V+pBWCCTinjB6TXk3PJB+t2QTWWv4IpXQ+ANOeD0hm/qI6sgISuNSjcN
         iRpUyjD16tW1lwwsTc/V0GkQ8TQZuFUcP59tUNVTzxs2uu6pN+uKM79dL30TASMUlKsY
         p9AA==
X-Gm-Message-State: AOJu0Yz7OIei07aoSVKEP4MgloNePV8jufp1y4PU/IOPHuBfZLtzP0Xs
        mZE+xBFhVs4TNsB4Eg5qiaXQl34rSfD8zeptzrr672V+3zrWRBHjv9fWlye+lYbbo3KPboBU32f
        CJOeku7Z7nXyFNXY5GjM2vH1QT9s=
X-Received: by 2002:ac8:5ac5:0:b0:40e:6f1:3d38 with SMTP id d5-20020ac85ac5000000b0040e06f13d38mr233761qtd.8.1691606974275;
        Wed, 09 Aug 2023 11:49:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzpoTg4lqsw5if4VaWq500G34reiyXBzIQuKd5GjSSqStpKeDhhWD0iICJfXLbUjgo1ZjAUA==
X-Received: by 2002:ac8:5ac5:0:b0:40e:6f1:3d38 with SMTP id d5-20020ac85ac5000000b0040e06f13d38mr233753qtd.8.1691606974052;
        Wed, 09 Aug 2023 11:49:34 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-157.dsl.bell.ca. [184.147.140.157])
        by smtp.gmail.com with ESMTPSA id g22-20020ac870d6000000b004054b435f8csm4180345qtp.65.2023.08.09.11.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 11:49:33 -0700 (PDT)
Date:   Wed, 9 Aug 2023 14:49:32 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Eder Zulian <ezulian@redhat.com>
cc:     linux-rt-users@vger.kernel.org, williams@redhat.com
Subject: Re: [PATCH] rt-tests: cyclictest: Suppress compiler warnings for
 unused variables
In-Reply-To: <20230808223904.290605-1-ezulian@redhat.com>
Message-ID: <cbbb28e6-4c55-e16d-7afa-d4c4f61bc4a@redhat.com>
References: <20230808223904.290605-1-ezulian@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 9 Aug 2023, Eder Zulian wrote:

> Using an attribute to inform the compiler that variables are expect to be unused so it will not issue a warning.
> 
> Signed-off-by: Eder Zulian <ezulian@redhat.com>
> ---
>  src/cyclictest/cyclictest.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 7b0f80f..86cec0e 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1610,11 +1610,13 @@ static void rstat_print_stat(struct thread_param *par, int index, int verbose, i
>  }
>  
>  
> +#define UNUSED __attribute__((__unused__))
> +
>  /*
>   * thread that creates a named fifo and hands out run stats when someone
>   * reads from the fifo.
>   */
> -static void *fifothread(void *param)
> +static void *fifothread(UNUSED void *param)
>  {
>  	int ret;
>  	int fd;
> @@ -1795,7 +1797,7 @@ rstat_err:
>  	return;
>  }
>  
> -static void write_stats(FILE *f, void *data)
> +static void write_stats(FILE *f, UNUSED void *data)
>  {
>  	struct thread_param **par = parameters;
>  	unsigned int i, j, comma;
> -- 
> 2.39.3
> 
> 

Just like in the kernel, we try to avoid preprocessor trickery,
so just put the attribute directly in the function header.

Watch the unwrapped lines in your commit messages.

John

