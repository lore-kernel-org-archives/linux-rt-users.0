Return-Path: <SRS0=gcb+=EK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6C2C2D0A3
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Nov 2020 11:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CE3F221F9
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Nov 2020 11:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbgKDLTw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Nov 2020 06:19:52 -0500
Received: from mail.monom.org ([188.138.9.77]:34932 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729382AbgKDLTv (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Nov 2020 06:19:51 -0500
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id E92D0500609;
        Wed,  4 Nov 2020 12:19:48 +0100 (CET)
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id 83C9D500596;
        Wed,  4 Nov 2020 12:19:48 +0100 (CET)
Date:   Wed, 4 Nov 2020 12:19:48 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.10-rc2-rt4
Message-ID: <20201104111948.vpykh3ptmysqhmve@beryllium.lan>
References: <20201103195731.erjkgyzxzzjylhui@linutronix.de>
 <20201104103809.bhl2iorbwv6xowtw@beryllium.lan>
 <20201104104617.ueefmpdou4t3t2ce@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104104617.ueefmpdou4t3t2ce@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Nov 04, 2020 at 11:46:17AM +0100, Sebastian Andrzej Siewior wrote:
> How reproducible are these numbers? If these numbers increase between
> rt3 and rt4 then we have a hand full patches to look at.

Usually signaltest generated reproducible results.

I did see those higher numbers also for v5.10-rc1-rt1 (forgot to post
those). For arm64 the max latency was even higher, around 450us. But I
don't have a lot of data so I wouldn't jump to any conclusion.

> just like that?

Yes, Just fired up signaltest 5 times for arm64 and x86_64 with the
latest release. Keep you posted.
