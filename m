Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55903C07E99
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 10:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38CB0613D6
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 10:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhGIKVp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Jul 2021 06:21:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57422 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbhGIKVp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Jul 2021 06:21:45 -0400
Date:   Fri, 9 Jul 2021 12:18:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625825941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lLQ/bdoOuCDOI/q2AMTOMyyNAd4a102JNJieThES7oE=;
        b=v//9zhLtRzR+eyb9Vp7wbNwGkxOS6lqODvmneOQab4Zo9QWY6RCREDiaZ95n09Jp/hGaSf
        47a2r7jKozTB3PIj9Mx3P/DZ3tYM9J83Svgp7aG+3iU6/iMyhe7au/sNnukAj8YscQY0yb
        XFcTyiE+sEGmNGd22ZIeJuiEkyep1tFrk7aBQT9eDzfJCQaswKD4DzcxnKAvto6ogRq3ht
        Kk+2g6iD+bEVCLrNZTBRsF+06b97PO0D9eNZ0JvQx+GllPLSW9Tm6Xd53lvE2EfKSi35AH
        tG8DaGoxzlwZhli+ExmExrO/jl6mk9S5SIt7YiMn65kCnONFAqoEBuvFs8eDWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625825941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lLQ/bdoOuCDOI/q2AMTOMyyNAd4a102JNJieThES7oE=;
        b=wrNVrNGKPHd7agEoCfkAYJkWm000loB9FmRxz6HmQok7gxSEpLAKRvMGvt4BxRXDSQg44A
        BPtqEjcgeUlsCnCQ==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Matthias Klein <matthias.klein@optimeas.de>
Cc:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: Working sample 5.10 kernel configuration for an IMX6 board?
Message-ID: <YOgikyyE7WhOP799@lx-t490>
References: <AM0PR10MB3107F4D6E0F50ECB027C06A199199@AM0PR10MB3107.EURPRD10.PROD.OUTLOOK.COM>
 <YOcY3rH7Q0DjyOyj@lx-t490>
 <AM0PR10MB31078807FE14B686B727CA2A99199@AM0PR10MB3107.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR10MB31078807FE14B686B727CA2A99199@AM0PR10MB3107.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Jul 08, 2021 at 03:46:14PM +0000, Matthias Klein wrote:
>
> The configuration is attached.
>

I've quickly inspected the .config file resulting from the defconfig
above.  You should disable the enabled symbols below:

  - CONFIG_PROVE_LOCKING
  - CONFIG_DEBUG_ALIGN_RODATA
  - CONFIG_DEBUG_FS_ALLOW_ALL
  - CONFIG_DEBUG_MISC
  - CONFIG_DEBUG_PREEMPT
  - CONFIG_DEBUG_RT_MUTEXES
  - CONFIG_DEBUG_SPINLOCK
  - CONFIG_DEBUG_MUTEXES
  - CONFIG_DEBUG_WW_MUTEX_SLOWPATH
  - CONFIG_DEBUG_RWSEMS
  - CONFIG_DEBUG_LOCK_ALLOC
  - CONFIG_DEBUG_USER
  - CONFIG_NO_HZ_COMMON
  - CONFIG_NO_HZ_IDLE
  - CONFIG_NO_HZ

You also have a lot of CPU frequency governors enabled. Disable all of
them except the performance governor and make sure that
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y.

The above, especially disabling CONFIG_PROVE_LOCKING and
CONFIG_DEBUG_PREEMPT, should really fix your problem.

If you still have issues, play around with disabling CONFIG_CPU_IDLE and
its governors. Note though that CPU manufacturers sometimes advise
against doing this.

If the latency is still higher than desired, see if CONFIG_DRM and high
GPU workloads negatively affects it . On some architectures, latency can
increase by 100 microseconds or more due to sharing of the Last Level
Cache and memory bandwidth between the GPU and the CPU.

After all of this, if latency is still higher than the 100->150
microseconds range, it's possible that the custom code you've added is
doing shady stuff; e.g., manually disabling interrupts or preemption.

If it aint so, and the latency is still higher than the expected range
(even with a pure RT release), then you'll need to manually trace the
kernel and catch the offending call chain.

Good luck,

--
Ahmed S. Darwish
Linutronix GmbH
