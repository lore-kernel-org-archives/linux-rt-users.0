Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F4DC433ED
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFCF260232
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238364AbhEGQmH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 12:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238361AbhEGQmG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 12:42:06 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA0AC061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 09:41:05 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id j3so5116243qvs.1
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 09:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=QjR9CHStX334fbwzetA4JhP7OKfPG7A+EQPTw7lB/S4=;
        b=fEK9BiFmcI9GQdd/KLoiSTv2Nuk2hjzUpSHO+WxlhKLeEzZU8xSWJ0cT0PY0r4OF8/
         27OJ/QsKdBwld5r0M+iPfiysyVChhQjuZHonsFkUM9KBQxFZY44Fw/RABVlHfaMGCabV
         7Ypkbustl6xirJpl6B8uZJpL/F2i7kFxzSac0r451ykuav9tZZ4zfV2XNnoBJ/2q244s
         IEVpdZ1cJaRT45tkqtDbzwMlDe9OgzZNa0XTBi24uFpqeiQCR9N7rSabQdwKdhIAKBWN
         MpnsWaBNEEA/IUvSR3Oj2EGcXhcbrjPNJTDqk9Otsq2EM9XHUFNoVK1Xae9Mq8NUyHrK
         Rciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=QjR9CHStX334fbwzetA4JhP7OKfPG7A+EQPTw7lB/S4=;
        b=eyyAKtXval5kXnWTzIydWfCwZsk9ccXuO1KQkWda2X1FOTrVnvIbws+Hn8z5jNuRuQ
         kVOC959Nb5ToWJDNdBW2oJT/ls5iftnkur+vqCPqx8F0SyFR+QKI1P0oCiYX6xaeDpdj
         2uVsxSOPHGWaJhmA55nGpfCemY2ifR+17KVT7POOITAR5qbcd49IjdFzyQYvhN8qrU47
         AN4byIzh1Ih31SROsBGxbyWgQ+BzB37vwxAST2yXncYsd2lzynThod7HLNntecUdDydc
         eg77Q93oCb3fH+IAWY3bAVF387ka3T8x+4ZpU4h1LC8Bdkq+E0/zeEVKXGqbAGaP7ZjW
         gP/g==
X-Gm-Message-State: AOAM5324Vi4gRMaZSjgx4GPUA/h0tfnpP3glfniIgOYfyY+Yhm+ajzmE
        c7pgL2i3TO3SMlYF5GhQdyUUouDL6axpgw==
X-Google-Smtp-Source: ABdhPJxoBwq023skEPvxoKjRxhX/xQFQRFyR/Kit+PQUWqbfR4qkOOZR8I2vl7Yr+HlJ3b91Aup4kw==
X-Received: by 2002:a05:6214:a43:: with SMTP id ee3mr10785278qvb.61.1620405665041;
        Fri, 07 May 2021 09:41:05 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id z4sm5089727qtv.7.2021.05.07.09.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:41:04 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 12:41:03 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 16/33] cyclictest: Record start of test
 execution
In-Reply-To: <20210320183829.1318-17-dwagner@suse.de>
Message-ID: <62c63ad8-34b5-1882-d272-bf8494d08b62@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-17-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sat, 20 Mar 2021, Daniel Wagner wrote:

> Use rt_test_start() to record a timestamp when the test starts.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/cyclictest/cyclictest.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 3f3b91bab53b..033b95a3a19a 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -615,6 +615,7 @@ static void *timerthread(void *param)
>  		setitimer(ITIMER_REAL, &itimer, NULL);
>  	}
>  
> +	rt_test_start();
>  	stat->threadstarted++;
>  
>  	while (!shutdown) {
> -- 
> 2.30.2
> 
> 
Signed-off-by: John Kacaur <jkacur@redhat.com>
