Return-Path: <SRS0=P7c/=4J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640D9C3566F
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 21:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC7E24650
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 21:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582320364;
	bh=IjzaTt8FULKTC4GD3U1z/rClqQSIYqxBkrFVREQ5Ouo=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=myv2MkRY16xGe+XdR+73tuTncY965YjAm+v2O4Ih+4Awtr6JTuZOM79DbXcYRHzSa
	 ZLRXuhZkyFwkFatUk72p0HtzZR2gYBepmGI8RcURDxRlsoNbIpBwCpz2BzelE+orQQ
	 RFxOL3oJcgsHw/T0/HgiLuKzUCGX2wdaMVBAS/CY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbgBUVZ4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:25:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:39512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729687AbgBUVZk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Feb 2020 16:25:40 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E797824694;
        Fri, 21 Feb 2020 21:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582320339;
        bh=IjzaTt8FULKTC4GD3U1z/rClqQSIYqxBkrFVREQ5Ouo=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=BX3NXvgINtbmf/u8h4b7fZ4IcJ7AOmaSoae9JkypRy/WlOxAe7i1Mvelxra1dOKd/
         xBN52Q3O2vMtydwYmF3YEAUeS44t468nAbmgZ6V3FW3tYLV0hDWhp1fIwI3xKbmmsT
         ntbedZ8l+JYMc78ZSZJJnKr7E/bqmO1qzPKPCskY=
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
Subject: [PATCH RT 25/25] Linux 4.14.170-rt75-rc1
Date:   Fri, 21 Feb 2020 15:24:53 -0600
Message-Id: <81061c6d7bfe76438e875ca80f0162b43d411058.1582320278.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

v4.14.170-rt75-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index 7d028f4a9e56..5449cd22a524 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt74
+-rt75-rc1
-- 
2.14.1

