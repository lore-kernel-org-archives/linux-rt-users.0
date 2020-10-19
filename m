Return-Path: <SRS0=qep6=D2=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FBDC433E7
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Oct 2020 19:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8B6D22260
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Oct 2020 19:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMbZfb/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbgJSTW2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Oct 2020 15:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730820AbgJSTW2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Oct 2020 15:22:28 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341F1C0613CE
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Oct 2020 12:22:28 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id n5so1429517ile.7
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Oct 2020 12:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=kJSPAoK4TvMYR3VFWuMVwOd6fVN1hheITcD42bDC02A=;
        b=kMbZfb/cUKCJWI0j+BVeBm1iIU3k5jP/qeruTYTi1hLbcQ1n2t4T8rUaQB7fIzpY+e
         fP7Hb8K5LMLa/MiT6REMOjDOkUpNnzKndZW5XvBWUox7NMZPBSLCSOrv/jgJimWSj2ra
         lskFe1oQdYmDZUIoZ6QJoPYyTRfor9zOg6M35lHTB8OUXRFP7banaXer2ENcRsiuWHoz
         0wD/v+iH6VEAVhymkQyRWC6AxRDmUwZGfs1X0Z5h2Sm21REHxLD7ltLyxivDbV/0Wkle
         LMm1ElnOx1ASYpCNx5jsykzQ6i3/nTqThtGYH3z0F8RDqCb+Qq38chtdrei+hMFTPk70
         YBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=kJSPAoK4TvMYR3VFWuMVwOd6fVN1hheITcD42bDC02A=;
        b=XsDamPZ3VkbGAjFfnBvno4zi9jm29q8m6wx8lMzwS2u7AzYrzAHJHviVWZv8cD/ewT
         2S4RgnnFbn/NhLfCinQsWi0cbN01bW51LSUjk8zBT17aqOg1j0xHeTsazHXchPX5H6T0
         LjsIYsgA+GiD24NqF9wzayLb303yBVMnXmnZWX4BLG+JmjO4Tt1XumI9TAyUDy3QzTUy
         S/6BFgQa+uWw/OIdo9J0Ks22WtwlLU+b/rsjepomn0O1MO0P+9xtjiTZprB/vdKDQlYa
         e3jAR6Aml1md2rDyxdsAwzES1GwOiIk2NuAahPZEq6pHpOivSURxFwvKnWCF/jlvmvkF
         wuEQ==
X-Gm-Message-State: AOAM5332fjAnHznoZQ0voP5xJFKjiUgt7rZ5A9XGqxcq3cGHjQWY4m2K
        MxJejvynoemyd+dDcMn/BoY=
X-Google-Smtp-Source: ABdhPJwEwETM32VxJO3I4KqhBCqx0v4q+OYMgoicmHB94hkWAgBUv0OTqCXfuBJSlBAQU1XYZQIm/Q==
X-Received: by 2002:a92:bb9c:: with SMTP id x28mr1353174ilk.77.1603135347646;
        Mon, 19 Oct 2020 12:22:27 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id n28sm647182ila.52.2020.10.19.12.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:22:26 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Mon, 19 Oct 2020 15:22:13 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@fionn
To:     Anders Roxell <anders.roxell@linaro.org>
cc:     williams@redhat.com, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] Makefile: manpages: only add get_cyclictest_snapshot if
 PYLIB
In-Reply-To: <20201009205230.887524-1-anders.roxell@linaro.org>
Message-ID: <alpine.LFD.2.23.451.2010191521400.8663@fionn>
References: <20201009205230.887524-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 9 Oct 2020, Anders Roxell wrote:

> Since the installation of get_cyclictest_snapshot.py is done if PYLIB
> then we should only install the manpages then as well.
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
> Hi,
> 
> I wasn't sure if this is the correct way for the manpages or if we just
> want to remove the "ifdef PYLIB" around the
> src/hwlatdetect/hwlatdetect.8 ?
> 
> What do you prefer ?
> 
> Cheers,
> Anders
> 
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index c3ebbd7b2a2e..5f34075a4aa1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -49,10 +49,10 @@ MANPAGES = src/cyclictest/cyclictest.8 \
>  	   src/sched_deadline/deadline_test.8 \
>  	   src/ssdd/ssdd.8 \
>  	   src/sched_deadline/cyclicdeadline.8 \
> -	   src/cyclictest/get_cyclictest_snapshot.8 \
>  	   src/oslat/oslat.8
>  
>  ifdef PYLIB
> +	MANPAGES += src/cyclictest/get_cyclictest_snapshot.8 \
>  	MANPAGES += src/hwlatdetect/hwlatdetect.8
>  endif
>  
> -- 
> 2.28.0

Signed-off-by: John Kacur <jkacur@redhat.com>
