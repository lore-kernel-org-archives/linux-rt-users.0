Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974F5C001DE
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 Jul 2023 14:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbjGYOeG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 25 Jul 2023 10:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjGYOeA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 25 Jul 2023 10:34:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F117E7B
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Jul 2023 07:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690295540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cx3Me1wV4utawgAc6iv9wDJemXbiFvsleuDBbp1JlFU=;
        b=Y7CZpOplzxpQHJHcYiIW+NUffsC52krxtVEdE/ESHlXbomnGDb5l0a+KvS8NWDLCozFxvG
        rPz6RkawI0c5PCF8P3aNYcKMG8BkRpiyl4x9r1bF10iFPp+RdUqEaxVObqeXURemib0bb9
        ueBFIWW5RWTc5jRODZQZElbgFLy/sTA=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-zba1-oUVNiC6FqkkB-U9kQ-1; Tue, 25 Jul 2023 10:32:18 -0400
X-MC-Unique: zba1-oUVNiC6FqkkB-U9kQ-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a5ad6088f8so4588069b6e.0
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Jul 2023 07:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690295538; x=1690900338;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cx3Me1wV4utawgAc6iv9wDJemXbiFvsleuDBbp1JlFU=;
        b=bOsRV/kF7pdkVhR3hN4uk1us5C3tzVDhy4hhxAookQDFJzn8LZxrV60lVwu6xB0nZA
         N96GZtBTFRe2FFZcQQ1NgbIS1nESn3r2mN4wARaPpP9fSK66Xvj0TAk1lV9DWtIMhP1Q
         XreUy+dFjBKUjxl629kVLh63xHYTDJLHGKC8fpwG9j5A04oYLD+sU/HgZyx1dji13g13
         K77FVQtwJ9WejT6uz4gFtpvI2yJwlujIKDNz9SSPYVbXkJJBWjl28fd9XrZm9fKOqrlJ
         u9WQwfs2B5ImHK/kPRAS5hYtsO8kSMCc9VxT4LgrbXk/N8CRmG4J2v24Lw9b7/V1nvDs
         KCSQ==
X-Gm-Message-State: ABy/qLawgtzCOLTo9aTOjG2rDQis2SAj1RznRzbtqzpv2lMK4UYX5N+k
        lfSsik/Vgvy/RWBxBfLa5k5KVQ8gbAcao/N45A4Q80oEP8rHyL/NMzT050Geo3gHYoUyQnxx8Qx
        oEpyUwKWXaNf71ELiHCqiw1QYltY=
X-Received: by 2002:a05:6808:3db:b0:3a1:f2fc:7e13 with SMTP id o27-20020a05680803db00b003a1f2fc7e13mr12424006oie.57.1690295538069;
        Tue, 25 Jul 2023 07:32:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFImyMwYBbRurnphG8lJIpZ+Xn+MRfs0Ql7/V9TLp4q7flHv9RgyeijPWwKKRMSkt8VOVl6tA==
X-Received: by 2002:a05:6808:3db:b0:3a1:f2fc:7e13 with SMTP id o27-20020a05680803db00b003a1f2fc7e13mr12423990oie.57.1690295537839;
        Tue, 25 Jul 2023 07:32:17 -0700 (PDT)
Received: from fionn ([184.147.142.236])
        by smtp.gmail.com with ESMTPSA id u2-20020a05620a120200b00767fbfea21dsm3713778qkj.69.2023.07.25.07.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 07:32:17 -0700 (PDT)
Date:   Tue, 25 Jul 2023 10:32:08 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Tomas Glozar <tglozar@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 6/6] rteval: Exclude isolcpus from loads report
In-Reply-To: <20230630091951.916865-7-tglozar@redhat.com>
Message-ID: <1a419d3d-9371-afc8-cdc3-97cacbfc1bb5@redhat.com>
References: <20230630091951.916865-1-tglozar@redhat.com> <20230630091951.916865-7-tglozar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 30 Jun 2023, Tomas Glozar wrote:

> Use SysTopology.default_cpus() to report cores on which measurements and
> loads and run by default to reflect the default behavior (no isolcpus).
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  rteval/modules/loads/__init__.py       | 2 +-
>  rteval/modules/measurement/__init__.py | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/rteval/modules/loads/__init__.py b/rteval/modules/loads/__init__.py
> index 761cc8c..74aad58 100644
> --- a/rteval/modules/loads/__init__.py
> +++ b/rteval/modules/loads/__init__.py
> @@ -138,7 +138,7 @@ class LoadModules(RtEvalModules):
>              # Convert str to list and remove offline cpus
>              cpulist = CpuList(cpulist).cpulist
>          else:
> -            cpulist = SysTop().online_cpus()
> +            cpulist = SysTop().default_cpus()
>          rep_n.newProp("loadcpus", collapse_cpulist(cpulist))
>  
>          return rep_n
> diff --git a/rteval/modules/measurement/__init__.py b/rteval/modules/measurement/__init__.py
> index d99873e..0e395be 100644
> --- a/rteval/modules/measurement/__init__.py
> +++ b/rteval/modules/measurement/__init__.py
> @@ -194,7 +194,7 @@ measurement profiles, based on their characteristics"""
>              # Convert str to list and remove offline cpus
>              cpulist = CpuList(cpulist).cpulist
>          else:
> -            cpulist = SysTop().online_cpus()
> +            cpulist = SysTop().default_cpus()
>          rep_n.newProp("measurecpus", collapse_cpulist(cpulist))
>  
>          for mp in self.__measureprofiles:
> -- 
> 2.41.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

