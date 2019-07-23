Return-Path: <SRS0=zk30=VU=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EBDC76186
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Jul 2019 18:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F254223A0
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Jul 2019 18:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563905291;
	bh=dGVHkCCYsxlCBxtrCgJYUpk7FTbTgtP083W+lGnmP0U=;
	h=Subject:From:To:Date:List-ID:From;
	b=zb8oYgw4/r/KQrXRs5xf5CW0aKjYbqkHN53gwgCqcB1OyoGi5STAqsOJjZpS/TOvL
	 4aQRgduvyVPOGEXoQcVbsCqISzg50fMiOrALFuwwjmznYPBRJTRWyPI1fNfFM1N85G
	 emKzoAVdqdIjtGpHR4wfckXIFy474WSUkUfW9F7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391195AbfGWSIH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 23 Jul 2019 14:08:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387594AbfGWSIH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 Jul 2019 14:08:07 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48D39205C9;
        Tue, 23 Jul 2019 18:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563905286;
        bh=dGVHkCCYsxlCBxtrCgJYUpk7FTbTgtP083W+lGnmP0U=;
        h=Subject:From:To:Date:From;
        b=xkMnFghGXBLIHrWhLd/T8zk6mmV9s2dzz7OhcetyplPCtUNUNSpzs3obalfzhcu26
         88zEJOa8pZdAPONLwgv/0lKmgjwLnE2tDnJWVSJQcXKR5MK+0y9jlmzaGC3MF4y8b5
         6VtMxVu2zFKbm8Jl9XWm+QEfmTqeqL8LqqGVv7E0=
Message-ID: <1563905284.16769.10.camel@kernel.org>
Subject: [ANNOUNCE] 4.14.134-rt63
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
Date:   Tue, 23 Jul 2019 13:08:04 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.14.134-rt63 stable release.

This release is just an update to the new stable 4.14.134
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 5ee0aa0546159772831e51f716580d56993600e6

Or to build 4.14.134-rt63 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.134.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.134-rt63.patch.xz

Enjoy!

   Tom
