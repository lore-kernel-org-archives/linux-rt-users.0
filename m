Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B05C433ED
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A900613C0
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238206AbhEGQcu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 12:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238201AbhEGQct (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 12:32:49 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98989C061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 09:31:49 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 197so9013653qkl.12
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 09:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=ztTw/uNuWFuq0rp2IHCYuj23sJ1knaEdU9UHlSPYDxs=;
        b=vXvn+fDeRcDy/d0A/QM2bhVl+zaLSe7cal+X/71BjclZgxUCAhs1NL+ccCm9hHF4UL
         SBV4cq92opD39KNCOPobCdmes3cASfW89s40DIVqTqb1C3zU3mAPGQ/9jkPQrKflMt4F
         6qPp5cHu89Wp2t/DaTmzCo0+hdaNLi1LtNrT9MlhllX/e9tgKcgXCttV5ZefW1enn24Y
         oPwpDvDe5MTtmJ7BiBRwAbyTXcKkVs9usnx+BsIboLBBkgghkdbG4DOD/PU9Mtqg1Ejb
         /AkYii0xjRhtQuu6AT7oALFQNzjXJ5y5Je0VACEsj0zcQB/ETnrg0sOZ96CNyS/o+kKF
         B74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=ztTw/uNuWFuq0rp2IHCYuj23sJ1knaEdU9UHlSPYDxs=;
        b=kbVJne4sweZefVm10Ybpl+Duq9dFN5kbWKGubMP+JeiNgbhOzHuiG9ZuWRDN2U7dNm
         sosm7trUdyXVyr2BVG7atieVIJR7/nbWXCD6Uc52/1npnzmhADZzMnZLoLP3Xtio29zb
         qot5Y8o5xfNSxGfBYPaE3Sj0EZ7AhYmv098mSimXRDrXCgEbsbndGrhXg6dzLFSZJMt5
         i0pekmBNkO7HxxUCIfIJBA0ko5K2OcZnka1NlKcjAm9/Mw3daaSHd2JmZHgKjcTwtLlo
         HWZV5iDPRxWKNKq2x/thlsRVEj4V6EVzh9+O63qVAck/8qdr/bKuHZ+1r6VkwOlHB6P2
         WYNg==
X-Gm-Message-State: AOAM531XjalqZjwkg5IRFNABMIoYMQr2y20CrQYrSy1Ng5qiiRyNJcuY
        1ZqwnnNoI2jgk4sUsj6Dyzk=
X-Google-Smtp-Source: ABdhPJwQOB4sZkSL8P2SmHKqkJ9U33luU5KehjP7zk3FcvjWSIBu7NoEHESVmGpk26/I4qRAEuYYXg==
X-Received: by 2002:a37:7246:: with SMTP id n67mr9887162qkc.71.1620405108938;
        Fri, 07 May 2021 09:31:48 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id t18sm5222833qkj.75.2021.05.07.09.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:31:48 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 12:31:47 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 10/33] cyclicdeadline: Initialize rt-util
In-Reply-To: <20210320183829.1318-11-dwagner@suse.de>
Message-ID: <cc5db426-30bf-4f2f-e55d-acc30247390@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-11-dwagner@suse.de>
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
>  src/sched_deadline/cyclicdeadline.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index d7aa9bb5d269..13a1812c13b3 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -1009,6 +1009,8 @@ int main(int argc, char **argv)
>  	int i;
>  	int c;
>  
> +	rt_init(argc, argv);
> +
>  	cpu_count = sysconf(_SC_NPROCESSORS_CONF);
>  	if (cpu_count < 1)
>  		err_quit("Can not calculate number of CPUS\n");
> -- 
> 2.30.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
