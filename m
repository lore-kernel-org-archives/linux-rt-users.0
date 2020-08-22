Return-Path: <SRS0=FO+3=CA=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818DAC433E1
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 Aug 2020 17:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64BB6207DA
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 Aug 2020 17:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgHVRef (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 22 Aug 2020 13:34:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728325AbgHVRee (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 22 Aug 2020 13:34:34 -0400
Received: from localhost (173-25-40-8.client.mchsi.com [173.25.40.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03DA5206C0;
        Sat, 22 Aug 2020 17:34:33 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.9.233-rt151
Date:   Sat, 22 Aug 2020 17:33:58 -0000
Message-ID: <159811763835.399127.13887910453912859384@theseus.lan>
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

I'm pleased to announce the 4.9.233-rt151 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: ac50e0392167afde7bc752ac240d2adbee56c483

Or to build 4.9.233-rt151 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.233.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.233-rt151.patch.xz


You can also build from 4.9.232-rt150 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/incr/patch-4.9.232-rt150-rt151.patch.xz

Enjoy!
Clark
