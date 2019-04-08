Return-Path: <SRS0=BA5Y=SK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE807C10F13
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 19:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E8F2087F
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 19:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554750940;
	bh=sFZj5PWbQwM9lYkGkYzvILhlUtNY/iGXZe7nNm+nm1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=n0V/q9fCygXXBs+amJSd3tnhMjfhYCNDTsnDUzUnCYNnsLqcqyYDzKPDw5bzgZOUL
	 teb6t69079ktz1wPSYLoLabbT5i3jEK1ChdnWLCa3D4Q1xwrOlP+zwNsMnwOvrwHQF
	 bt6WF2q7oZxxjTMEkIkmZPS9qh/+MMbKFCAT2Z44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfDHTOX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:14:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfDHTOV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Apr 2019 15:14:21 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2EC22087F;
        Mon,  8 Apr 2019 19:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554750860;
        bh=sFZj5PWbQwM9lYkGkYzvILhlUtNY/iGXZe7nNm+nm1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=2JQUBS2+Pe/BuDdgU4qAz8OgTYK1dVpCztDsx7ItLq/3CFFsrlD2bEWSG7AEUJoYa
         UIAh+8cERUFbQZ7uWSCmk8e8ZhOyZ5Dk92Cnc06jDQgkh3TT1XpZp36TbFimC6iVuE
         an7zWqh7Cko94KsyQ4FdAbwzIpKdzcHguLYD1PSY=
From:   Tom Zanussi <zanussi@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com, amartin@nvidia.com
Subject: [PATCH 01/13] arm64: fpsimd: use preemp_disable in addition to local_bh_disable()
Date:   Mon,  8 Apr 2019 14:14:03 -0500
Message-Id: <b639e14b57a08f3a8931e44ed26101867414b4be.1554737688.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1554737688.git.tom.zanussi@linux.intel.com>
References: <cover.1554737688.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1554737688.git.tom.zanussi@linux.intel.com>
References: <cover.1554737688.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

4.14.109-rt58-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 3afdfe419c33c1655d0763e070350aad44416594 ]

In v4.16-RT I noticed a number of warnings from task_fpsimd_load(). The
code disables BH and expects that it is not preemptible. On -RT the
task remains preemptible but remains the same CPU. This may corrupt the
content of the SIMD registers if the task is preempted during
saving/restoring those registers.

Add preempt_disable()/enable() to enfore the required semantic on -RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[tom.zanussi@linux.intel.com: ignored sve-related changes]
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>

 Conflicts:
	arch/arm64/kernel/fpsimd.c
---
 arch/arm64/kernel/fpsimd.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 5d547deb6996..049641a458f3 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -172,6 +172,7 @@ void fpsimd_flush_thread(void)
 	if (!system_supports_fpsimd())
 		return;
 
+	preempt_disable();
 	local_bh_disable();
 
 	memset(&current->thread.fpsimd_state, 0, sizeof(struct fpsimd_state));
@@ -179,6 +180,7 @@ void fpsimd_flush_thread(void)
 	set_thread_flag(TIF_FOREIGN_FPSTATE);
 
 	local_bh_enable();
+	preempt_enable();
 }
 
 /*
@@ -190,12 +192,14 @@ void fpsimd_preserve_current_state(void)
 	if (!system_supports_fpsimd())
 		return;
 
+	preempt_disable();
 	local_bh_disable();
 
 	if (!test_thread_flag(TIF_FOREIGN_FPSTATE))
 		fpsimd_save_state(&current->thread.fpsimd_state);
 
 	local_bh_enable();
+	preempt_enable();
 }
 
 /*
@@ -208,6 +212,7 @@ void fpsimd_restore_current_state(void)
 	if (!system_supports_fpsimd())
 		return;
 
+	preempt_disable();
 	local_bh_disable();
 
 	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
@@ -219,6 +224,7 @@ void fpsimd_restore_current_state(void)
 	}
 
 	local_bh_enable();
+	preempt_enable();
 }
 
 /*
@@ -231,6 +237,7 @@ void fpsimd_update_current_state(struct fpsimd_state *state)
 	if (!system_supports_fpsimd())
 		return;
 
+	preempt_disable();
 	local_bh_disable();
 
 	fpsimd_load_state(state);
@@ -242,6 +249,7 @@ void fpsimd_update_current_state(struct fpsimd_state *state)
 	}
 
 	local_bh_enable();
+	preempt_enable();
 }
 
 /*
@@ -281,6 +289,7 @@ void kernel_neon_begin(void)
 
 	BUG_ON(!may_use_simd());
 
+	preempt_disable();
 	local_bh_disable();
 
 	__this_cpu_write(kernel_neon_busy, true);
@@ -295,6 +304,7 @@ void kernel_neon_begin(void)
 	preempt_disable();
 
 	local_bh_enable();
+	preempt_enable();
 }
 EXPORT_SYMBOL(kernel_neon_begin);
 
-- 
2.14.1

