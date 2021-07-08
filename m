Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055B9C07E96
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Jul 2021 15:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E446761414
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Jul 2021 15:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbhGHPVN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Jul 2021 11:21:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43330 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbhGHPVM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Jul 2021 11:21:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2116F21A5C;
        Thu,  8 Jul 2021 15:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625757510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=M+i9dQvQVs6IK6Vf+sKAL/8oozfSGWLTpMXU9oxV/9M=;
        b=A92JCGeSHwIodfukpn0UEnotr5Ch6hy/0l9KdMgub4KYH18sQw5Zsrt9dT89BYswGEkjmb
        PCv8DjOXqry1++KAv0oSR9LWW5EJsqLUroaWltBTC8GjStXmtpHCCjIrcYxvyjuvgEE3yS
        fNEbeYtNKdE+Z5vhKfp5h9Q+2DhPkoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625757510;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=M+i9dQvQVs6IK6Vf+sKAL/8oozfSGWLTpMXU9oxV/9M=;
        b=6V9JS7gZUfQB0zD/ZNBPuEUg9qW96z07jGszHorG8nUlD0jFdfapPhMPCCdFZP6YnR+5S6
        MQ52aAviBUMdFYCw==
Received: from localhost (unknown [10.163.25.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 03EDDA3B88;
        Thu,  8 Jul 2021 15:18:29 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v2 0/3] Fix a few fallouts
Date:   Thu,  8 Jul 2021 17:18:24 +0200
Message-Id: <20210708151827.21430-1-dwagner@suse.de>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

v1:
 - initial version
v2:
 - update error message for sched_get_affinity()


original cover letter:

Another round of small cleanups and fixes.

The first one fixes static builds for armhf host. Patch two is another
of the printf format specifier which I got wrong. No idea why we
didn't see this earlier. Anyway gcc on armhf was not happy. The same
for the third fix. Why the gcc on armhf complains and not on anything
else, is dubios to me.


Daniel Wagner (3):
  rt-numa: Use sched_getaffinity() instead of pthread_getaffinity_np()
  signaltest: Fix printf format specifier
  cyclicdeadline: Fix buffer allocation

 src/lib/rt-numa.c                   | 6 ++----
 src/sched_deadline/cyclicdeadline.c | 2 +-
 src/signaltest/signaltest.c         | 6 +++---
 3 files changed, 6 insertions(+), 8 deletions(-)

-- 
2.32.0

