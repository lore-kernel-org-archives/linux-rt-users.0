Return-Path: <SRS0=IBCX=WJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03CDC32750
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Aug 2019 10:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C18120679
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Aug 2019 10:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfHMKWg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 13 Aug 2019 06:22:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33943 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbfHMKWf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 13 Aug 2019 06:22:35 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hxTwo-0002AF-GJ; Tue, 13 Aug 2019 12:22:34 +0200
Date:   Tue, 13 Aug 2019 12:22:34 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Benjamin Rouxel <benjamin.rouxel@uva.nl>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Boot issue on odroid-XU4
Message-ID: <20190813102234.i2w7to5cde2fxcak@linutronix.de>
References: <cfa2b805-380d-39fd-2955-ab19c5a11aaa@uva.nl>
 <d6033713-25b7-7ef0-b0ad-8b7100d7d4b0@uva.nl>
 <20190813090001.youm2uow3slx2tiu@linutronix.de>
 <3719213d-9cb1-5628-000d-5d946d7704d3@uva.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3719213d-9cb1-5628-000d-5d946d7704d3@uva.nl>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-08-13 12:02:14 [+0200], Benjamin Rouxel wrote:
> Hi Sebastian,
Hi,

> I rolled back my changes and removed IRQF_ONESHOT as you said and it is
> indeed working, no more hanging out at boot.

good.

> Should we keep that fix?

I think so. I will craft a patch and post upstream and see how it goes.

> Best,
> 
> Benjamin.

Sebastian
