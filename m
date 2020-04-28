Return-Path: <SRS0=fi+z=6M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6844C83007
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 19:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B42FD21707
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 19:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588103587;
	bh=5MwtAwt23HUwt3RmEjSvPLH4SlUCkLVGjGSVTiRJ0dc=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=1cE2CKiizCdUV6Inw3HkDisyzHMNJrOgZuhTNdKknvCLUACqcfb9mV9AEsjLtNEsC
	 zJPH2tbFPcEKbDnHlWQ1dHhngATzh0g3nKfOC5Rh4p78xoo36yLf/UWoFrbOlbK3Um
	 0Bf2FFjdwovoIIEnoiAYcE0c0Pkm81CL/A8qKfsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbgD1TxF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:53:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728559AbgD1TxB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Apr 2020 15:53:01 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE47021973;
        Tue, 28 Apr 2020 19:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588103580;
        bh=5MwtAwt23HUwt3RmEjSvPLH4SlUCkLVGjGSVTiRJ0dc=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=F9wnkZb23TzzFcVBfgWUw8kPJVZRklt9sECh8ao4YbR3Rtl6iwVkScwInAK0A8J9W
         8zOWsDjP/IGtq1h4j1uZJO7nYfG2wg+FeIcSxdfRCqKWGiiDEgSg6ARLZS+EIzKM5U
         9psBgoCh4r4Gsb5Rdj1kNXa2hZR5q6v/vweHpwDs=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH RT 2/2] Linux 4.19.115-rt50-rc1
Date:   Tue, 28 Apr 2020 14:52:56 -0500
Message-Id: <54bb6619645e09a96cb23259282e6fa5add27c58.1588103561.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1588103561.git.zanussi@kernel.org>
References: <cover.1588103561.git.zanussi@kernel.org>
In-Reply-To: <cover.1588103561.git.zanussi@kernel.org>
References: <cover.1588103561.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

v4.19.115-rt50-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index 4b7dca68a5b4..e8a9a36bb066 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt49
+-rt50-rc1
-- 
2.17.1

