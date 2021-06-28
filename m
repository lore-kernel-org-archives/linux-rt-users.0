Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6C3C11F64
	for <linux-rt-users@archiver.kernel.org>; Mon, 28 Jun 2021 20:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1FEC61CC7
	for <linux-rt-users@archiver.kernel.org>; Mon, 28 Jun 2021 20:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbhF1UOg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 28 Jun 2021 16:14:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44560 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbhF1UOe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 28 Jun 2021 16:14:34 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4B6102252F;
        Mon, 28 Jun 2021 20:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624911127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=F6J14A+psIc2n/sLvRo4ypCSPG46yf7b15RbqT+u5R0=;
        b=eyEHt5HeLTzi27FoTixqny/yWdTH93aCSWtFGexa19zzXp9MFc49oKaZPW/HZW/ze6xR4U
        15Yay4+7Y/imi3SQddJ8fuhsRDc9LOtvcVpHFH6lt74Ibe9lWBx305uDamz/RDc9gO/TnP
        VHIfHf+WPL+dDONztFlOsbzjxUrLvbM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624911127;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=F6J14A+psIc2n/sLvRo4ypCSPG46yf7b15RbqT+u5R0=;
        b=dvPLGo6oObN07AbsAgD7Jk4dI70M3gq7bb0ADMdpAdJQ6pTZgwM+K+bFJSDgPu/hCN4WWa
        f1oSqDZbXgx9F5CA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 32CE611906;
        Mon, 28 Jun 2021 20:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624911127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=F6J14A+psIc2n/sLvRo4ypCSPG46yf7b15RbqT+u5R0=;
        b=eyEHt5HeLTzi27FoTixqny/yWdTH93aCSWtFGexa19zzXp9MFc49oKaZPW/HZW/ze6xR4U
        15Yay4+7Y/imi3SQddJ8fuhsRDc9LOtvcVpHFH6lt74Ibe9lWBx305uDamz/RDc9gO/TnP
        VHIfHf+WPL+dDONztFlOsbzjxUrLvbM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624911127;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=F6J14A+psIc2n/sLvRo4ypCSPG46yf7b15RbqT+u5R0=;
        b=dvPLGo6oObN07AbsAgD7Jk4dI70M3gq7bb0ADMdpAdJQ6pTZgwM+K+bFJSDgPu/hCN4WWa
        f1oSqDZbXgx9F5CA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id LPVnCxct2mACLwAALh3uQQ
        (envelope-from <dwagner@suse.de>); Mon, 28 Jun 2021 20:12:07 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 0/2] Fix for start timestamp
Date:   Mon, 28 Jun 2021 22:12:01 +0200
Message-Id: <20210628201203.30974-1-dwagner@suse.de>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

As Mike reported, the rt_test_start() was not placed cleverly. Let's
move the code to rt_init() and avoid any further problems with it.

Daniel Wagner (2):
  rt-utils: Call get_timestmap() in rt_init()
  rt-utils: Remove empty rt_test_start()

 src/cyclictest/cyclictest.c           |  1 -
 src/include/rt-utils.h                |  2 --
 src/lib/rt-utils.c                    | 29 ++++++++++++---------------
 src/oslat/oslat.c                     |  1 -
 src/pi_tests/pi_stress.c              |  1 -
 src/pmqtest/pmqtest.c                 |  1 -
 src/ptsematest/ptsematest.c           |  1 -
 src/rt-migrate-test/rt-migrate-test.c |  1 -
 src/sched_deadline/cyclicdeadline.c   |  1 -
 src/signaltest/signaltest.c           |  1 -
 src/sigwaittest/sigwaittest.c         |  1 -
 src/ssdd/ssdd.c                       |  1 -
 src/svsematest/svsematest.c           |  1 -
 13 files changed, 13 insertions(+), 29 deletions(-)

-- 
2.32.0

