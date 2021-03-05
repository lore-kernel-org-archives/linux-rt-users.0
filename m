Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8C8C43381
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Mar 2021 07:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE9EA65011
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Mar 2021 07:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhCEHfH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Mar 2021 02:35:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:43706 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229538AbhCEHfG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Mar 2021 02:35:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 587C7AE85;
        Fri,  5 Mar 2021 07:35:05 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v2 03/14] signaltest: Add missing --output usage info
Date:   Fri,  5 Mar 2021 08:34:49 +0100
Message-Id: <20210305073500.17926-4-dwagner@suse.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210305073500.17926-1-dwagner@suse.de>
References: <20210305073500.17926-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/signaltest/signaltest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index b1a7e1db8302..e2ffc0bb8693 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -189,6 +189,7 @@ static void display_help(int error)
 		"-h       --help            display usage information\n"
 		"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
 		"-m       --mlockall        lock current and future memory allocations\n"
+		"         --output=FILENAME write final results into FILENAME, JSON formatted\n"
 		"-p PRIO  --prio=PRIO       priority of highest prio thread\n"
 		"-q       --quiet           print a summary only on exit\n"
 		"-t NUM   --threads=NUM     number of threads: default=2\n"
-- 
2.30.1

