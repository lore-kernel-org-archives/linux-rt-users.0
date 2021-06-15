Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997FFC48BE5
	for <linux-rt-users@archiver.kernel.org>; Tue, 15 Jun 2021 15:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7001461627
	for <linux-rt-users@archiver.kernel.org>; Tue, 15 Jun 2021 15:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhFOPfU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 15 Jun 2021 11:35:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhFOPfT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 15 Jun 2021 11:35:19 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A94D761603;
        Tue, 15 Jun 2021 15:33:14 +0000 (UTC)
Date:   Tue, 15 Jun 2021 11:33:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Song Hui <hui.song_1@nxp.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-rt-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Esben Haabendal <esben@geanix.com>
Subject: Re: commit 3d5bfbd97163 versus -rt
Message-ID: <20210615113312.0dad32bb@oasis.local.home>
In-Reply-To: <5afbc89e-dbc4-3f47-4e61-63a77165aaec@prevas.dk>
References: <5afbc89e-dbc4-3f47-4e61-63a77165aaec@prevas.dk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 15 Jun 2021 14:35:27 +0200
Rasmus Villemoes <rasmus.villemoes@prevas.dk> wrote:

> Reverting commit 3d5bfbd9716318b1ca5c38488aa69f64d38a9aa5 (gpio:
> mpc8xxx: change the gpio interrupt flags.) makes it go away, as does
> disabling CONFIG_PREEMPT_RT or simply booting a vanilla v5.10.42 (where
> that option exists but cannot be selected).

I'm curious if it will also trigger on vanilla v5.10.42 but add to the
kernel command line: threadirqs

Make sure you have CONFIG_IRQ_FORCED_THREADING set too.

Because it appears to be an issue with that being called by the generic
threaded irq infrastructure, which PREEMPT_RT enables automatically.


-- Steve
