Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1026EE4993
	for <linux-rt-users@archiver.kernel.org>; Wed, 23 Aug 2023 13:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbjHWNjW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 23 Aug 2023 09:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbjHWNjW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 23 Aug 2023 09:39:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B54CD6
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Aug 2023 06:39:20 -0700 (PDT)
Date:   Wed, 23 Aug 2023 15:39:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692797958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f5nwXtiyluPtDqL65v1bULBy0OAY58hztBlNY3VZaoA=;
        b=0DBk8aDihEaRtZ7S2RAxWU1311RAoBBhgYOvXO80Qe02sF/RtD75voVDJnnZq3HDKjaN2S
        paxBeV6/rfScrCCv2RG/LLUKzQRD8s69rMXq2IDWT25WkqRDEicFDuju2pQZz5fB4MEU2O
        e0jdv6ooIYdAespcKoNu8coMbOfOB4KNCM1xFTiFfsLICEAlJB8ao3AIDt/B7Q1pVF5wCo
        ff8ZouPbu0q08WOrt0IGrL4yMyU/FLkWdl2BDbKEHW+ArC4bNQMx4Z+uFAvTZPcW+CuRZG
        sFcbNKvqIcX7khun1jLotFWjZSc1g+ITq+aqcczjC/5D3/0Z75qz1wzwDqLxSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692797958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f5nwXtiyluPtDqL65v1bULBy0OAY58hztBlNY3VZaoA=;
        b=BHGXvFiVfOuj3CTiYx86pQJy8T/4nQ2CDgPelqokkIihFOLHpr7CMMnCNwJ52wk0lsj9Ad
        7H4uSRZNwHessZBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     paul.gortmaker@windriver.com
Cc:     Clark Williams <williams@redhat.com>,
        Joseph Salisbury <joseph.salisbury@canonical.com>,
        linux-rt-users@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: Re: [PATCH 6.1-rt/5.15-rt 0/1] Backport i915 reset fix from v6.4-rt
Message-ID: <20230823133915.gu_SxqTS@linutronix.de>
References: <20230819024525.2056048-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230819024525.2056048-1-paul.gortmaker@windriver.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-08-18 22:45:24 [-0400], paul.gortmaker@windriver.com wrote:
> From: Paul Gortmaker <paul.gortmaker@windriver.com>
Hi Paul,

> However, the original regression was reported on v5.15-rt.  This closes
> the loop by backporting the v6.4-rt change to v5.15-rt/v6.1-rt -- as it
> turns out, the same backport applies cleanly to both baselines.

Thanks for the ping. I've sent a backport request
	https://lore.kernel.org/all/20230727105040.4V9DQ5pM@linutronix.de/

which includes the patch. It didn't go very so far but I am full of hope
;)

Sebastian
