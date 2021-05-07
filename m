Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8C3C433ED
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2CDB6144F
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238187AbhEGQaw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 12:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238184AbhEGQav (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 12:30:51 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A86C061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 09:29:50 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id q6so5094196qvb.2
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 09:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=laSWqi9PcuhCtt2UTTlMC6XPYAzlNsm04hLQoY7Z/so=;
        b=No5VgVFGsBQ0wwTLDEossdY8oFxVc51apBMl9hTHJZsW/lUGao1rXI4SwpVs8KUu+r
         +j8ll/KZ/qyLTELTdyMjigH7j8ERe0jVId6a1CoXaqHBdIxXpf8pFbj8SVhtY1fDuB+5
         In27S6kRfUqK5jDlrXi6mZQXntNj3i0rYus4itVk+3KIQJ/RCsTBXlqaw9QfAWL3dnoA
         ZagFocYPgr0bpVvk5eU8wc96koU5uYf3oAM/ddRT273DeelPSO65VigzsQjLvbCuFyBI
         mLJh/1h9pscKRXV8xyIpzpaVrv6suk90iRBFI2KxIk/VmbExr6fFrJciZHqlk78EpM3e
         3/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=laSWqi9PcuhCtt2UTTlMC6XPYAzlNsm04hLQoY7Z/so=;
        b=WWwjz/yWFZlMAUOiV7gVzGFCcxEYxWxOgCCvL9/ECWnbonyXxQ8RtepB/uNx0DXUE/
         O3Jv1qaMHcIy/ODXlSo9vrtKfmKMzkvJsel9GnOtKHBSzOf6eUBYKX+wNurpfklLvWyA
         F4ujCxe58lTQTuGLBmxKKnTuHHaAwwVIG+JZuJxDJTxuuqOd5/kW0W+tvHs6OojJYdYP
         TAcGBoGHw1iboxCN8epOgq9aEKF4qwGLDQyafDR5/8vbZjB3awU72UPgq5W6NJ6KNWVm
         XdS5NBsTYGQizE2Mvt+f7i4t0j9MmCvwQ8fx7mte0R0iXSN4XT+aif5q+QsO4widcp+G
         BpqA==
X-Gm-Message-State: AOAM532XBUplwTRI3DZPdkpPbZgmkqR86i4bQhgceavdMrEWh+Vmen9/
        XUKfFlk/7Ir+9rScQaXDviY=
X-Google-Smtp-Source: ABdhPJy5/JmY/5T9edWabT3g9IOg3Yaz1muubFfxFhP28ZgMbST8COc7OD7pkZs4GxWec2x2Bnq2ew==
X-Received: by 2002:a05:6214:178b:: with SMTP id ct11mr10769921qvb.37.1620404989709;
        Fri, 07 May 2021 09:29:49 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id o12sm5281022qtg.14.2021.05.07.09.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:29:49 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 12:29:48 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 07/33] pmqtest: Initialize rt-util
In-Reply-To: <20210320183829.1318-8-dwagner@suse.de>
Message-ID: <2786177c-e02b-996a-bfde-ce2b1ae57f1@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-8-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sat, 20 Mar 2021, Daniel Wagner wrote:

> Allow rt-util make a copy of the command line.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/pmqtest/pmqtest.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
> index e1f59836ea07..aae3c78f8a0a 100644
> --- a/src/pmqtest/pmqtest.c
> +++ b/src/pmqtest/pmqtest.c
> @@ -502,6 +502,7 @@ int main(int argc, char *argv[])
>  	mqstat.mq_msgsize = 8;
>  	mqstat.mq_flags = 0;
>  
> +	rt_init(argc, argv);
>  	process_options(argc, argv);
>  
>  	if (check_privs())
> -- 
> 2.30.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
