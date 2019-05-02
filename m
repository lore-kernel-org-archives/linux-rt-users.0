Return-Path: <SRS0=oduH=TC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30307C43219
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 19:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61D1205F4
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 19:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556825677;
	bh=6h2nLHV75K7pg/3GnG/ZmdYCJph+Z72ZxnGvCN5uKYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=Q4UtLf3RsBefgBpfbvm6mhpSdVhJi1Ep8JF1GG2IBeWs5pk9BgUv3zb8RaRb7QRV1
	 a2DR/7jgQMGC7oRxBluca8qZUZMO3zacvdP9CrBjMO5Vg0yw5Dvi6r1cz386DwkWtR
	 35E59AbxfzmFWB4MW9aZ/bt0Q6itQmgxvzy4+vOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfEBTeg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 2 May 2019 15:34:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfEBTeg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 May 2019 15:34:36 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 770EF20B7C;
        Thu,  2 May 2019 19:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556825675;
        bh=6h2nLHV75K7pg/3GnG/ZmdYCJph+Z72ZxnGvCN5uKYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=x+BLP2VbfcRxCs2mkDw876W9CTC4er0ih5SgnYrdlY6+3DOXjSDYMb9rtfBc5Jn21
         +AT7R5P8fhpGg24jMxX+p56Z1YsKRcnDKGV5vFcJ0Me0ZSA40fSwZot4wx1shUO2gQ
         i/Squ2zQe8SD1NdHZ6JMUZZ4R7AXKiY6aksFAquE=
From:   Tom Zanussi <zanussi@kernel.org>
To:     wagi@monom.org
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH 01/10] srt_commit: Fix --release-candidate arg misspelling
Date:   Thu,  2 May 2019 14:34:00 -0500
Message-Id: <6ab8cb7da40ee60bd0f9344f6729dc2cdd754c98.1556825097.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1556825097.git.tom.zanussi@linux.intel.com>
References: <cover.1556825097.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1556825097.git.tom.zanussi@linux.intel.com>
References: <cover.1556825097.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Fix misspelling of the current --release-canditate to make it the
intended --release-candidate.

Not because the misspelling itself is so bad, but so the user doesn't
have to remember to misspell it to use it ;-)

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 srt_commit.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/srt_commit.py b/srt_commit.py
index 9752a3f..8260513 100644
--- a/srt_commit.py
+++ b/srt_commit.py
@@ -114,7 +114,7 @@ def commit(config, rc):
 
 def add_argparser(parser):
     prs = parser.add_parser('commit')
-    prs.add_argument('--release-canditate', '-r',
+    prs.add_argument('--release-candidate', '-r',
                      default=None, metavar='N', type=int)
     return prs
 
@@ -123,4 +123,4 @@ def execute(args, config, ctx):
     if args.cmd != 'commit':
         return False
 
-    commit(config, args.release_canditate)
+    commit(config, args.release_candidate)
-- 
2.14.1

