Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FFCC433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Sep 2021 18:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE005610C9
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Sep 2021 18:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242781AbhIWSzC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Sep 2021 14:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242714AbhIWSzC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Sep 2021 14:55:02 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E68FC061574
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Sep 2021 11:53:30 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id r16so7122449qtw.11
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Sep 2021 11:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SUjnel/Bk1/l/WpQpYAPDFQJSrnbuRpEo7f8NvcatLA=;
        b=iu5CPPMF5+sUT9Ulv0QbeKphNKOjSgbdsev72n7t6D+pF8NqBrqeZvMPW5UKQ+ZIat
         GQ/bHZzVn9DPH+Omv24F9enjsZrYQ01UHI5oibNylisKT2qMQ58+X9Mpc1t8uCWmMhdk
         Q4VSLfoHdcbDstDuX9K3xuwfgxCVRvwY2y9Ogz89b7vTbM+9ouHwaJ+oylODWZNniLHD
         9vny6EuncEiataOhbDC0WKKwizKhgQLFvF6KixOE7ecb4Dmd8pG7cnYgIDeMEXERtTVh
         OPQy5SRecw+KUc+Y3cC38W3d9j0rrrTCDvpRBThOJhHG1arHu4StaVG7cWLUfM36O0xv
         KF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=SUjnel/Bk1/l/WpQpYAPDFQJSrnbuRpEo7f8NvcatLA=;
        b=5DtLX2xkJ25kOcEEW1xaaV57xpUY8Gz2j1tM7d0EYwxOieztD/Rpzvhijc0Gq8qb/i
         E0T+VREbw3wpl2m/D7oF0lyixnQux9Oc2l5oF5S8jZPUhOFOuQOE8zJaoDB9b/HEM3jN
         tD5yZ+R7BhUKU3EU0cZ3TOCyn5TXGKQNKKq72V112T6efgeFYdbNmGGElQsMk9CtxtXZ
         grKAM51TCW4PBeeODrLp3uw+4O3YBrddnjWtpcf/UrPMkpmaHe8rPAvQkusjG+jic4uG
         7T5UBN8Zd+upTdbW8PtkDk5GdxYlhl5+JYGkdAP/n7t7GLt0GbDJJwt+sZTp7fsuxF7g
         23sg==
X-Gm-Message-State: AOAM531mK8xSjwe5k6s1FS/jdbL1SiQR0SRl/G1qBXBbdCeKLf9JiX+J
        q8NiqFUuPN7bxQ2RC2ZcmC+o/ZHZ3jE=
X-Google-Smtp-Source: ABdhPJwyF22m0FsOM++3T1cjxal8nnHpMDWaKk8nz4DMsJ0S6sb6twksR8z8WjOZ28DQV3CUW2p1/w==
X-Received: by 2002:ac8:5912:: with SMTP id 18mr260199qty.212.1632423209707;
        Thu, 23 Sep 2021 11:53:29 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-06-184-147-140-75.dsl.bell.ca. [184.147.140.75])
        by smtp.gmail.com with ESMTPSA id az6sm4672089qkb.70.2021.09.23.11.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 11:53:29 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 0/2] rteval: Create exclusive load modules
Date:   Thu, 23 Sep 2021 14:53:17 -0400
Message-Id: <20210923185319.1216575-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The ability to run stress-ng as a load to rteval was already added.

The original intention was to run stress-ng as the only load for
diagnostic purposes.

The following patches create the notion of a module with an exclusive
field meaning it should run exclusively, and makes the stress-ng module
one of those.

The first patch does some clean-ups and makes sure that the current
donotrun field works as advertised.

The second patch creates the ability to run a load exclusively and sets
stress-ng as an exclusive module by default

John Kacur (2):
  rteval: Make donotrun work correctly in load modules
  rteval: Add idea of exclusive load module and make stress-ng one

 rteval/__init__.py                |  4 ++--
 rteval/modules/__init__.py        | 21 +++++++++++++++++++++
 rteval/modules/loads/__init__.py  |  2 +-
 rteval/modules/loads/hackbench.py |  3 +++
 rteval/modules/loads/kcompile.py  |  9 +++++++++
 rteval/modules/loads/stressng.py  |  2 ++
 6 files changed, 38 insertions(+), 3 deletions(-)

-- 
2.31.1

