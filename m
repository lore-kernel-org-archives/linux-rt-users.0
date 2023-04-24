Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A573C77B73
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Apr 2023 05:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjDXFnf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 24 Apr 2023 01:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDXFne (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Apr 2023 01:43:34 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:4f8:1c1e:abde::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A222E12B;
        Sun, 23 Apr 2023 22:43:32 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8720CDE4F5;
        Mon, 24 Apr 2023 07:43:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1682315007; h=from:subject:date:message-id:to:cc:mime-version:content-type;
        bh=tKQdEKeiXHq9oIwSBNQB0267WF9rTyUyvUo7qtVXIKs=;
        b=CAiEViP7tjETgCD3t17feslDM2SfWvnyM+BNulrNsjyuTkvQ+uJuWhr/EtzADR+nY4DHRH
        HgV2Q9lzlWn3AGnl4izUymLe5FWvKLxFZtQOvRdyD+ZAC2raWBep8Wp3OlDJwrGK+wbWFY
        9kJtkBXOfNat9Z0x5kpUcNHN7vxti7nftPMljPlMlAc1vF28vTEDIGGF83+KTmdo5jRcvS
        oQvPi8Aa56fjh6i0Ay2Td9GNfRuD9rizW380wyvP6A0qOYChcYOc006q+fFkp9iOsWJx0u
        A0nmmMgAqslWsQYctX7pMmqdnDgSvWgenuyhzEv4b1IBsdqKvmIR3X+ye5cKDA==
Date:   Mon, 24 Apr 2023 07:43:18 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
Cc:     Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [ANNOUNCE] 4.19.280-rt123
Message-ID: <168231434044.6936.2313095554994970305@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.19.280-rt123 stable release. This is
just updating to the v4.19.280 stable release. No RT specific changes.

We (stable-rt maintainers) are starting to use kernelci as additinal
step in the release process. The test results are available here:

  https://linux.kernelci.org/job/rt-stable/

For this particular release

  https://linux.kernelci.org/test/job/rt-stable/branch/v4.19-rt-next/kernel/v4.19.280-rt123-rc3/

Also the test results will  be mailed to the stable-rt mailing list
(http://vger.kernel.org/vger-lists.html#stable-rt). We decided against posting them on
linux-rt-users are they are a bit bulky.

I suppose this new process might need some more fine tuning but let's
see how it goes. Anyway, let us know if that is working for you or not.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 6dd5166ea2a6d1fe77eda1e5780fa0b14774da1a

Or to build 4.19.280-rt123 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.280.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.280-rt123.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

