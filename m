Return-Path: <SRS0=LljW=DT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FC3C433DF
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Oct 2020 09:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB6B420776
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Oct 2020 09:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbgJLJu0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 12 Oct 2020 05:50:26 -0400
Received: from mail.monom.org ([188.138.9.77]:46660 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgJLJuZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Oct 2020 05:50:25 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id BAC9F5005E8;
        Mon, 12 Oct 2020 11:50:22 +0200 (CEST)
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id 23E38500103;
        Mon, 12 Oct 2020 11:50:22 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
Subject: [ANNOUNCE] 4.4.238-rt208
Date:   Mon, 12 Oct 2020 09:49:32 -0000
Message-ID: <160249617227.24514.6186022932302074164@beryllium>
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

I'm pleased to announce the 4.4.238-rt208 stable release.

This is  an update to the latest stable Linux release. No RT spefic
changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: ed649ee804194368c828b19e2821a6d8bfb8221b

Or to build 4.4.238-rt208 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.238.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.238-rt208.patch.xz

Enjoy!
Daniel
