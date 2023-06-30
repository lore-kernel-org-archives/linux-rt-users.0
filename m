Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AB4EB64D7
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jun 2023 17:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjF3Rvy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 30 Jun 2023 13:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjF3Rvw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Jun 2023 13:51:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA8E2952
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Jun 2023 10:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688147461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EpSWVoBbToU1S3A+RbwhXmaIem6W7ZODVasEM/nE3Pw=;
        b=PsvoVt5CiReXkJfQzY6t3mcD0YtmooMahqnXmbm7FhT3OLrmHu5hKkH0aOzcZ9hpvgZNla
        kBGL1+Om6yKeBN8TNg6rUq5HjFIWiz+afoU6IBkWA2hBglAuImvCbp2pIr1GJqkh8exZ7Z
        YSg2bAY+8Uka07y4jJU8NSZymoJaGu4=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-KN1jSsYvPPmhdlB8wrEe7A-1; Fri, 30 Jun 2023 13:50:59 -0400
X-MC-Unique: KN1jSsYvPPmhdlB8wrEe7A-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-47e245f9d9fso63784e0c.3
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Jun 2023 10:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688147459; x=1690739459;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EpSWVoBbToU1S3A+RbwhXmaIem6W7ZODVasEM/nE3Pw=;
        b=crUh+JpminqJTSUWDKgQ373dtyLOra/sZ9kub7xdVfY9ATjPjn+pMoKkkMDrbKTD4E
         D/hCKQtd8fntXdw/zDlZsGyY9wZW0hnPmRkXFqkMbcUWJkBe2ElFFY+ezWgXLPY3wc0M
         Jec3YG0nmmTALips1POxNRW3kfglccNF2jyJcMu0aYKNC/Koh0sj8I88n+JOMFJyZCvk
         LTOMK9XuqV0lDL9qczTJj9IEnJCqX27K0sNf3rHCB33E1YBqVSlboNDJbWCU/s3wxnrH
         LA1VsKXf1M+weiVU4j1ks7p+Q0cVf5ZWpIhGnXnqWKsXjYOUEdUc7jFL5XxkQwW9mF+i
         9CjQ==
X-Gm-Message-State: ABy/qLZsg13aI/qT2hxZCISlXj1BLtcHyb7RvtxRstB1jcO/qHW03Jce
        6KrLsST1gZbdU7heZgFr+VHfNZ581yZw5RCZJQsA90S0yrPxTh3XOMMetYDElPjihCWygcGRGfp
        uWiXsIGXz+iryhN6bwv2DiGrm4Ns=
X-Received: by 2002:a1f:c1d0:0:b0:471:5939:f4f2 with SMTP id r199-20020a1fc1d0000000b004715939f4f2mr1985801vkf.8.1688147459013;
        Fri, 30 Jun 2023 10:50:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFgDMqLS4fQrQtdA/r4PLL00AtuNVxp5YWU4vGwz7fRgE4aAY+HK+JPjUoaJd/VhkWWxwuiFQ==
X-Received: by 2002:a1f:c1d0:0:b0:471:5939:f4f2 with SMTP id r199-20020a1fc1d0000000b004715939f4f2mr1985787vkf.8.1688147458754;
        Fri, 30 Jun 2023 10:50:58 -0700 (PDT)
Received: from fionn ([184.147.141.56])
        by smtp.gmail.com with ESMTPSA id q16-20020ae9e410000000b007672ab185fesm2326168qkc.115.2023.06.30.10.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 10:50:58 -0700 (PDT)
Date:   Fri, 30 Jun 2023 13:50:49 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Anubhav Shelat <ashelat@redhat.com>
cc:     linux-rt-users@vger.kernel.org, kcarcia@redhat.com
Subject: Re: [PATCH v3 2/2] Edited code from previous commit to exclude
 try-except block
In-Reply-To: <20230630171017.1072241-2-ashelat@redhat.com>
Message-ID: <fb3e2c9c-14b1-ed3d-3ccc-cdc898ca67b@redhat.com>
References: <20230630171017.1072241-1-ashelat@redhat.com> <20230630171017.1072241-2-ashelat@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 30 Jun 2023, Anubhav Shelat wrote:

> Edited code, from previous commit that allowed -S to download kernel
> versions of the form x.y, to exclude try-except block.
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  rteval-cmd | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/rteval-cmd b/rteval-cmd
> index d019da41d8d3..44921dfe0764 100755
> --- a/rteval-cmd
> +++ b/rteval-cmd
> @@ -291,11 +291,7 @@ if __name__ == '__main__':
>                  kernel_prefix = re.search(r"\d{1,2}\.\d{1,3}\-[a-z]*\d{1,2}", rtevcfg.srcdownload).group(0)
>                  url = "https://git.kernel.org/torvalds/t/"
>              else:
> -                try:
> -                    kernel_prefix = re.search(r"\d{1,2}\.\d{1,3}\.*\d{1,2}", rtevcfg.srcdownload).group(0)
> -                except AttributeError:
> -                    # if kernel version specified is of the form x.x and not x.x.x
> -                    kernel_prefix = re.search(r"\d{1,2}\.\d{1,3}", rtevcfg.srcdownload).group(0)
> +                kernel_prefix = re.search(r"(\d{1,2}\.\d{1,3}\.\d{1,3})|(\d{1,2}\.\d{1,3})", rtevcfg.srcdownload).group(0)
>                  major_version = re.search(r"\d{1,2}", kernel_prefix).group(0)
>                  url = "https://kernel.org/pub/linux/kernel/v" + major_version + ".x/"
>  
> -- 
> 2.39.3
> 
> 
- Modified comment
Signed-off-by: John Kacur <jkacur@redhat.com>

