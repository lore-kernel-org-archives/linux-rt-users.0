Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970EAC433E0
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Jan 2021 09:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46A782226A
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Jan 2021 09:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbhAHJPs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 8 Jan 2021 04:15:48 -0500
Received: from mail.emcraft.com ([142.93.143.113]:49994 "EHLO mail.emcraft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727478AbhAHJPs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 8 Jan 2021 04:15:48 -0500
Received: from mehome.localdomain (unknown [217.107.124.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.emcraft.com (Postfix) with ESMTPSA id 075F73F02A;
        Fri,  8 Jan 2021 09:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=emcraft.com;
        s=default; t=1610097306;
        bh=vZHZYu5IjkYhyea+PxthkYHvGcpS59cWxp0aquDvdwg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Pyj0tn/Oryjo5zBMzdMhUh2vto6LG6pfM9QwL+VJCBd4vPniM5yr6uTSQ+qawHyEV
         G6JQsZudFmr7vMombp5OL+4Rn11kAmosJguiCkFxBk+dDrNCuBOoru704je/KUsBXV
         Epry1c7Kw88Ebq4leSCXW4mehdaeU/P91tY5suYI=
Message-ID: <d868096428ede5ef93cca7431cf67c021bf2541b.camel@emcraft.com>
Subject: Re: kernel crash with ARM64 5.4.47 preempt_rt
From:   Sergei Poselenov <sposelenov@emcraft.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
Date:   Fri, 08 Jan 2021 12:15:05 +0300
In-Reply-To: <20210108082911.cz7oropmnezhqx5p@linutronix.de>
References: <20201230140917.50e86fc3@sergmir.emcraft.com>
         <20210107164902.5guoavadivwugsz3@linutronix.de>
         <20210108082911.cz7oropmnezhqx5p@linutronix.de>
Organization: Emcraft Systems
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Sebastian,

Thank you for the feedback, it is very helpful.
Could you please provide us with a pointer to the bug?

Thanks again!

Regards,
Sergei
On Fri, 2021-01-08 at 09:29 +0100, Sebastian Andrzej Siewior wrote:
> On 2021-01-07 17:49:02 [+0100], To Sergei Poselenov wrote:
> > On 2020-12-30 14:09:17 [+0300], Sergei Poselenov wrote:
> > > Hello,
> > Hi,
> > 
> > > We applied patch-5.4.47-rt28.patch to NXP 5.4.47-2.2.0 release
> > > ARM64
> > > kernel running on IMX8M NANO chip, and enabled CONFIG_PRREMPT_RT.
> > > We
> > > are observing the following crash (below), on a system running an
> > > application that communicates with some SPI device. Obviously,
> > > the
> > > system doesn't crash without the patch applied.
> > > 
> > > Any thoughts on the reason of the failure would be appreciated.
> > > How would we start debugging the problem?
> > 
> > Can you give v5.10 a try v5.10 and/or enable SLUB_DEBUG?
> 
> Now that I look at it again, you need update to more recent v5.4-RT
> kernel. The current is v5.4.84-rt47, the bug was fixed in v5.4.54-
> rt33.
> 
> > > Thanks!
> > > 
> > > Regards,
> > > Sergei Poselenov,
> > > Emcraft Systems
> Sebastian

