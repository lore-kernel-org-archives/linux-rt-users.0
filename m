Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F002C001B0
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Aug 2023 18:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjHISnI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 14:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjHISnI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2023 14:43:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D031FCC
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 11:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691606545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n275fbg41+d3TIzwMZ9bIW0IvGaT/jcUStuLbC61dvo=;
        b=cwJkEMR2PUcwYufo0GeYZlExMGGz1V2lUTRqUSj5ZfjSn0kJ4+s/iWbelwnrG+ttRWtiFo
        O1jDBq7XLjLEoH9OuieZYgtoAEXqyszwy4NGJ01ZQh+1v242FtU3qpESZ8rMhaO6vr0bFU
        6GW25Ng22i29HhW+Wzul/ALZQPMC+F8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-Q7n6F2GcMEGpaZdE9jm1xA-1; Wed, 09 Aug 2023 14:42:23 -0400
X-MC-Unique: Q7n6F2GcMEGpaZdE9jm1xA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-63cfc4ebcecso1368566d6.1
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Aug 2023 11:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691606543; x=1692211343;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n275fbg41+d3TIzwMZ9bIW0IvGaT/jcUStuLbC61dvo=;
        b=dsOBDhpBajnZ4u/97josYzKPVdmdbWnCfS97/mVDBIdLc49o/sYtQNNbfneltuLQ57
         Ru2imzJ3YXvFEqrVISX/byCK3pCJBxFKEDwUk5SFyT3bRwgNr896f2tvPwmcx7Po/usp
         x0VR2P3eb0huOn4Hei4jgo00RhjNL90/gUibGAk+ca0VZ8hM4OkTecrjBXXByrK1iEc1
         I9Z1jITk3nuX5nCti5KR+M/FKeRVmMoO9bw+GUWRQ/A0JhzlZVfRqPoohzqsRM6X6rzz
         6m45QN9wnlmgayYlKtOtPVLOCElGASgLgY2+JQqWUI7a+RYD378Yug2B006khH/APj0k
         bB/g==
X-Gm-Message-State: AOJu0YzXlf2qgh6CtCsRvYPZ7oYcEJJQojs6h0hOBIOaDzbqIELjrc4G
        1cTepCwWXT0FQtkGmX1jR93zgxwxpGSdjRhZW9USzWy2P6SkHYuCuRH0RZAj5GfyyQbkOFVkKCu
        YY+kRXW3v1RMq2Om6fvM1ezm4b1NTMHkRTX0=
X-Received: by 2002:a05:6214:12e:b0:63c:da03:1c12 with SMTP id w14-20020a056214012e00b0063cda031c12mr31923qvs.60.1691606543288;
        Wed, 09 Aug 2023 11:42:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx+qCqKhCOyuTFOHTRsjf4hZmSjwR7e1MW8iBaG6xsTO1yH13CPYkUfHQfW9BTw9QmRMzvog==
X-Received: by 2002:a05:6214:12e:b0:63c:da03:1c12 with SMTP id w14-20020a056214012e00b0063cda031c12mr31906qvs.60.1691606543056;
        Wed, 09 Aug 2023 11:42:23 -0700 (PDT)
Received: from fionn ([184.147.140.157])
        by smtp.gmail.com with ESMTPSA id u1-20020a0cf1c1000000b0063f5c72f771sm4598718qvl.28.2023.08.09.11.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 11:42:22 -0700 (PDT)
Date:   Wed, 9 Aug 2023 14:42:13 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Eder Zulian <ezulian@redhat.com>
cc:     linux-rt-users@vger.kernel.org, williams@redhat.com
Subject: Re: [PATCH] rt-tests: cyclictest: Remove warnings due different
 signedness in comparison
In-Reply-To: <20230808225500.292257-1-ezulian@redhat.com>
Message-ID: <19674a14-8df8-3ba5-e025-4a655f53231@redhat.com>
References: <20230808225500.292257-1-ezulian@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 9 Aug 2023, Eder Zulian wrote:

> Type casting used to remove compiler warnings due to comparison of integer expressions of different signedness.
> 
> Signed-off-by: Eder Zulian <ezulian@redhat.com>
> ---
>  src/cyclictest/cyclictest.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 7b0f80f..3b47d53 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -317,8 +317,8 @@ static int raise_soft_prio(int policy, const struct sched_param *param)
>  		return err;
>  	}
>  
> -	soft_max = (rlim.rlim_cur == RLIM_INFINITY) ? policy_max : rlim.rlim_cur;
> -	hard_max = (rlim.rlim_max == RLIM_INFINITY) ? policy_max : rlim.rlim_max;
> +	soft_max = (rlim.rlim_cur == RLIM_INFINITY) ? (unsigned)policy_max : rlim.rlim_cur;
> +	hard_max = (rlim.rlim_max == RLIM_INFINITY) ? (unsigned)policy_max : rlim.rlim_max;
>  
>  	if (prio > soft_max && prio <= hard_max) {
>  		rlim.rlim_cur = prio;
> -- 
> 2.39.3
> 
> 
Although we are not as strict as the kernel, we try to follow most of 
their coding rules, and I usually run checkkpatch on patches.

../linux/scripts/checkpatch.pl eder2.patch 
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars 
per line)
#8: 
Type casting used to remove compiler warnings due to comparison of integer 
expressions of different signedness.

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#25: FILE: src/cyclictest/cyclictest.c:320:
+	soft_max = (rlim.rlim_cur == RLIM_INFINITY) ? (unsigned)policy_max 
: rlim.rlim_cur;

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#26: FILE: src/cyclictest/cyclictest.c:321:
+	hard_max = (rlim.rlim_max == RLIM_INFINITY) ? (unsigned)policy_max 
: rlim.rlim_max;

total: 0 errors, 3 warnings, 10 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or 
--fix-inplace.

eder2.patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

-------
The cast is fine in this case, we can't just use an unsigned int
because sched_get_priority_max could return an error. So, just fix
the unwrapped line in your commit message and make the cast
unsigned int

and then I'll apply it.

Thanks

John

