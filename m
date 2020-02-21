Return-Path: <SRS0=P7c/=4J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39474C3566F
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 21:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F93124650
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 21:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582320377;
	bh=hfjqjbH/69XjOXVTFuEk8cVS7pwRb367c/FI/hNju5Y=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=lHoFVqPOIgdPFf+WuStJP/lt9osj/La+RD3hfwakDtHL9r4knuvH8vlN48pyZ4J9u
	 UJZZiXha/uXlJ0J+VAXCO6nfT2KYbU+w28W83QSQv6uXgndQL2taSI7xHlqb66PCaV
	 OL9M2ep+ho3QHA0meTi4t69ziUVCuyFhripgYzEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbgBUV0N (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:26:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:39328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729518AbgBUVZc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Feb 2020 16:25:32 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B1BD24687;
        Fri, 21 Feb 2020 21:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582320331;
        bh=hfjqjbH/69XjOXVTFuEk8cVS7pwRb367c/FI/hNju5Y=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=BQTSZZYRCvqt/Gc6DKFHb7lQsz3gVxVvy5tCdDbqFkYXAjDg46yKonzu/BQklzMgO
         BkoiZ2dVAL4hAo2c/arGDPJ/1fO6YOSvt3mVjeq8wyq1CKijxfF1ImapPooCzMV9/L
         DbOzHsCWRfDQKhM0N5GyrcAY6Cc+0SIidvt/nEbE=
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
Subject: [PATCH RT 17/25] x86/fpu: Don't cache access to fpu_fpregs_owner_ctx
Date:   Fri, 21 Feb 2020 15:24:45 -0600
Message-Id: <25549e4ff2e5d78e663cf6e5cd8ed108ef03ff44.1582320278.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.14.170-rt75-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit eb46d70e4455e49928f136f768f1e54646ab4ff7 ]

The state/owner of the FPU is saved to fpu_fpregs_owner_ctx by pointing
to the context that is currently loaded. It never changed during the
lifetime of a task - it remained stable/constant.

After deferred FPU registers loading until return to userland was
implemented, the content of fpu_fpregs_owner_ctx may change during
preemption and must not be cached.

This went unnoticed for some time and was now noticed, in particular
since gcc 9 is caching that load in copy_fpstate_to_sigframe() and
reusing it in the retry loop:

  copy_fpstate_to_sigframe()
    load fpu_fpregs_owner_ctx and save on stack
    fpregs_lock()
    copy_fpregs_to_sigframe() /* failed */
    fpregs_unlock()
         *** PREEMPTION, another uses FPU, changes fpu_fpregs_owner_ctx ***

    fault_in_pages_writeable() /* succeed, retry */

    fpregs_lock()
	__fpregs_load_activate()
	  fpregs_state_valid() /* uses fpu_fpregs_owner_ctx from stack */
    copy_fpregs_to_sigframe() /* succeeds, random FPU content */

This is a comparison of the assembly produced by gcc 9, without vs with this
patch:

| # arch/x86/kernel/fpu/signal.c:173:      if (!access_ok(buf, size))
|        cmpq    %rdx, %rax      # tmp183, _4
|        jb      .L190   #,
|-# arch/x86/include/asm/fpu/internal.h:512:       return fpu == this_cpu_read_stable(fpu_fpregs_owner_ctx) && cpu == fpu->last_cpu;
|-#APP
|-# 512 "arch/x86/include/asm/fpu/internal.h" 1
|-       movq %gs:fpu_fpregs_owner_ctx,%rax      #, pfo_ret__
|-# 0 "" 2
|-#NO_APP
|-       movq    %rax, -88(%rbp) # pfo_ret__, %sfp
…
|-# arch/x86/include/asm/fpu/internal.h:512:       return fpu == this_cpu_read_stable(fpu_fpregs_owner_ctx) && cpu == fpu->last_cpu;
|-       movq    -88(%rbp), %rcx # %sfp, pfo_ret__
|-       cmpq    %rcx, -64(%rbp) # pfo_ret__, %sfp
|+# arch/x86/include/asm/fpu/internal.h:512:       return fpu == this_cpu_read(fpu_fpregs_owner_ctx) && cpu == fpu->last_cpu;
|+#APP
|+# 512 "arch/x86/include/asm/fpu/internal.h" 1
|+       movq %gs:fpu_fpregs_owner_ctx(%rip),%rax        # fpu_fpregs_owner_ctx, pfo_ret__
|+# 0 "" 2
|+# arch/x86/include/asm/fpu/internal.h:512:       return fpu == this_cpu_read(fpu_fpregs_owner_ctx) && cpu == fpu->last_cpu;
|+#NO_APP
|+       cmpq    %rax, -64(%rbp) # pfo_ret__, %sfp

Use this_cpu_read() instead this_cpu_read_stable() to avoid caching of
fpu_fpregs_owner_ctx during preemption points.

The Fixes: tag points to the commit where deferred FPU loading was
added. Since this commit, the compiler is no longer allowed to move the
load of fpu_fpregs_owner_ctx somewhere else / outside of the locked
section. A task preemption will change its value and stale content will
be observed.

 [ bp: Massage. ]

Debugged-by: Austin Clements <austin@google.com>
Debugged-by: David Chase <drchase@golang.org>
Debugged-by: Ian Lance Taylor <ian@airs.com>
Fixes: 5f409e20b7945 ("x86/fpu: Defer FPU state load until return to userspace")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Rik van Riel <riel@surriel.com>
Tested-by: Borislav Petkov <bp@suse.de>
Cc: Aubrey Li <aubrey.li@intel.com>
Cc: Austin Clements <austin@google.com>
Cc: Barret Rhoden <brho@google.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: David Chase <drchase@golang.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: ian@airs.com
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Bleecher Snyder <josharian@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Cc: stable-rt@vger.kernel.org
Link: https://lkml.kernel.org/r/20191128085306.hxfa2o3knqtu4wfn@linutronix.de
Link: https://bugzilla.kernel.org/show_bug.cgi?id=205663
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 arch/x86/include/asm/fpu/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index fa2c93cb42a2..92e12f5d0d64 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -498,7 +498,7 @@ static inline void __fpu_invalidate_fpregs_state(struct fpu *fpu)
 
 static inline int fpregs_state_valid(struct fpu *fpu, unsigned int cpu)
 {
-	return fpu == this_cpu_read_stable(fpu_fpregs_owner_ctx) && cpu == fpu->last_cpu;
+	return fpu == this_cpu_read(fpu_fpregs_owner_ctx) && cpu == fpu->last_cpu;
 }
 
 /*
-- 
2.14.1

