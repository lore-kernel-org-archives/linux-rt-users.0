Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA3DC7EE23
	for <linux-rt-users@archiver.kernel.org>; Thu,  1 Jun 2023 14:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbjFAOrZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 1 Jun 2023 10:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbjFAOrY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 1 Jun 2023 10:47:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A6FC0
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Jun 2023 07:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685630796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=emCP1RklvmC+5cu2xH7YB1kUzrFBC1+5dLIGxXdgYU0=;
        b=P/cYRn3hRcix92XOgaVvVZqewEKj6itrY+TlvxJ3efbNj3f37oBUMQDBXZPupNOXFVziXb
        u4dawM+nMj8+jUUNCYmf1wSbDsKaF0rM+qimlRx2ST2y/wT2EkM7IBEk0dQ/Pvki6ZA5Eo
        tY9sQWnYf8jldOb9+O7h03BjXNbXaXE=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-q0fHb_LtN6qwXgfUrxnXgw-1; Thu, 01 Jun 2023 10:46:27 -0400
X-MC-Unique: q0fHb_LtN6qwXgfUrxnXgw-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-39a06b3b71aso826554b6e.2
        for <linux-rt-users@vger.kernel.org>; Thu, 01 Jun 2023 07:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685630786; x=1688222786;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=emCP1RklvmC+5cu2xH7YB1kUzrFBC1+5dLIGxXdgYU0=;
        b=WWcZszyQS2Q7nLGjZq37YxWS2VGo64gyt377wNPER4OfPkueB/qi3G83Md/FyRyvnh
         llyC9CUELkddDOk3N3K+FU4xChyYtzGot1kdyYzDPoZLIixpOAyJOjgiYC6bV+ZHGons
         bsOpFdP91PknUf4GTr96n1RbqB4K2hYl52x3NN0ws+XFIRuC/7aQjH7hlBuhGz1nSF9n
         3/1JepiZUN4EsTgR5U1t+TFTYNDK/jAM1oOD3onu1FEASgHZfWcCYJKkb8vU5rXKAd9v
         1XQs2lmUXJMF3DYeY4+wCeU1qtysrt4Yy5ACNWfm9ctVotu3bXOim5J3b11Ra7tmb+Ic
         UluQ==
X-Gm-Message-State: AC+VfDwvrxkd+8WBD9VMe+2oC+qC1+inNeNCudD9oGQDmXZ7oQflGlQg
        fZpvz8vT5+kfx2ysGOqd3xsYownmJlp28aTCh997+EnIpCfrM+uFQ98v+SPxjGWaOsV3rGvpazs
        /6tQcsQgMtOnYw+EjbLYNWuGux+A=
X-Received: by 2002:a05:6808:434b:b0:398:bdb:956a with SMTP id dx11-20020a056808434b00b003980bdb956amr6546969oib.35.1685630786251;
        Thu, 01 Jun 2023 07:46:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4NGx84r1P3dxpZbFXWK72NeFTaIW2XFOJ3M6g7RKhR5z3X2bcbWDKcM4UJvgDJV2B0RxI4+w==
X-Received: by 2002:a05:6808:434b:b0:398:bdb:956a with SMTP id dx11-20020a056808434b00b003980bdb956amr6546952oib.35.1685630786050;
        Thu, 01 Jun 2023 07:46:26 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-07-184-147-141-56.dsl.bell.ca. [184.147.141.56])
        by smtp.gmail.com with ESMTPSA id l9-20020ad44249000000b00623819de804sm7585182qvq.127.2023.06.01.07.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 07:46:25 -0700 (PDT)
Date:   Thu, 1 Jun 2023 10:45:42 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
cc:     linux-rt-users@vger.kernel.org, Nini Gu <ngu@redhat.com>,
        Jun Wang <jwang@redhat.com>
Subject: Re: [PATCH] cyclictest: remove inclusion of unnecessary headers
In-Reply-To: <ZHYsPobROUdwnEC/@tpad>
Message-ID: <36d4d5b7-9f99-e979-8dfa-ecf9a495312e@redhat.com>
References: <ZHYsPobROUdwnEC/@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 30 May 2023, Marcelo Tosatti wrote:

> 
> The following three headers seem to be unnecessary,
> and do not exist on FreeBSD.
> 
> Remove their inclusion.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 82759d1..7b0f80f 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -22,11 +22,8 @@
>  #include <time.h>
>  #include <errno.h>
>  #include <limits.h>
> -#include <linux/unistd.h>
>  
> -#include <sys/prctl.h>
>  #include <sys/stat.h>
> -#include <sys/sysinfo.h>
>  #include <sys/types.h>
>  #include <sys/time.h>
>  #include <sys/resource.h>
> 
> 

Signed-off-by: John Kacur <jkacur@redhat.com>

