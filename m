Return-Path: <SRS0=2PTS=RZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A108C43381
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Mar 2019 22:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD23421929
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Mar 2019 22:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553292725;
	bh=ujYd7IX7fyxS9/kWpv5Metrq+K6lSudMgEg/9fWswUc=;
	h=Subject:From:To:Cc:Date:List-ID:From;
	b=ThjAxmZbP5ue4SEpylyANmQyumJJpq06VpiE+dwgRh5E5EUkttUc4T4HPF+n4NeKi
	 bCaIJevJrVePSTb+n4lXDNOIBGILssFVjDFMOzUdRBsaGAbx7PgDW0RqENeSrFwPza
	 X8ydbfu/C04Ee+uereA7nKue5ZcbweAMSRZtGVHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfCVWL7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:11:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727733AbfCVWL7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 22 Mar 2019 18:11:59 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C52E2190A;
        Fri, 22 Mar 2019 22:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553292719;
        bh=ujYd7IX7fyxS9/kWpv5Metrq+K6lSudMgEg/9fWswUc=;
        h=Subject:From:To:Cc:Date:From;
        b=LalVyt6VhuaSAnb2Q4d0zzRlPXDswsfEQkSucUWvmx4oJ5ZYXKCwiBnjDgtAL90Cl
         vaGaxCHkBLJkKmGuPnzuigpBseDjLaawUzL9yhkGaBypekFesGIyL0G1+jH2ttakKJ
         5YPziyV1HRVxKmwRbIr5vB0deMF5fySftpdRKOi8=
Message-ID: <1553292717.2307.3.camel@kernel.org>
Subject: [ANNOUNCE] 4.14.106-rt56
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Julia Cartwright <julia@ni.com>
Date:   Fri, 22 Mar 2019 17:11:57 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.14.106-rt56 stable release.

This release is just an update to the new stable 4.14.106 version
and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: fd629860fb77274f443798e02346e153a243be0e

Or to build 4.14.106-rt56 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.106.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.106-rt56.patch.xz


Enjoy!
   
   Tom
