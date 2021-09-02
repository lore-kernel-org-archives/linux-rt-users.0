Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD88C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 Sep 2021 20:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EF1261074
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 Sep 2021 20:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346272AbhIBU1d (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 2 Sep 2021 16:27:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345944AbhIBU1c (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 Sep 2021 16:27:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19FF860F4B;
        Thu,  2 Sep 2021 20:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630614393;
        bh=98y8N1D3TfUZSK4FFIHO9hUEJNJZ2K8z6HSAkJ+QdXc=;
        h=From:To:Subject:Date:From;
        b=tShrA+B/2xvieZLejDQm9c6MTt4QJVFNLPPSSXmTjTOHDMMRWm+UaL5k3sYLQtuXj
         jDLxRikVfNOKXTKdJBVA2xEzFH2m6UbViHPVkn9nOr5HGY+oKTz5ooCyXNAC6hhv0Z
         drN4yVH/qLCeJDaEUn7csBijfyrPmWIPJiPGh9DYx/twi8OmCDGpP1lta1yZnJrQhP
         rlgze4yA2ebLpgwwZYJBPM/bqEbEzLIk1U/lfavo306DVD6U+ZiqdlxwgHfU93zg2l
         TiMvoy+fyt/l/f3lCWwgIy5KKV6Sf5KTE4KFAr8FCkK1yeqMsiuSLjf9IGOvJG0q+i
         q+BTtnj1Um+sQ==
From:   zanussi@kernel.org
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
Subject: [PATCH RT 0/2] Linux v5.4.143-rt64-rc1
Date:   Thu,  2 Sep 2021 15:26:29 -0500
Message-Id: <cover.1630614380.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Dear RT Folks,

This is the RT stable review cycle of patch 5.4.143-rt64-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release on 2021-09-07.

To build 5.4.143-rt64-rc1 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.143.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.143-rt64-rc1.patch.xz

You can also build from 5.4.143-rt63 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4.143-rt63-rt64-rc1.patch.xz


Enjoy,

-- Tom


Andrew Halaney (1):
  locking/rwsem-rt: Remove might_sleep() in __up_read()

Tom Zanussi (1):
  Linux 5.4.143-rt64-rc1

 kernel/locking/rwsem-rt.c | 1 -
 localversion-rt           | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

-- 
2.17.1

