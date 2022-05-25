Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4C1C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed, 25 May 2022 11:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243093AbiEYLzn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 25 May 2022 07:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbiEYLzm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 25 May 2022 07:55:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C2DA2069
        for <linux-rt-users@vger.kernel.org>; Wed, 25 May 2022 04:55:41 -0700 (PDT)
Date:   Wed, 25 May 2022 13:55:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653479739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TRJb6JF7bGIM3vuVI3q/oEKJ+8U6tJ0HPNReM4LDeiI=;
        b=vgkiRv3HzRrcIpPMm0IxVKCeIWu1QhF/QNKlpAL4DxVtMisB+8Qtk37ofLqHRgL987Vwvq
        2XJ0AyMzJS3Ti37c5LoaWbUHh7xtRebXDbzZl73FiH28ff/btQbUfXDR9gu+80GN6zVqkW
        Eqa4B7plu8VMmcRJJ+OsH4WFa9JivifhP26bSQovt0KGhxPLNJlt+FIwjzWD9Ac2vKerXR
        uN2SVdnLhW5qMvjXT6k2326HUAv0htYKvU9mmo8wyNVPqKcERGAMqccTugK62An4AqbLu8
        amrgc5wzwBJF2Ih7mVKDPv7QFZSD1R7AbnRJ3N0ei0/GT3TcvPZCEuRx8rBsgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653479739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TRJb6JF7bGIM3vuVI3q/oEKJ+8U6tJ0HPNReM4LDeiI=;
        b=IimO6TxRVXz/u23w64eHIKuPXlZSSw+H5+V2JuTMUWV3Q7FeFFB2Wu1/xEZh07Np2qbr+8
        yV4FUmWMF88VG0Cw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Gautam Thaker <ghthaker@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: seeking a .config with ALL DEBUG settings turned off...
Message-ID: <Yo4ZOh2zTig+0wSV@linutronix.de>
References: <CA+1+E3V4Z-Y=-iBRxoFzD=14Tq7ndaHdM=3fzT=nKDZmUNpbeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+1+E3V4Z-Y=-iBRxoFzD=14Tq7ndaHdM=3fzT=nKDZmUNpbeg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-05-03 09:59:05 [-0400], Gautam Thaker wrote:
> I am building 5.17.1-RT and I want to disable ALL DEBUG (both related
> to RT Patch) and all others that can be turned off and still have a
> working RT kernel. I want todo this to try to measure scheduling
> latency, etc that is not marred by various counters and trace support
> things.
> 
> Is there a page or directions that can tell me how to do this? I go
> thru and disable various DEBUG settings in .config manually, but then
> I notice that making the kernel re-enables some of them, it is unclear
> to me why this is.
> 
> I do:
> 
> # cp -vi /boot/config-`uname -r` .config
> 
> as my starting point.

do "make menuconfig" and go to "Kernel hacking". Most options underneath
are related to debugging. Some options may not be disabled because they
are forced by other options. For instance if CONFIG_DEBUG_LIST is forced
enabled and you don't know why, simply click on "Help" and look for
"Selected by [y]:".
This should be the easiest way.

> Thanks.

Sebastian
