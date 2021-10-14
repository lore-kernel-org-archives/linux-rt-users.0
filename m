Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31608C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Oct 2021 18:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12B7F61037
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Oct 2021 18:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbhJNSZv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 14 Oct 2021 14:25:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45840 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231256AbhJNSZu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Oct 2021 14:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634235825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2el+AZuA250Lh/QNdTwUwWYEUPhyKAmGHd37F6IiQKc=;
        b=GFnP2C80zh45kxN0KOrYAizjkdkI1Miq+XAhp9oikfKdRCU6pFjm1smt9zozoSnb/JIPIf
        CVmYKFDCD5JgJfxpowHu1uyFbSUAFW3j4UJ0ov2lu5q7VyxF3kVq1LR2SFcHBCcXhIi/jk
        tE2bm6zMQnfJweDp4ZRTtniIVPLmJj8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-vjyp6q-iOQaOebmA5ZyPLA-1; Thu, 14 Oct 2021 14:23:42 -0400
X-MC-Unique: vjyp6q-iOQaOebmA5ZyPLA-1
Received: by mail-qk1-f198.google.com with SMTP id v14-20020a05620a0f0e00b0043355ed67d1so5094216qkl.7
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Oct 2021 11:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=2el+AZuA250Lh/QNdTwUwWYEUPhyKAmGHd37F6IiQKc=;
        b=n6saDQaP7OlsFCGy/Jo5FPCUFLWfA8RzUasLEthHj7povKabu/ivTXvCW9Rrn0Q9xN
         DpUTsKp1M7irNghjMfpn/apBCoJ4VUOWdnUHNW88RAWS9hpdbc547ZTnT4JG1Nkl1ThV
         ngipP7m1NqWk6TfJ9vwl7ASdeYKshB8WSIkJwuS547R1VFqZTNcxTgi+F/me6b1I/4Xj
         JRyeg1QKIeQCyS0tX6DHzecURw4mSiO2nj9JvaHCb6MNqpl8SqE/qPfAb4WrXe7RFzeo
         octdXYFOCKAPCRHlcI2dI7cQLewo5BgaUWW7MDhTk88kB+pgkKpNu4G4Z5FDQY7Nrz3h
         JrnA==
X-Gm-Message-State: AOAM530gs2/QBCdxG/0XhLD8+r+mT3H+QEek52eH55a03PPDS0MeZzvV
        WqTi+SrRmvk56FiURFTcEcFXcQ+a1vnLvfR7/tUUZY+3f3VVnWoxqkV9GxA78uZo+9rSQrDE3+W
        zM4a8vNbHL9cfFWSoPxUXmNiFBFE=
X-Received: by 2002:a37:2717:: with SMTP id n23mr5897289qkn.149.1634235821394;
        Thu, 14 Oct 2021 11:23:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvr0oX5XxpddTyeQ+IIwf/OIsznSseozpTBNXXNoRNAxXWNFdqdZu10VruBSGMJgmY7MSyRw==
X-Received: by 2002:a37:2717:: with SMTP id n23mr5897270qkn.149.1634235821209;
        Thu, 14 Oct 2021 11:23:41 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id v80sm1624921qkb.45.2021.10.14.11.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 11:23:40 -0700 (PDT)
Date:   Thu, 14 Oct 2021 14:23:39 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punitagrawal@gmail.com>
cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>, williams@redhat.com,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFC 1/7] rt-tests: cyclictest: Drop unused defines
In-Reply-To: <20211014071247.4165329-2-punitagrawal@gmail.com>
Message-ID: <d4b49e6e-95d7-706b-a16-6ebd124e2343@redhat.com>
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

This looks like more left over code from before we handed tracing 
functionality to tracecmd. Just remove the 'RFC' and I'll sign-off on 
that.

