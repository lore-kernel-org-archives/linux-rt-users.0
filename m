Return-Path: <SRS0=oduH=TC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A885C43219
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 19:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5F52087F
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 19:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556825675;
	bh=ytGYuaxpvzpXWzpVIMgVq00MUz605JQOvh8HijmyGeg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hb8gUnuwfOwcAKOcMpXvg1KswIYNNrU3SND3hTUxh2zH1l4lnQTTwa+8IGsw0nGPQ
	 7oHg1oSkIprJLPikONbcf8M250mlbm3a+iKGm97YDHNjYFjZXy1GqyZK6rroHXyLw5
	 3yECCkJHP0xqTV22MLpfXj5Gnu4CdrKeq2uw9pGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfEBTef (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 2 May 2019 15:34:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfEBTee (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 May 2019 15:34:34 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E076205F4;
        Thu,  2 May 2019 19:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556825674;
        bh=ytGYuaxpvzpXWzpVIMgVq00MUz605JQOvh8HijmyGeg=;
        h=From:To:Cc:Subject:Date:From;
        b=ZhA3se97bYhPABGqa0Ncld7TiRFcnKQgfILff1KiqOpknVyhd8LdWrfrxRI2H5TOJ
         tNg0+5VFaMS1fbpAMJvlCHZsl9Qh9kvYy2pxyPAJCGlTkoa4fnZ1MBURUtR/ep4N0o
         4a0EWwXWnKxrzm26YBONlMbu1sNF2j4rh3tEmZ2M=
From:   Tom Zanussi <zanussi@kernel.org>
To:     wagi@monom.org
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH 00/10] Some more stable-rt-tools fixes
Date:   Thu,  2 May 2019 14:33:59 -0500
Message-Id: <cover.1556825097.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Hi Daniel,

I just did my first srt tools backport release for 3.18 - as promised,
here's the set of patches for the things I ran into.

Thanks,

Tom

Tom Zanussi (10):
  srt_commit: Fix --release-candidate arg misspelling
  srt_util: Make the 'configuration not found' message more informative
  srt_announce: Add an option to suppress git send-email auto-cc
  srt_announce: Allow rc releases to also reference release artifacts
  srt_create: Use old_tag.base, not old_tag, to create patch for rc
  announce-srt: Remove {major}.{minor} from upload paths
  srt_upload: Upload incremental update patch to prj_dir/incr, not
    prj_dir/older
  srt_announce: Add "new_tag_rc" for rc incremental releases
  announce-srt: Remove explicit v4.x from upload paths
  announce-srt-rc: Add tarball links

 announce-srt-rc.txt | 13 +++++++++++++
 announce-srt.txt    |  8 ++++----
 srt_announce.py     | 53 +++++++++++++++++++++++++++++++++--------------------
 srt_commit.py       |  4 ++--
 srt_create.py       |  2 +-
 srt_upload.py       | 11 ++++++++---
 srt_util.py         |  2 +-
 7 files changed, 62 insertions(+), 31 deletions(-)

-- 
2.14.1

