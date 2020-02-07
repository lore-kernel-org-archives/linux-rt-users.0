Return-Path: <SRS0=JiWK=33=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E9FC2BA83
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Feb 2020 21:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5B621775
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Feb 2020 21:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581111714;
	bh=1XSHgg3xsancQIqyXulA7qODdtZSBt+QpsOi65jd20w=;
	h=Subject:From:To:Date:List-ID:From;
	b=oeCPC0f/Vq2zIbbwrVPqgo26Mrjq4x7Ij8EZFZq06Wazf0OZs2WD6XTAbPyQ6T1V9
	 sr9UhQ/nYkwqQDjZjSUQLOYwO/NFyp/Qgb2UuhzWgXX7soNgSchh+XgZuam4NP+kaF
	 ZJdGvSJR289Ge88/AuCyO6z6Q43H3Xk2QWdJrSK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgBGVlv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 Feb 2020 16:41:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:59550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbgBGVlu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 Feb 2020 16:41:50 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9920520720;
        Fri,  7 Feb 2020 21:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581111710;
        bh=1XSHgg3xsancQIqyXulA7qODdtZSBt+QpsOi65jd20w=;
        h=Subject:From:To:Date:From;
        b=2AdKwtE2M1iA3so13cdptK5H2IrZUsswCFDdjJYmFJc6uA+AJHHI1XZuBT4/ZUbmI
         zmk1Ii52SJKY7cVJVkKXOrfzPewYLhtHu94aNFWkqSom63zYXgmpBY2m0DQi/wJxoL
         Z8ZddpajBR7KTE80/RWXKb53tfkO6BTKgkkLF9/M=
Message-ID: <1581111708.21499.3.camel@kernel.org>
Subject: [ANNOUNCE] 4.14.170-rt74
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Date:   Fri, 07 Feb 2020 15:41:48 -0600
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.14.170-rt74 stable release.

This release is just an update to the new stable 4.14.170
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: a5ba91f90efefa03b75dba0a7268d1911d2700cc

Or to build 4.14.170-rt74 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.170.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.170-rt74.patch.xz

Enjoy!

   Tom
