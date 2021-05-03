Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2A1C433B4
	for <linux-rt-users@archiver.kernel.org>; Mon,  3 May 2021 20:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47AA8611C9
	for <linux-rt-users@archiver.kernel.org>; Mon,  3 May 2021 20:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhECUiJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 3 May 2021 16:38:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhECUiI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 3 May 2021 16:38:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0ABEC61165;
        Mon,  3 May 2021 20:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620074235;
        bh=e9qdCqIfx1vvezxv6qbUuo1yW/47SBtC40qZqqGOUKs=;
        h=Subject:From:To:Date:From;
        b=Rswqtrdo3Op2B/B5Lo8jnRiZxbRS69+GHewzExsZe1q9ip2gNRaAm4BRocMdIMWod
         0sz2/a2R0go3aoLfpoIBcV74bWHK52LjTDbOvectPtyAtO22yZbknYW919/HLDDS6K
         FDEp+OilaAymC/wBitoDeoO5ru24d86cwj9BOJK804eTLXuyJgqLCy/Q2CNkLrn9Gp
         vrD5S6+avu+Z+wTf9S+pBLJYBrjk3r+xT2TvZ5x+VeGhpa0u/3WVZNO9KITpIMrX7c
         uJJ1p6Dme58jmbkFYVzy8tYMLZJ5ysmsVlWe+LNa+oaCaasLntt3IiXWUasKrV1qzA
         afgO71nNv7KYw==
Message-ID: <aa931db0a2b0fd1e2b6bcabd54a031f8496c365b.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.115-rt57
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
Date:   Mon, 03 May 2021 15:37:12 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 5.4.115-rt57 stable release.

This release is just an update to the new stable 5.4.115
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: 726d30934f4269f05ab15ddb3a6375ff000466ff

Or to build 5.4.115-rt57 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.115.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.115-rt57.patch.xz

Enjoy!

   Tom

