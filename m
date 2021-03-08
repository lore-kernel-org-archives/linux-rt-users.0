Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D252C433DB
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Mar 2021 19:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 439C4652AC
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Mar 2021 19:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhCHTgO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Mar 2021 14:36:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:50258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229790AbhCHTgK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Mar 2021 14:36:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4AEAE65290;
        Mon,  8 Mar 2021 19:36:10 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.14.224-rt107
Date:   Mon, 08 Mar 2021 19:33:59 -0000
Message-ID: <161523203964.1591892.770429705933119269@puck.lan>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.14.224-rt107 stable release.

Note that there was a futex/mutex code collision when I merge v4.14.218. I believe
that it's fixed correctly but anyone with suspicions about futex/mutex behavior
in this release, that's where I'd start looking.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: fd06bf8d39083ae08e14e5629bd23b1355eb358b

Or to build 4.14.224-rt107 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.224.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.224-rt107.patch.xz


You can also build from 4.14.215-rt105 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.215-rt105-rt107.patch.xz

Enjoy!
Clark

