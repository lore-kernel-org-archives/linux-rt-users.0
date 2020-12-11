Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B37C4361B
	for <linux-rt-users@archiver.kernel.org>; Fri, 11 Dec 2020 21:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 772ED24058
	for <linux-rt-users@archiver.kernel.org>; Fri, 11 Dec 2020 21:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732785AbgLKTXW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 11 Dec 2020 14:23:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:58702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731470AbgLKTXT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 11 Dec 2020 14:23:19 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A21824058;
        Fri, 11 Dec 2020 19:22:37 +0000 (UTC)
Date:   Fri, 11 Dec 2020 14:22:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: [ANNOUNCE] 5.4.82-rt45
Message-ID: <20201211142236.1884a443@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 5.4.82-rt45 stable release.

[ Note: There's a known issue that still needs to be fixed:
  https://lore.kernel.org/r/20201116172221.25ymeo62tgmzwe4z@linutronix.de
  Will be fixing this next (and seeing if there's anything else needing
  to be backported. ]

This release is just an update to the new stable 5.4.82 version
and no RT specific changes have been made.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: 609cce000909f44148cbd08c1f8acdb9b43379df


Or to build 5.4.82-rt45 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.82.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.82-rt45.patch.xz




Enjoy,

-- Steve

