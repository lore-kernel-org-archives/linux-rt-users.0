Return-Path: <SRS0=aCPW=2H=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1BAC43603
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Dec 2019 21:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279EC206E0
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Dec 2019 21:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfLQVQb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Dec 2019 16:16:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56219 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfLQVQb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Dec 2019 16:16:31 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ihKCi-0005yi-0H; Tue, 17 Dec 2019 22:16:28 +0100
Date:   Tue, 17 Dec 2019 22:16:27 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.4.3-rt1
Message-ID: <20191217211627.gap55jtxt55yraok@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.4.3-rt1 patch set. 

Changes since v5.2.21-rt15:

  - Rebase to v5.4

  - CONFIG_PREEMPT_RT is part of v5.4. While rebasing I merged
    CONFIG_PREEMPT_RT_BASE and CONFIG_PREEMPT_RT_FULL into
    CONFIG_PREEMPT_RT. This switch depends on ARCH_SUPPORTS_RT (which is
    currently provided by arm, powerpc and x86) and EXPERT.

Known issues
     - None

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.4.3-rt1

The RT patch against v5.4.3 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/older/patch-5.4.3-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/older/patches-5.4.3-rt1.tar.xz

Sebastian
