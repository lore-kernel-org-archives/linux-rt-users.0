Return-Path: <SRS0=wHCa=VI=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6D9C74A35
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Jul 2019 15:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406AE216B7
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Jul 2019 15:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbfGKPnH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Jul 2019 11:43:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50388 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbfGKPnH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Jul 2019 11:43:07 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hlbDs-0001YQ-Jy; Thu, 11 Jul 2019 17:43:04 +0200
Date:   Thu, 11 Jul 2019 17:43:04 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.2-rt1
Message-ID: <20190711154304.gcadninxohyznc4k@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.2-rt1 patch set. 

Changes since v5.0.21-rt16:

  - Rebase to v5.2

First release in the v5.2 series. I had in testing for the last few
days and did not notice anything unusual.

Known issues
     - rcutorture is currently broken on -RT. Reported by Juri Lelli.

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.2-rt1

The RT patch against v5.2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/older/patch-5.2-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/older/patches-5.2-rt1.tar.xz

Sebastian
