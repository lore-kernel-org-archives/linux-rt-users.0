Return-Path: <SRS0=zqoB=AT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD69C433DF
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Jul 2020 19:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B087D2065D
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Jul 2020 19:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgGHTVx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 8 Jul 2020 15:21:53 -0400
Received: from mail.monom.org ([188.138.9.77]:52584 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgGHTVx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Jul 2020 15:21:53 -0400
X-Greylist: delayed 343 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jul 2020 15:21:52 EDT
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id D8687500626;
        Wed,  8 Jul 2020 21:16:07 +0200 (CEST)
Received: from localhost (b9168f17.cgn.dg-w.de [185.22.143.23])
        by mail.monom.org (Postfix) with ESMTPSA id 2E67C5004C4;
        Wed,  8 Jul 2020 21:16:07 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
Subject: [ANNOUNCE] 4.4.229-rt200
Date:   Wed, 08 Jul 2020 18:44:02 -0000
Message-ID: <159423384250.24491.10602573106875114227@beryllium>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.4.229-rt200 stable release.

This release is just an update to the new stable 4.4.215 version.

Note: This update required dealing with a conflict in net/core/dev.c, where
devnet_rename_seq was moved from a seqence count to an RWSEM and renamed
to devnet_rename_sem. If you encounter runtime issues that show tracebacks
in net/core/dev.c, please let me know.

Patch "net: Add a mutex around devnet_rename_seq" dropped in favour of
602c47fbf46b ("net: core: device_rename: Use rwsem instead of a seqcount")

Known issues:

  sigwaittest with hackbench as workload is able to trigger a crash on x86_64,
  the same as reported for the v4.4.220-rt196 release. The crash seems to
  be triggered by a BPF program. IIRC, BPF was never supported in v4.4-rt
  and I just forgot to disable in my configuration.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: dd9655ee04bfb54f781974e3074a0caeb2423623

Or to build 4.4.229-rt200 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.229.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.229-rt200.patch.xz

Enjoy!
Daniel
