Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C30C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Apr 2022 20:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381062AbiD2U4q (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 29 Apr 2022 16:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381069AbiD2U4o (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 29 Apr 2022 16:56:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 538E8CC517
        for <linux-rt-users@vger.kernel.org>; Fri, 29 Apr 2022 13:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651265604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mf11uxN2CtyOag1m7eneTl+o8UxHGhCTVhKLPBN+bEc=;
        b=MGRIIIcimMw/FYJL3xJOfNg6i0drRovgmndO7jFMM+E4cdYdW4Fr4HduplE1Bes5LFk6KF
        QMkDtMWputjh2FNXswlVV4uowbJ3x2swMrjUiwiytwUYt2ZM6oeAGeei/XcsGfwrsqxWuu
        1PRzW5aiaznpTigR48mKDFoqOyq84fg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-my0NQoSiOr6GaZFFZ8Pmow-1; Fri, 29 Apr 2022 16:53:22 -0400
X-MC-Unique: my0NQoSiOr6GaZFFZ8Pmow-1
Received: by mail-qt1-f197.google.com with SMTP id x10-20020ac8700a000000b002c3ef8fc44cso6505935qtm.8
        for <linux-rt-users@vger.kernel.org>; Fri, 29 Apr 2022 13:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Mf11uxN2CtyOag1m7eneTl+o8UxHGhCTVhKLPBN+bEc=;
        b=Gf2ykX2ZEpUs15afAv9BWw/8rDB0SBqdqpYudZpAHD36HxvdTjNeRMLujbX9Z/tRnP
         2DAJRqBmdIoZkDWmKlqR8trkgWTCSVrCLlp8e39urww279z7GzsXCqAc+ZmpznQa0YW9
         U4Y2T4VlE66ZUcvJfUu5Qi4Ll4OVJKTwnY5QiwfQZnjQ7VjG5Dvw3HXve0Eyw6xyvIpX
         lNFo1aBE7KyzN0FYHHErS1IR1inrQC5cm9sKO4RhBhVJ6k87FCNx65Y5qOYJ0BaUFbzP
         pRlq4EOlPR6ZsqIMvdCWnn5G2dlyU3UHFBODjxUPeX+tQMH9mSCblusJK/Dkncys9unx
         NM8w==
X-Gm-Message-State: AOAM530Z7B7oRydgxakuQ1dCdSeOaztJMwdAYyWs+rsLQfILhgKGhhI5
        0Ss1YVpShJPwD7mN6MMe01Bx88HGwhjBokAyJvnqGKXkK8nXHVhltVti2wWyqTxHNd219Jx3aqG
        g0/tb9IR9J6H2DKfMEt9537xs+cw=
X-Received: by 2002:a05:6214:21e4:b0:457:c078:be48 with SMTP id p4-20020a05621421e400b00457c078be48mr966718qvj.118.1651265602243;
        Fri, 29 Apr 2022 13:53:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwClWi780Pji4Ig4qc45XVUPEZOxmXb33o/gIHAiyQxBh5ptFGvzaRYuKxM4LYA47wNZru6w==
X-Received: by 2002:a05:6214:21e4:b0:457:c078:be48 with SMTP id p4-20020a05621421e400b00457c078be48mr966709qvj.118.1651265602081;
        Fri, 29 Apr 2022 13:53:22 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-93.dsl.bell.ca. [184.147.143.93])
        by smtp.gmail.com with ESMTPSA id 138-20020a370a90000000b0069fc13ce1ffsm148080qkk.48.2022.04.29.13.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 13:53:21 -0700 (PDT)
Date:   Fri, 29 Apr 2022 16:53:20 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>
cc:     linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 3/3] rteval: systopology: Slight CpuList.__expand_cpulist()
 cleanup
In-Reply-To: <20220419161443.89674-4-vschneid@redhat.com>
Message-ID: <f03dc22b-75e8-982b-5766-e0ccfbe3cd7c@redhat.com>
References: <20220419161443.89674-1-vschneid@redhat.com> <20220419161443.89674-4-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 19 Apr 2022, Valentin Schneider wrote:

> This method currently aggregates CPUs into a list, then converts this to
> set and then back to list. The aggregation can instead be done directly
> into a set.
> 
> (as an offside, it would make more sense for CpuList to have its storage be
> a set in the first place as duplicate CPU ids don't make sense for it, but
> that's a separate discussion :-))
> 
> The integer conversion of the "a-b" pattern can also be condensed into a
> single map() expression.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  rteval/systopology.py | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/rteval/systopology.py b/rteval/systopology.py
> index b2da7bb..2a28f9c 100644
> --- a/rteval/systopology.py
> +++ b/rteval/systopology.py
> @@ -102,20 +102,19 @@ class CpuList:
>          """ expand a range string into an array of cpu numbers
>          don't error check against online cpus
>          """
> -        result = []
> -
>          if not cpulist:
> -            return result
> +            return []
> +
> +        result = set()
>  
>          for part in cpulist.split(','):
>              if '-' in part:
> -                a, b = part.split('-')
> -                a, b = int(a), int(b)
> -                result.extend(list(range(a, b + 1)))
> +                a, b = map(int, part.split('-'))
> +                result |= set(range(a, b + 1))
>              else:
>                  a = int(part)
> -                result.append(a)
> -        return [int(i) for i in list(set(result))]
> +                result |= {a}
> +        return list(result)
>  
>      def getcpulist(self):
>          """ return the list of cpus tracked """
> -- 
> 2.27.0
> 
> 

I'm guessing that the reason for the "set" was to remove any potential 
duplicates. Duplicates are not normally a problem in rteval, but if you 
want to ensure you handle any user input correctly, it makes sense to do 
that. I think your code is correct, but I'm not sure if it buys us 
anything.

John

