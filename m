Return-Path: <SRS0=qep6=D2=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60FDC433E7
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Oct 2020 08:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FC4D2225F
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Oct 2020 08:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbgJSIpu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Oct 2020 04:45:50 -0400
Received: from mail.monom.org ([188.138.9.77]:52672 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729315AbgJSIpu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Oct 2020 04:45:50 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id D8A51500592;
        Mon, 19 Oct 2020 10:45:47 +0200 (CEST)
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id 5618350011E;
        Mon, 19 Oct 2020 10:45:47 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
Subject: [ANNOUNCE] 4.4.240-rt209
Date:   Mon, 19 Oct 2020 08:40:28 -0000
Message-ID: <160309682871.27031.1989836720936657074@beryllium>
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

I'm pleased to announce the 4.4.240-rt209 stable release.

This is an update to latest stable release. There are no RT changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: 8c4598122932f2f0800b5bb18fb71d84a635dd3e

Or to build 4.4.240-rt209 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.240.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.240-rt209.patch.xz

Enjoy!
Daniel
