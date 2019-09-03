Return-Path: <SRS0=pNo3=W6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63672C3A5A2
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Sep 2019 07:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C4F21881
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Sep 2019 07:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfICHwX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 3 Sep 2019 03:52:23 -0400
Received: from mail.monom.org ([188.138.9.77]:57608 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfICHwX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 3 Sep 2019 03:52:23 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 587A6500696;
        Tue,  3 Sep 2019 09:52:21 +0200 (CEST)
Received: from localhost (b9168f76.cgn.dg-w.de [185.22.143.118])
        by mail.monom.org (Postfix) with ESMTPSA id C6A2B5001C9;
        Tue,  3 Sep 2019 09:52:20 +0200 (CEST)
Date:   Tue, 03 Sep 2019 09:52:20 +0200
From:   Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.190-rt187
Data:   Tue, 03 Sep 2019 07:40:28 -0000
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>, Pavel Machek <pavel@denx.de>
Message-Id: <20190903075221.587A6500696@mail.monom.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.4.190-rt187 stable release.

This release is just an update to the new stable 4.4.190 version
and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: fe150dfd33d9f7e53823755788dd23bce58236bd

Or to build 4.4.190-rt187 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.190.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.190-rt187.patch.xz

Enjoy!
   Daniel
