Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEF2C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 13:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA34261507
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 13:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350655AbhI3NUN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Sep 2021 09:20:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50102 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350789AbhI3NUD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Sep 2021 09:20:03 -0400
Date:   Thu, 30 Sep 2021 15:18:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633007899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iwLLXwfY2Czm+bgn/s+8usyZGJzU38TMHjJcLauJP6w=;
        b=C07eH25cE5JMAVoajvB4SGewOxwWL74A+HCZ8oZ2x4v2TqFfzDIJGv2Da7v39f0uL1W0lY
        6p89OrLEIfNXHkdLhBcufzPFNfNQXqP87dST24dg6yLakYpTIxNmxbnwuu3bKQRX/yZ+7v
        Lyg728RGZWjYZrSyEsN7zXksr6RhofiqQdzwRFTB12RK/GncNLCl3GJfG/BrzXdeBoiOno
        ejQLRyxfgNo+OIZrlbklFb699SiuUuQ4hjqumIzEhBTTxHxDNbd7lM6LkNtYCw4+jQoICe
        T6VQS4pnF5HqIiz5lXLOyL497tmNLtrN3Lye2zIRKccwluI6edV+bDOxpGeLKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633007899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iwLLXwfY2Czm+bgn/s+8usyZGJzU38TMHjJcLauJP6w=;
        b=Bw40f+zMd3OnleP4gUGITAfhuTGuooG+cJiBVy5rqRwYzbKefZTHlpze1o6QBmymbuDG2C
        1MpL419ETxJYOpAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: Strange problem with PREEMPT_RT
Message-ID: <20210930131818.ctr6n6iz2cn6oxwg@linutronix.de>
References: <CAFc1U0sgMtKvcpTWkyjwXsq3Md_Huew7mSye_AratkM63D6K-Q@mail.gmail.com>
 <87y27e53a2.fsf@stealth>
 <CAFc1U0ufOcT14+JpU60Xoe4D_oJoADwwWszPypT6Y=CLDX39dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFc1U0ufOcT14+JpU60Xoe4D_oJoADwwWszPypT6Y=CLDX39dg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-09-30 10:21:44 [+0200], Pierre FICHEUX wrote:
> Hi,
> 
> Thx a lot for your help (I suspected such a thing).
> 
> I can see CONFIG_CPU_IDLE=y in the config but as it's an old kernel
> (3.10) there is no entry such as
> /sys/devices/system/cpu/cpu?/cpuidle/state?/disable
> 
> Will take a look further.

  cpupower idle-info

Some of the higher C states have _long_ transition time. Very often
anything > C1 is evil.

> regards

Sebastian
