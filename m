Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85602C433DB
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Jan 2021 18:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 331D623A7C
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Jan 2021 18:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbhAHS2M (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:28:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:59002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728326AbhAHS2M (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 8 Jan 2021 13:28:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AE9223A79;
        Fri,  8 Jan 2021 18:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610130452;
        bh=QEU7UA6dFUx/UkxWu6YlIfT6Zr+BDauotYDLsbfSSj8=;
        h=Subject:From:To:Date:From;
        b=G726XAwEQuO3muR5qc+fvMIaA1Q8z7PkZw7TE377W+3yfuUBN7RoZQUFenR4igLMt
         ueWLSlTu0psy+bafTP8Ve3Ego1vaWrDLqXViPyDe3Fdn5vGMyvo+9aKVNq0V+T3Tsk
         JUxEuavV5OfBB1kornctPwxlUfnrULoKz8qJY16RK0Z8owzd19bBxMXESX3IHicCVd
         PlKdxgf01/Nn8QzXQ2vheVnX0r4Ek4rP7DwdqJxKSiAbfhJEyjywEZtgmm6LYaO10e
         OPhc9B9pIwB8uetQpcyklRRaPActM9vzJWkhMP9Om+cXpMBC1qhLIUqzXI53ai2BHk
         L6VCl7uI9Dvaw==
Message-ID: <ce36bd6febcf2816d9286fa59c9e698959bb5036.camel@kernel.org>
Subject: [ANNOUNCE] 4.19.165-rt70
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
Date:   Fri, 08 Jan 2021 12:27:29 -0600
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.19.165-rt70 stable release.

This release is just an update to the new stable 4.19.165
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 443f65a6dbad1e4b9184f81675c1d62e27c0ccee

Or to build 4.19.165-rt70 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.165.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.165-rt70.patch.xz

Enjoy!

   Tom

