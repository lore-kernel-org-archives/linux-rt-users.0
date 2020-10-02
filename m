Return-Path: <SRS0=LIBJ=DJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829C1C35257
	for <linux-rt-users@archiver.kernel.org>; Fri,  2 Oct 2020 22:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49EDA2072E
	for <linux-rt-users@archiver.kernel.org>; Fri,  2 Oct 2020 22:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601676248;
	bh=yybcndHOjmfwLTmM0mu6h5cJAPUOEJCSW1Ob8kRd5Pc=;
	h=Subject:From:To:Date:List-ID:From;
	b=axF5QRXFY/SPdYdX7Ni0BlyF4VreTftM/LGSwoPTCbvT7P3QsnjR9/9jY+1nmE8se
	 ygMdnmwvxc2jdf7woAvOwLG6ywvX3GH3dPmh8SOWlDOghncblb87V1nwscCtmuMXF4
	 ErXqBUtcHszFfKhKKCDy/BHO5JrrOSeXtpWWBmZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725446AbgJBWED (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 2 Oct 2020 18:04:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJBWED (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 2 Oct 2020 18:04:03 -0400
Received: from tzanussi-mobl (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA89420719;
        Fri,  2 Oct 2020 22:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601676242;
        bh=yybcndHOjmfwLTmM0mu6h5cJAPUOEJCSW1Ob8kRd5Pc=;
        h=Subject:From:To:Date:From;
        b=A4l5ehT6vbvxEWmJ4sNkUQv9cHJu4XKqHpL6YX1GlpN3NwElu6P5xzjj8tlZaRELZ
         SW0umMCTZZAPRZRydfsq95mnZeR3KBUOMVD0z+N+lYSWOI7mD5i9NPA+lSedXwATMN
         ZFpjSj8lBUA3Y+c2tgGysk0Pa2YpVpuPZOh0TeRU=
Message-ID: <ee85ed63067c9b681e62735d0491e25819da5dd0.camel@kernel.org>
Subject: [ANNOUNCE] 4.19.148-rt64
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
        Pavel Machek <pavel@denx.de>, Tom Zanussi <zanussi@kernel.org>
Date:   Fri, 02 Oct 2020 17:04:00 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.19.148-rt64 stable release.

This release is just an update to the new stable 4.19.148
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 0f0eda46246e76215f9056d17df7d964a2047cb8

Or to build 4.19.148-rt64 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.148.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.148-rt64.patch.xz

Enjoy!

   Tom

