Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FBFC88CB2
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Jun 2023 15:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239683AbjFLPps (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 12 Jun 2023 11:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239708AbjFLPpp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Jun 2023 11:45:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31279172B;
        Mon, 12 Jun 2023 08:45:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3714623CA;
        Mon, 12 Jun 2023 15:45:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6360C433D2;
        Mon, 12 Jun 2023 15:45:27 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.33-rt11
Date:   Mon, 12 Jun 2023 15:44:10 -0000
Message-ID: <168658465081.107634.18340630132654176106@demetrius>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 6.1.33-rt11 stable release. This is a merge of the v6.1.33
stable update into the v6.1-rt tree.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 3f9ca5f166e5796bd21176f356a479e505ce7760

Or to build 6.1.33-rt11 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.33.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.33-rt11.patch.xz


Enjoy!
Clark
