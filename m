Return-Path: <SRS0=GZ+T=5T=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39093C2BA12
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Apr 2020 17:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC70206F6
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Apr 2020 17:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391022AbgDCREr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:04:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40730 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbgDCREr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Apr 2020 13:04:47 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jKPkK-0001Pp-0L; Fri, 03 Apr 2020 19:04:44 +0200
Date:   Fri, 3 Apr 2020 19:04:43 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.6.2-rt1
Message-ID: <20200403170443.pzm24672qo4hufcm@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.6.2-rt1 patch set. 

Changes since v5.4.28-rt19:

  - Rebase to v5.6.2

Known issues
     - It has been pointed out that due to changes to the printk code the
       internal buffer representation changed. This is only an issue if tools
       like `crash' are used to extract the printk buffer from a kernel memory
       image.

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.6.2-rt1

The RT patch against v5.6.2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.6/older/patch-5.6.2-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.6/older/patches-5.6.2-rt1.tar.xz

Sebastian
