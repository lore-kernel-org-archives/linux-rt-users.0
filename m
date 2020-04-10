Return-Path: <SRS0=Yj13=52=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29D7C2BB86
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Apr 2020 20:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8F421556
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Apr 2020 20:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586549711;
	bh=ZRRD0SOwdkN0kTjAbwlVemj3yzKyYjhCCjAGcyZm7Q4=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=uiSUF2eJzIsMYVNKAGFqym2QP2PMHJtaIw0rR/pjTokYBHUNrnOLjG5JBma3Wy0e4
	 E3bb+5d+u7YOlSGPeR1gqX3mdofrNlIE2HSilGIq9Ew6g7jHxVIscUgo+RT23pmIEj
	 cjAOQhoxDPfgh5zFtFDpM4wjgiYv3MnfYSPrgfGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgDJUPG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 Apr 2020 16:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgDJUPG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Apr 2020 16:15:06 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B89EB2087E;
        Fri, 10 Apr 2020 20:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586549706;
        bh=ZRRD0SOwdkN0kTjAbwlVemj3yzKyYjhCCjAGcyZm7Q4=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=glNmDlYj8kAvTOIiBJJwTj11Vf5nerdGNUHkxRlLmPlfPK9Ha15yFWp8amuizMPfj
         kPnhN7t+b4n4gf3Up2KFg4uvX2VmCcvqYNjzuLTwfSbBLqDuy9Kp/e927UGpgSOeI/
         DvSWLAdE1oy8bex3iXthO0M4nCyQ4LUV8hsF3sX0=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 2/2] Linux 4.14.175-rt81-rc1
Date:   Fri, 10 Apr 2020 15:15:02 -0500
Message-Id: <3eb9287dc6bed6dc7dbf069ca0ae3d4187cebb65.1586549682.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1586549682.git.zanussi@kernel.org>
References: <cover.1586549682.git.zanussi@kernel.org>
In-Reply-To: <cover.1586549682.git.zanussi@kernel.org>
References: <cover.1586549682.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

v4.14.175-rt81-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index 5ba2c2091cf9..738174cbcc3e 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt80
+-rt81-rc1
-- 
2.17.1

