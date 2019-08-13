Return-Path: <SRS0=IBCX=WJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C87C32750
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Aug 2019 09:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910B720840
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Aug 2019 09:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbfHMJAD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:00:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33298 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfHMJAD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 13 Aug 2019 05:00:03 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hxSev-0008HV-Mk; Tue, 13 Aug 2019 11:00:01 +0200
Date:   Tue, 13 Aug 2019 11:00:01 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Benjamin Rouxel <benjamin.rouxel@uva.nl>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Boot issue on odroid-XU4
Message-ID: <20190813090001.youm2uow3slx2tiu@linutronix.de>
References: <cfa2b805-380d-39fd-2955-ab19c5a11aaa@uva.nl>
 <d6033713-25b7-7ef0-b0ad-8b7100d7d4b0@uva.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d6033713-25b7-7ef0-b0ad-8b7100d7d4b0@uva.nl>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-07-24 19:07:46 [+0200], Benjamin Rouxel wrote:
> Hi,
> 
> I thought it would be harder to debug/fix. Please find attached a patch
> that corrects this boot issue, the exynos5 i2c driver was still using
> the "spinlock_t" structure and all initial utility functions, I just
> changed it to use the "raw_spinlock_t" struct.
> 
> Was it the good fix?

Could you remove the IRQF_ONESHOT from the devm_request_irq() statement
and check if this fixes the issue? I don't see the reason for it.

> Best,
> 
> Benjamin Rouxel.

Sebastian
