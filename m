Return-Path: <SRS0=gxMZ=CN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB17C28E83
	for <linux-rt-users@archiver.kernel.org>; Fri,  4 Sep 2020 12:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FE732084D
	for <linux-rt-users@archiver.kernel.org>; Fri,  4 Sep 2020 12:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbgIDMD3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 4 Sep 2020 08:03:29 -0400
Received: from mail.monom.org ([188.138.9.77]:54882 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730163AbgIDMDI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 4 Sep 2020 08:03:08 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id C1FF550035A;
        Fri,  4 Sep 2020 14:02:57 +0200 (CEST)
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id 1963D50016C;
        Fri,  4 Sep 2020 14:02:57 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
Subject: [ANNOUNCE] 4.4.234-rt205
Date:   Fri, 04 Sep 2020 11:55:24 -0000
Message-ID: <159922052495.29454.693485315909832584@beryllium>
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
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.4.234-rt205 stable release.

This updates the v4.4-rt almost to the latest stable release. Just
can't keep up with Greg. Anyway there was a small merge conflict in
page_alloc.c but with the help from Vlastimil Babka it was easy to
resolve. Thanks!

Also I included Matt Fleming's fix for the signal code:

  signal: Prevent double-free of user struct

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: 89c4f38681e9b025859146f144f167ef7a3dd83f

Or to build 4.4.234-rt205 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.234.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.234-rt205.patch.xz


Enjoy!
Daniel
