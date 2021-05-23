Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF9BC47080
	for <linux-rt-users@archiver.kernel.org>; Sun, 23 May 2021 18:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D78160FE4
	for <linux-rt-users@archiver.kernel.org>; Sun, 23 May 2021 18:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhEWSlu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 23 May 2021 14:41:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:60224 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231829AbhEWSlt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 23 May 2021 14:41:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1621795222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+ubjQ0lJUcSHIAAmMznh6E1yM4aHFPJd4dnTsp3+3Qw=;
        b=cUPUwumNGibYFp3j1Fy5Tq6HX/PtifuQBOosOShQgQhLycAX28go9oUQlaBPH3riInB8nc
        GAXwUW5jcRieS3Kr3p8EGjfb3cII3QX1HkZt0OJZ2REwPD5HPZ+L48x4j3kW31h4zvBri1
        u4aWOeOq+y9wYtnvClJoQjbbsC1bCJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1621795222;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+ubjQ0lJUcSHIAAmMznh6E1yM4aHFPJd4dnTsp3+3Qw=;
        b=SIMnhhQIsFx5jf7p0OdMQtEVRWzyZww03uCa6807gT8KR2syoh1hrKwLQ8I/6fAeEgT5Zq
        O566CbB//05gWgCw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 04849AC4B;
        Sun, 23 May 2021 18:40:22 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 0/2] Silence cyclicdeadline 
Date:   Sun, 23 May 2021 20:40:14 +0200
Message-Id: <20210523184016.32314-1-dwagner@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

cyclicdeadline logs on default all every cycle via the ftrace
buffers. Not really needed in normal test operation mode, thus
introduce --debug to silence it for CI systems.

Daniel Wagner (2):
  cyclicdeadline: Generate ftrace log entries in debug mode only
  cyclicdeadline: Document --debug command line option

 src/sched_deadline/cyclicdeadline.8 |  6 +++++-
 src/sched_deadline/cyclicdeadline.c | 13 ++++++++++---
 2 files changed, 15 insertions(+), 4 deletions(-)

-- 
2.31.1

