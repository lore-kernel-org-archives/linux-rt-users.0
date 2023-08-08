Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF11C41513
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Aug 2023 20:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbjHHUJP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjHHUI4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Aug 2023 16:08:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A88900C
        for <linux-rt-users@vger.kernel.org>; Tue,  8 Aug 2023 11:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691519419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2FZ1uLC5x3O7S5Br75v2XQetXm23G3bROYwQEzamdls=;
        b=CvDbGmg1956NXwyfyRz/Xc7dAoQXJTuaXwFmRrGB/ISfSO/U2buPNWH8+0zNqAN/OwlCEr
        MIALiAThQpED1oYp41RSsVZd13OFxhKLREZos2egdad/5xAb6p4EyCw83F9RnjXGJ40Ttw
        sxzy+mnnFM3yJOKRNHm9p9q1StBrBdk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-yNL7xhq3NtmVlEU3w66Izg-1; Tue, 08 Aug 2023 14:30:18 -0400
X-MC-Unique: yNL7xhq3NtmVlEU3w66Izg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-63cd05c0415so73827396d6.1
        for <linux-rt-users@vger.kernel.org>; Tue, 08 Aug 2023 11:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691519417; x=1692124217;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2FZ1uLC5x3O7S5Br75v2XQetXm23G3bROYwQEzamdls=;
        b=S/SpXTDRIlh/B0KoSLvet8VXgipMBkSnTvpD6dR4dDBJObHPPNk/0YnytUwRcHUz+E
         W6k6TX4k0v0NwJ8rSI4oACvF16xuJ/vZHHZqUXAzFHXI9CBy18qqpv1gKB8xysS+SwFi
         TxMbCde5O4eBV8BVxjLhaQjw5JQlO7b/vr5NBVf2riFzn4GVVuW1hoV/Fwl6oW5f4G8r
         HtaU0yl4S3f58UpXMEDwTZYTTnmOTU/75vDmrNFbPXgIqvvjYytU4b8q1d7KB0iv0n7n
         lod8hJV4V7A1PKzpBBKvrcsdPQh6KH6oTKvN8Ff9ogZ52eBDkWF+YqiNwrNAtlFVngxq
         /vcg==
X-Gm-Message-State: AOJu0YyZDzp8LL4RMkBG1+AyRaMCCZvbNXtL84tdFu5ST8gYVhjD02Yl
        Qxaunzbcv+sx5GYgDHpwD1gwVS+T54ttVnGwQGB4UV43xHEhgrmFfh2H0TxtS8cZIhoegidqwQf
        bYYW00v2hS50Qwgbm+7OF1ze299NMkeaFBAY=
X-Received: by 2002:a05:6214:3d09:b0:63c:fbdd:4592 with SMTP id ol9-20020a0562143d0900b0063cfbdd4592mr313466qvb.31.1691519417827;
        Tue, 08 Aug 2023 11:30:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEST5VKoNmoiSuA05MiEPFDufrcnPLnBi1I4f5HxQMo1ydtCvUXUGVK3cWSXboCh/gBj4iQJA==
X-Received: by 2002:a05:6214:3d09:b0:63c:fbdd:4592 with SMTP id ol9-20020a0562143d0900b0063cfbdd4592mr313453qvb.31.1691519417622;
        Tue, 08 Aug 2023 11:30:17 -0700 (PDT)
Received: from fionn ([184.147.140.157])
        by smtp.gmail.com with ESMTPSA id p11-20020a0c9a0b000000b0063d30c10f1esm3892985qvd.70.2023.08.08.11.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 11:30:17 -0700 (PDT)
Date:   Tue, 8 Aug 2023 14:29:57 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Tomas Glozar <tglozar@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rteval: Correct Python version in doc/rteval.txt
In-Reply-To: <20230808115201.43187-1-tglozar@redhat.com>
Message-ID: <d98aab0-3f8b-ec8e-e8b1-b9c7dc47852@redhat.com>
References: <20230808115201.43187-1-tglozar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 8 Aug 2023, Tomas Glozar wrote:

> doc/rteval.txt specifies that rteval is a Python 2.x program. This is
> not true, since rteval no longer works with Python 2.x:
> $ python2 rteval-cmd
>   File "rteval-cmd", line 67
>     print(f"Don't know how to summarize {repfile} (tarfile open failed)")
>                                                                        ^
> SyntaxError: invalid syntax
> 
> Replace "Python 2.x" with "Python 3.x".
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  doc/rteval.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/rteval.txt b/doc/rteval.txt
> index 7342866..569168e 100644
> --- a/doc/rteval.txt
> +++ b/doc/rteval.txt
> @@ -21,7 +21,7 @@ of a network packet). To give a realtime application the best chance
>  of meeting its deadline(s), a realtime OS must minimize the time
>  between event occurance and the servicing of that event (latency). 
>  
> -This paper describes the 'rteval' program, a Python 2.x program
> +This paper describes the 'rteval' program, a Python 3.x program
>  developed at Red Hat to help quantify realtime performance on the
>  Realtime kernel. Rteval is an attempt to put together a synthetic
>  benchmark which mimics a well behaved realtime application, running on
> -- 
> 2.39.3
> 
> 
Thanks for the clean-up
Signed-off-by: John Kacur <jkacur@redhat.com>

