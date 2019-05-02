Return-Path: <SRS0=oduH=TC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A0FC43219
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 19:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9562087F
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 19:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556825678;
	bh=kLyFsK7Ml5XQwxgRRB0k8lxfSLxbavkUgFLzl1GMV/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=RjQAvX/Roj7HwVJIBqDR1EcfI0uE5qbqjOMeko3wMX8EUTOSWg11tbwtOBXcA0E2n
	 N9m8NTS0DPp7CfOgIKSxjE8MK7iR5+U2jW5OA2iCKX/ypjw1SXk3nqIQlEwCt9uEhY
	 /TlloeQsxt6UOwbuNEnJpPbkaKarv8A0wq0zDIiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfEBTeh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 2 May 2019 15:34:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfEBTeh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 May 2019 15:34:37 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 966112085A;
        Thu,  2 May 2019 19:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556825676;
        bh=kLyFsK7Ml5XQwxgRRB0k8lxfSLxbavkUgFLzl1GMV/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=XOoa0pyJMBqyokXZich5VyNL7SgxKXjj8K7RgjAp0mRr12DXdh/lRLD+s8HfhoDx3
         jcWV9eIEkYR9cQEWPGykSAIweiJaEmEfCXSSJbQ8yD7lrIXMg0BPbhxDssaBIB0DWS
         TYQl1DkuKLWkToh8zHGKWvtHm1F58U+u4Qg0huEg=
From:   Tom Zanussi <zanussi@kernel.org>
To:     wagi@monom.org
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH 02/10] srt_util: Make the 'configuration not found' message more informative
Date:   Thu,  2 May 2019 14:34:01 -0500
Message-Id: <d688e408dd03fe7f62ea9d3bc0dbc26ae5a1194d.1556825097.git.tom.zanussi@linux.intel.com>
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

When a command such as srt commit can't find an entry in srt.conf
corresponding to the current repo/branch, it errors out with:

  ERROR:root:Could not retrieve configuration

The message makes it sound like it couldn't find the srt.conf file,
but in reality that wasn't the problem - it couldn't find a group
matching repo/branch.  Add that detail to the message as such:

ERROR:root:Could not retrieve configuration
           stable-rt/linux-stable-rt/v3.18-rt-next from srt.conf

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 srt_util.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/srt_util.py b/srt_util.py
index b572e03..c6099fd 100644
--- a/srt_util.py
+++ b/srt_util.py
@@ -97,7 +97,7 @@ def get_config():
         debug('Using configuration {0}'.format(config_name))
         config = read_config()[config_name]
     except:
-        error('Could not retrieve configuration')
+        error('Could not retrieve configuration {0} from srt.conf'.format(config_name))
         sys.exit(1)
 
     return config
-- 
2.14.1

