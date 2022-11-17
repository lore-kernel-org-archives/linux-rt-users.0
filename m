Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CACAC4332F
	for <linux-rt-users@archiver.kernel.org>; Thu, 17 Nov 2022 07:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239386AbiKQHoV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 17 Nov 2022 02:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239378AbiKQHoT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 17 Nov 2022 02:44:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7635FB68
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Nov 2022 23:44:18 -0800 (PST)
Date:   Thu, 17 Nov 2022 08:44:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668671056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GZ0rWp6iP202MavzCZ+xkNmS8s2Kt78+S4hljWNceDw=;
        b=SVKPtIgEVW2YW6B3WQimRCRqDx4RgM9JNLkRisth72YPLMsVq+8KnAh8HgFhqn1qm2vHxf
        cHxgvLrKoIM0YlGRJ7SWv3Tf2Lfyxr4gBwTO1Eb9KfjoHDSDBtfH3qe/Zes01wLVvyRERW
        xMuq5RUq5UMaOqVfUhWiYUkgj2CU57SaNUDA1b2XD5xv65t/pjpfigNjUt5jp1J6SWolAv
        uOFS1xLR7prwAe2WtWufkh/EHVz/xC6ZX8bAyEDqESEhIYDNDZbMY9AvAhTp8UGJWtlgFh
        muz5zD6M38vvv/2E/8HZoh/myfY7a6Tx2Urrl8VUk1EjWa35LnuM8DU2hHL3RQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668671056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GZ0rWp6iP202MavzCZ+xkNmS8s2Kt78+S4hljWNceDw=;
        b=5VKJTgTd+wAFNEtVSoC8EwrXgzgZ/EeHf/r798eGobJv2DMG6shiFb1sgV21fAOi62RkbE
        PexuIlDHQucX4KCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     David Runge <dave@sleepmap.de>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: v6.0.3-rt12 does not compile (WAS: [ANNOUNCE] v6.1-rc2-rt1)
Message-ID: <Y3XmTKq9+04da+G7@linutronix.de>
References: <Y1lPqHjmytaSEnHn@linutronix.de>
 <Y1m0MXDKt0yqXdsu@hmbx>
 <Y1osx2Iw0qs3gWxu@linutronix.de>
 <Y3PHQM0QXTTrKcXg@hmbx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3PHQM0QXTTrKcXg@hmbx>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-11-15 18:07:09 [+0100], David Runge wrote:
> 
> For reference: Will there be more rebases on stable versions of the most
> recent kernel versions going forward?

I don't plan to.

> The linux-stable-rt repository seems to only cover LTS kernels AFAIKT
> and a few more releases in the current stable kernel version range would
> allow downstreams to more easily backport patches (e.g. for security
> issues) also for the realtime kernel.

The non-LTS kernels are dropped quickly so I don't expect v6.0 to stay
for long. I plan to stay behind upstream as close as possible so I don't
have to backport anything for testing and development.

> Best,
> David

Sebastian
