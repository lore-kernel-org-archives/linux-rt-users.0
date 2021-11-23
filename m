Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30615C433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Nov 2021 16:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237846AbhKWQPx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:15:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:39428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231180AbhKWQPx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 Nov 2021 11:15:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29BAD60F5A;
        Tue, 23 Nov 2021 16:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637683965;
        bh=Btl/k5wkTfXVrQ9FWrfjUa3DuDxvXmrsFCsAOrx4ZSg=;
        h=Subject:From:To:Date:From;
        b=NrRtYCPNhPf8ZLrbGCqvL+Z18KkLIp3/NGy1MZ5yBeMXoXdqEJFc9Rr5njzBc/FN6
         3DwE7UW6CFRN7ME5e0C/eNJtNaJgx5fQyc3J3rHzz9Dzdo+/oxjLji+S6sTv2ma7Wo
         Hh4Z5FMYMDWfEwf70XCiGr8FZNn0Jl2vQSqWaeEB/inyY2xfslRgBk30vKjLSF50Zk
         U2sfxvBf5vGLtLC5H1PPlSJd2UyGt6x74GJv3taubbhCSqUv9HW6/gdAKlGEKJSc9P
         wl2gR4h9mKZZ9lcDFM/xcfWBKnrc3+G6050HQJ6+/mAy0B3iPuBr7r73iqHLqfmo+H
         uDG+uK5aGQ4Aw==
Message-ID: <5653da59c25a12ec2bb1cac0957571daa0d86e76.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.161-rt66
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Date:   Tue, 23 Nov 2021 10:12:42 -0600
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 5.4.161-rt66 stable release.

This release is just an update to the new stable 5.4.161
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: a72653aef7332ed81f0138da49e3c2ef9b1a8665

Or to build 5.4.161-rt66 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.161.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.161-rt66.patch.xz

Enjoy!

   Tom

