Return-Path: <SRS0=0Kbd=XM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABADC4CEC9
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 14:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5020E21852
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 14:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASWI4Q3C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfIQOOd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Sep 2019 10:14:33 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35334 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfIQOOc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Sep 2019 10:14:32 -0400
Received: by mail-qk1-f194.google.com with SMTP id w2so4175318qkf.2;
        Tue, 17 Sep 2019 07:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=QSCiIQtdw+qUPAvKfQqwKrA3+KoQs7hg9t8yi5+zFjw=;
        b=ASWI4Q3CUvxYI/rpGXBkKaupvndARiKMb2R6QxzoUfYSQ52zTWv5Kqc1HImsQlGhyr
         rzUv/1n9GOuddeHOwooJCt45nGT+m2ObQVLpWEY1QQrESWU18K8WX5NH8Byh5KOY06Xn
         IvCl4nFGCmTBAD3OykmorAC8wGoMjmqB1zbF1+/A2UInP8OXWZaOWQEqDqVGEwgLK968
         xoiH9g48DX4PeSg+z0t/+nEgWAqpPOi44rckBXowCYcNFraln0B4Szb3/TlPqiPWkKU5
         zm2pZIcyahWEKkqtzi+aGVdRUoX2Sxbv+g6MxCi+B7OXiVZsNltJLU5K5USxau8u7Sk6
         CdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=QSCiIQtdw+qUPAvKfQqwKrA3+KoQs7hg9t8yi5+zFjw=;
        b=ixTi0T+h3nsNMKa5kCVlJbZlf24md8krb91hhcHm4VuHwGynhsni1Le8AD3cFpaDZ3
         8NgTHR2+xvMaRIjxsh2IZSLFXBtGKGh3otTWWBY5Lnzh6wjZsKI/eteXwHzzFVVYWIN/
         sOcJm+CnmZZc52pXm5otVE2AhdKbX/7q8xTKR2/+pQY+V5M57e2ClqRjlUCcpydJCegz
         x0eUx5jBj9rCokdWXCwiI9amgbR5q2foptjA/d2s+gQen58VCePSq1rjqVT36HCUGgiO
         Hcsl4cC4Zu6PbWnn+fbGYcWwEhj1mZQX9NJKx1NlQTQfnYTJ54xfcBSGbHaHWtAE7eQL
         AYpA==
X-Gm-Message-State: APjAAAX0b/1lSTpafY2CKLqLnOotjcQIIGiwyhKaYyX68v24J26F9HVl
        3YQBrSCRRLdCVA+NFqb53Gow58mHkJfIPA==
X-Google-Smtp-Source: APXvYqyxTuQp3XVsYoB4NNFKSASJ6kU6iUeBF/q+3WtENKOKTZpWfvLfImN4GXB8VBFRkCttpRhVtw==
X-Received: by 2002:a37:7ac1:: with SMTP id v184mr4069319qkc.129.1568729670950;
        Tue, 17 Sep 2019 07:14:30 -0700 (PDT)
Received: from planxty (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id z200sm1353932qkb.5.2019.09.17.07.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 07:14:30 -0700 (PDT)
Date:   Tue, 17 Sep 2019 16:14:29 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Sultan Alsawaf <sultan@kerneltoast.com>
cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        sebastian@breakpoint.cc, tglx@linutronix.de, rostedt@goodmis.org
Subject: Re: [PATCH] rt-tests: backfire: Don't include asm/uaccess.h
 directly
In-Reply-To: <20190917071546.GA27627@sultan-box>
Message-ID: <alpine.LFD.2.21.1909171613150.3853@planxty>
References: <20190903191321.6762-1-sultan@kerneltoast.com> <alpine.LFD.2.21.1909162356500.10273@planxty> <20190917071546.GA27627@sultan-box>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 17 Sep 2019, Sultan Alsawaf wrote:

> On Mon, Sep 16, 2019 at 11:57:32PM +0200, John Kacur wrote:
> > Signed-off-by: John Kacur <jkacur@redhat.com>
> > But please in the future
> > 1. Don't cc lkml on this
> > 2. Include the maintainers in your patch
> 
> Hi,
> 
> Thanks for the sign-off. I was following the instructions listed here:
> https://wiki.linuxfoundation.org/realtime/communication/send_rt_patches

Those are the instructions for rt kernel code.
rt-tests is a users space program to test the performance of the rt 
kernel.

Always just check if there is a MAINTAINERS file (there is)
when you clone the git repo.

Thanks

John

> 
> I couldn't find any documentation of how to send patches for rt-tests. Is there
> a different set of patch submission instructions on a wiki somewhere I missed?
> 
> Thanks,
> Sultan
> 
