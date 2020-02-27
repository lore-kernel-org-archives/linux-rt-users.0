Return-Path: <SRS0=oIgZ=4P=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4484DC7656A
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Feb 2020 14:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1183524656
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Feb 2020 14:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814071;
	bh=/wpvT2KXTKwREYtzErr3NN+MGdbBtsYoGaQrIonZXqY=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=EN2q0XpDTH6QiP0HYrEwXXLyAI4XQUkVlTPptJtuSBkXcpdRJdkb1D9cK5ZilhkZx
	 op6T1yXnqFvesPHNIxJkFYGJD3DQfcfGO2NoPJ7tl9JQihFZxOyinbXAfoIFQh3bg7
	 KmoEjnq09xYq/IfWZcHmUuU4YWK5pX+muCSfhx8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388319AbgB0Oea (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:34:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:45332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388584AbgB0OeW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 27 Feb 2020 09:34:22 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E5C6246C1;
        Thu, 27 Feb 2020 14:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582814062;
        bh=/wpvT2KXTKwREYtzErr3NN+MGdbBtsYoGaQrIonZXqY=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=iBZelBUGJFmusjfErvjX2Ojhd1CSpD+6xoIq45Tsbog3v2Ueza+z3fCNFRMr/NDN4
         OzMlzTNMQvhGggl17G5i1YDsFSNn0fo4X3HTheR6hE7z91ma3jsnengLu32Eegp9UG
         oo4i3yqQFG7K1aVEzxeBrsDcfzUCEeh3cj2/lirQ=
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
Subject: [PATCH RT 23/23] Linux 4.14.170-rt75-rc2
Date:   Thu, 27 Feb 2020 08:33:34 -0600
Message-Id: <10c5fe4fa61fbc7206eb702e0435bdce6213f90f.1582814004.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1582814004.git.zanussi@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
In-Reply-To: <cover.1582814004.git.zanussi@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

v4.14.170-rt75-rc2 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index 7d028f4a9e56..2d2ca36685e5 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt74
+-rt75-rc2
-- 
2.14.1

