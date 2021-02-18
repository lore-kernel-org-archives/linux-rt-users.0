Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE40C433DB
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Feb 2021 18:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21C7164E92
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Feb 2021 18:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhBRSeV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 18 Feb 2021 13:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbhBRQ00 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Feb 2021 11:26:26 -0500
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FC3C061574
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Feb 2021 08:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1613665543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+rjjNPkhzATc0LmHASOLRnnddhHwASBSKLnluCWJTb0=;
        b=VkioJ45SWJGc1AEprRO7q+6LwGTZ1URnLYbbbJ705aNUzNUVlFQiHv/gZeJAgYBXxeiyOM
        PcdnQHRr1mN2ec7bUwpRz2bHhST56Z6bALLrVgYPn2y+XU3vppFTIJ56scsZHa047k8P3L
        KsyoSy5kNAeskFD4X4UKRvOIYTL/RvY=
Received: from [192.168.0.2] (host-82-54-239-193.retail.telecomitalia.it [82.54.239.193])
        by sysam.it (OpenSMTPD) with ESMTPSA id 007d339b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 18 Feb 2021 16:25:43 +0000 (UTC)
Message-ID: <844950db-3b81-669c-8043-2400e0e5bdb6@kernel-space.org>
Date:   Thu, 18 Feb 2021 17:25:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: arm64: imx8qxp: irq 464: nobody cared (try booting with the
 "irqpoll" option)
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
References: <da64238e-dc1e-c479-44e2-0ea18d9577b8@kernel-space.org>
 <20210208122918.wyvto62kwyevfkyx@linutronix.de>
 <d2d772dc-57f0-39f0-abec-caa8297d3e32@kernel-space.org>
 <20210218135255.yucnl4xi6x7uqctg@linutronix.de>
From:   "angelo@kernel-space.org" <angelo@kernel-space.org>
In-Reply-To: <20210218135255.yucnl4xi6x7uqctg@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Sebastian,

On 18/02/21 2:52 PM, Sebastian Andrzej Siewior wrote:
> On 2021-02-09 20:08:53 [+0100], angelo@kernel-space.org wrote:
>> I finally found a solution, replacing drivers/irqchip/irq-imx-intmux.c
>> code with mainline. It seems quite reliable, i cannot replicate
>> the issue anymore. Any comment is welcome.
> 
> so this uses a raw_spinlock_t and switched to a level handler. This
> looks *way* better.
> 
> You could ping the people in charge of the vendor tree and ask them if
> they could please please fix their broken driver.
> 

Sure, will inform them.
Thanks a lot for confirmation and support,


>> Regards,
> 
> Sebastian
> 

Regards,
-- 
Angelo Dureghello
+++ kernelspace +++
+E: angelo at kernel-space.org
+W: www.kernel-space.org

