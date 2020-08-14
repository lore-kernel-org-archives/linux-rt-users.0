Return-Path: <SRS0=y2gO=BY=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83D8C433E1
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Aug 2020 11:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8CE520771
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Aug 2020 11:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z2cLJOge";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="25C2XuDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgHNLlh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgHNLlg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 14 Aug 2020 07:41:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5628EC061384
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2020 04:41:36 -0700 (PDT)
Date:   Fri, 14 Aug 2020 13:41:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597405293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Icf7rtcdV62iG4ikVKmuk0Wimxc7ZBSdHw9knKcGB7A=;
        b=z2cLJOgeL6UH/js6tFpqgX4/7sFGagkAmGqGMFOk2QNZgvTAlX6B34IIFxQ5dv9l5IcnQz
        UrJtbqr5s6piaR6rat/kxzIrajT1tIjkp7Wr2T+PuQd+/eMwoDXw6YINCWvxCKecXsLYLW
        rJr+Kju21fGXdbFaHCZMPIrqtsS6FqqL7Z92XjuBCi8n5H9VGgZ3qUKJitsFj0KzzW0p7u
        mF11Oj6RSDiBrPeF2BmrGkTotH0PQdrJt11HnZyd6QAoK3ZNcPKFpYSIfEFL9htrVUnoRb
        y/yS02MktGWW6mPw9jEKnmg5Fm4NDtlQ1gRJ96fZr860y2PCl/JHMCJkuJ9MaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597405293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Icf7rtcdV62iG4ikVKmuk0Wimxc7ZBSdHw9knKcGB7A=;
        b=25C2XuDi7/lrOhluXHVUfaI+Ry5oe5P6fxO6mjtPW0FCWIqNp0rMgqaP6JpCGsonw5ffhK
        92yLuFiq8fPbRsAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [BUG] stress-ng close causes kernel oops(es) v5.6-rt and v5.4-rt
Message-ID: <20200814114132.rq7ygkexdqn5aqgg@linutronix.de>
References: <20200810133639.GA59705@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200810133639.GA59705@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-08-10 15:36:39 [+0200], Juri Lelli wrote:
> Hi,
Hi,

> As per subject, the following test
> 
> # stress-ng --close 0 --verbose --timeout 60 --metrics-brief
> 
> Causes kernel crashes for both v5.6.19-rt11 and v5.4.28-rt19 (splats
> follow). Will try to dig deeper, but wanted to report early as this
> seems to be very easy to reproduce and maybe someone already saw it and
> might have suggestions.
> 

kvm:
|stress-ng: info:  [2067] successful run completed in 60.03s (1 min, 0.03 secs)
|stress-ng: info:  [2067] stressor       bogo ops real time  usr time  sys time   bogo ops/s   bogo ops/s
|stress-ng: info:  [2067]                           (secs)    (secs)    (secs)   (real time) (usr+sys time)
|stress-ng: info:  [2067] close            903449     60.02     22.68    182.01     15053.52      4413.74

real HW, no debug:
|stress-ng: info:  [50376] successful run completed in 60.01s (1 min, 0.01 secs)
|stress-ng: info:  [50376] stressor       bogo ops real time  usr time  sys time   bogo ops/s   bogo ops/s
|stress-ng: info:  [50376]                           (secs)    (secs)    (secs)   (real time) (usr+sys time)
|stress-ng: info:  [50376] close           9937122     60.00    129.59    352.74    165614.20     20602.33

Can you reproduce this in kvm and send me a .config? As of now I can't
reproduce it.

> Juri

Sebastian
