Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A823C433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 29 Mar 2022 22:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbiC2WVI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 29 Mar 2022 18:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236608AbiC2WVG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 29 Mar 2022 18:21:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCC6B4133F
        for <linux-rt-users@vger.kernel.org>; Tue, 29 Mar 2022 15:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648592359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2AVT9NIxWV7b7zLqUQtMxEUF/d2SgBDH5G5+pu2PC6k=;
        b=B9Ced1DiJRW47dlSm0bZuYyP3iUu2igGV3MtMpdmBE23IBvb/0AESGVqQCJYc1/UGJf8Ah
        MQ0OwITxWi0gnRZWhge4v+5EcsYVKjVa2nXH/9DAaLB+wWmmHecP/Su9PaEKPoMXx+xqbi
        51FZCnxyVXYDchJ+EhEA/D+Uwezk0Rg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-oSQArG0OPK2puOdauNo0_Q-1; Tue, 29 Mar 2022 18:19:18 -0400
X-MC-Unique: oSQArG0OPK2puOdauNo0_Q-1
Received: by mail-qk1-f197.google.com with SMTP id q5-20020a05620a0d8500b004738c1b48beso11427258qkl.7
        for <linux-rt-users@vger.kernel.org>; Tue, 29 Mar 2022 15:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=2AVT9NIxWV7b7zLqUQtMxEUF/d2SgBDH5G5+pu2PC6k=;
        b=eQ3cbEB9Sqp0rJIaSjxYA5S0khkgMMBdH3GESZldZiiYaGKWX9SkzAQbUJCmvf3hy/
         KJceibfi+QcrcAcnOu++4mci4BUyKVMRVGmjmywQAATYH8QC272T+2mgGZn4Au0HlzQn
         fCUUrgnoE1ThJRZcgE4z26wtxxWyH1MMwR40pyzKxOGvaiBSY5GpAqJ5xXIMsEHWkyER
         7FMUBs4FF9BUa3g68gNQ/KFi86lZ/M84quKtgEieGo1T0qaPZx/pabgDtv+1c1fSCn30
         rrNA6h3U8NQpibWFk9Vrb7vDLUhc1ZXbO1b2/s8lWy72O4qdruFWHvNaXzKgwuox5Ar+
         errA==
X-Gm-Message-State: AOAM532bSjo1GT1PGB85c7jGe65rdns3GHjAvGVknof/+Se7jQ2xQvTV
        MzNxokLa+9PJO4sEmprOFOgTJHf92hcKQ6avpk1hj8vy98s6cFiViA44CytHuVvd7FxzvgWLJK9
        b+ZbrRs4oSSZNIblUuuJYz/sBRYA=
X-Received: by 2002:a05:620a:2981:b0:67d:6a35:70f2 with SMTP id r1-20020a05620a298100b0067d6a3570f2mr21692252qkp.404.1648592357617;
        Tue, 29 Mar 2022 15:19:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNfg3ziUCvSMGXlM36yI2dxPI8NKJKngzyPd5pTWMW9/hCVp6MehZSlnT2H+KggDUaFgkIOg==
X-Received: by 2002:a05:620a:2981:b0:67d:6a35:70f2 with SMTP id r1-20020a05620a298100b0067d6a3570f2mr21692238qkp.404.1648592357355;
        Tue, 29 Mar 2022 15:19:17 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-127.dsl.bell.ca. [174.88.121.127])
        by smtp.gmail.com with ESMTPSA id o6-20020a05622a044600b002e1b9be8e6fsm15630751qtx.36.2022.03.29.15.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 15:19:16 -0700 (PDT)
Date:   Tue, 29 Mar 2022 18:19:15 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Bart Wensley <bwensley@redhat.com>
cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Daniel Bristot de Oliveria <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: Cyclictest doesn't support --smi option for ice lake
 processors
In-Reply-To: <CAGCuPdNVEtSk0jqL+74RiV5YcHmdHzsAOcAu_DqLSdhh4h6-aA@mail.gmail.com>
Message-ID: <383be4c3-c1ad-3b60-dd32-71b8d04e814f@redhat.com>
References: <CAGCuPdNVEtSk0jqL+74RiV5YcHmdHzsAOcAu_DqLSdhh4h6-aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 28 Mar 2022, Bart Wensley wrote:

> Using the --smi option with cyclictest on ice lake processors gives
> the following error:
> FATAL: SMI counter is not supported on this processor
> 
> It looks like the ice lake model (0x6A) is missing from function
> has_smi_counter:
> https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/tree/src/cyclictest/cyclictest.c#n410
> 
> Before submitting a patch for this, I was just wondering if there was
> a better way to handle this than having to update cyclictest every
> time a new processor model is released?
> 
> Bart
> 
> 

This function is based on turbostat in the linux kernel. It hasn't been 
synced in awhile, so, if you would like to update it for ice lake
then please update it for any other processors in turbostat as well.
I think the function to look at is probe_nhm_msrs().

Thank You

John Kacur

