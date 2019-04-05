Return-Path: <SRS0=lqhu=SH=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964A7C282CE
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Apr 2019 16:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C772146F
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Apr 2019 16:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKWMY8iL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbfDEQ1o (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:27:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37462 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730870AbfDEQ1n (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Apr 2019 12:27:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id w10so8753630wrm.4
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Apr 2019 09:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=juLdakmdu5HzqtzI8bfl5Og9a4tTlIX/MF+EteZj37M=;
        b=RKWMY8iL+SIeInZ3bu4E02SqEa6OEW4nxTc1n1I+gKJXWGL9SHsFJRmdvikFvk5B6b
         OWETl+I4BWeUK97lgwa3gDOkLBbHIzRq58R9SsNEAIcg7Diy0EczNzRlaieyF0AR8WWR
         Y3Tf+nhTLWhY/X8G75dDUTQybRx9oBfEXDKRBcc+6id5MLGGYM1no21eXVQBEw0xbMvy
         SwhtxInGvVhSAPrRXjs9Q0vT/dLJWkKVWyEe6L4GlfJO8ONtJKndVuYCiNohQ114UVip
         BQDU50uN95B0lKsEGuPeMxqgP8VhW0nXWfck+lD/d8jIjoZWSNSiM5zQfe8UG3rXf3gh
         YzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=juLdakmdu5HzqtzI8bfl5Og9a4tTlIX/MF+EteZj37M=;
        b=uXf3CGwOV7HWZMkT79mWnt1z32vcXspbKwGXoibDGUW0nQQfjJS02bMYZWSGbKNugx
         Y4Dd5l1VDTOgQteBXzC+RZIKIdKy41dp+434Wfvq9SVQsx6F+iLbnOLzK1Sy99VgahAH
         KU2OBEtVD/SougzNky+1wGxpDiB6q5wdqBjgMWrys5jul1+yHuPGQQobr2PuNFd6JbFJ
         3Ac/qK3iaxZlk/Lw0aptZgmK3GiM/KGDhW+LGFxZ85+gDrZzcNmBHzAGF0wNg3a4JD8z
         c1WaVNcHWGh7nMNXP/WzTmAaQDEX7MoBaUdsXVOVDurc+SADgeC314W70QzXc7PTgUKd
         J4Yg==
X-Gm-Message-State: APjAAAWkygT3ssDJE4QuYzM3aSDKvWFgdVlFL7qtfbDhQ5ScwJv0xsdm
        ymOtAVGr2e/FhIIXmVkEa2s=
X-Google-Smtp-Source: APXvYqxQyZ637PeRxgmhDg8wUDWmm9xpZyWLHD5N7FAyn15mx7IoA3y+BbWHlpEFCHbSSWZyPYMMfA==
X-Received: by 2002:adf:f1cc:: with SMTP id z12mr9456970wro.180.1554481662136;
        Fri, 05 Apr 2019 09:27:42 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id 4sm2258035wmi.14.2019.04.05.09.27.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Apr 2019 09:27:41 -0700 (PDT)
Date:   Fri, 5 Apr 2019 18:27:40 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Daniel Wagner <daniel.wagner@siemens.com>
cc:     linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 2/4] deadline_test: Fix stack corruption
In-Reply-To: <20190312172436.18314-3-daniel.wagner@siemens.com>
Message-ID: <alpine.LFD.2.21.1904051827150.8480@planxty>
References: <20190312172436.18314-1-daniel.wagner@siemens.com> <20190312172436.18314-3-daniel.wagner@siemens.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 12 Mar 2019, Daniel Wagner wrote:

> The buffer is too short for the string.
> 
> Signed-off-by: Daniel Wagner <daniel.wagner@siemens.com>
> ---
>  src/sched_deadline/deadline_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
> index b213c206559c..1b72c6097a87 100644
> --- a/src/sched_deadline/deadline_test.c
> +++ b/src/sched_deadline/deadline_test.c
> @@ -435,7 +435,7 @@ static void setup_ftrace_marker(void)
>  {
>  	struct stat st;
>  	const char *debugfs = find_debugfs();
> -	char files[strlen(debugfs) + 14];
> +	char files[strlen(debugfs) + strlen("/tracing/trace_marker")];
>  	int ret;
>  
>  	if (strlen(debugfs) == 0)
> -- 
> 2.20.1
> 
> 
You beat Kurt with this patch, but his included the null byte, so I 
grabbed that one
