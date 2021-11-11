Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07A5C433FE
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B77F561264
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbhKKUbU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 15:31:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42637 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233489AbhKKUbT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Nov 2021 15:31:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636662509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w8WWpnPcTc9ymT+OmhX2IzEnOJ+I4cd30/h1uj5D2pA=;
        b=Bv7qBDbFfZ0BvpPpom0h3RKiTLiENxQ6Hsxoln4Ok6Diksz+I0ZJbmOPF0aQADGQF0CYjP
        Mevolz9M3DcjwoK6KX0yC8gUj075F/v2eMcrm15fTmkP4sHug+oPEzcf+iRVtI46rp9MRf
        +x6HTMkAbkNf4ECceAA8OHiTZID0P2U=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-kShbwEAYMYy4cjZLp70d4g-1; Thu, 11 Nov 2021 15:28:27 -0500
X-MC-Unique: kShbwEAYMYy4cjZLp70d4g-1
Received: by mail-qt1-f198.google.com with SMTP id v32-20020a05622a18a000b002b04d0d410dso4305258qtc.11
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:28:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=w8WWpnPcTc9ymT+OmhX2IzEnOJ+I4cd30/h1uj5D2pA=;
        b=41ZYiJa+pNDNQETez8jOGF2PxmvViDq7kI5J+lTjXy+YOPwFZjkp7ZEtuGa/TlxPgC
         hV5ZZC8DfCiZlaXs/HjxaM4EsbAnhseazPPX5SbauNU51aoZdI5UynSnuVUJv6aSNiIO
         ANRW6B4U1lWhyqX7xknlr6nkIQR1AZ8hr6Vdxf6y9qOiiwtLksU02MsWl0wlnhhm8Vuo
         rbgDaCnKlXJ2egLDe3HUo8O3Z0Kfx5LTmeYrSqHh1CMDCwlg9iQAlTfB/aqLlxz/6lBb
         xIBYM6sZa2KvxznYSttEyRfgoRPZbwJwqV1t7k1mNyiJA2U5Os6qiM23KzcBYAF7gKOl
         KmEQ==
X-Gm-Message-State: AOAM532/zEoivXf5amKapL/t2wR/wXL720y0YiFknHEftLNHLCo90oN+
        wNuShIRzZTWmH0+sEsd/+ArFaPQbjztyB7aPXfG0cAPeBjRhUBRxun5SBjJy3rGcwjy3RskzWwn
        3Vn0TC+YL7bRcDr6zWXeTTtDtzaQ=
X-Received: by 2002:a37:cd1:: with SMTP id 200mr8679880qkm.106.1636662506446;
        Thu, 11 Nov 2021 12:28:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxuCPvormdPNGZJb9QR+DaNB9yOFMNorEGQ8M4U+LndofWarhoOCkpNfsOJTYvbemNE6L9kqw==
X-Received: by 2002:a37:cd1:: with SMTP id 200mr8679860qkm.106.1636662506289;
        Thu, 11 Nov 2021 12:28:26 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-08-184-147-142-154.dsl.bell.ca. [184.147.142.154])
        by smtp.gmail.com with ESMTPSA id v3sm1717773qkd.20.2021.11.11.12.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 12:28:25 -0800 (PST)
Date:   Thu, 11 Nov 2021 15:28:24 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punitagrawal@gmail.com>
cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>, williams@redhat.com,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFC 1/7] rt-tests: cyclictest: Drop unused defines
In-Reply-To: <20211014071247.4165329-2-punitagrawal@gmail.com>
Message-ID: <e4d65d6-928b-9f0-6edf-21d12c32db7f@redhat.com>
References: <20211014071247.4165329-1-punitagrawal@gmail.com> <20211014071247.4165329-2-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 14 Oct 2021, Punit Agrawal wrote:

> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> 
> KVARS, KVARNAMELEN and KVALUELEN defines are not used in
> cyclictest. Drop them.
> 
> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> ---
>  src/cyclictest/cyclictest.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 2187d98de725..0c1e6617e0e1 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -99,10 +99,6 @@ extern int clock_nanosleep(clockid_t __clock_id, int __flags,
>  /* Must be power of 2 ! */
>  #define VALBUF_SIZE		16384
>  
> -#define KVARS			32
> -#define KVARNAMELEN		32
> -#define KVALUELEN		32
> -
>  #if (defined(__i386__) || defined(__x86_64__))
>  #define ARCH_HAS_SMI_COUNTER
>  #endif
> -- 
> 2.32.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

