Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6149AC433E0
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Feb 2021 16:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B3564E87
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Feb 2021 16:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbhBHQT1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Feb 2021 11:19:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:49126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232605AbhBHQTP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Feb 2021 11:19:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 900E064EA1;
        Mon,  8 Feb 2021 16:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612801114;
        bh=q8Wz1u2c1qWDv9pAcYBZRdY6dda4M4xtYNaWJPa0vZw=;
        h=Subject:From:To:Date:From;
        b=ovGCywDoEmpLqnQolMQPpYTcXz93pDS6OA0tt/SBHSC1oBXdsr3UD7kM0EL2ZYvLs
         wtTAI2Vq6WYBtenhPJ8TSOagFtSdwNtbo5JsBJi73CAhgQprvqVyHniTvNaOkMvW6x
         tXzG17n+T1rc3gL0lgO/UVzAd857ldoqdHJqNzug8Q/FLpoSzLctLT81q/H8Pt59Q/
         B2XTSkXd1q51PyQ1H/hWEQHSOVfVLIi2+WpkkA34SWzMjYsPzKJrgVdpQOfN0/l4DA
         QwbndfNkO/RJovNLh/Ppbb1VrNVKfN63TRZo68MtumojLrtTofdYPjRBQ5ZpTMCT64
         GqRxFpHxCFm6w==
Message-ID: <78a65c1c8cc1b6fbc739a91a5dfdd84be795ed1a.camel@kernel.org>
Subject: [ANNOUNCE] 4.19.173-rt72
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
Date:   Mon, 08 Feb 2021 10:18:32 -0600
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.19.173-rt72 stable release.

This release is just an update to the new stable 4.19.173
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 0f716c5aef71ce6891b78818ba2a8a59d95ac053

Or to build 4.19.173-rt72 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.173.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.173-rt72.patch.xz

Enjoy!

   Tom

