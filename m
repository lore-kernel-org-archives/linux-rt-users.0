Return-Path: <SRS0=Yna/=7T=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666E7C433E0
	for <linux-rt-users@archiver.kernel.org>; Sat,  6 Jun 2020 19:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52540207BC
	for <linux-rt-users@archiver.kernel.org>; Sat,  6 Jun 2020 19:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgFFTdx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 6 Jun 2020 15:33:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728351AbgFFTdx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 6 Jun 2020 15:33:53 -0400
Received: from localhost (173-25-40-8.client.mchsi.com [173.25.40.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C75C2067B;
        Sat,  6 Jun 2020 19:33:52 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.9.226-rt145
Date:   Sat, 06 Jun 2020 19:31:27 -0000
Message-ID: <159147188776.590596.6048195704641808309@theseus.lan>
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

I'm pleased to announce the 4.9.226-rt145 stable release.

Note that since 4.9-rt is in maintenance mode, this is just the result
of merging in the latest linux-stable releases; no changes were made to
the PREEMPT_RT patches for the 4.9 tree.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: c301c11d2fbcfbc83b536b0209d5ee24b8fe4d13

Or to build 4.9.226-rt145 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.226.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.226-rt145.patch.xz


You can also build from 4.9.224-rt144 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/incr/patch-4.9.224-rt144-rt145.patch.xz

Enjoy!
Clark
