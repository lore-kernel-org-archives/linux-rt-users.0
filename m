Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E836FC4361B
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Dec 2020 22:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B797C23AFB
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Dec 2020 22:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbgLHWjk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbgLHWjj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Dec 2020 17:39:39 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2ADC0613CF;
        Tue,  8 Dec 2020 14:38:59 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id w79so268800qkb.5;
        Tue, 08 Dec 2020 14:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:subject:message-id:mime-version
         :content-disposition;
        bh=nXoogOelth45m3680v5dZQaa0Q3qItZ3ltsEtGhqtc8=;
        b=M5BfxozHRlw3l2o4rTRpHD5p48CGpDBsna0zK/X+ca/8y0a35teW83GRtEERQzIjUb
         Nbmqvimz4DicZs/aFRhkzSXUDu0aZXR2NnL54O0HMcDkvpEWEqeCTreeEEGVAgG5JkRu
         GAzhZYOIQNno3BuwuU63y6cTBdQUXhv4JgQsLMfrYnnRfzYlDwQ/zfJOElw8iJBG4u+M
         HrpmukNk/oFGIDEhTaJUjNVmeGNfgjAdFjAj0PRJxijg5pKBCEVC7V8vTadFfP827SHY
         YEVbJt394K3quhKFiDGjAoZymqar07jPFQ6mV5FOn3vPqTw7cSFkQf/okAxMgzLDTg3U
         8r8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:subject:message-id
         :mime-version:content-disposition;
        bh=nXoogOelth45m3680v5dZQaa0Q3qItZ3ltsEtGhqtc8=;
        b=TWGPGavWff/CqG5BZywHDyX9J7vixqUNLsBFEipoBuKw2DBHPpKuJpGihX4JvTECJo
         eQci2JTfBpK7pD2ddg/DnMqmA57GEITmWwTG+gu4suys7+MNxU8JzFQNgwF1YjFvDrji
         uaPOGyKpMKTTh6uZkdtvQsyk0zC8zKYVj4zdvsBpWEkx5IqWz34P2/qXOUDu/cRtiNiW
         HO45X2z7YS+6ODT4BkQKRb5hqnVA9kCK8xuUCFyEKwQSgJcv5UvvHy6iXNOVcK1MhTFl
         gYLjUMA5OpLOIz1g72q6+y8ROVrirD8v49Ywg4XZZ3Dq8igerrbY4xjh9cTW7yZiy3OR
         kaig==
X-Gm-Message-State: AOAM531NS3huipO6luDr9ZYpJJlOVZRnununNtg0g6I9B9sSyv1oTqv8
        9Hir/X+eZHUouDlaldMSXGOMa6Ehw+M=
X-Google-Smtp-Source: ABdhPJz1OtRdaRy8RNImn03gJ3baPUIgjN2QP/MdDMoPzf23TXdxT5EUSAXp9ROoIU1cFLeSnI502A==
X-Received: by 2002:a05:620a:6a1:: with SMTP id i1mr34032820qkh.136.1607467138709;
        Tue, 08 Dec 2020 14:38:58 -0800 (PST)
Received: from lclaudio.dyndns.org ([191.177.185.4])
        by smtp.gmail.com with ESMTPSA id t133sm68705qke.82.2020.12.08.14.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 14:38:58 -0800 (PST)
Sender: "Luis Claudio R. Goncalves" <lclaudio00@gmail.com>
From:   "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
X-Google-Original-From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id A05ED3C0047; Tue,  8 Dec 2020 19:38:55 -0300 (-03)
Date:   Tue, 8 Dec 2020 19:38:55 -0300
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 4.9.247-rt162
Message-ID: <20201208223855.GO348285@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.247-rt162 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: 35e7b01017420a52fa269101a09a0a93815ec65d

Or to build 4.9.247-rt162 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.247.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.247-rt162.patch.xz

Enjoy!
Luis

