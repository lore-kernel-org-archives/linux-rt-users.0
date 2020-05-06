Return-Path: <SRS0=CmHT=6U=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2EFC28CBC
	for <linux-rt-users@archiver.kernel.org>; Wed,  6 May 2020 21:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9C7F2078C
	for <linux-rt-users@archiver.kernel.org>; Wed,  6 May 2020 21:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588799467;
	bh=co9Gra5cR72CT4e3jHvuVVeJJ7RZIRnAiDSBNmDN5Rc=;
	h=Subject:From:To:Date:List-ID:From;
	b=Ja7LMgjhl15X/SwAe3R8vRQcIvkYVqfnqBcFihSa6F/pBNCPST6eSVHHF5KOpUALa
	 1wRS/EkPtJ8bDdYeZX110s/WhL1Hlh8qgYjMwIaKszg50JAg2TvbT/L66jskYgHEqt
	 p9cnQGvJ4yWCUlZjFfPvbsJDdWCTB6XOE5JlX2hw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbgEFVLB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 6 May 2020 17:11:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728621AbgEFVLB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 6 May 2020 17:11:01 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E87D82076D;
        Wed,  6 May 2020 21:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588799460;
        bh=co9Gra5cR72CT4e3jHvuVVeJJ7RZIRnAiDSBNmDN5Rc=;
        h=Subject:From:To:Date:From;
        b=sWEgKcNqMsmVg/xv1WhNIiFKCnvD5ALN8GoBV9oCIvrVhG5FbMT/R6fQz1wEOSrnG
         K4llbe+bWJRaH2AvSBXblP8HTM4gKKnWUOh/xmAKwvJZfuxefjwiwOVbA9bKk44Nk1
         SXetJdWsnnXb4/vc8/LUw2CD8C+ztXntS/RwVvus=
Message-ID: <1140500a306348653f20938d6ebc06bf6cb8b9dd.camel@kernel.org>
Subject: [ANNOUNCE] 4.19.120-rt52
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
        Tom Zanussi <zanussi@kernel.org>
Date:   Wed, 06 May 2020 16:10:58 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.19.120-rt52 stable release.

This release is just an update to the new stable 4.19.120
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 39b4ecd5455033f6ba60e84199ebf6d9454b2efb

Or to build 4.19.120-rt52 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.120.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.120-rt52.patch.xz

Enjoy!

   Tom

