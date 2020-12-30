Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6642AC433DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 30 Dec 2020 21:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 331A12072E
	for <linux-rt-users@archiver.kernel.org>; Wed, 30 Dec 2020 21:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgL3Vfy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 30 Dec 2020 16:35:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:56914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbgL3Vfy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 30 Dec 2020 16:35:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 734F620729;
        Wed, 30 Dec 2020 21:35:13 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.14.213-rt103
Date:   Wed, 30 Dec 2020 21:34:04 -0000
Message-ID: <160936404471.1176951.9539710153114005701@puck.lan>
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

I'm pleased to announce the 4.14.213-rt103 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: af29de213eb180fe8a0db0d4aadde83f1a74be13

Or to build 4.14.213-rt103 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.213.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.213-rt103.patch.xz


You can also build from 4.14.212-rt102 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.212-rt102-rt103.patch.xz

Enjoy!
Clark

