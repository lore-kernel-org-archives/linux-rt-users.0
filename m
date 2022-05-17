Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D697C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 May 2022 22:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiEQWEQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 May 2022 18:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiEQWEO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 May 2022 18:04:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135B749F29;
        Tue, 17 May 2022 15:04:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF5F8B81CBA;
        Tue, 17 May 2022 22:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED82EC385B8;
        Tue, 17 May 2022 22:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652825051;
        bh=Znd9eYIPaF0iJIaRGP7but9a+svacnqOyw6mc3ZUB2M=;
        h=Subject:From:To:Date:From;
        b=HDL0yumrRynKNY9mFDF+xsznkIRqrGn5rVgntWJrdyLye5vRhZWpvOvhdN7LvW1Qx
         6+osWg0D4/v2kknEcruT8q3saei8gH8rx0Kk19hYE4RzujN7DzT3YwzDW6hLRa2PvI
         bomcBiHE7dHjDahQosoQLNirU2m3DG6wx7by4uOvamBqp2/GjD9xOIlRXtdLO/kR4M
         oimQjpD/dZ5n/xFxTCOf2QEN/INJUXUZB9H0/kU/stRaeJTNuK57tyVNfwTgqpDlf3
         ltYuxDR+Ixvo8+xFuv3+6uX8I9PvLJMmies4MfYrVywr9twMSNO1WUbAE4FnG72cYK
         gdyaDeabqAHhg==
Message-ID: <50baec90cbd1ae552777f4d00efc7edcfb36eedf.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.193-rt74
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
        Tom Zanussi <zanussi@kernel.org>
Date:   Tue, 17 May 2022 17:04:08 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 5.4.193-rt74 stable release.

This release is just an update to the new stable 5.4.193
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: 5e0620d175441f899c093f590d84e4be6beda434

Or to build 5.4.193-rt74 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.193.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.193-rt74.patch.xz

Enjoy!

   Tom

