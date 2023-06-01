Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03032C77B7A
	for <linux-rt-users@archiver.kernel.org>; Thu,  1 Jun 2023 06:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjFAGkT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 1 Jun 2023 02:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjFAGkN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 1 Jun 2023 02:40:13 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 May 2023 23:40:11 PDT
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:4f8:1c1e:abde::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E02132;
        Wed, 31 May 2023 23:40:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 48D45DE51F;
        Thu,  1 Jun 2023 08:23:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1685600607; h=from:subject:date:message-id:to:mime-version:content-type;
        bh=/r2qOvwy7YwQkvhXgOWsW1l/k3p5jbFHmPHTU/r1Law=;
        b=gsgZvIF91urmloPkdUEH4/hzKPcggbK1UqsUt108UgvEGX2TwBz3o15hDWTK/dGYo393AR
        eT3kabeU6J7TbxDTTTUtmofaAtF1GBnwumUjpXnDt0KkD/88SVc5MuTzOScsmhNha2hskQ
        5U6p7spuzXVBM3WuAJqarMwveDEhKaLLUsC96THfBJlUxrs73WNXLlIbXYGe0n3uVVpUX7
        7UGIh/Y6iTNBDmpsyc54YnoZSM7gYcHYXJOYWSr4MSAetwXwIfsnItr/EYOvX15s3HUbZu
        3Ag+CiPPQFm4vYiq/f4eUV7WsVT+z+JGqHvbBHs7TvmCJzRvfPU0SvVQU7dFAg==
Date:   Thu, 1 Jun 2023 08:23:25 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org, stable-rt@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.284-rt125
Message-ID: <168560053367.8134.6051252603215600719@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.19.284-rt125 stable release.

This is just an update to the latest stable release. No RT specific
changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 667d7f30ea873d10dc49365c95a387018da5961a

Or to build 4.19.284-rt125 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.284.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.284-rt125.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

