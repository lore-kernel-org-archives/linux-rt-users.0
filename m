Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EAFC07E9C
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 18:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08CE6613D9
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 18:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhGISKy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Jul 2021 14:10:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28229 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229459AbhGISKx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Jul 2021 14:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625854089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W7m36XUoOTcGAnuZUAVmwpsgpxlNLu16rgQVaRqJKZA=;
        b=cfFyfN7EhbQQ+fd2By7NF1+z32aOqwW2NoegV3XbsEw4PA5cRvl5U8LPusdHBTZd5va3ZS
        x3mseZu5lLSdgz4g8X4NBYFdvxxdIBcYK+3x6TPEh7MI+BnJvKzhOzfLeS+KviaxqjS2+v
        VpOLuy2ID7YKs2yUV3LfMBwfghyZ1io=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-hQ6-8dIaPPW1V158RY2lzA-1; Fri, 09 Jul 2021 14:08:08 -0400
X-MC-Unique: hQ6-8dIaPPW1V158RY2lzA-1
Received: by mail-qt1-f200.google.com with SMTP id v17-20020a05622a1451b02902533c8b7139so2593465qtx.3
        for <linux-rt-users@vger.kernel.org>; Fri, 09 Jul 2021 11:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=W7m36XUoOTcGAnuZUAVmwpsgpxlNLu16rgQVaRqJKZA=;
        b=SBhWFgz9geWRVnFDlD1maJD8b7gQ0Wa+vcz2Bo65n4HucQSridBgK+550+7IXLD5an
         x2byNKVVhSLTeVgVsH9Zyua5J7g3fAKbh+C+e9mA9qfw3RMMdRHrwKJnCuMycnrBRs/B
         /cqdE8PcNqbrbE6PS4Hp+E7JP31nNkb8TtPs4+mH2sm1w1XrPLXD88THMK6O0apuiwmL
         nhMA32GPS5P09hOcHx8KbzxaogP+fK36tAPrpMeiICWrI18BNlSpU5hKJtycWD3olVu4
         4NHGYImdtyvJ3Wp9mSEJTIDUtJsFmEVbI+tIu+LJpA1cgZ4kbTRYhIcbvOEESReiw37e
         m4Rw==
X-Gm-Message-State: AOAM531O17niR8xqtHpkd+jCJRTwoNVGReC0jvuZKjccfa4/JCCZApB6
        WHffgU+1jFgabHtp2KPg7cqBBIhzlyffCLm0STwjHJ4l5E01zku/Gk9k+V//wUZsrkv2qtT0BuH
        8Sj929uO2oe5y41o8Z+g+c6Wcxjc=
X-Received: by 2002:a05:620a:a92:: with SMTP id v18mr38825580qkg.156.1625854087945;
        Fri, 09 Jul 2021 11:08:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYja9p+iBUYOWLZEE5vkF/TIofw7179X5wk7cCNkFpftjfKHXSePsV6S6En3r3+2G/BdHw/w==
X-Received: by 2002:a05:620a:a92:: with SMTP id v18mr38825566qkg.156.1625854087816;
        Fri, 09 Jul 2021 11:08:07 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-07-184-147-141-243.dsl.bell.ca. [184.147.141.243])
        by smtp.gmail.com with ESMTPSA id i67sm2869816qkd.90.2021.07.09.11.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 11:08:07 -0700 (PDT)
Date:   Fri, 9 Jul 2021 14:08:06 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
cc:     linux-rt-users@vger.kernel.org, peterx@redhat.com,
        williams@redhat.com
Subject: Re: [PATCH 1/2] oslat: Remove redundant include
In-Reply-To: <20210707084849.304329-1-nsaenzju@redhat.com>
Message-ID: <cd484678-dcc4-e85e-e038-e7112ecc3f@redhat.com>
References: <20210707084849.304329-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 7 Jul 2021, Nicolas Saenz Julienne wrote:

> inttypes.h is already included above.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> ---
>  src/oslat/oslat.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index 6108fed..1cba6fc 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -29,7 +29,6 @@
>  #include <numa.h>
>  #include <math.h>
>  #include <limits.h>
> -#include <inttypes.h>
>  
>  #include <sys/prctl.h>
>  #include <sys/stat.h>
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

