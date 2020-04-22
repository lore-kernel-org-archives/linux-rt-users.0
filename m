Return-Path: <SRS0=xzyi=6G=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6211AC5518B
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Apr 2020 18:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 488512075A
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Apr 2020 18:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgDVSbP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 22 Apr 2020 14:31:15 -0400
Received: from mail.monom.org ([188.138.9.77]:46460 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgDVSbP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Apr 2020 14:31:15 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 2A26B50047C;
        Wed, 22 Apr 2020 20:31:13 +0200 (CEST)
Received: from localhost (b9168f17.cgn.dg-w.de [185.22.143.23])
        by mail.monom.org (Postfix) with ESMTPSA id D833A50029E;
        Wed, 22 Apr 2020 20:31:12 +0200 (CEST)
Date:   Wed, 22 Apr 2020 20:31:12 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.6.4-rt3
Message-ID: <20200422183112.nfbxob7gv33fsqgp@beryllium.lan>
References: <20200416164510.kbrklqahdng5uhij@linutronix.de>
 <20200422173359.inlikfugjzsjyyp6@beryllium.lan>
 <20200422181232.a33sfm6udmy2zcvy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422181232.a33sfm6udmy2zcvy@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Apr 22, 2020 at 08:12:32PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-04-22 19:33:59 [+0200], Daniel Wagner wrote:
> > Hi Sebastian,
> 
> Hi Daniel,
> 
> > On Thu, Apr 16, 2020 at 06:45:10PM +0200, Sebastian Andrzej Siewior wrote:
> > > I'm pleased to announce the v5.6.4-rt3 patch set.
> > 
> > Finally solved my lab setup issue (NFS wants to use TCP per default now) and
> > all looks good. The fallout on rt-tests-migrate was a configuration bug on my
> > side. All rt-tests work and pass on my three system (Beaglebone Black 32bit,
> > RPi3 64bit and old x86_64 Core2 Duo CPU E8400 box in 64bit mode).
> 
> So there is no backtrace of any kind in any configuration (bug or no
> bug)?

Correct, all tests pass and from a quick glance there are no backtraces in the
logs. IIRC, lava detects warnings and backtraces in the logs and marks them as
error.

v5.6.4-rt seems to be in a good shape as far my quick tests tell me.
