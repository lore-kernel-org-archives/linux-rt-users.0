Return-Path: <SRS0=6FAt=B5=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BDAC433E1
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 Aug 2020 20:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 679912086A
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 Aug 2020 20:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TV6SVaLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725275AbgHSUTy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 Aug 2020 16:19:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53540 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726896AbgHSUTt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 Aug 2020 16:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597868385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3qL9ByE7n6hHlEIiKkepcx//px2SabGL7NxDWE8H65U=;
        b=TV6SVaLHJ5AVAiD3rt3bYQhbN9zPeX2d5o4gzG9x2w9QLmgkTQrFJKXMexqv/PIgahR3G/
        XP0/eAc2Ai+iTVfiat8VzM40j51u6u06JXJOG5J6JXhPzaNXOtJrKh0GCS+1ldUupw3/MK
        2gdYmaWyE+m3gb2R4ZIrKk1kBnxCezo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-SdFGWVXcOV-G__6_91rD7g-1; Wed, 19 Aug 2020 16:19:43 -0400
X-MC-Unique: SdFGWVXcOV-G__6_91rD7g-1
Received: by mail-qk1-f200.google.com with SMTP id x20so16180309qki.20
        for <linux-rt-users@vger.kernel.org>; Wed, 19 Aug 2020 13:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3qL9ByE7n6hHlEIiKkepcx//px2SabGL7NxDWE8H65U=;
        b=YLFbFGYDhD1eRMM1FpQXb7aqi6U0AWUIkM/1WNtp73ELmbwgvzoEjL0WMA9C1qf0Eg
         v3bqPb06S87BTlAJY9Vx5UwziOXX23w+5U1Vl3ca/m1XaHRYNnKar5coI2nGw59FnZXK
         iDPXCR9y3prBCsKmOOdefjBCOP4aodFEUz7Ou7GaBC1XIu3+0AZjc9xfKp0NUhmpKkcC
         VxA43fErIor2O/6ecujiR7Ojfhu0LMdr3Og10x6qTZeUAO2oJZkR8S4QgEn97DYzjk99
         yBtLRayhp0/NCTAq7mWyWnnV6a30FfvHRumizW9VlukVQCPZYO1PjtYgVu/RMM8foQPu
         yKcg==
X-Gm-Message-State: AOAM533kztyWaG1rma0E+o1jmsFCgRfS/Vvr/dvGx5tao3Z++ShwYZLw
        Ova3HLHA8jwpD/DjM26B4e0SDOs4kOxDjgiWXrJUMo+rKFwQkb313lT2pRY9Svh+SeQp5LVvgKL
        b5IDoSnfiP9OJ8wt364oCk2u4g5w=
X-Received: by 2002:aed:3102:: with SMTP id 2mr22348548qtg.212.1597868382821;
        Wed, 19 Aug 2020 13:19:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9sPkVSsnp2v5r6lYrroq4cb9eP1pMwbIcCT6avDxw8Kd+jVASA56MU0PCdVWFdDSTnmY7oQ==
X-Received: by 2002:aed:3102:: with SMTP id 2mr22348530qtg.212.1597868382565;
        Wed, 19 Aug 2020 13:19:42 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id k1sm25363289qkf.12.2020.08.19.13.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 13:19:41 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     peterx@redhat.com, John Kacur <jkacur@redhat.com>
Subject: [PATCH 0/1] rt-tests: oslat: Format the code
Date:   Wed, 19 Aug 2020 16:19:39 -0400
Message-Id: <20200819201940.317257-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The code was not following generic Linux coding style. Reformat the code.=0D
=0D
Also using spdx license identifier as suggested by John.=0D
=0D
It should also pass checkpatch but except a few exceptions that I think it'=
s=0D
either a checkpatch bug or not applicable to the code.=0D
=0D
Thanks,=0D
=0D
Peter Xu (1):=0D
  rt-tests: oslat: Proper reformat of code=0D
=0D
 src/oslat/oslat.c | 1323 ++++++++++++++++++++++-----------------------=0D
 1 file changed, 649 insertions(+), 674 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

