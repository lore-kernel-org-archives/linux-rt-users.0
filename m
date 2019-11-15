Return-Path: <SRS0=Wzxq=ZH=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA095C432C3
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Nov 2019 08:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769F420732
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Nov 2019 08:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfKOI44 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 15 Nov 2019 03:56:56 -0500
Received: from mail.monom.org ([188.138.9.77]:49562 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfKOI4z (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 15 Nov 2019 03:56:55 -0500
X-Greylist: delayed 499 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Nov 2019 03:56:55 EST
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id D37BC50064D;
        Fri, 15 Nov 2019 09:48:34 +0100 (CET)
Received: from localhost (b9168fab.cgn.dg-w.de [185.22.143.171])
        by mail.monom.org (Postfix) with ESMTPSA id 535655004AF;
        Fri, 15 Nov 2019 09:48:34 +0100 (CET)
Date:   Fri, 15 Nov 2019 09:48:33 +0100
From:   Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.201-rt189
Data:   Fri, 15 Nov 2019 08:39:05 -0000
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>, Pavel Machek <pavel@denx.de>
Message-Id: <20191115084834.D37BC50064D@mail.monom.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.4.201-rt189 stable release.

This release is just an update to the new stable 4.4.201 version and
no RT specific changes have been made. -rt188 points to the tiny merge
conflict in a Makefile, just in case you are wondering.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: fd812331da09b85713fdb0f3ce44640180dfad97

Or to build 4.4.201-rt189 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.201.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.201-rt189.patch.xz

Enjoy!
   Daniel
