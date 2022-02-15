Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D30C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 15 Feb 2022 22:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244473AbiBOWJu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 15 Feb 2022 17:09:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243913AbiBOWJt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 15 Feb 2022 17:09:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C67CA23BC2
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Feb 2022 14:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644962977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/PkCAoJgwjjo9coJKGNG+/flo4nJvjnLfPvrTfannGk=;
        b=KRzZKbNYSpTsxK5iIy2y+FlmpOnXVV1lUl72ObvAwE/ri6wPj7UShnQyMjQn7mKlN16mtd
        r3R6kTp9N9Gq2I0FWSzTD4knSPCpMflVxqbvzF+H1XZspXhZ0vM2tOefR+BHy2Ba8wrDfb
        hT0qyXfsZicdMMfHtH1Klk7J+L7lNjQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-T53Q6YOuNzO7v6-gaN8Tig-1; Tue, 15 Feb 2022 17:09:36 -0500
X-MC-Unique: T53Q6YOuNzO7v6-gaN8Tig-1
Received: by mail-qt1-f200.google.com with SMTP id br10-20020a05622a1e0a00b002d37e07e79aso161402qtb.4
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Feb 2022 14:09:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=/PkCAoJgwjjo9coJKGNG+/flo4nJvjnLfPvrTfannGk=;
        b=DifuTqgahXZfYTNrDbfJDWXUPvgcLb7z4nDO1OJFF8LO7qqWqB96Ins+qLoS/IpzMh
         9zJGYKezZW6RRyfEngiaUUsajyuLU8WRC9ESFVQNHhhZSNvTPOX6kY52zzRnYCL65qFO
         v3UEHXamPEiB4M0Objqs5UjJ9g2Ph5iL71Cq9mF2poXpr2CIwScwNYnLV4la2I76KiLa
         6Qyq7kOKkAR3UP1u/xqB2xrGbNf/acSY8DGyNSFNtSGed7wqzI3ibwFmKsmLenSm/Qtf
         sV9aKO/D/Jt8Mfce0fF2pR4CztLB5O29XYZqaFx41Vzdus/82qXB+7pN5Hs5dtItq3e3
         qwDw==
X-Gm-Message-State: AOAM531Y15hOFsMOrPddMnt4FTRQp9iOfLfH55+f8MOAmkbiTxpTdJDQ
        dBl6dDhRC+nAcCXbO6dmryNviCiKtrCS4iPQPSPzRSUxl11NWjgn54Hcw/UTiISVJExGyP78dug
        627CgRObutxP/N5ay59oTtKCuNOw=
X-Received: by 2002:ad4:40ce:0:b0:42c:f251:778d with SMTP id x14-20020ad440ce000000b0042cf251778dmr35473qvp.71.1644962976037;
        Tue, 15 Feb 2022 14:09:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwOo9ehzngsFWmKOcQ4NqVgbnWJrHDmCoHEt34eNYrcW4Jk9X36rGKPlLCO5ZtnIoUZaS24Vg==
X-Received: by 2002:ad4:40ce:0:b0:42c:f251:778d with SMTP id x14-20020ad440ce000000b0042cf251778dmr35466qvp.71.1644962975869;
        Tue, 15 Feb 2022 14:09:35 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-127.dsl.bell.ca. [174.88.121.127])
        by smtp.gmail.com with ESMTPSA id s14sm18534709qkp.79.2022.02.15.14.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 14:09:35 -0800 (PST)
Date:   Tue, 15 Feb 2022 17:09:34 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Liwei Song <liwei.song@windriver.com>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests] rt-migrate-test: increase the buf size to 2048
 when parse cpuinfo
In-Reply-To: <20220214095441.23390-1-liwei.song@windriver.com>
Message-ID: <cc493264-f98d-d390-5b49-5c5b9b7793@redhat.com>
References: <20220214095441.23390-1-liwei.song@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 14 Feb 2022, Liwei Song wrote:

> When parse /proc/cpuinfo, the size of "flags" may exceed 1024,
> this will cause "realloc(): invalid next size" error, increase
> the buf size to 2048 to fix this case.
> 
> Signed-off-by: Liwei Song <liwei.song@windriver.com>
> ---
>  src/rt-migrate-test/rt-migrate-test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
> index 62cc603c983b..883e60e21bff 100644
> --- a/src/rt-migrate-test/rt-migrate-test.c
> +++ b/src/rt-migrate-test/rt-migrate-test.c
> @@ -497,14 +497,14 @@ static void stop_log(int sig)
>  static int count_cpus(void)
>  {
>  	FILE *fp;
> -	char buf[1024];
> +	char buf[2048];
>  	int cpus = 0;
>  	char *pbuf;
>  	size_t *pn;
>  	size_t n;
>  	int r;
>  
> -	n = 1024;
> +	n = 2048;
>  	pn = &n;
>  	pbuf = buf;
>  
> -- 
> 2.17.1

Signed-off-by: John Kacur <jkacur@redhat.com>

