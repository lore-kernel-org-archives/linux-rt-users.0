Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFC3C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu,  6 Oct 2022 06:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiJFG1p (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 6 Oct 2022 02:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiJFG1o (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 6 Oct 2022 02:27:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2CA868B4
        for <linux-rt-users@vger.kernel.org>; Wed,  5 Oct 2022 23:27:43 -0700 (PDT)
Date:   Thu, 6 Oct 2022 08:27:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1665037661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iYBZf53mvRaP00Bdm0EYHezJtXFT10hJ+ERe40A6a2I=;
        b=2Ck49N1JU8mr14Vk6txUmwuvPNjip6CzGGuFOsx5Y818jcAlJUwTu083k6FwiA1WEhYj9/
        511xxcR9n1i/XzpO51sanciKwprqRsTE2MF1ZhFQvoUew4g+ww1DyIT0+WLBrJpYjSP3Fe
        NyqrlJA568ErroHkq2zGg9Ju6KlSoEskVRJ0cbf7SMBpS928kikH8d/KRQxnjIC+WbPxh7
        /T38/cDN0D9LaAQdhDVHuzjQcW7nx7VPxC66OixWHhSYFSQAzdW0X4fjJsELXzZQtQo8zB
        cm6O2+VwBB9esOP7rGmjS1kZYTWrx79IK6EaDu05ZkLPka+Kd8DhNRZsUSAkAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1665037661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iYBZf53mvRaP00Bdm0EYHezJtXFT10hJ+ERe40A6a2I=;
        b=oHcqrygFa+E5UatzOcyvkS+1yGGesfCqLvdprx3BM8dtILdqigSgNowzkVCV3eTTDR8ZWq
        tm/Z+fmiKpMlY8BA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Florian Paul Schmidt <mista.tapas@gmx.net>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: Regression (latency spike) between 5.16.2-rt19 and 5.17.1-rt17
Message-ID: <Yz51W0+ZVvYSa9kq@linutronix.de>
References: <565463ae-b86e-357d-962b-89d2a151ac73@gmx.net>
 <Yz2HQlzZ491HtOm+@linutronix.de>
 <5675da76-80ba-5708-e022-2385e3b56fad@redhat.com>
 <9a950f2b-94c2-7dad-51f2-545aa37850c2@gmx.net>
 <6b79b2f3-7ec9-88e9-48e4-71c6ec85b7db@redhat.com>
 <5d127d10-d606-52ad-b270-9bcbd66eec6c@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5d127d10-d606-52ad-b270-9bcbd66eec6c@gmx.net>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-10-06 05:25:26 [+0200], Florian Paul Schmidt wrote:
> They are 13M each. Attached are just the tails for a start. Do you want
> to see the whole thing?

that looks fine to me.
The runtime_resume path points to intel_dmc_load_program(). The
preempt-disable section there was introduced by commit
   dff457d74e7ea ("drm/i915: Speed up DMC firmware loading")

and the other thing seems to be intel_irq_reset() not sure where but it
is the runtime_suspend path.

So disabling runtime-suspend should help.

> FPS

Sebastian
