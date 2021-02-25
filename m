Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84456C433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Feb 2021 03:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32D2564EC4
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Feb 2021 03:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhBYDhK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 24 Feb 2021 22:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhBYDhI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 24 Feb 2021 22:37:08 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89CCC061574
        for <linux-rt-users@vger.kernel.org>; Wed, 24 Feb 2021 19:36:27 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id v3so3211254qtw.4
        for <linux-rt-users@vger.kernel.org>; Wed, 24 Feb 2021 19:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=IrEb0F7OYml+nJPx65LMzHHSMVIxWD1WA63MLd09cbY=;
        b=GhQF+CNQPyXEGXnDstGk8GL8dNJTi6GculACZ0aowqD5jHK2FCi3/qhyeq3mDZ8aEU
         xUx8xKtwi2PZn/K9XEu3JvaUSmM8T07RKO2lzErSkpu0gev7GGKsoejIcz2D0/k3tqw0
         RCebLIOMDjwL5+T9/Un7+GQzmXe/hIj23P8tjPOZzNuQy1+rsjgwyuHS8eod0nYAT46J
         0UmCTjnPJcFAB5BzjxMPmeXy6lJhlSwgsTkHzXEKsOni5zWi+PBpbWSLlrzictMENJKr
         sXptcF8L9kA8FGsRaQolqyy38oQMsq/S9PrewOAyDi4n60RUhITLaW+p2M6Wnxg7wLNs
         5/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=IrEb0F7OYml+nJPx65LMzHHSMVIxWD1WA63MLd09cbY=;
        b=PKqcE1WZjd8XkUD6kMmTyA6LviMVyJ/QqOORP8Z1ij9JYfDUKpP/O06XhWp+SfaWqe
         zbFokEqv00mzCOoS7llQdmG/Nrvbbrsl1/qcziUdkaGl0YIBV41jzXbAnaR1vBJGw+7J
         PpAAs4aIpk+MNsvFzE8f7RG9Eq3O2y/LqSVOGO9X/R8gXCpZkeBK4ISml+NRskRIDPx8
         2lmjLMUNr9MxzCsf8cPctL8Zr1lVmUe7DZiuAoqXKqFeu+pzuSbXDFQ5ZavfA7RMIkGW
         L4sjT/uU6XWwmBoOeOtTralbB5OtPielQKjREmjrHjzzcvyCaUiX739jBXKwctflJyhs
         Qsbw==
X-Gm-Message-State: AOAM5329O4+qrxD2GH55EsuJtmUOMYWVgESKyyk6tn/aqVDE1m4Jpcz3
        4n9krtt9yl6iTCZI0SNBoD4=
X-Google-Smtp-Source: ABdhPJxggDeqvycth5LA5ls5ONLDLsGmVQymGaxBuo7JMehEbDeesUSGGrBZD0AxQvlUxovN/iicYQ==
X-Received: by 2002:a05:622a:cf:: with SMTP id p15mr874078qtw.276.1614224186866;
        Wed, 24 Feb 2021 19:36:26 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id m190sm3042625qkc.66.2021.02.24.19.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 19:36:26 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Wed, 24 Feb 2021 22:36:12 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
cc:     RT <linux-rt-users@vger.kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 0/2] Fix for machines without numa
In-Reply-To: <87y2fdzujz.fsf@kurt>
Message-ID: <5ececc53-c7db-422-ba86-2c9c3e957567@redhat.com>
References: <20210222220750.12911-1-jkacur@redhat.com> <87y2fdzujz.fsf@kurt>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 24 Feb 2021, Kurt Kanzenbach wrote:

> Hi John,
> 
> On Mon Feb 22 2021, John Kacur wrote:
> > Trying to return the code to a state where numa is required at compile
> > time but not at runtime
> >
> > - The first patch should allow cyclictest to run on a machine
> > without numa.
> >
> > - The second patch is a clean-up of some old code
> >
> > The code is pushed in git to branch unstable/devel/no-numa-runtime
> > so that people can test before I integrate the code back in the main
> > branch
> 
> arm32 seems to work fine.
> 
> Tested-by: Kurt Kanzenbach <kurt@linutronix.de> # arm32
> 
> Thanks,
> Kurt
> 

Thanks, I added your tested by and merged all the changes into
unstable/devel/latest

John
