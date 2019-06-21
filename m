Return-Path: <SRS0=sCGC=UU=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2104C43613
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Jun 2019 12:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F58A2084E
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Jun 2019 12:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aX9ICw6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfFUMIL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Jun 2019 08:08:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54642 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfFUMIL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Jun 2019 08:08:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id g135so6095075wme.4;
        Fri, 21 Jun 2019 05:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=POlTtNJe8i4EyB2J0dXIX6qA1ovmeEXANz2w4jxAvWo=;
        b=aX9ICw6U5MSGkcGoawKALCmi84pOuNi8sHD7srb+00gG/yMN+DYCKEX/2H9sPUEmv6
         GFQVpJc6dRzWFFNx6VtJcDLGZiH/OSVk7QSoN0bHoHPntGJXssO/3/vs3EJ9PkDq2blh
         CKUS1dedd02/WzmcufMN0OKRrCIJII+gPfq1aasDbemBaaZYZi7FYJflhPNB5KeJG5rb
         VZBHS1AWxKnk8fbet1jnqlyor5Crig7x1mgR0+kYw2kcjM5H/GcJkVQTo6rzNibWRLlt
         2A2voQC5IhiaBOm4iDf+9+lEn7MpmSk4UMlLw0UnnbIYXE7ABqilsRIk4xlsnLbI88X5
         uyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=POlTtNJe8i4EyB2J0dXIX6qA1ovmeEXANz2w4jxAvWo=;
        b=RWbnnxe5VKfVqOIFV1908okdX09QZvZ3qO6cy0G5YLZGWFrMaOLcI8kgifVjqarCC8
         BSJl/MZbJq5oyzRFtGZIzme1rT1cS2wF/Y5tnFdhoZp4wwdMdVj2hZtGdjn9+SQxangv
         M0+zZivj1Tbl10XnkWMeVtrQEtGz9del+3s/QEQwEgjtT+XNC9pH4vOuiCGdR84Je5/n
         oX1G5vN18vxtB3PCQrRS0Io05kcv4tdhOok6peFuqEAM+Dt79nhrwUNq01vgwXeoog8Q
         GiuXkct0SDxgr169XrzPJ3MRd/FlObn/VLZ+m7luH/3E/OBKU3q0lCqgxYz1EsnDxiCb
         7mDw==
X-Gm-Message-State: APjAAAWlOApvodbd7l+PUNu1i9kUNzQ17CeTbjxyWGD2XnILRSaiZHN9
        X/kSzn07ulIfIMYH/oAIcpU=
X-Google-Smtp-Source: APXvYqzub0N+WsXm4k2ccoqppi8JP34Xt0GhFOXLDfgKZaHHKHoEswJ7pEl/Ij0XFmwMTWQRSvCvdg==
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr3747753wmk.99.1561118888896;
        Fri, 21 Jun 2019 05:08:08 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id 5sm1833234wmg.42.2019.06.21.05.08.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 05:08:08 -0700 (PDT)
Date:   Fri, 21 Jun 2019 14:08:01 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     David Runge <dave@sleepmap.de>
cc:     Linux RT Users <linux-rt-users@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Clark Williams <williams@redhat.com>
Subject: Re: [ANNOUNCE] New release rt-tests-1.4
In-Reply-To: <20190621065807.GJ20165@dvzrv.localdomain>
Message-ID: <alpine.LFD.2.21.1906211407410.3661@planxty>
References: <alpine.LFD.2.21.1906201444220.6702@planxty> <20190621065807.GJ20165@dvzrv.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 21 Jun 2019, David Runge wrote:

> Hi!
> 
> On 2019-06-20 15:26:30 (+0200), John Kacur wrote:
> > We haven't had a release in a while as people were content to work
> > from git. However, in order to make it easier to use, test, and put
> > into distributions, now would be a good time for an official release.
> Good news! :)
> 
> It seems the tag is not available yet (according to `git tag -l`).
> Could you add it? I would like to package it.
> 
> Thanks a lot!
> 
> Best,
> David
> 
> -- 
> https://sleepmap.de
> 

I just pushed the tags, let me know if you can see them now.

thanks

John
