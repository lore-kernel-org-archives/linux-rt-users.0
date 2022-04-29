Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C17C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Apr 2022 20:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354535AbiD2UYa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 29 Apr 2022 16:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239530AbiD2UY3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 29 Apr 2022 16:24:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E83A253A45
        for <linux-rt-users@vger.kernel.org>; Fri, 29 Apr 2022 13:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651263668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b8SQRh0SkgzzYlvxiWnAs44sLXkxpm1PPcm6S3c6EXQ=;
        b=aGqE5eVfU4YsHqNJVBfytBqZFZ3X1/xoF5BvTPJ+H9qaXLz36bygM0QPnBSguJm2Nwbg7L
        kNfTsmMClWvjhhoY1KjgAlOua5FGokkjPuS3xrDD68na6IJ9QoXcvrnElIyRZBcqfSVG+T
        QLKdzH+gx5CbgBtG8omapQddspLkiYI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-196-msDXAq1mM_OO7T3DLdRR6A-1; Fri, 29 Apr 2022 16:21:07 -0400
X-MC-Unique: msDXAq1mM_OO7T3DLdRR6A-1
Received: by mail-qk1-f198.google.com with SMTP id bs18-20020a05620a471200b0069f8c1c8b27so5942460qkb.8
        for <linux-rt-users@vger.kernel.org>; Fri, 29 Apr 2022 13:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=b8SQRh0SkgzzYlvxiWnAs44sLXkxpm1PPcm6S3c6EXQ=;
        b=eL5I4IAqyK6eP9DO26NTHAj2tW6QEwsKB5ZxOfkWp5P0mU1DUOBHG9eSMNGsU18zfI
         CV9gHu6lUKK/YrMeNsRELQo52mTSKPMMoDBn4azsQqVtRxYTK/GPn4gxG6VgLykNUKmf
         lHjvHIxzPMjdRLABGtksGolgZgEUcKbKyKN7evKxPx8bwbTCUB+7Q+WwtHiwczAI1e+h
         hlMRFYlbIoKrzrBiWPb/2avQ0PUck3bmhEh+Y8no5I9lvQibeQpP1qU0ifyTmm/5hZl7
         valV4wk7expIMPh+yeZBQshq/A8QOyxAowHCqvCDnX6TlQ0I15L3OAX74etLXq8sZk9B
         qgwQ==
X-Gm-Message-State: AOAM532wxfbEPA+J+9q0uoAlPrn2cuxpbQerb+Na9KFCRWMFUIojhY6x
        nDmjJkZ8zm3eFmCMd48TL3XfEPzSUWVCLwc0uBfuI/OuRpHySNDaixSLAYdkRBcyVmarkg7zlSX
        Tguqhn9xclvTyoO1zrqpSB5AWbjQ=
X-Received: by 2002:a05:622a:20d:b0:2f3:600e:ee6a with SMTP id b13-20020a05622a020d00b002f3600eee6amr1058545qtx.294.1651263666938;
        Fri, 29 Apr 2022 13:21:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjudpkBfdQLm395diGWdax1oM33sATpRP/mecKIUFhdrRj0ild38X/rszc6Zv9SMIwOhPVxA==
X-Received: by 2002:a05:622a:20d:b0:2f3:600e:ee6a with SMTP id b13-20020a05622a020d00b002f3600eee6amr1058532qtx.294.1651263666720;
        Fri, 29 Apr 2022 13:21:06 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-93.dsl.bell.ca. [184.147.143.93])
        by smtp.gmail.com with ESMTPSA id w15-20020a37620f000000b0069fc13ce249sm99929qkb.122.2022.04.29.13.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 13:21:06 -0700 (PDT)
Date:   Fri, 29 Apr 2022 16:21:04 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>
cc:     linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 2/3] rteval: kcompile: Fix offline node handling
In-Reply-To: <20220419161443.89674-3-vschneid@redhat.com>
Message-ID: <6ecdb475-953-081-c817-62d5e3647e8@redhat.com>
References: <20220419161443.89674-1-vschneid@redhat.com> <20220419161443.89674-3-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 19 Apr 2022, Valentin Schneider wrote:

> Having an empty NumaNode but with CPUs attached to it (IOW they are all
> offline) causes kcompile.py to raise the following exception:
> 
>   calc_jobs_per_cpu():
>       ratio = float(mem) / float(len(self.node))
>   ZeroDivisionError: float division by zero
> 
> Remove nodes that do have CPUs but none of which are online.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  rteval/modules/loads/kcompile.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
> index 367f8dc..ac99964 100644
> --- a/rteval/modules/loads/kcompile.py
> +++ b/rteval/modules/loads/kcompile.py
> @@ -211,7 +211,10 @@ class Kcompile(CommandLineLoad):
>  
>          # remove nodes with no cpus available for running
>          for node, cpus in self.cpus.items():
> -            if not cpus:
> +            # If the intersection between the node CPUs and the cpulist is empty
> +            # then either the cpulist exludes that node, or the CPUs allowed by
> +            # the cpulist are actually offline
> +            if not set(self.topology.nodes[node].cpus.cpulist) & set(cpus):
>                  self.nodes.remove(node)
>                  self._log(Log.DEBUG, "node %s has no available cpus, removing" % node)
>  
> -- 
> 2.27.0
> 
> 

Sorry, this isn't quite right.

The cpulist in kcompile is the list of cpus where the load modules will 
run. The user can specify it like this
--loads-cpulist=LIST

If the user does not specify a list (because they want it to run 
everywhere) then the cpulist is empty. Your patch was working for you 
because the cpulist was empty, but that has nothing to do with whether the 
cpu is online or not.

systopology will fetch a list of cpus and consider whether they are online 
or not. So, I think the solution is to delete the method in kcompile and 
just use the one in systopology.

Sending another mail with the patch.

Thanks

John Kacur

