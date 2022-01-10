Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D98C433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 10 Jan 2022 21:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244487AbiAJVio (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 10 Jan 2022 16:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244307AbiAJVio (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 10 Jan 2022 16:38:44 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94B5C06173F
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Jan 2022 13:38:43 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id b127so6354792qkd.0
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Jan 2022 13:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aZ3xw99npnJK893nnK98bSrHJRisKU+OAicQo0PUvdM=;
        b=IEc1orH1dLMZRKsTjbMxh5wEpO/+khlJsVDCOkrNNCHYA3OpEQuby1RtWdKfSasWPm
         RX71LkFR3fv8WTrgTjojXppkDzb5ZQBg32g4TGjuyR1XhjOxmkGISIo7c/LaRs2Axj31
         EdEdtjcZw3N2S7uhT9P/NoI/SkNPgBKUaYbV9A09fjuN11QltTwZ9LR1UVuhfkxlKhXf
         LNYnlkXK0pjoDywaxVXFwYBSkpR+OnWUTRZvNHaGnp205f9/s94hk1JGnQ5zsHZYqxsA
         5yyd45QptbDMJ6ED6NVITfTUFtLxug7ZcQlcBKSZ4eZGvrhM4gvIXy2PnIUdHGpNAKXu
         txFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=aZ3xw99npnJK893nnK98bSrHJRisKU+OAicQo0PUvdM=;
        b=78SJbNo/DT/jvPk0WjbL3+OfRtMyRdE865JeLaAt18qSV64L7vw+hN37sRjYqryXL+
         SQWgnfk8Z4KYvpyWsDgeSphGvmMsXcVYO5wxbnmI4IAX/9wKIXc0iAsTrVY06T0+RIvy
         cpvpJxy0mTrtYzMm3/PZSOo4Gj0xljo5FXVvjYjByngE8LdiNrpnQ6P4OhleYRN4/X12
         1I5Xdq/m5TCkIxiLpSyPGtXGNQcb8GuZCaNW+qntMOKyHG66spGJ5HgzfddA0tvCOuOr
         nIlQOKibpGIG869mzDLGVqn6W9P1sclP6MjRcc1F2FJ4qWOWFr9kUvHPSE64dLwsfGCL
         wJQw==
X-Gm-Message-State: AOAM5318WeuVQoja0LEDvXsgbNOIEkYhO5H9ZB7wTX2gTkxdwjvoW1dZ
        ZRPJ/n9Jgw/3cQMH6eXA5Wc=
X-Google-Smtp-Source: ABdhPJzQ9tUi2JXTaoOZXUp+Ht04mMoHl4yviQW+ikv/lG/9q1wv0Ye0ieyvv+qi1kcdyKxbZJZqrA==
X-Received: by 2002:a37:5f04:: with SMTP id t4mr1295492qkb.190.1641850723080;
        Mon, 10 Jan 2022 13:38:43 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-11-174-88-121-127.dsl.bell.ca. [174.88.121.127])
        by smtp.gmail.com with ESMTPSA id d15sm5106268qka.3.2022.01.10.13.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 13:38:42 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     tuna-devel@lists.fedorahosted.org
Cc:     Jiri Kastner <cz172638@gmail.com>,
        Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        Ty Berry <tyberry@redhat.com>,
        Kate Carcia Poulin <kcarcia@redhat.com>,
        RT <linux-rt-users@vger.kernel.org>,
        John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] tuna-0.17
Date:   Mon, 10 Jan 2022 16:38:28 -0500
Message-Id: <20220110213828.18873-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I'm pleased to announce version 0.17 of tuna.

A few highlights.
- more flexible way to specify scheduling policy, fifo, sched_fifo, etc
- fix to display correct cpu affinity when cpus are offlined
- warning if unable to move a pid during isolate that would otherwise be
  legal
- many small fixes and clean-ups

Thanks to everyone who contributed
Your bug reports, patches and comments are always welcome

John Kacur

To fetch

Clone
git://git.kernel.org/pub/scm/utils/tuna/tuna.git
https://git.kernel.org/pub/scm/utils/tuna/tuna.git

Branch: main
Tag: v0.17

Tarballs available here
https://mirrors.edge.kernel.org/pub/software/utils/tuna

Older version tarballs are available here
https://mirrors.edge.kernel.org/pub/software/utils/tuna/older


John Kacur (15):
  tuna: Specify Gtk version before import to prevent warning
  tuna: Change tuna.spec to define version of python
  tuna: Replace unnecessary comprehension
  tuna: Replace "and or" with ternary
  tuna: Use sys.exit instead of exit
  tuna: Remove is_s390 from tuna and use the python-linux-procfs
    function
  tuna: A few simple spelling / grammar fixes in comments
  tuna: Improve sysfs.py
  tuna: Print warning if setting affinity results in EBUSY and continue
  tuna: Don't use relative imports in tuna.py
  tuna: Make it clear that include and isolate affects IRQs in help
  tuna: Add tags to gitignore
  tuna: Fix tuna displays incorrect cpu affinity when cpu is offlined
  tuna: Create class Policy and  allow users to specify policy in more
    formats
  tuna: release 0.17

Leah Leshchinsky (3):
  tuna: Remove argument requirement for config_file_list option
  tuna: Add distinction between --spread and --move to error message
  Clean up print statements for readability

tyberry@redhat.com (1):
  tuna: Spelling fix in tuna-cmd.py Spelling fix in tuna-cmd.py Signed
    off-by: Ty Berry <tyberry@redhat.com>

 .gitignore          |  1 +
 docs/tuna.8         |  4 +--
 rpm/SPECS/tuna.spec | 11 +++-----
 setup.py            |  2 +-
 tuna-cmd.py         | 48 +++++++++++++++--------------------
 tuna/config.py      |  3 +++
 tuna/sysfs.py       | 48 +++++++++++++++++++++++++++--------
 tuna/tuna.py        | 42 +++++++++++++++---------------
 tuna/tuna_sched.py  | 62 +++++++++++++++++++++++++++++++++++++++++++--
 9 files changed, 151 insertions(+), 70 deletions(-)

-- 
2.31.1

