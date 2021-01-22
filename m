Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C97C433DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Jan 2021 18:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE50323A9C
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Jan 2021 18:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbhAVSLB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 22 Jan 2021 13:11:01 -0500
Received: from mail.monom.org ([188.138.9.77]:52006 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729583AbhAVSIs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 22 Jan 2021 13:08:48 -0500
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id C2BE150065D;
        Fri, 22 Jan 2021 19:08:03 +0100 (CET)
Received: from localhost (unknown [94.31.99.195])
        by mail.monom.org (Postfix) with ESMTPSA id 0E6CF500296;
        Fri, 22 Jan 2021 19:08:03 +0100 (CET)
From:   Daniel Wagner <dwagner@suse.de>
Subject: [ANNOUNCE] 4.4.252-rt213
Date:   Fri, 22 Jan 2021 18:06:54 -0000
Message-ID: <161133881498.6875.6130616051575583051@beryllium>
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

I'm pleased to announce the 4.4.252-rt213 stable release.

This release is just an update to the new stable 4.4.252 version.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: d35ff0a17ed3694aeda12927e2379c8d5641a4e8

Or to build 4.4.252-rt213 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.252.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.252-rt213.patch.xz

Enjoy!
Daniel
