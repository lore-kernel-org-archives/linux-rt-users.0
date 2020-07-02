Return-Path: <SRS0=9hME=AN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A03C433DF
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 Jul 2020 18:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC4E020772
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 Jul 2020 18:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGPyqmlg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgGBSku (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 2 Jul 2020 14:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgGBSkt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 Jul 2020 14:40:49 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67F6C08C5C1
        for <linux-rt-users@vger.kernel.org>; Thu,  2 Jul 2020 11:40:49 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id g13so22052493qtv.8
        for <linux-rt-users@vger.kernel.org>; Thu, 02 Jul 2020 11:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=nE28S4ikk/2uIhEX0j1rCt27uBSNQzr54IH4m73vb2c=;
        b=MGPyqmlg+U9ntCdGV7g7oO2B6r0ViJmTa5up5y192nAVcPsRqOYQy02j1+TzizU6wu
         3hVY1DDFbbBGk2FUBCKNRAe6PzFDJKTUmdKNpfqqvSfZteRBA4gbR/nJ3I4LfausiIj2
         X4KWxWXNH/lDlRDcHREmk1mC5KIGv16rC5loydIcptN7plgISEkKJg1p2vpRJqqoarKx
         Mrf5rCbvS2MB+5XecrcBAiX4+fYy0+HPSL3WVEF9BYZ+zIkPPlYoc1W/21+44ayPQj/e
         UZpjK0te1d5mawgTOEnYH3yusBvYX3lVwLajwo7id+Ll0bFEH2GWQzBWEhQ7zgSUQtFE
         F1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=nE28S4ikk/2uIhEX0j1rCt27uBSNQzr54IH4m73vb2c=;
        b=KiSz6U/Jd+d33RF54HN7Jy4JlIAQfZwXmztMgSPolBADd8FJjHmz6xP36aSXm0YLS8
         XlLLzXBm5wrKLOIx1K+pZQ6uh0SHKCVy9w21lone92leHtAWiCi+Im9HpcJm4Lhe1Ajt
         vnQoHiyyg61XTI10xdI7Pj6FMqFYCzNXOpBUyDRajl35K8DYkRmeC+4bShg40G+ihhzf
         NRNlceyj6F252wuGgkKssrduLq2v1fXE6DLVJSs4NlrxI9YdRhEM3otW4yyKLcl1jRPN
         j2106kTtEylK/xgqTXGpFUlvg32hyii+0L9ny/nlJv0if19kmdPMjRTGdDko2Jmu09Tl
         MNdw==
X-Gm-Message-State: AOAM533rgftIQMRAPo314tPotYbaGzXc+hTqe8tIr76pkAZugndza1Tb
        +rut5Eu/6El09jwSjE+lrWw=
X-Google-Smtp-Source: ABdhPJyst/d9r1sNo0roMuf+lhRvPDebmh3zImzM7NTgIXBRjlXNupaq9sw3vE7vsG2KSP/DrhmGRw==
X-Received: by 2002:ac8:3893:: with SMTP id f19mr33532764qtc.184.1593715249104;
        Thu, 02 Jul 2020 11:40:49 -0700 (PDT)
Received: from planxty (rdwyon0600w-lp130-04-70-29-134-36.dsl.bell.ca. [70.29.134.36])
        by smtp.gmail.com with ESMTPSA id s46sm10145071qts.85.2020.07.02.11.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 11:40:48 -0700 (PDT)
Date:   Thu, 2 Jul 2020 14:40:39 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Yunfeng Ye <yeyunfeng@huawei.com>
cc:     williams@redhat.com, linux-rt-users@vger.kernel.org,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
Subject: Re: [PATCH v2] rt-tests: cyclictest: remove the debug log "pid =
 xxx" in rstat_shm_open()
In-Reply-To: <62b7d30b-14ce-b340-a6f7-cf6abcf3a6f9@huawei.com>
Message-ID: <alpine.LFD.2.21.2007021439180.7503@planxty>
References: <62b7d30b-14ce-b340-a6f7-cf6abcf3a6f9@huawei.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 2 Jul 2020, Yunfeng Ye wrote:

> The infomation "pid = xxx" is printed with other infomation on the same
> line. so remove this debug log in rstat_shm_open().
> 
> Signed-off-by: yeyunfeng <yeyunfeng@huawei.com>
> ---
> v1 -> v2:
>  - remove the debug code
> 
>  src/cyclictest/cyclictest.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index b3d72caa10ce..8353f561bb46 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1910,7 +1910,6 @@ static int rstat_shm_open(void)
>  	pid_t pid;
> 
>  	pid = getpid();
> -	printf("pid = %d", pid);
> 
>  	snprintf(shm_name, SHM_BUF_SIZE, "%s%d", "/cyclictest", pid);
> 
> -- 
> 1.8.3.1
> 
> 

Applied, thanks

Signed-off-by: John Kacur <jkacur@redhat.com>
