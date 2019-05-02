Return-Path: <SRS0=oduH=TC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91982C43219
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 19:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6157820B7C
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 19:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556825679;
	bh=DMXcS5i4oDzT7nI1kYQDA1GZI1tVguw/fjijLikocJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=vpMomNXT0g0VxhrZEgS0sP8+lEUqQfwoLA2mEjzNk/BSo32ubc5tunS+fCHCiUTyL
	 CGJ0tmkCvLgupx7MPQF+4jEOvzScvtP2t2zMWXTDzRPFpvi9iYIqnpqOrgH97hHafw
	 KG5fjEuAslm9diDwtN+U2+rFp3Z432qCGOv78Mos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfEBTej (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 2 May 2019 15:34:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfEBTei (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 May 2019 15:34:38 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABBEE205F4;
        Thu,  2 May 2019 19:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556825678;
        bh=DMXcS5i4oDzT7nI1kYQDA1GZI1tVguw/fjijLikocJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=XhXrcgkBqNguGnONnBCfhxxfL9qAdiQWvfD02R9PebZr9iwgno6XKZahZJCMBG0XG
         uHunAwZm0EdISV9cXZyTSdytJJT2rC9QZMNGrPRLs56jlQlJ7OqFJbMUFfax0tjSmS
         LYiXOB0DHrIdZlKxX3DE4RUWhfMwDSjkit9CcITo=
From:   Tom Zanussi <zanussi@kernel.org>
To:     wagi@monom.org
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH 03/10] srt_announce: Add an option to suppress git send-email auto-cc
Date:   Thu,  2 May 2019 14:34:02 -0500
Message-Id: <6dcebadc2b4f1557c78787c5e3c4ee9ff0864d95.1556825097.git.tom.zanussi@linux.intel.com>
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

Sometimes it's useful to be able to do a 'real' dry run i.e. actually
sending out -rc patches and cover letter to a real e-mail address and
nowhere else.

Doing this with the default auto-cc defeats the purpose though, so add
an option to allow disabling it from the command line.

Example usage:

 srt -d announce -s v3.18.138-rt115 v3.18.138-rt116-rc1

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 srt_announce.py | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/srt_announce.py b/srt_announce.py
index 3a89ef6..cc00412 100644
--- a/srt_announce.py
+++ b/srt_announce.py
@@ -71,8 +71,10 @@ def write_rc_cover_letter(config, ctx):
         f.write(coverletter)
 
 
-def send_rc_patches(config, ctx):
+def send_rc_patches(config, ctx, args):
     gmd = ['git', 'send-email', '--confirm=never']
+    if args.suppress_cc:
+        gmd += ['--suppress-cc=all']
     gmd += ['--to="{}"'.format(t) for t in config['MAIL_TO'].split(',')]
     gmd += [ctx.new_dir_mails]
 
@@ -84,15 +86,15 @@ def send_rc_patches(config, ctx):
         cmd(gmd)
 
 
-def announce_rc(config, ctx):
+def announce_rc(config, ctx, args):
     create_rc_patches(config, ctx)
     write_rc_cover_letter(config, ctx)
-    send_rc_patches(config, ctx)
+    send_rc_patches(config, ctx, args)
 
 
-def announce(config, ctx):
+def announce(config, ctx, args):
     if ctx.is_rc:
-        announce_rc(config, ctx)
+        announce_rc(config, ctx, args)
         return
 
     # rfc2822.html
@@ -134,6 +136,8 @@ def add_argparser(parser):
     prs = parser.add_parser('announce')
     prs.add_argument('OLD_TAG')
     prs.add_argument('NEW_TAG')
+    prs.add_argument('--suppress-cc', '-s', action="store_true", default=False,
+                     help='Don''t auto-cc anyone (for testing)')
     return prs
 
 
@@ -141,4 +145,4 @@ def execute(args, config, ctx):
     if args.cmd != 'announce':
         return False
 
-    announce(config, ctx)
+    announce(config, ctx, args)
-- 
2.14.1

