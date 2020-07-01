Return-Path: <SRS0=+yQN=AM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C226C433DF
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 Jul 2020 16:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4322120781
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 Jul 2020 16:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3BWZwVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbgGAQYc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbgGAQYb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 Jul 2020 12:24:31 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D095C08C5C1
        for <linux-rt-users@vger.kernel.org>; Wed,  1 Jul 2020 09:24:30 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id u8so11241689qvj.12
        for <linux-rt-users@vger.kernel.org>; Wed, 01 Jul 2020 09:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=BEiaBssbQQDz+PDczgT2BscbDK6atZ01QexuZxA2B2A=;
        b=G3BWZwVc5iX9C1T7lBFviLTFDyFBwO3iMvNvjVAb8Csfsvlo5yQ/G30RIrqVU/FPsg
         0ZIrs7nGLCSxXB/NHNgcYv8R/0be3bAVwS0kh2eed3a7WRtXm+UmRbZkMF4x7Mftpo3M
         aZok8jIArVJ2NkAaiPkzszRCJitZ9G+xUp6TvOMeOKxBQjKZREVQwvJESSP+iKreCF9V
         m1Wxx4N0ieQ1sz/NP6xAakSknXJfCpZmnbTo0mp9NM5Fm57asoY4mybDJi0kRQMxxBRN
         KtbmHzHXr/37w4D80LZCSc4wWE9QeZQjwtUyplHVptfrI0xhwnquP6Bx+fZcbeO/+c79
         iMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=BEiaBssbQQDz+PDczgT2BscbDK6atZ01QexuZxA2B2A=;
        b=K0q/5tUEC2mxaXctfggP+0Niq4GnEAGkfgisFAhZDOOrj8lE3Uzbj1GSSxIOkjp1AF
         aFRCh8vSRrXu/WpFDno6kiArGicCW17HHZG42YzOGqtHhC8LnKkV/f47ZD3M1vrhyHeL
         zdhtCbsgv/fVgMkl8T/FVzMGeWLUjwNDBJ34DUgDjTSNG/3bMd5094n7Eq4Zpq4umDHB
         rRWp+dbrXtz65Nxj06taV1uPP5K2DWWFc/X8fouUH3iLVdkUz8OFQ0dF9/YE86tiuJ6a
         P51MGNHr9pLE9w3GEkuQkEszjd5pATZjZP7BasqkGcA8LkRfyVN54KF8VVhHSlUCWy6N
         qUhA==
X-Gm-Message-State: AOAM532r2ytEgVoorlxio3WWvtWLW4DXXhSLKRPwUYFSbxSalK9/0ebH
        2Hzyn3Hb7nFwsMiBuyf40iA=
X-Google-Smtp-Source: ABdhPJzF+aZ5bXCK+45dFdpIZ0GSnNLt016bQqXFF+R0k+3t2oQF/Og2+gtPVfRWvyib1C5jB1Lf1A==
X-Received: by 2002:ad4:510e:: with SMTP id g14mr14193798qvp.111.1593620669608;
        Wed, 01 Jul 2020 09:24:29 -0700 (PDT)
Received: from planxty (rdwyon0600w-lp130-04-70-29-134-36.dsl.bell.ca. [70.29.134.36])
        by smtp.gmail.com with ESMTPSA id b22sm4909204qka.43.2020.07.01.09.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 09:24:28 -0700 (PDT)
Date:   Wed, 1 Jul 2020 12:24:27 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Yunfeng Ye <yeyunfeng@huawei.com>
cc:     williams@redhat.com, linux-rt-users@vger.kernel.org,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
Subject: Re: [PATCH] rt-tests: cyclictest: try not to share the same cpu with
 main thread
In-Reply-To: <60c13be0-76ad-5d95-f8d5-124cb13d0561@huawei.com>
Message-ID: <alpine.LFD.2.21.2007011145320.7008@planxty>
References: <60c13be0-76ad-5d95-f8d5-124cb13d0561@huawei.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

<

On Sat, 20 Jun 2020, Yunfeng Ye wrote:

> The main thread will interfere with the test thread and try not to share
> the same CPU with the main thread when the number of thread is less than
> max_cpus.
> 
> Signed-off-by: yeyunfeng <yeyunfeng@huawei.com>
> ---
>  src/cyclictest/cyclictest.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 989113fb3483..b3d72caa10ce 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1080,7 +1080,8 @@ static int cpu_for_thread_sp(int thread_num, int max_cpus)
>  		fatal("No allowable cpus to run on\n");
>  	}
> 
> -	m = thread_num % num_cpus;
> +	/* just don't try to share the same cpu with main thread */
> +	m = (thread_num + 1) % num_cpus;
> 
>  	/* there are num_cpus bits set, we want position of m'th one */
>  	for (i = 0, cpu = 0; i < max_cpus; i++) {
> -- 
> 1.8.3.1
> 
> 
I'm not sure about this one. It would work, but the purpose of the test is 
to make sure we get good real-time results despite the other threads. Plus 
we have done it this way for so long, and tools might expect things to 
work this way. I'm inclined not to take this, even though your idea is 
correct, although note that you didn't apply it everywhere it would be 
needed.

Thanks

John
