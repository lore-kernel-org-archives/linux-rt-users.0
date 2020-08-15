Return-Path: <SRS0=Sn7D=BZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9865C433E1
	for <linux-rt-users@archiver.kernel.org>; Sat, 15 Aug 2020 22:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E7F32063A
	for <linux-rt-users@archiver.kernel.org>; Sat, 15 Aug 2020 22:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgHOWNA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:13:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728730AbgHOWK1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 15 Aug 2020 18:10:27 -0400
Received: from localhost (173-25-40-8.client.mchsi.com [173.25.40.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 288FA22EBE;
        Sat, 15 Aug 2020 13:28:01 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.14.193-rt92
Date:   Sat, 15 Aug 2020 13:26:45 -0000
Message-ID: <159749800552.1746232.11751078271440052247@theseus.lan>
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

I'm pleased to announce the 4.14.193-rt92 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 832a83d1bb8ce9a523aef196b40c17318f0a6e52

Or to build 4.14.193-rt92 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.193.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.193-rt92.patch.xz


You can also build from 4.14.192-rt91 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.192-rt91-rt92.patch.xz

Enjoy!
Clark
