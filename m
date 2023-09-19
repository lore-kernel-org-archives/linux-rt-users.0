Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D7CCE79A8
	for <linux-rt-users@archiver.kernel.org>; Tue, 19 Sep 2023 18:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjISSUe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 19 Sep 2023 14:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjISSUd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 19 Sep 2023 14:20:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2409ED9;
        Tue, 19 Sep 2023 11:20:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A39C433C7;
        Tue, 19 Sep 2023 18:20:26 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.54-rt15
Date:   Tue, 19 Sep 2023 18:19:29 -0000
Message-ID: <169514756994.173357.6057931618138971221@demetrius>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>,
        Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 6.1.54-rt15 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 669c3f02ad623292f0e2ee7aa4b033f4c7333f71

Or to build 6.1.54-rt15 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.54.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.54-rt15.patch.xz


Enjoy!
Clark
