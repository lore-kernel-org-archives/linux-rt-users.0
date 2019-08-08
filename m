Return-Path: <SRS0=QXCx=WE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197DEC433FF
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D898D21874
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565294029;
	bh=+hrevod6U+GRNoraVTplUdmzgZKw6sRo8XrLTpG0oo8=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=z30HBMu41W9yiG4paz/Y6ewhtSqREBIHHk1ZnSRjIrnHXiuVk55dQ595DHjfNULjI
	 XjehBgX/BBK8lNV12qpIVHv/Qq+TpsfKcyTkoFnupRKn+lIxaZABfBg2huhbKlS6wA
	 6NsX8FnWgld+CCoJ+ti5LhBPNNcgYbAuHaOi0pyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404603AbfHHTxa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:53:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404588AbfHHTx3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Aug 2019 15:53:29 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61C5F21902;
        Thu,  8 Aug 2019 19:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565294008;
        bh=+hrevod6U+GRNoraVTplUdmzgZKw6sRo8XrLTpG0oo8=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=y4Jz00omwW7RGdmLkLGzb8bYKGx+RAnyYDdzGLXBr0w7IzPytnuyYRe2/K6G83zG+
         WaewQAkwtto9dect7n8pqYiL9C0YSrS1rhttKmENC++B7d7q2pk3EHhTEJkL72JI+P
         dM7y8F43lWVO4wPm5+iCVr13tQlBKGWFElpBqI2A=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 19/19] Linux 4.14.137-rt65-rc1
Date:   Thu,  8 Aug 2019 14:52:47 -0500
Message-Id: <97ea70a48ad812c4aa4fda03a76c51a2795f4c75.1565293935.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

v4.14.137-rt65-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index 10474042df49..03188f3e7d8d 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt64
+-rt65-rc1
-- 
2.14.1

