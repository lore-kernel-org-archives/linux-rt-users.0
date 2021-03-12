Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD798C433E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Mar 2021 22:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A1CE64F69
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Mar 2021 22:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbhCLWnu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 12 Mar 2021 17:43:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235499AbhCLWnn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 12 Mar 2021 17:43:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E8A164F12;
        Fri, 12 Mar 2021 22:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615589023;
        bh=vRsyjYAc06/w7+bJVqYXFD1dEr+bqMQbHAgSifRcWws=;
        h=Subject:From:To:Date:From;
        b=gv1V2aTBK8aU5gIGB9+GXrn24qG3sNSCaCcfqSiEBGFk0yV6kypuUQ9iggROF+FNF
         fS3wywEsap1u3bT/kghlsUM4zWfVwx1Ae9eKBkmt5X7/+c3xKj3i25QuBdA2073qCD
         KJeT51WzxRnYJ04Af3QHtLMbo9WAYD9+TtO+X32xVv5QFtU2wTfikSf34JGYoS5rfs
         4W0kfkLAUj1KI1Qu2XYTdsV4qGReJJbnH7P0iDVISXB8G5OAV1YWUos+UXplxRX9fY
         8xvSRFdgQiS/XqGhXb5laiRhmGrlys2n/jLyfO4nlAlqz5zcSL9ZDRM1h/rJPOB8wn
         5GQD5MrqOAxrA==
Message-ID: <41dbfa16aeaf441ec49268372263183edeff2e94.camel@kernel.org>
Subject: [ANNOUNCE] 4.19.180-rt73
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
        Pavel Machek <pavel@denx.de>, Tom Zanussi <zanussi@kernel.org>
Date:   Fri, 12 Mar 2021 16:43:41 -0600
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.19.180-rt73 stable release.

This release is just an update to the new stable 4.19.180
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: fffa72a0bb5b707d7b437cfdbce1a84bae419f2e

Or to build 4.19.180-rt73 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.180.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.180-rt73.patch.xz

Enjoy!

   Tom

