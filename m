Return-Path: <SRS0=oRme=CV=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AFEC433E2
	for <linux-rt-users@archiver.kernel.org>; Sat, 12 Sep 2020 00:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F613221E3
	for <linux-rt-users@archiver.kernel.org>; Sat, 12 Sep 2020 00:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgILAEY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 11 Sep 2020 20:04:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbgILAEN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 11 Sep 2020 20:04:13 -0400
Received: from localhost (173-25-40-8.client.mchsi.com [173.25.40.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29A8B21D91;
        Sat, 12 Sep 2020 00:04:13 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.14.197-rt95
Date:   Fri, 11 Sep 2020 23:55:22 -0000
Message-ID: <159986852267.467714.15755814782200263061@theseus.lan>
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

I'm pleased to announce the 4.14.197-rt95 stable release.

In addition to the merge of the .196 and .197 stable release tags, this
release contains three RT specific fixes:

eba893980303 net: xfrm: fix compress vs decompress serialization
23d7ce6a6ca9 Bluetooth: Acquire sk_lock.slock without disabling interrupts
c0e17a81059e signal: Prevent double-free of user struct

Note the above sha1's are for the regular merge branch. The rebase branch
commits are:

59e53fae6d31 net: xfrm: fix compress vs decompress serialization
3eb9ffa69d28 Bluetooth: Acquire sk_lock.slock without disabling interrupts
89ac4fb20261 signal: Prevent double-free of user struct

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 4b77f0c11a53ef0ca870f3d7a05d3de62d3dfd0a

Or to build 4.14.197-rt95 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.197.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.197-rt95.patch.xz


You can also build from 4.14.195-rt94 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.195-rt94-rt95.patch.xz

Enjoy!
Clark
