Return-Path: <SRS0=4xIy=WT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B27DC3A5A2
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 15:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9AF2133F
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 15:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YD5uSz11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732750AbfHWPG0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Aug 2019 11:06:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37403 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732470AbfHWPG0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Aug 2019 11:06:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id d16so9440855wme.2
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Aug 2019 08:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=hHC4OhFYP5cvDt6LlCCtqlQVO/8Rvu+QX3hpl8ApTNM=;
        b=YD5uSz11H463zW3twDnUClu4LOF1rbGY5BKQ3+DGbgCdkyO8dlC1o/xSiywnW+9/1F
         RXSdBlQFU/K7awQupzdWSQultAEtD/hmdsHUwjy/BPSMzlwa2ptPnqXO/E+MC6HQba9E
         sy7zCuc67G3SyWqFsOMzypOhA0rYRfoC1CQAJvWcq43Xp83e7os6qEP6ZH8N72cDs+B8
         eIOCXa4lOIiLIEVO0IUAOEkPpG67VOTTeFGX/yOy44nGVi9YxMRsPSZbWpNtw/Ke7lVP
         VPOZ+UtGLnGm3nJxfBaIDffa21Klyk5HhJVcLIFN9HOjy4HUrokdTZNjEkpt04ijsYND
         cxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=hHC4OhFYP5cvDt6LlCCtqlQVO/8Rvu+QX3hpl8ApTNM=;
        b=VeGdGyokIJcvyvZYPqUoXe4BvrsWUMOl1q+Szphx5ZbqZJ3uKZgpbG0lUdNWZyUbLJ
         397XclhdBv3YX41nAXZry5LF8QlbYcqN9Lpiiw52JdhXrSqybf4nqN5SVtiepkdVQ4ag
         O3CxjkGcIbf5kzz+P2EQqOJK0X0i6C9bXU6+LAYAF75HOMOE4vrglwLRqicAki9kN+9o
         nH5HPr6z92J3x/CLZzI2bQAIsceMQ2blkC25b5aOU3yCRQBFyn4LheZs3E7IF7VtuQZM
         QJOx2mN12NkqYC3S0cP60WjQyLJtKacNs6+Ygatalttk9BjrMbPZJeC0TLQeGtOLgktC
         klvw==
X-Gm-Message-State: APjAAAXxmpCYZ5+Jby3+xxsTaTA/7HdetjCTDRz4k3Eei1YVKU9nJpWk
        fOqsmlP1EVE9IxsAmo/h/i4=
X-Google-Smtp-Source: APXvYqyvLTaTVZnwa/eLfk4F+P6jjjhZmKnIVXdbdNWVCM+9PpR8d2HzaOmB1fp+fZTc2PKAaSV01A==
X-Received: by 2002:a7b:c8c1:: with SMTP id f1mr5322212wml.87.1566572784085;
        Fri, 23 Aug 2019 08:06:24 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:19dc:b567:5617:6bc1:51bb])
        by smtp.gmail.com with ESMTPSA id i18sm3751640wrp.91.2019.08.23.08.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 08:06:23 -0700 (PDT)
Date:   Fri, 23 Aug 2019 17:06:21 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Afzal Mohammed <afzal.mohd.ma@gmail.com>
cc:     Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 2/2] rt-tests: Let git ignore cscope generated files
In-Reply-To: <9365886de54b1570a82428bda0543d588e076e87.1566455869.git.afzal.mohd.ma@gmail.com>
Message-ID: <alpine.LFD.2.21.1908231706050.7154@planxty>
References: <eb3b222b7741d16bf45735f59015c40fcbb31ba2.1566455869.git.afzal.mohd.ma@gmail.com> <9365886de54b1570a82428bda0543d588e076e87.1566455869.git.afzal.mohd.ma@gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 22 Aug 2019, Afzal Mohammed wrote:

> Let git ignore cscope generated files
> 
> Signed-off-by: Afzal Mohammed <afzal.mohd.ma@gmail.com>
> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.gitignore b/.gitignore
> index aa9b82c..f7574ef 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -38,3 +38,4 @@ SRPMS
>  rt-tests.spec
>  tags
>  TAGS
> +cscope.*
> -- 
> 2.23.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
