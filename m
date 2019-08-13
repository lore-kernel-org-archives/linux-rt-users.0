Return-Path: <SRS0=IBCX=WJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD78C32750
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Aug 2019 10:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1940320665
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Aug 2019 10:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfHMKB7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 13 Aug 2019 06:01:59 -0400
Received: from out28-ams.mf.surf.net ([145.0.1.28]:57424 "EHLO
        out28-ams.mf.surf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728700AbfHMKB7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 13 Aug 2019 06:01:59 -0400
Received: from smtp-prd1.ic.uva.nl (smtp-prd1.ic.uva.nl [146.50.108.156])
        by outgoing1-ams.mf.surf.net (8.14.4/8.14.4/Debian-4+deb7u1) with ESMTP id x7DA1qCB023572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 13 Aug 2019 12:01:53 +0200
Received: from [145.109.126.203] (wcw-self-145-109-126-203.wireless.uva.nl [145.109.126.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-prd1.ic.uva.nl (Postfix) with ESMTPSA id CB53C5F;
        Tue, 13 Aug 2019 12:01:52 +0200 (CEST)
Subject: Re: Boot issue on odroid-XU4
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
References: <cfa2b805-380d-39fd-2955-ab19c5a11aaa@uva.nl>
 <d6033713-25b7-7ef0-b0ad-8b7100d7d4b0@uva.nl>
 <20190813090001.youm2uow3slx2tiu@linutronix.de>
From:   Benjamin Rouxel <benjamin.rouxel@uva.nl>
Message-ID: <3719213d-9cb1-5628-000d-5d946d7704d3@uva.nl>
Date:   Tue, 13 Aug 2019 12:02:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813090001.youm2uow3slx2tiu@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Scanned-By: CanIt (www . roaringpenguin . com)
X-Scanned-By: MIMEDefang 2.84 on 146.50.108.156
X-Bayes-Prob: 0.0001 (Score 0, tokens from: uva-out:default, uva:default, base:default, @@RPTN)
X-CanIt-Geo: ip=146.50.108.156; country=NL; region=North Holland; city=Amsterdam; latitude=52.3534; longitude=4.9087; http://maps.google.com/maps?q=52.3534,4.9087&z=6
X-CanItPRO-Stream: uva-out:default (inherits from uva:default,base:default)
X-Canit-Stats-ID: 0u0My1RId - 4f3d1d9859c8 - 20190813 (trained as not-spam)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Sebastian,

I rolled back my changes and removed IRQF_ONESHOT as you said and it is
indeed working, no more hanging out at boot.

drivers/i2c/busses/i2c-exynos5.c

760     ret = devm_request_irq(&pdev->dev, i2c->irq, exynos5_i2c_irq,
761                 IRQF_NO_SUSPEND,
762                 dev_name(&pdev->dev), i2c);

Should we keep that fix?

Best,

Benjamin.


Le 13/08/2019 à 11:00, Sebastian Andrzej Siewior a écrit :
> On 2019-07-24 19:07:46 [+0200], Benjamin Rouxel wrote:
>> Hi,
>>
>> I thought it would be harder to debug/fix. Please find attached a patch
>> that corrects this boot issue, the exynos5 i2c driver was still using
>> the "spinlock_t" structure and all initial utility functions, I just
>> changed it to use the "raw_spinlock_t" struct.
>>
>> Was it the good fix?
> Could you remove the IRQF_ONESHOT from the devm_request_irq() statement
> and check if this fixes the issue? I don't see the reason for it.
>
>> Best,
>>
>> Benjamin Rouxel.
> Sebastian
