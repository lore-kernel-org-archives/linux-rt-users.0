Return-Path: <SRS0=+yQN=AM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C763AC433E0
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 Jul 2020 15:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B32A207BB
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 Jul 2020 15:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUHyjYEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731823AbgGAPic (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731399AbgGAPib (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 Jul 2020 11:38:31 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6C7C08C5C1
        for <linux-rt-users@vger.kernel.org>; Wed,  1 Jul 2020 08:38:31 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 145so20099793qke.9
        for <linux-rt-users@vger.kernel.org>; Wed, 01 Jul 2020 08:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=XCy0V5WaFCVb7p2blQMH29XDNluyv23rNOIdSdrlAQE=;
        b=QUHyjYEalwyznnp/FP0dpuG3CSFtKL5lNaV5fAaooI4+R40EbsHObWObmfR11cXrQp
         wUoaE3hHDS3mEopYT21SuJknKvalUy9R68U3s9oWXySbA1zwYc2FfY+d9gASKVQKEWPA
         slQyzm201bYVVS9aNQLvoCF1LEyDiHqZtbnz3b9vRBLAPP6K4/MI4p0ADeemChYWTDZQ
         GVjY1oKKM1KWh64rP/U/DIXsle46GTeMElSFjnvCSec8dBiyEqzuwi+lu+7V6JOO9Txo
         nvvBYiwt1akrJVVRxUuMBZepfROvtbgksqIulu7fy2EayjAsV6jcHG1wDsUqpHyYqdKa
         8SZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=XCy0V5WaFCVb7p2blQMH29XDNluyv23rNOIdSdrlAQE=;
        b=HJBsJdigBVZhGPptjtnj8YpgcoPNxeIv/ccblyxH7iTNFuP95S2G5JH/KAlxAweA05
         Me4+BnuKykuI0ZiCup2xTErgH7tQAHnIoq5zVL20l4BQ6vOOK5CMlQk+HDcVNj7SLWQd
         jQTRaiX4xat32caqvjgLFVjNUbSOAu87heNwW3jS2pO+nC+DL29jwHre3R347kl0/GhG
         wTIl+1u9dwtng8EvJhgmc1JfntMM0kV3gRfuyWf73c6k1qdpoHUPO+r7/NTSayf4Ep7/
         nNqSkUGAfiYHqcWfc7NRKLlmg772wBJWjNfkJFcp19l0pSAzcA3BXnFpeQrvj5PaAJe2
         6e9g==
X-Gm-Message-State: AOAM532CdDbqOv1onQmAqEcJjk0JPO2TM8LmT+hibgMm21tInLerWuNp
        Xnap6vCCHoOrtLsvxqAdfS+zebX0y+c=
X-Google-Smtp-Source: ABdhPJyFZF7TdsBqNvWPv5/NXa4BNgDOWUawIp3ycS/LXVd6EA/Ciu1ddq1hIR5pDTEXGD3isLkGPA==
X-Received: by 2002:a37:5b81:: with SMTP id p123mr25556089qkb.150.1593617910608;
        Wed, 01 Jul 2020 08:38:30 -0700 (PDT)
Received: from planxty (rdwyon0600w-lp130-04-70-29-134-36.dsl.bell.ca. [70.29.134.36])
        by smtp.gmail.com with ESMTPSA id y67sm1682366qka.101.2020.07.01.08.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 08:38:30 -0700 (PDT)
Date:   Wed, 1 Jul 2020 11:38:23 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Yunfeng Ye <yeyunfeng@huawei.com>
cc:     williams@redhat.com, linux-rt-users@vger.kernel.org,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
Subject: Re: [PATCH] rt-tests: cyclictest: add '\n' symbol for printf in
 rstat_shm_open()
In-Reply-To: <b5d8bafb-6bd2-7fec-2f78-86c6d2508408@huawei.com>
Message-ID: <alpine.LFD.2.21.2007011137180.7008@planxty>
References: <b5d8bafb-6bd2-7fec-2f78-86c6d2508408@huawei.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sat, 20 Jun 2020, Yunfeng Ye wrote:

> The infomation "pid = xxx" is printed with other infomation on the same
> line. so add '\n' symbol for printf in rstat_shm_open().
> 
> Signed-off-by: yeyunfeng <yeyunfeng@huawei.com>
> ---
>  src/cyclictest/cyclictest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index b3d72caa10ce..d1c148563dad 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1910,7 +1910,7 @@ static int rstat_shm_open(void)
>  	pid_t pid;
> 
>  	pid = getpid();
> -	printf("pid = %d", pid);
> +	printf("pid = %d\n", pid);
> 
>  	snprintf(shm_name, SHM_BUF_SIZE, "%s%d", "/cyclictest", pid);
> 
> -- 
> 1.8.3.1
> 
> 
oops, that looks like my debug code that I forgot to remove. Do you want 
to send a patch removing that line?

Thanks

John Kacur
