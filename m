Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F6EC636CC
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Feb 2023 16:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjBOQCH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 15 Feb 2023 11:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjBOQCG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Feb 2023 11:02:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92BF83ED;
        Wed, 15 Feb 2023 08:02:05 -0800 (PST)
Date:   Wed, 15 Feb 2023 17:02:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676476924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zd2fmHKWbURQBjI0LX6CjtBk2h3C2F2YLQ58w+UZWyA=;
        b=TRY9ebSmqyomAHTQ4GE/dtDh/uiERGis37MrtTQL/vlEJ7nJcDGaE8GRrOszPvo609cVdF
        JeSOOGnaBgaZ6JntfghHfJbIkTeVq6Z2r7QDOe5xDcUW2rc9ktx6IvqVpCwbNRkft9arTA
        KL0xTkTYlQ8le9/oFHQjW+9s0+JczZgx90/nHM7i247Ix+mWVVEfN4y5uxqPgd6xFHa96I
        jyNF1CBYRia4NXZxNBiaD1frykVevaGeCPG/7vGTdMK3JZSm4hTE050fCBCKCsSF3kjRe5
        rKeA9zrLzY2R4rGwi847uiJoKTxYEXQ2oJDKnLAbWWLlWcNiM+dxmsIt/uJbhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676476924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zd2fmHKWbURQBjI0LX6CjtBk2h3C2F2YLQ58w+UZWyA=;
        b=Gx02e691Ey2fK7do2oNpRvAKxyIJZLJILNmKbP4nZru5ElwRXFvSoFjKk1E7S19JzHw+ie
        XQp/IAbMn02PfyDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] locking/rwbase: Mitigate indefinite writer starvation
Message-ID: <Y+0B+1q4cYpjUcgr@linutronix.de>
References: <20230120140847.4pjqf3oinemokcyp@techsingularity.net>
 <87ttzyyigk.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ttzyyigk.ffs@tglx>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-02-06 15:30:35 [+0100], Thomas Gleixner wrote:
> What's the downside of actually forcing !RT readers into the slowpath
> once there is a writer waiting?

We always said that there are no RT users of rwsem. Therefore it
shouldn't matter because we still assume that nothing depends on this.
After all we had one a one reader implementation of rwsem and this is
the first report (to my knowledge) of a fallout since it was changed to
multi-reader.

That said let me update Mel's patch and resend it without this bit.

> Thanks,
> 
>         tglx

Sebastian
