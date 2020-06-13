Return-Path: <SRS0=1l0C=72=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC0CC433E0
	for <linux-rt-users@archiver.kernel.org>; Sat, 13 Jun 2020 15:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6EBD2078A
	for <linux-rt-users@archiver.kernel.org>; Sat, 13 Jun 2020 15:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgFMPZP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 13 Jun 2020 11:25:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726361AbgFMPZP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 13 Jun 2020 11:25:15 -0400
Received: from localhost (173-25-40-8.client.mchsi.com [173.25.40.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2DC6206B7;
        Sat, 13 Jun 2020 15:25:14 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.14.184-rt84
Date:   Sat, 13 Jun 2020 15:22:02 -0000
Message-ID: <159206172278.1098109.8375845910679325527@theseus.lan>
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

I'm pleased to announce the 4.14.184-rt84 stable release.

In addition to the 4.14.184 stable release merge, this release contains
the following three RT fixes:

5bba64129745 tasklet: Address a race resulting in double-enqueue
886fa0cf47d6 mm: slub: Always flush the delayed empty slubs in flush_all()
8500870d1580 fs/dcache: Include swait.h header

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 7c010a975cdc47eba4341b50e6262aa5fb53c17e

Or to build 4.14.184-rt84 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.184.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.184-rt84.patch.xz


You can also build from 4.14.183-rt83 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.183-rt83-rt84.patch.xz

Enjoy!
Clark
