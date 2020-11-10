Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3361C388F7
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Nov 2020 20:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DEE420781
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Nov 2020 20:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxL31Fgq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgKJUGw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Nov 2020 15:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgKJUGv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Nov 2020 15:06:51 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9460C0613D1
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Nov 2020 12:06:51 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id g15so5813005qtq.13
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Nov 2020 12:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=jH+EUkYYbwsl1bu1qkTldhFvHbLw3I4A7E+HAqyfwZg=;
        b=hxL31FgqPNpFs0C6ic9E42uQHCwJDvcj8N/6FhuPo/ujCYz5V7jg0fS1Dw6PfE4dWe
         FmVXcEMci+4EsmdCXEYyigZr5ah3zcZfcL8rDRlG68jH6htWqua8PddSGy2JvNsqkz8l
         nL+wxTsqNLuXewpK+e5wzzUVsg/9RH1EMxXYBZpfaSa9FBg87wvGAjdnNPGsjQdgX7o6
         P0mYz3p04bTuNBHF1wg576/HpdU6fAcfMn7BtKuSM+0tyQqmrjBXf7EggJa5Kzs4P37M
         ZxFc3nKaLok8FxLQjvXS9fpEY3Np1r8e08hvWyBrlgT97uhJWPz7VTLL5Kfc29092Uif
         tZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=jH+EUkYYbwsl1bu1qkTldhFvHbLw3I4A7E+HAqyfwZg=;
        b=HRkuyJ/T6XCG62UwtUbAleDjCr2JzM/LeiZU4wFf5eOdMbGAhXrP0pID442VAfoZzZ
         fDgNegaxtApycfSNwywPAd0HtzFCDiTcp47O9GF+CG6xKP8EtIl0KlCLTymMvDCg50wh
         20eWoh/vT68qhBrYzevJuwBL1g5HzvtyZQvGIE6YYxXijD0NwRXHKkvcpUOz5LQx6JEn
         xpuK684/2OcqPx/m31JH5UtYqQ9GdNC4iEh2L7H5vn36Attp+xC8u18rossep2mApqvD
         2hWh7sXIUbdOy11PRuLMecuHLT1FcX23nZM9qkuzdnAiy4G5qIQy0M7h8EO/cxC4EydM
         rfJA==
X-Gm-Message-State: AOAM530dg0wuJ5S01rB5sAaj5F+uPOknQYMyVB4JDA5oPawNqVMO8P/f
        PxtwEqXyd4j6dPDajEUeAU0=
X-Google-Smtp-Source: ABdhPJxTFv0lgMbMvvo4d8aUyofGYjQ6VhNqmBaNWNYzHedZGw2VCK8qKQOjNAbvvd72Kys6XX0w/Q==
X-Received: by 2002:aed:3fb7:: with SMTP id s52mr20503192qth.100.1605038810962;
        Tue, 10 Nov 2020 12:06:50 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id b4sm3243814qtt.52.2020.11.10.12.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 12:06:50 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 10 Nov 2020 15:06:41 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH 1/5] cyclictest: Only report the first incident
In-Reply-To: <20201110180036.859080-2-bigeasy@linutronix.de>
Message-ID: <af5cc1c4-42de-1a62-bcfc-211d357adcc9@redhat.com>
References: <20201110180036.859080-1-bigeasy@linutronix.de> <20201110180036.859080-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 10 Nov 2020, Sebastian Andrzej Siewior wrote:

> Record only the first inciding inlcuding tid, value and trace event.
> If multiple threads exceed the limit then the reported `tid' might not
> match the reported value.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  src/cyclictest/cyclictest.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 34aa9be583f85..777da26d7bdc3 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -718,13 +718,14 @@ static void *timerthread(void *param)
>  
>  		if (!stopped && tracelimit && (diff > tracelimit)) {
>  			stopped++;
> -			tracemark("hit latency threshold (%llu > %d)",
> -				  (unsigned long long) diff, tracelimit);
>  			shutdown++;
>  			pthread_mutex_lock(&break_thread_id_lock);
> -			if (break_thread_id == 0)
> +			if (break_thread_id == 0) {
>  				break_thread_id = stat->tid;
> -			break_thread_value = diff;
> +				tracemark("hit latency threshold (%llu > %d)",
> +					  (unsigned long long) diff, tracelimit);
> +				break_thread_value = diff;
> +			}
>  			pthread_mutex_unlock(&break_thread_id_lock);
>  		}
>  		stat->act = diff;
> -- 
> 2.29.2
> 
> 
  - minor grammar and spelling edit
    Signed-off-by: John Kacur <jkacur@redhat.com>
