Return-Path: <SRS0=gcb+=EK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D3AC55178
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Nov 2020 10:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C1222072C
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Nov 2020 10:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgKDKiO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Nov 2020 05:38:14 -0500
Received: from mail.monom.org ([188.138.9.77]:34606 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729568AbgKDKiN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Nov 2020 05:38:13 -0500
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 76987500609;
        Wed,  4 Nov 2020 11:38:10 +0100 (CET)
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id 18F2F500596;
        Wed,  4 Nov 2020 11:38:10 +0100 (CET)
Date:   Wed, 4 Nov 2020 11:38:09 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.10-rc2-rt4
Message-ID: <20201104103809.bhl2iorbwv6xowtw@beryllium.lan>
References: <20201103195731.erjkgyzxzzjylhui@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103195731.erjkgyzxzzjylhui@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Nov 03, 2020 at 08:57:31PM +0100, Sebastian Andrzej Siewior wrote:
> I'm pleased to announce the v5.10-rc2-rt4 patch set.

All tests on passed in my lab. On arm64 and arm I saw slightly higher
max latency values for signaltest and sigwaittest. Usually they are
below 200us but currently I see up to 350us.

BTW, x86_64 also showed slightly higher numbers for signaltest for the
v5.10-rc1-rt1 release. These are gone now.
