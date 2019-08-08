Return-Path: <SRS0=QXCx=WE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0D4C433FF
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 20:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB932184E
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 20:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404255AbfHHUFz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:05:55 -0400
Received: from mail.monom.org ([188.138.9.77]:37838 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404174AbfHHUFz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Aug 2019 16:05:55 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 8BCFE500294;
        Thu,  8 Aug 2019 22:05:53 +0200 (CEST)
Received: from localhost (b9168f76.cgn.dg-w.de [185.22.143.118])
        by mail.monom.org (Postfix) with ESMTPSA id C43F6500241;
        Thu,  8 Aug 2019 22:05:52 +0200 (CEST)
Date:   Thu, 08 Aug 2019 22:05:52 +0200
From:   Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.188-rt185
Data:   Thu, 08 Aug 2019 20:01:31 -0000
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>, Pavel Machek <pavel@denx.de>
Message-Id: <20190808200553.8BCFE500294@mail.monom.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.4.188-rt185 stable release.

This release is just an update to the new stable 4.4.188 version
and no RT specific changes have been made.

The know issue from last time is now resolved. The missing patch for
-rt has is now also part of stable 1ab1512366d4 ("mm, vmstat: make
quiet_vmstat lighter"). There was a patch missing fece2f828ffe
("vmstat: Remove BUG_ON from vmstat_update"). With this patch the
NVIDIA boards (at least Tegra K1) should work again.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: bc22d8bc8f5566ba4fe13115fb11d843d140f37c

Or to build 4.4.188-rt185 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.188.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.188-rt185.patch.xz

Enjoy!
   Daniel
