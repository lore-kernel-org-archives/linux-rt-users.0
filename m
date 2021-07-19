Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A97EC12002
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Jul 2021 09:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E9DA61165
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Jul 2021 09:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbhGSIyR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Jul 2021 04:54:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37866 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhGSIyQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Jul 2021 04:54:16 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EE875201DA;
        Mon, 19 Jul 2021 08:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626682506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=x4VEqRDv+ixtIdSdipnAuDapyFD0qCFsSJGJSGua5nY=;
        b=pvt2mYxsKYtJiUY2fZDTi97h5B09sPpkKjBWna11vvaX6eHHFtK4r7MMulWuc4R7LqGeHa
        xv5tkrDJhmF+tWSoWErzlUsyU274BCOjUrKKONRLaXTqwsFR83OhGO0nkv6oXb20xbTr1t
        cpthUNnSHDRkMkGluycVRZ4qB0mTi8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626682506;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=x4VEqRDv+ixtIdSdipnAuDapyFD0qCFsSJGJSGua5nY=;
        b=ALXkrPxdsHxhil1QyeU0EXs3/FQR/hm/QATls+Y4jba+DWPHSpCIGhXfBWiXEdtQobe2Oj
        691eayK9wAJVZgAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D86BB133D0;
        Mon, 19 Jul 2021 08:15:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id s8FnNIo09WDQCgAAGKfGzw
        (envelope-from <dwagner@suse.de>); Mon, 19 Jul 2021 08:15:06 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v3 0/1] Fix a few fallouts
Date:   Mon, 19 Jul 2021 10:15:04 +0200
Message-Id: <20210719081505.520-1-dwagner@suse.de>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

v1:
 - initial version
v2:
 - update error message for sched_getaffinity()
v3:
 - updated commit message for sched_getaffinity()

Daniel Wagner (1):
  rt-numa: Use sched_getaffinity() instead of pthread_getaffinity_np()

 src/lib/rt-numa.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
2.32.0

