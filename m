Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B705C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Oct 2021 14:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 357A760EFE
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Oct 2021 14:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbhJ0O0h (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 27 Oct 2021 10:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238214AbhJ0O0f (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 27 Oct 2021 10:26:35 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689B9C061570
        for <linux-rt-users@vger.kernel.org>; Wed, 27 Oct 2021 07:24:10 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id v64so343111ybi.5
        for <linux-rt-users@vger.kernel.org>; Wed, 27 Oct 2021 07:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurora.tech; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=uI0JK99gc4L+TdPALc9N29KiNxW3Reg5J3LNOcfuOjg=;
        b=ds2bW4heh8S2XauQEDNvvqvZKRykGwoezITEMtt90KelLmGLoRhXzMV21DJG/dF4pj
         C/J1LrIlDlx7YZW0bGDQ9/KcVFIWHdCR2uPGfkI30aMCDId06B6CttGtxii4Auc2aC9D
         DQH6WmTBOb/nwqwKn31OcxR6d3EvsDAl4MPApmsjWi+JaM33KinuSCHkk4Gk9rOI3Njr
         4PDCeye0e55sL0tzWCQ0Bytyi1btvop7PRa7noDWaT3HoVdQHM/EfhybJ0/EyJZwL3pH
         MgW0ICs4BY2WD0QzSKKXpXow//LXOCkWBeY3LHpGpTPFb6yIWuihWY1tt5tN8JMCjAKn
         tPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=uI0JK99gc4L+TdPALc9N29KiNxW3Reg5J3LNOcfuOjg=;
        b=pygP+VNY4ip5ggD9jobNDVrwITWkz5THRQzCD56OcbJRaG1sgT9RqT7Ir54g3ABovQ
         yUTN/UtKUHqJNfqqz5h9vRWw2qhMii0heMRwO59QH58eES1Wuqi6lahr+YX1nAZL9aZr
         mZhoXermfLX3iJ4qJAKyUDozXlgL1/5iekSF8uoYk4twLiLfmmyBHM7XUhKwRfZr+tiq
         IERoHnpxNDB+9fri7S+6dQiewyHYh+0AqPieIez0i99/R3zLfdnbtF9P1Xw3dloEnwvz
         llXe3+UQgMF8C1VvzgQq59hO/1qvJ/SdSzwp/vHgkhBsFXBUSZdh2mMzJ/7LOUAr4jco
         LfEw==
X-Gm-Message-State: AOAM533MdGOxi5Ouy6fKWJ+VCH4Hyno8d7um3IUJ4zmr65s1XW/lbbS/
        eF8eXjNoyGhn46iDAkjkktZndThE2fTCfxeuHNZfnTtSUYaxNQ==
X-Google-Smtp-Source: ABdhPJwjQrWrY6xOUjFvcgp+32aKKn4xbD85TmRARnvbyoANj6pX6pWawbqE5DfiAFR8eii5IsbE7CuG0UzYElBW9VQ=
X-Received: by 2002:a25:548:: with SMTP id 69mr29931456ybf.57.1635344649681;
 Wed, 27 Oct 2021 07:24:09 -0700 (PDT)
MIME-Version: 1.0
From:   Alison Chaiken <achaiken@aurora.tech>
Date:   Wed, 27 Oct 2021 07:23:58 -0700
Message-ID: <CAFzL-7u+g0de7M7dqCe8xWNaYM9e_ZZTc0CNCdJ_VWHScvwprg@mail.gmail.com>
Subject: rcutree.kthread_prio and Principle of Least Surprise
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The kernel cmdline parameter rcutree.kthread_prio elevates the
priority of various RCU service threads as stated by
kernel-parameters.txt:

Set the SCHED_FIFO priority of the RCU per-CPU
kthreads (rcuc/N). This value is also used for
the priority of the RCU boost threads (rcub/N)
and for the RCU grace-period kthreads (rcu_bh,
rcu_preempt, and rcu_sched).

What the parameter does not do, at least in kernel 5.4, is to elevate the
priority of the rcuop threads that perform the work of rcuc threads
for cores offloaded via rcu_nocbs.  Is there a reason why doing so
would be a bad idea, or is the differing treatment of rcuc and rcuop
threads merely an oversight?  If the latter, would it make sense to
patch the kernel to make the behavior more uniform?

Thanks,
Alison Chaiken
Aurora Innovation
