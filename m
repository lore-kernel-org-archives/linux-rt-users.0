Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A676CC47080
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 May 2021 20:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C20A61164
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 May 2021 20:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhEUUWP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 May 2021 16:22:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23548 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231327AbhEUUVi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 May 2021 16:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621628414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q6Ok0xtCsXnkU7yz4GwhBkJ0V9IiKOAGafL0X0MwZBA=;
        b=VnsYLtWc+55ahnAvqDU1TuF0Bo+4WzbFSXu07b6+qg48KlCIodePh71B/igwnknoEaW7Fq
        +6fLAK8aXDPRMCNlPuw/C7uNoRgQgkBvCXQg+YK3+DlfC3ELyVof/eqpnqLN+dFBU3F+V7
        Hdky0Rzi59WZ4cOraWBQe7fpSDUZwsI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-7rnPlQ0OPdKX7cVQI5OgSA-1; Fri, 21 May 2021 16:20:12 -0400
X-MC-Unique: 7rnPlQ0OPdKX7cVQI5OgSA-1
Received: by mail-qt1-f197.google.com with SMTP id d13-20020a05622a05cdb02901c2cffd946bso16462926qtb.23
        for <linux-rt-users@vger.kernel.org>; Fri, 21 May 2021 13:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=q6Ok0xtCsXnkU7yz4GwhBkJ0V9IiKOAGafL0X0MwZBA=;
        b=muD4eJBf0pl3/RFHG8KlgVyYcZy0ee59Ds9DkJp3gY8KkHF9QctOupTs1jcFVbbeiI
         2C9Lg5HovWHFmYqcbKYQvQJRV2r94Poz5NGpZeoPxYbIGx2y2uMe9ic1VMQuPDBu+heT
         lVh45E2lnPsFM5gasWIcY4U7hCwKiUq8iqziUv6GgRHZP2vArhfrCH//q6B5mBnLdqI5
         N9/JJ7L5lCVDNAE2BdMPoGxrqQLGce+8c1rLdgMGywDI3U107kpynm4TceOM/Mhk7NzY
         OmPPGvfApvh5RFYnm5J4zd3gHKCKREnhwoTIdxyvIvciaJ48ph6oc23M2M1IT2oz9Myr
         b4Xg==
X-Gm-Message-State: AOAM531FIJZVYVUMeV1KwlH2IdzLeNoHYhz2vb4nf6ABBI3iHAyVuTLY
        G0Kk2zvMCCy2Hb3bMGhMl1jwGNQRXPFceUpCCthDfgVpll52csceKZDpLd1PzF/TOpn2iLK1hWi
        UcbjZOQqWy0tNyxQq5xrokP5fc1E=
X-Received: by 2002:ae9:e519:: with SMTP id w25mr10308725qkf.232.1621628411912;
        Fri, 21 May 2021 13:20:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMx5gqMdB1VXN0lklJMqcV9kq8h0rL2c+ANP40WstX7RIVfvtTZpxitftZtuiLiZ4aeJCGPg==
X-Received: by 2002:ae9:e519:: with SMTP id w25mr10308698qkf.232.1621628411718;
        Fri, 21 May 2021 13:20:11 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id j6sm5236666qti.4.2021.05.21.13.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 13:20:11 -0700 (PDT)
Date:   Fri, 21 May 2021 16:19:16 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Jonathan Schwender <schwenderjonathan@gmail.com>
cc:     williams@redhat.com, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v4 1/2] cyclictest: Move main pid setaffinity handling
 into a function
In-Reply-To: <20210518083712.8237-2-schwenderjonathan@gmail.com>
Message-ID: <755ca9b1-b3c3-806f-95e0-b12a87d9448d@redhat.com>
References: <20210518083712.8237-1-schwenderjonathan@gmail.com> <20210518083712.8237-2-schwenderjonathan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 18 May 2021, Jonathan Schwender wrote:

> Move error handling for setting the affinity of the main thread
> into a separate function.
> This prevents duplicating the code in the next commit,
> where the main thread pid can be restricted to one of
> two bitmasks depending on the passed parameters.
> 
> Signed-off-by: Jonathan Schwender <schwenderjonathan@gmail.com>
> ---
>  src/cyclictest/cyclictest.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 59dda19..3bab3b2 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1768,6 +1768,17 @@ static void write_stats(FILE *f, void *data)
>  	fprintf(f, "  }\n");
>  }
>  

How about set_thread_affinity() since you want to use the function
for the main thread plus other threads.

> +static void set_main_thread_affinity(struct bitmask *cpumask)
> +{
> +	int res;
> +
> +	errno = 0;
> +	res = numa_sched_setaffinity(getpid(), cpumask);
> +	if (res != 0)
> +		warn("Couldn't setaffinity in main thread: %s\n",
> +		     strerror(errno));
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	sigset_t sigset;
> @@ -1792,13 +1803,7 @@ int main(int argc, char **argv)
>  
>  	/* Restrict the main pid to the affinity specified by the user */
>  	if (affinity_mask != NULL) {
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
> 2.31.1
> 
> 

