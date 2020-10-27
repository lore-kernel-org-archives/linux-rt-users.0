Return-Path: <SRS0=5J30=EC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1333FC388F9
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Oct 2020 10:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C98CA22263
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Oct 2020 10:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898059AbgJ0K0I (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 27 Oct 2020 06:26:08 -0400
Received: from mail.monom.org ([188.138.9.77]:54444 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898032AbgJ0K0E (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Oct 2020 06:26:04 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id CE53550046C;
        Tue, 27 Oct 2020 11:25:47 +0100 (CET)
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id 8B7F9500299;
        Tue, 27 Oct 2020 11:25:47 +0100 (CET)
Date:   Tue, 27 Oct 2020 11:25:47 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.9.1-rt19
Message-ID: <20201027102547.y6wop7j2ovzg2tyx@beryllium.lan>
References: <20201024091838.gzhn2dlx2j7xnixg@linutronix.de>
 <20201027093616.5vn6xinmthxulhvx@beryllium.lan>
 <20201027100049.xtkmjqdwkn7zec2f@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027100049.xtkmjqdwkn7zec2f@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Oct 27, 2020 at 11:00:49AM +0100, Sebastian Andrzej Siewior wrote:
> On 2020-10-27 10:36:16 [+0100], Daniel Wagner wrote:
> > On Sat, Oct 24, 2020 at 11:18:38AM +0200, Sebastian Andrzej Siewior wrote:
> > > I'm pleased to announce the v5.9.1-rt19 patch set. 
> > 
> > FWIW, all tests pass in my lab (by avoiding doing the same stupid
> > mistake as last time...)
> 
> glad to hear.

Well, one thing I need to figure out is how to get pi_stress working
correctly on my machines (that is for all -rt trees, so it's nothing
new). It consistently triggers RCU stall warnings with hackbench as
workload. Clark told me the test only works if there are enough CPUs to
run on. Need to look into it.
