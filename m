Return-Path: <SRS0=MKa8=2J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E78EC43603
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Dec 2019 19:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAFB206EC
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Dec 2019 19:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfLSTCp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:02:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:42616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729498AbfLSStN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 19 Dec 2019 13:49:13 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38B8F24680;
        Thu, 19 Dec 2019 18:49:12 +0000 (UTC)
Date:   Thu, 19 Dec 2019 13:49:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [ANNOUNCE] 4.19.90-rt35
Message-ID: <20191219134910.29a2ff23@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 4.19.90-rt35 stable release.


This release is just an update to the new stable 4.19.90 version
and no RT specific changes have been made.

Note, I had to revert 64694b276d74 from stable 4.19 (which was upstream
commit 7faa313f05c) because it depended on commit 396244692232 which
was not added until 5.0, and this broke arm64.

Link: https://lore.kernel.org/r/20191214021403.GA1357@home.goodmis.org

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 5e45a0ea52bc99c515828b0ef501cb320a17f383


Or to build 4.19.90-rt35 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.90.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.90-rt35.patch.xz




Enjoy,

-- Steve

