Return-Path: <SRS0=AM/X=2C=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE252C43603
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Dec 2019 17:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A073B2173E
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Dec 2019 17:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbfLLRbT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:31:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46461 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730023AbfLLRbT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 12 Dec 2019 12:31:19 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ifSJ0-0007cV-Dj; Thu, 12 Dec 2019 18:31:14 +0100
Date:   Thu, 12 Dec 2019 18:31:14 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@debian.org>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests] queuelat: use ARM implementation of gettick
 also for all !x86 archs
Message-ID: <20191212173114.cz3bq5eotczql5s2@linutronix.de>
References: <20191208210625.5999-1-ukleinek@debian.org>
 <18a0be03-74dd-54f1-a0f0-4f4acdd061ad@monom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18a0be03-74dd-54f1-a0f0-4f4acdd061ad@monom.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-12-09 10:40:29 [+0100], Daniel Wagner wrote:
> Just wondering if the tool should print a warning if the fallback is used?
> IIRC, the code wants to use the TSC and clock_gettime is probably not so
> precise.

clock_gettime() is precise but it might have more overhead. With VDSO
support the overhead is quite low.

> Thanks,
> Daniel

Sebastian
