Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E850AC43381
	for <linux-rt-users@archiver.kernel.org>; Fri, 25 Dec 2020 18:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B320E22203
	for <linux-rt-users@archiver.kernel.org>; Fri, 25 Dec 2020 18:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgLYSvO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 25 Dec 2020 13:51:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:52182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgLYSvO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 25 Dec 2020 13:51:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0DBA22203;
        Fri, 25 Dec 2020 18:50:33 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.14.212-rt102
Date:   Fri, 25 Dec 2020 18:48:56 -0000
Message-ID: <160892213672.505134.12058823794527484171@puck.lan>
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

I'm pleased to announce the 4.14.212-rt102 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: cc763276d939207b3424090ab618c3e52f7d49de

Or to build 4.14.212-rt102 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.212.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.212-rt102.patch.xz


You can also build from 4.14.209-rt101 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.209-rt101-rt102.patch.xz

Enjoy!
Clark
