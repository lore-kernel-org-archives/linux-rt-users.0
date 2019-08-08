Return-Path: <SRS0=QXCx=WE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13695C433FF
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94E821743
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565293460;
	bh=OQrIwJerPWfoySkt0blmJAgpcXMR3umUGbRJrpHLS4U=;
	h=Subject:From:To:Date:List-ID:From;
	b=dZnzFHK1u6Wbyo/jdoZKdGUp7iC7HLtKXmcJrPO659ziXQgb4qWncoFRy8oFPdMj/
	 VrBEBFsN0jisPJBhwfFDTE60nE2Rr0JxaJE/9IhHwM4lHGHFk6x9jkhVL9FfNplr4u
	 llQT49vvUTm5r91Iqnc8BlswyaDrW1JkbGmsGRps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732544AbfHHToQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:44:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730768AbfHHToQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Aug 2019 15:44:16 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ADC62173E;
        Thu,  8 Aug 2019 19:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565293455;
        bh=OQrIwJerPWfoySkt0blmJAgpcXMR3umUGbRJrpHLS4U=;
        h=Subject:From:To:Date:From;
        b=pL9LX3dk6VjvCGyLizf4P3MedKWWltByH8Z2N3R6HG8aW/DW0/k/k0PaSjQtYPTJ+
         gX6QNHuiCbzvDrgBoMXFg/fgobVCqWmWdqKHtanHjKNCx/1WQ0lL6coYkSwCpLJXlE
         nwai2OElsqq7Az5mBHUUlfVqYX4vP5aq2eHf7JuQ=
Message-ID: <1565293453.2623.4.camel@kernel.org>
Subject: [ANNOUNCE] 4.14.137-rt64
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Julia Cartwright <julia@ni.com>
Date:   Thu, 08 Aug 2019 14:44:13 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.14.137-rt64 stable release.

This release is just an update to the new stable 4.14.137
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: b86042812cec9871bba4a0da843cccdc77682ee3

Or to build 4.14.137-rt64 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.137.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.137-rt64.patch.xz

Enjoy!

   Tom
