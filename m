Return-Path: <SRS0=FO+3=CA=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E67EC433DF
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 Aug 2020 17:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39DE12078D
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 Aug 2020 17:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgHVRFI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 22 Aug 2020 13:05:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgHVRFH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 22 Aug 2020 13:05:07 -0400
Received: from localhost (173-25-40-8.client.mchsi.com [173.25.40.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 606ED2072D;
        Sat, 22 Aug 2020 17:05:07 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.14.194-rt93
Date:   Sat, 22 Aug 2020 17:04:20 -0000
Message-ID: <159811586094.330999.6304055427779310413@theseus.lan>
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

I'm pleased to announce the 4.14.194-rt93 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 12bc7963be92af2155fb661bea9f3a420338b54d

Or to build 4.14.194-rt93 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.194.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.194-rt93.patch.xz


You can also build from 4.14.193-rt92 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.193-rt92-rt93.patch.xz

Enjoy!
Clark
