Return-Path: <SRS0=4xIy=WT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B37C3A5A2
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 19:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26ED422CE3
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 19:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566588539;
	bh=U/A0momVqhHaFlm7Hx1Y+nXg1DiM3+yBHhPlu6jm9N0=;
	h=Subject:From:To:Date:List-ID:From;
	b=Y/IKIilz93GBGzYc+vHfmwdJBupPghheP+AJDHP6riFVz804l7fCu6PKQBkc282Ld
	 VCncjC8TduasERvDIKjYiS3xe/dvADamZzfXYkHTunrc6IQWKZ23Df/sohn86lcULk
	 +pWRrebh8p76cdEPjfSe+J1IxUVbrQCtseRKLghE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391264AbfHWT2u (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Aug 2019 15:28:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbfHWT2u (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Aug 2019 15:28:50 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F23A421874;
        Fri, 23 Aug 2019 19:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566588529;
        bh=U/A0momVqhHaFlm7Hx1Y+nXg1DiM3+yBHhPlu6jm9N0=;
        h=Subject:From:To:Date:From;
        b=nsomjWOqMsAxjQ1VYs8nJ339Cpcf8IUcOkPhhrfFUxC43FVpT5c4Fkq/ON3N1R7gr
         wysvNNGlxt9fMWDZE7EsGO6y1UlZU1HYKxuOKz1t6uLPRbwA1lQYD15oyoY1RxYQlV
         HedH3SkOUU65CV2WGF8X/2CpFoai+IVJJYSfI2EY=
Message-ID: <1566588528.26856.11.camel@kernel.org>
Subject: [ANNOUNCE] 4.14.139-rt66
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
Date:   Fri, 23 Aug 2019 14:28:48 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.14.139-rt66 stable release.

This release is just an update to the new stable 4.14.139
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: a201ac2897512d77f5984a2618ebbb3a84f29d5e

Or to build 4.14.139-rt66 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.139.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.139-rt66.patch.xz

Enjoy!

   Tom
