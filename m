Return-Path: <SRS0=oduH=TC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD27C43219
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 19:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2942087F
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 19:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556825680;
	bh=Ecldx371gWp/Wh+E+GrdRmYW/8atoOCa2YrWVazV7m0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=eykFQvFZi6PfkmzPmDIFruH5gkKQjJntYIUDDURxfc9/XWEf60+SFomGMTXsy05IQ
	 dQYXmBabkpqEYw61XaNWmRfByKnrCaboNCnGPb0BnuZNTYPA42xPC9Ov8B2CijbmC9
	 r5SFYgPFRsQq3ZFRhkh7D4vAfecAd7JIPgF3rS2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfEBTek (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 2 May 2019 15:34:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfEBTej (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 May 2019 15:34:39 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C720B2085A;
        Thu,  2 May 2019 19:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556825679;
        bh=Ecldx371gWp/Wh+E+GrdRmYW/8atoOCa2YrWVazV7m0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=xTrhX/6d7B7F4AcHfFsCJA3pLxV1M7mmcpbkPmOb7RILCDXRfkcPLcafO6mu0XXaH
         S76LSTh8UqVGBNMVPTH8qCUgHgOBTUkvj4JlriRYky88OB9bbIy6IeNcPIpA+oJlLc
         3SMQmaGYV2wfeudVe/vy9k6oW/ez1FSVR2qOPMYg=
From:   Tom Zanussi <zanussi@kernel.org>
To:     wagi@monom.org
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH 04/10] srt_announce: Allow rc releases to also reference release artifacts
Date:   Thu,  2 May 2019 14:34:03 -0500
Message-Id: <6ba2040dd3c9ca6466e959e208ddaf2071b348a8.1556825097.git.tom.zanussi@linux.intel.com>
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

The code to generate the rc cover letter assumes there won't be any
references to release tarballs, which isn't the case for everyone, and
so doesn't pass in a lot of the format strings to format().

To change this, create a common map and have the cover-generating code
use that, after appending its own specific strings.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 srt_announce.py | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/srt_announce.py b/srt_announce.py
index cc00412..a1985cd 100644
--- a/srt_announce.py
+++ b/srt_announce.py
@@ -47,6 +47,16 @@ def create_rc_patches(config, ctx):
     cmd(['git', 'checkout', branch_name])
     cmd(['git', 'branch', '-D', 'next-tmp'])
 
+def cover_letter_replacements(config, ctx):
+    r = {"mail_to" : config['MAIL_TO'],
+         "major" : ctx.new_tag.major,
+         "minor" : ctx.new_tag.minor,
+         "patch" : ctx.new_tag.patch,
+         "new_version" : ctx.new_short_tag,
+         "old_version" : ctx.old_short_tag,
+         "prj_dir" : config['PRJ_DIR'],
+         "new_tag_rt" : ctx.new_tag.rt }
+    return r
 
 def write_rc_cover_letter(config, ctx):
     with open(ctx.new_dir_mails + '/0000-cover-letter.patch', 'r') as f:
@@ -59,10 +69,13 @@ def write_rc_cover_letter(config, ctx):
     with open(config['RC_TEXT'], 'r') as f:
         rc_text = f.read()
 
+    r = cover_letter_replacements(config, ctx)
+
     today = date.today()
     rc_date = today + timedelta(weeks=1)
-    rc_text = rc_text.format(new_version=ctx.new_tag,
-                             release_date=rc_date)
+    r["release_date"] = rc_date
+
+    rc_text = rc_text.format(**r)
 
     coverletter = coverletter.replace('*** BLURB HERE ***',
                                       rc_text)
@@ -105,18 +118,13 @@ def announce(config, ctx, args):
     with open(config['ANNOUNCE'], 'r') as f:
         stable_rt_text = f.read()
 
-    print(stable_rt_text.format(
-        date=timestamp,
-        mail_to=config['MAIL_TO'],
-        branch_name=get_remote_branch_name(),
-        branch_head=cmd(['git', 'rev-parse', 'HEAD']),
-        major=ctx.new_tag.major,
-        minor=ctx.new_tag.minor,
-        patch=ctx.new_tag.patch,
-        new_version=ctx.new_short_tag,
-        old_version=ctx.old_short_tag,
-        prj_dir=config['PRJ_DIR'],
-        new_tag_rt=ctx.new_tag.rt))
+    r = cover_letter_replacements(config, ctx)
+
+    r["date"] = timestamp
+    r["branch_name"] = get_remote_branch_name()
+    r["branch_head"] = cmd(['git', 'rev-parse', 'HEAD'])
+
+    print(stable_rt_text.format(**r))
 
     print(cmd(['git', '--no-pager', 'shortlog', '{0}..{1}'.
                format(ctx.old_tag, ctx.new_tag)]))
-- 
2.14.1

