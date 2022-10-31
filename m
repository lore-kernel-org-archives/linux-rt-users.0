Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE795FA3741
	for <linux-rt-users@archiver.kernel.org>; Mon, 31 Oct 2022 15:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiJaPvQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 31 Oct 2022 11:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiJaPvP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 31 Oct 2022 11:51:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0A411C23
        for <linux-rt-users@vger.kernel.org>; Mon, 31 Oct 2022 08:51:14 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667231473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nUudqo2a/1VzbJ3yHcwnjj0sa+dQ9YlBZ7twHuzOjBg=;
        b=veWEiyFSU8zbjLXaDJSnQLoxdIVAMK33yMy3Eb5nh7TZrXrgqEzt8xT9LqsNsj9sMSXsaS
        wn0rm6nKIV3+4eLmqwqYqhwrY++m84e3Rndf2rMZZ0zvBL5Oc8sFviTjwJXuhKPLFvixKy
        +oumG0KIDRXlyhmXnieBtyW0kiVXapxHhmF/rYR0NgtiqSIkVh+s+sIEOrTCVxZ1TgZ87Z
        FYLNlRxKWAPpYcC5ASYwcHZrqjCJDPpaH64T49qIYv8rRpmx9kflkl3Ow40cKPrAZjFp2S
        jz4oR5IGcyjMzFWg/z55NpdR4RqBT62G4vD3d+jlYfzUsFp6rSMwNmlkQBgSTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667231473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nUudqo2a/1VzbJ3yHcwnjj0sa+dQ9YlBZ7twHuzOjBg=;
        b=JwThRrjRcCHGxp2AAwf40km4laMlR9GnnOXzaYeY1aiFEa55AOzyuR3Yj6O6AurB75eoY2
        Ar33dDuO1t7Ki6Dw==
To:     Daniel Wagner <wagi@monom.org>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        homas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Subject: [PATCH RT 0/3] timers: backport timer bits
Date:   Mon, 31 Oct 2022 16:50:03 +0100
Message-Id: <20221031155006.1651995-1-bigeasy@linutronix.de>
In-Reply-To: <20221024105416.nflnrqhmzsyqqdzz@carbon.lan>
References: <20221024105416.nflnrqhmzsyqqdzz@carbon.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I've been looking at sleeping-while-atomic splats in
v4.19.255-rt114-rc1.
It received a backport of an intermediate state of the timers patches
which were part of v5.0 during the development. It remained unchanged in
the v5.2 cycle and got merged slightly different upstream in v5.4.

This is a small series for v4.19.255-rt114-rc1 which contains the patch,
that was merged in v5.4 and the two fixes that followed on top.

Sebastian


