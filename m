Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F11CC28CF5
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Jan 2022 16:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243199AbiAZQp4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 26 Jan 2022 11:45:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58102 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236669AbiAZQp4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 26 Jan 2022 11:45:56 -0500
Date:   Wed, 26 Jan 2022 17:45:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643215554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=UHFa8oEIdaXaWC3dUGqBtpDOM8h2/+7Inl6Y4pck+Fo=;
        b=UgzCg0GKDpNqohbospaim02YX4E4djchMgYY4c5vdkARzQfb10Gl5RgMvNiXX7Y0cEfehy
        KOgNOfGTYoyxt4MkKsFGMdrszUMJ9vytskgemDCyke+MrH7ztpQhF9+ad+ZMji7E+yK9QR
        r3PIk5/H1DljzHK4acR/FpvPyg+B6xBg56LPT9kYkF5942lvKUFLo00HXknD4Ph+ragXXd
        on/vYVIRu94BuosR33gqXxKhH6W8ED4eev8TkJBCOyF2krG0uSbWXsZ5vwHnoQNRLEo2u3
        6SUjQoaURaJuH4xycTq8HovbTMyaxu787xRxYfYgV9x/318mFzxSOI19G5Hagg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643215554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=UHFa8oEIdaXaWC3dUGqBtpDOM8h2/+7Inl6Y4pck+Fo=;
        b=HXrF2nr/Vh3cp4SErauXSdtOhz62Pg3QNDSKMaU95hUkQe+Zs6om84nl4RZqC1PqdgF3o5
        C5AGQWm7i+f56QBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.17-rc1-rt1
Message-ID: <YfF6wTyztdJtRmNw@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.17-rc1-rt1 patch set. 

Changes since v5.16.2-rt19:

  - Rebase to v5.17-rc1.

Known issues
     - netconsole triggers WARN.

     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.17-rc1-rt1

The RT patch against v5.17-rc1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.17/older/patch-5.17-rc1-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.17/older/patches-5.17-rc1-rt1.tar.xz

Sebastian
