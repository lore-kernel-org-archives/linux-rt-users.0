Return-Path: <SRS0=I6ff=4W=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C5BC3F2D7
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Mar 2020 15:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6640A2073B
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Mar 2020 15:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCEPra (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:47:30 -0500
Received: from mail.monom.org ([188.138.9.77]:60182 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgCEPra (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 5 Mar 2020 10:47:30 -0500
X-Greylist: delayed 547 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Mar 2020 10:47:29 EST
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 690A3500535;
        Thu,  5 Mar 2020 16:38:21 +0100 (CET)
Received: from localhost (b9168f9a.cgn.dg-w.de [185.22.143.154])
        by mail.monom.org (Postfix) with ESMTPSA id C21C0500316;
        Thu,  5 Mar 2020 16:38:20 +0100 (CET)
Date:   Thu, 05 Mar 2020 16:38:20 +0100
From:   Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.215-rt192
Data:   Thu, 05 Mar 2020 15:35:48 -0000
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>, Pavel Machek <pavel@denx.de>
Message-Id: <20200305153821.690A3500535@mail.monom.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.4.215-rt192 stable release.

This release is just an update to the new stable 4.4.215 version
and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: 604d02652563e86888169fd24301c4c3855eb6f2

Or to build 4.4.215-rt192 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.215.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.215-rt192.patch.xz

Enjoy!
   Daniel
