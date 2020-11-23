Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8962C63697
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Nov 2020 18:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7505120717
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Nov 2020 18:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390537AbgKWSJQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 23 Nov 2020 13:09:16 -0500
Received: from mail.monom.org ([188.138.9.77]:40258 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388481AbgKWSJP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 23 Nov 2020 13:09:15 -0500
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 368B750029D;
        Mon, 23 Nov 2020 19:09:13 +0100 (CET)
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id A26A6500239;
        Mon, 23 Nov 2020 19:09:12 +0100 (CET)
From:   Daniel Wagner <dwagner@suse.de>
Subject: [ANNOUNCE] 4.4.245-rt211
Date:   Mon, 23 Nov 2020 18:07:45 -0000
Message-ID: <160615486580.26049.952306950325962162@beryllium>
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
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.4.245-rt211 stable release.

This release is just an update to the new stable 4.4.245 version
and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: db62f88a6505883fff4282c7d44d02858b505c7e

Or to build 4.4.245-rt211 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.245.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.245-rt211.patch.xz

Enjoy!
Daniel
