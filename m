Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EC4C433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 10 Jan 2022 21:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344346AbiAJVxM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 10 Jan 2022 16:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241465AbiAJVxL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 10 Jan 2022 16:53:11 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F2DC06173F
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Jan 2022 13:53:11 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id m2so16956795qkd.8
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Jan 2022 13:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wIPZhRDTNppRVrJG8ocsLcnit8bssizHEMP4v9SA0es=;
        b=VetQDju/E0iipagzsAPwyHslK2vpFp5BKPLintziIlE3/Zft+o668nG4yQagIuOdnb
         HKHn2SISV2jCLkuDFQYPks9HBY9NXZ2c5VSDsfQ6pjoMa/QOcOdj2n7E9koYq5mmKrMA
         haHafo5D3nfIDfRk9QjXl+wh5zBUkk9x6phR9bGomiiDoMkFccTjrzKSdeJkMrv5AhB2
         dPCqK5RHbfxQUQ5/DgHUNMKOwIliWQi1vpzStLZaU8G3ZFb9RUfs1vg5DVB/L7aat2rm
         Pv0OW2xog8EDL16+EF8pubNiBGNbso39jYEx3vKEKF7mHSVld/I0FtVParSqfQNvdM0E
         ge/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=wIPZhRDTNppRVrJG8ocsLcnit8bssizHEMP4v9SA0es=;
        b=RwL/FrCVkEku9fJ51YFrlhuR+2fyltQ6Jf17Qk7BrWCKg40QfmndG/0/j2I14mPCBE
         JUVdEQmFDMoeJtMuZmZeu7W3LPt0OqHed4HtVxT6GQTGvVUo6JSfazUk/PQ7+6gEMjxL
         mU8QTqLjMRTphjFqUMsNXTt9LIsa+yrHfc97RtZfY/AHuFf/UNFsqkLXgl7w4aEQWGZw
         yVhmiwSyslu/bMaZL0OPllzdTFwotRBCJSo+rmoZF+bGLrl3Y3knEB+ZWikQ6aQvbTqp
         ozQXvb52uDY4m5fz3t+uf5YaQhaXQhfQeya/wXy1hpZTy5MUYENx6M+OKpg6LeU3d2e8
         uoRg==
X-Gm-Message-State: AOAM532YtLrhDiwEnDp+vjKBYJoqd5dlTPB55TvO+wHlitQWeULdvias
        2tp0uTYAMHpgVrf858/uVjQ=
X-Google-Smtp-Source: ABdhPJxQ8Uzc211A/nFaX6G9biyf5TeETh142W7FzxGRcPBsSCJMF5TgjCr5gAQUgzikxD6k/3oCxg==
X-Received: by 2002:a05:620a:796:: with SMTP id 22mr1311553qka.454.1641851590084;
        Mon, 10 Jan 2022 13:53:10 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-11-174-88-121-127.dsl.bell.ca. [174.88.121.127])
        by smtp.gmail.com with ESMTPSA id z14sm5716167qtw.59.2022.01.10.13.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 13:53:09 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     tuna-devel@lists.fedorahosted.org
Cc:     Jiri Kastner <cz172638@gmail.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        Kate Carcia Poulin <kcarcia@redhat.com>,
        Clark Williams <williams@redhat.com>,
        RT <linux-rt-users@vger.kernel.org>,
        John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] python-linux-procfs-0.7.0
Date:   Mon, 10 Jan 2022 16:52:59 -0500
Message-Id: <20220110215259.19442-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I'm pleased to announce version 0.7.0 of python-linux-procfs

Your bug reports, patches and comments are always welcome.

John Kacur

To fetch

Clone
git://git.kernel.org/pub/scm/libs/python/python-linux-procfs/python-linux-procfs.git
https://git.kernel.org/pub/scm/libs/python/python-linux-procfs/python-linux-procfs.git

Branch: main
Tag: v0.7.0

Tarballs available here
https://mirrors.edge.kernel.org/pub/software/libs/python/python-linux-procfs/

Older version tarballs are available here
https://mirrors.edge.kernel.org/pub/software/libs/python/python-linux-procfs/older


John Kacur (9):
  python-linux-procfs: Add tar.xz and asc files to gitignore
  python-linux-procfs: Fix traceback with non-utf8 chars in the
    /proc/PID/cmdline
  python-linux-procfs: Propagate error to user if a pid is completed
  python-linux-procfs: pflags: Handle pids that completed
  python-linux-procfs: Makefile: Add ctags
  python-linux-procfs: Remove procfs/sysctl.py
  python-linux-procfs: Various clean-ups
  python-linux-procfs: Fix UnicodeDecodeError
  python-linux-procfs: Create release v0.7.0

 .gitignore                         |   2 +
 MANIFEST                           |   1 -
 Makefile                           |  10 +-
 pflags                             |  15 +-
 procfs/__init__.py                 |   1 -
 procfs/procfs.py                   | 329 +++++++++++++++--------------
 procfs/sysctl.py                   |  68 ------
 rpm/SPECS/python-linux-procfs.spec |  13 +-
 setup.py                           |   2 +-
 9 files changed, 209 insertions(+), 232 deletions(-)
 delete mode 100755 procfs/sysctl.py

-- 
2.31.1

