Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08988C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Jan 2022 08:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238233AbiAQIgD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 17 Jan 2022 03:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238231AbiAQIgC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 17 Jan 2022 03:36:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC8DC061574
        for <linux-rt-users@vger.kernel.org>; Mon, 17 Jan 2022 00:36:02 -0800 (PST)
Date:   Mon, 17 Jan 2022 09:35:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642408559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=myUfiamsS/ThbetB+vkLscbK3FIh4om7PD2wltTKAcU=;
        b=QuN6oPdYrzJmv5lRjZKEncs8ghGGY+9stL8eF9xCIjw1WkYBa8TpWFB3/OQloD8CeTQQN+
        bje1l8B/VwSY4QyjC/ubTkQgikbvVYz9kZ0LpgDg3y7C3E5spxSB3FkL9zk52+FqYRLY36
        J3ix/yWuCEdq7YISaAFeUAFOtppX7xsj46Y2NTrv1WxFw1xvPDfkIyl/LFAvVRZQzU7dkF
        M3NKV3Q0q/OWeaprntORNUD7g3EGCavyJY5/2kSQrzVp6wKikDC1jlbQ7veQ/7KZievej3
        67EiS7K+RHWWRvXcR2um4BvPqBQDb1owshxAN/IA9mcE/X4IEt8c2naTyGRMeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642408559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=myUfiamsS/ThbetB+vkLscbK3FIh4om7PD2wltTKAcU=;
        b=zXm+egujsQxIXgidMMdl0XUhhPVxZJ2P9LsaN//brpzMRsboJfMYAHjv/cVBf9isssKtGC
        oeIBYD19qT2XszAA==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     gene heskett <gheskett@shentel.net>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: What replaces the 4.19.y scripts/mkknlimg in 5.16-rc6-rt12?
Message-ID: <YeUqbhZklDM9aCPe@lx-t490>
References: <19384294.dZ2EVBas6m@coyote>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19384294.dZ2EVBas6m@coyote>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi gene,

On Sun, Jan 16, 2022 at 11:15:39PM -0500, gene heskett wrote:
> Greetings all;
>
> That script/mkknlimg is missing in v5.16-rc6-rt2. What replaces it?
>
> Or, can this script be copied to a v5.16-rc6-rt12 build and used?
>
> Thanks a bunch, I'm trying to build a v5.16-rc6-rt12 on a rpi4 for the
> rpi4. The build itself was flawless.
>

That script was never part of any mainline kernel (and thus any previous
or current RT release) to begin with. So... this is not exactly the
right place to ask.

Good luck,

--
Ahmed S. Darwish
Linutronix GmbH
