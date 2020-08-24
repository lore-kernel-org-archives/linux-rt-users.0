Return-Path: <SRS0=wzCU=CC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C22DC433E3
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Aug 2020 15:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24ACC205CB
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Aug 2020 15:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dk17feOT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uoxPrnEi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgHXPqP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbgHXPqJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Aug 2020 11:46:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01417C061575;
        Mon, 24 Aug 2020 08:46:08 -0700 (PDT)
Date:   Mon, 24 Aug 2020 17:46:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598283966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=XW44TtTM39puFK29r2Z1U/n2rm1H4SidXLcRJnMMlmA=;
        b=dk17feOTeW+1t5Q/8v7UsiKCKLnvXMcdkw/NRcBOjStCnViSBi2PLuh2RgtdYvtnuhe5hN
        AaQ2+dMoRBrjz5CL+iWWlkXQFTtUdqgPzoyLX7u5u+6EH7murKCuffAtn3dlNyia/S/sYU
        /lHuPSoVpxEm8zY9Fz//rXmbwqeFdfD1jX1yyyVPqJi/xdzKbcO5r0CylSmCdBb/pZd9/s
        eblSFmhZR8Q6HBh1dxO//24ofbQvVSh/SIicYVBIesjozQOQ7SmySAf2BnCZzgRd2d+as5
        6tHEUslyN/zCxDa3nx2TZgVCmW0EQDZz7aBH+HbcVhEcNsYD+B2bWTgFsJofEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598283966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=XW44TtTM39puFK29r2Z1U/n2rm1H4SidXLcRJnMMlmA=;
        b=uoxPrnEimQi6WRdAXuN/Xr3MXTD5nNxslAPBCH0UvkXxxTgtLxmePw/Yzz+GlKR0nHNh9J
        hMsGaUBbbUgUSEDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.9-rc2-rt1
Message-ID: <20200824154605.v66t2rsxobt3r5jg@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.9-rc2-rt1 patch set. 

Changes since v5.6.19-rt12:

  - Rebase to v5.9-rc2

  - The seqcount related patches have been replaced on top of the
    seqcount series by Ahmed S. Darwis which landed mainline. 

  - The posix-timer patches have been dropped because upstream changes
    cover all of was needed on RT's side. As a result RT relies on
    HAVE_POSIX_CPU_TIMERS_TASK_WORK. This is provided only by x86.
    The RT patch provides this option for ARM/ARM64/POWERPC as long as
    KVM is disabled. The reason is that the task work must be handled
    before KVM returns to guest.

Known issues
     - It has been pointed out that due to changes to the printk code the
       internal buffer representation changed. This is only an issue if tools
       like `crash' are used to extract the printk buffer from a kernel memory
       image.

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.9-rc2-rt1

The RT patch against v5.9-rc2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/older/patch-5.9-rc2-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/older/patches-5.9-rc2-rt1.tar.xz

Sebastian
