Return-Path: <SRS0=JZDS=42=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5BEC10F25
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Mar 2020 19:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A85302467D
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Mar 2020 19:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583783308;
	bh=G7vUJDgxpIyD0AK6ceAVmAqJg4av+11jswgYZAGa5Ls=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=gaWrIiifoSmY8ajSD5aqo36pqxV2BU2O7ZKSIAyRAqwnINKHxqLQfTsKEmQUEFrjj
	 iukPUOaJkI2SWUr3rxqXH/ZqCEDJv61aoQnYbe42cPsNec9/FOjqZ3x3RW4ac58aXU
	 bobwN21dOXSQC7qXToqFAeLhm7kApSOD9a5yuoQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgCITsX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:48:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbgCITsX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 9 Mar 2020 15:48:23 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10B4B2467E;
        Mon,  9 Mar 2020 19:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583783302;
        bh=G7vUJDgxpIyD0AK6ceAVmAqJg4av+11jswgYZAGa5Ls=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=bHPZNbo8QLKxs2dqYl6oQeVRpJ1E97lSMVpD2FxWkxPd+KUy72yLpJh7RBvPcPZCd
         1/OgXN7hLrEOZomxlyXk7ZZaFjhmM9YepLIBzKfL0vvWvdekN+tlUOb2QcMlc9hf7o
         lnTUMqDGjnbeLDx87PUQ9ZhDDprb28bGGlgKO/00=
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
Subject: [PATCH RT 8/8] Linux 4.14.172-rt78-rc1
Date:   Mon,  9 Mar 2020 14:47:53 -0500
Message-Id: <5370884d55b44085438e8ac70fae403ac109f3bd.1583783251.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1583783251.git.zanussi@kernel.org>
References: <cover.1583783251.git.zanussi@kernel.org>
In-Reply-To: <cover.1583783251.git.zanussi@kernel.org>
References: <cover.1583783251.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

v4.14.172-rt78-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index 595841feef807..9cdb2dc591ba7 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt77
+-rt78-rc1
-- 
2.14.1

