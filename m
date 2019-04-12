Return-Path: <SRS0=XVUn=SO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FFFC10F0E
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Apr 2019 17:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B76F218C3
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Apr 2019 17:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555090303;
	bh=ce+3SuDKyQmhC9OWOwSuF6aG1EY/v9dsFu5b+NiU5oI=;
	h=Subject:From:To:Cc:Date:List-ID:From;
	b=zMsELDZf8dB9kRjmr0X32pdwCXgvrGikt7eMt5EDLEFAghRleH7+N+//72EljHzV3
	 VroeckftAA4tqUiBX2jJCNJ1DbgxbcCMaB2Du30JtoYkUOigEpuY2uXV9VUaC1Y8Uz
	 isBOUxDXZBplJLJVDpYsgVzD8lSeOOjhERFcCUa4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfDLRbm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 12 Apr 2019 13:31:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbfDLRbm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 12 Apr 2019 13:31:42 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E73B02171F;
        Fri, 12 Apr 2019 17:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555090301;
        bh=ce+3SuDKyQmhC9OWOwSuF6aG1EY/v9dsFu5b+NiU5oI=;
        h=Subject:From:To:Cc:Date:From;
        b=n4Kh+MCo0zc/OxWg6nY//+0ZO67nwvCMKg6EyaS5te/dxIo3oB/Xygv9Ryf0NzUFm
         Mn8GeI6R3r70s7059Nixna67SOXxjiFiXkxJOqqe2yISp93FjHaV/KsV5zdaBWfFZV
         hEcUFF4/HjuxVNc3ZU8XLzHVfjc7bmquWA2WBGfM=
Message-ID: <1555090299.12566.35.camel@kernel.org>
Subject: [PATCH] srt_create: Make sure series output is sorted
From:   Tom Zanussi <zanussi@kernel.org>
To:     Daniel Wagner <daniel.wagner@siemens.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Date:   Fri, 12 Apr 2019 12:31:39 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Daniel,

I actually used your stable-rt-tools srt tool this time to do the
latest 3.18-rt update release - overall it works well and did the job
nicely!

I did run into one serious problem in that the series file that gets
created for the patches tarball lists the patches in essentially random
order on my system, so using it to apply the series with quilt failed
immediately.  The patch below fixes the problem for me.

There were a few other things I ran into which boiled down to
essentially lack of documentation and/or informative enough error
messages, and one or two things having to do with my workflow on two
separate machines that I'll have to think about.  I'll write some
patches addressing those and sent when I get the chance.

Anyway, thanks for the useful tool!

Tom 

--

From: Tom Zanussi <tom.zanussi@linux.intel.com>

os.listdir() doesn't guarantee ordering, so using its output directly
as input for the series file can result in a randomly ordered series
that quilt can't apply.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 srt_create.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/srt_create.py b/srt_create.py
index 7314988..90d1e1b 100644
--- a/srt_create.py
+++ b/srt_create.py
@@ -47,7 +47,7 @@ def create_series(old_tag, new_tag, dirname):
     cmd(['git', 'format-patch', '-q', '-o', dirname,
          '{0}..{1}'.format(old_tag, new_tag)])
 
-    patches = [f for f in os.listdir(dirname)
+    patches = [f for f in sorted(os.listdir(dirname))
                if os.path.isfile(os.path.join(dirname, f))]
     with open(dirname + '/series', 'w') as file:
         for p in patches:
-- 
2.14.1

