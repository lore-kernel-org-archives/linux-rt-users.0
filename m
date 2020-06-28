Return-Path: <SRS0=bPli=AJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6D1C433E0
	for <linux-rt-users@archiver.kernel.org>; Sun, 28 Jun 2020 16:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B94E020772
	for <linux-rt-users@archiver.kernel.org>; Sun, 28 Jun 2020 16:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgF1QIU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 28 Jun 2020 12:08:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgF1QIU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 28 Jun 2020 12:08:20 -0400
Received: from localhost (173-25-40-8.client.mchsi.com [173.25.40.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9531C2071A;
        Sun, 28 Jun 2020 16:08:19 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.14.186-rt86
Date:   Sun, 28 Jun 2020 16:03:20 -0000
Message-ID: <159336020086.43014.7500398284585690610@theseus.lan>
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
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.14.186-rt86 stable release.

Note: This update required dealing with a conflict in net/core/dev.c, where
devnet_rename_seq was moved from a seqence count to an RWSEWM and renamed
to devnet_rename_sem. If you encounter runtime issues that show tracebacks
in net/core/dev.c, please let me know.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: a7cf9b98ed7ef70e74661efb46488f0f842f1639

Or to build 4.14.186-rt86 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.186.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.186-rt86.patch.xz


You can also build from 4.14.185-rt85 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.185-rt85-rt86.patch.xz

Enjoy!
Clark
