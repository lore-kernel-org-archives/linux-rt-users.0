Return-Path: <SRS0=c0v5=6H=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0494CC54FCB
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Apr 2020 20:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D208020767
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Apr 2020 20:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587675275;
	bh=BeQcSF6jOG+uWuVTDZg5UbaIPKcyCROEisceWJecsyw=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=XpsoEGFHA8I1qVq5wKFmWGEDfKTfH4LYYu+f7f4ngiXN3SKIwexSM/qCUEbI3MzbV
	 dXKp6lyOzcjJmruG7WDCzgr1HE51nopfqTf9h96AVYYf6iBNFJqDFi7XSvpI25OtjS
	 /0x+vFnrL9WNzSCoG62lFupiJRuuvXWLAIP4MZEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgDWUyc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Apr 2020 16:54:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgDWUyb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Apr 2020 16:54:31 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13E202084D;
        Thu, 23 Apr 2020 20:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587675271;
        bh=BeQcSF6jOG+uWuVTDZg5UbaIPKcyCROEisceWJecsyw=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=tj74cLqSAdR67vEpDKSM6RDEgPhdokOlTtsWb/8RwPBU4IGxVdgd5cRAjm+orOsQD
         /Ec4LUqjJyXipMWOfPJ4IiGafVQZJqS9wlAcwgz6Gm/nQOznfgapC2LolnFqZiTi4I
         1mL+D3d4MJACz3VRJuObUGlMgXDN2+P2PSKjEvIQ=
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
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 2/2] Linux 4.19.115-rt49-rc1
Date:   Thu, 23 Apr 2020 15:54:26 -0500
Message-Id: <431f6cb1ee0a4bff9541c17103ae26ea0c417618.1587675252.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1587675252.git.zanussi@kernel.org>
References: <cover.1587675252.git.zanussi@kernel.org>
In-Reply-To: <cover.1587675252.git.zanussi@kernel.org>
References: <cover.1587675252.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

v4.19.115-rt49-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index 24707986c321..623b4c9cb701 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt48
+-rt49-rc1
-- 
2.17.1

