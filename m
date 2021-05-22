Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A89C2B9F2
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 03:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33203613DF
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 03:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhEVDkq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 May 2021 23:40:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35668 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231290AbhEVDkp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 May 2021 23:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621654759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u5j/QDCf6XpWk+T7IjcT/0FFhP5YZYYXS2/VkUX7JYo=;
        b=IoYA3FHE7bdF5neKlxlYRw9J0dOqnXEdPy8qbIptnE/+S9Z29eeaHalVp7kUzmuH7tuPcx
        0ZkW+SapWXDaogcH3JDXnaP8lK8m2gNq0hHUavJdD/5MF/IMjgB1L0cR5B6OyprWVOUkSU
        OV4HB/kKgmg3rajlVGuiKnEqNrQvGDs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-agwOLv1DNGChhRUuDWuhWw-1; Fri, 21 May 2021 23:39:17 -0400
X-MC-Unique: agwOLv1DNGChhRUuDWuhWw-1
Received: by mail-qk1-f200.google.com with SMTP id a198-20020a3766cf0000b0290320e7711ebdso18715295qkc.22
        for <linux-rt-users@vger.kernel.org>; Fri, 21 May 2021 20:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=u5j/QDCf6XpWk+T7IjcT/0FFhP5YZYYXS2/VkUX7JYo=;
        b=IPGpnO1wzBS6Y2INpZMNwWZB9iWlYzajix8Pq+LQaeAdiMoA5iwniwtMVp14Cb/p8T
         SJqqa2s80O234VX+Wva7WqqjX9rqGgm/QPim6ezARKArRQvgB+FDXwctzzoKWfDsK0mn
         uGOVpbojkN1IXrcZfvZNBnSkEMhGNQSNQXgqVq9zNYdJYGxW9m0YeG2JX9E+GUGyVogY
         StlpWeKtwGaG8vkYP6e3pTyBbo9EEGTcApuGtM4V2uiWvmuBQj+VfxB5odhjUX4bg070
         aYms8Zvrhg3tFE4U1wHL7cxEqXiQUz8eyNp/0gFlWZtMqO/0oJfyW52z5lrezATzlKdz
         nnsA==
X-Gm-Message-State: AOAM533s6E6fNxLxCo0SU669hTnSTJwLSBQEn1Ftb3VlQdnZ4c0exXr0
        bsP0U3ice9rNEhAxtbLXfoQL7ziXEjIctgJrZNU5TpA28bs7b8gmyu6GE1j3suuLVPv2ttore9L
        hCtQv1i1RTrbu2EogL9S/Gqx6xWA=
X-Received: by 2002:a05:620a:f03:: with SMTP id v3mr17092626qkl.96.1621654756879;
        Fri, 21 May 2021 20:39:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyW07688IkZudbdnAfI52NRaTDo7dI3k6dlsYlOoR12yLJN65i5b3Xe8l3MgGzOwHKSNq0OZw==
X-Received: by 2002:a05:620a:f03:: with SMTP id v3mr17092613qkl.96.1621654756731;
        Fri, 21 May 2021 20:39:16 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id r72sm6234997qka.18.2021.05.21.20.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 20:39:16 -0700 (PDT)
Date:   Fri, 21 May 2021 23:39:15 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v1 14/23] oslat: Add --json to man page
In-Reply-To: <20210519170945.21941-15-dwagner@suse.de>
Message-ID: <6d34edb-fb4d-3853-6311-458afba13ad9@redhat.com>
References: <20210519170945.21941-1-dwagner@suse.de> <20210519170945.21941-15-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 19 May 2021, Daniel Wagner wrote:

> Add the newly introduced --json command line to the man page.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/oslat/oslat.8 | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/src/oslat/oslat.8 b/src/oslat/oslat.8
> index b481d8d82783..4b28abd24425 100644
> --- a/src/oslat/oslat.8
> +++ b/src/oslat/oslat.8
> @@ -5,8 +5,9 @@ oslat \- OS Latency Detector
>  .SH SYNOPSIS
>  .SY oslat
>  .RI "[ \-shvz ] [ \-b " bucket-size " ] [ \-B " bias " ] [ \-c " cpu-list " ] \
> -[ \-C " cpu-main-thread " ] [ \-f " rt-prio " ] [ \-m " workload-mem " ] \
> -[\-t " runtime " ] [ \-T " trace-threshold " ] [ \-w " workload " ]"
> +[ \-C " cpu-main-thread " ] [ \-f " rt-prio " ] [ \-\-json " filename " ] \
> +[ \-m " workload-mem " ] [\-t " runtime " ] [ \-T " trace-threshold " ] \
> +[ \-w " workload " ]"
>  .SH DESCRIPTION
>  .B oslat
>  is an open source userspace polling mode stress program to detect OS level
> @@ -30,6 +31,9 @@ Specify which CPU the main thread runs on.  Default is cpu0.
>  Using specific SCHED_FIFO priority (1-99).  Otherwise use the default
>  priority, normally it will be SCHED_OTHER.
>  .TP
> +.B \-\-json=FILENAME
> +Write final results into FILENAME, JSON formatted.
> +.TP
>  .B \-m, \-\-workload-mem=SIZE
>  Size of the memory to use for the workload (e.g., 4K, 1M).
>  Total memory usage will be this value multiplies 2*N,
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

