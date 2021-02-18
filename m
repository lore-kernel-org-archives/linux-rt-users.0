Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491FCC433E6
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Feb 2021 15:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA6A664E85
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Feb 2021 15:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbhBRP4X (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 18 Feb 2021 10:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhBRNxz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Feb 2021 08:53:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CE6C061574
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Feb 2021 05:52:57 -0800 (PST)
Date:   Thu, 18 Feb 2021 14:52:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613656376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5rwZDZq6JbhLzfcsph/UV/R7B6qr3B24wf7pRxdhoa4=;
        b=W8QuaMvSV95vmOcj07/QCLFT84jV4SajjlukLbCJCTyh8/wVcFQeC9f3xUx17r7TsgpxCh
        /M0iksfk7w95WJrxsTMSwD0o3zPA+kdaMrsMXlUhc0t0xEUDTtMRLu+7I+07x03wMRFfa5
        LWWIyIswaUPxoNmDbVuw8UbiQ0sRVf4MyoO+OIF0C9JvVsVvTVBX3cbDF9GOIzHiQ26YpY
        aSGQM5TuIX0Y/ZAIwhmj8ug6vlghRRUJPCz8l8K446Q6CLxQcTmAYlg1dyGd15Bzs8shCI
        uRCsGvodwh31hY+kC1plJnECrxIo8MrVEruK7VUIqTsluiz9/JBVYPSDwBaO1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613656376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5rwZDZq6JbhLzfcsph/UV/R7B6qr3B24wf7pRxdhoa4=;
        b=UQW38D2E1190xXZP801OwilOeK8JgBbv1b2c3DgkQNNGtwUKz2tP4ybwL7xUuMaBqjc+RH
        QdouAkKrlYsZEIAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "angelo@kernel-space.org" <angelo@kernel-space.org>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: arm64: imx8qxp: irq 464: nobody cared (try booting with the
 "irqpoll" option)
Message-ID: <20210218135255.yucnl4xi6x7uqctg@linutronix.de>
References: <da64238e-dc1e-c479-44e2-0ea18d9577b8@kernel-space.org>
 <20210208122918.wyvto62kwyevfkyx@linutronix.de>
 <d2d772dc-57f0-39f0-abec-caa8297d3e32@kernel-space.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2d772dc-57f0-39f0-abec-caa8297d3e32@kernel-space.org>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-02-09 20:08:53 [+0100], angelo@kernel-space.org wrote:
> I finally found a solution, replacing drivers/irqchip/irq-imx-intmux.c
> code with mainline. It seems quite reliable, i cannot replicate
> the issue anymore. Any comment is welcome.

so this uses a raw_spinlock_t and switched to a level handler. This
looks *way* better.

You could ping the people in charge of the vendor tree and ask them if
they could please please fix their broken driver.

> Regards,

Sebastian
