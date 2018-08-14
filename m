Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.kernel.org ([198.145.29.99]:54412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbeHNVnl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Aug 2018 17:43:41 -0400
From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 14/15] um: Use POSIX ucontext_t instead of struct ucontext
Date: Tue, 14 Aug 2018 13:54:07 -0500
Message-Id: <2de9b82e0bded67d3488ad0df109aac78a8f64f4.1534263273.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1534263273.git.tom.zanussi@linux.intel.com>
References: <cover.1534263273.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1534263273.git.tom.zanussi@linux.intel.com>
References: <cover.1534263273.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org
Cc: rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org, jkacur@redhat.com, bigeasy@linutronix.de, daniel.wagner@siemens.com, julia@ni.com

v3.18.117-rt105 rt-stable review patch.  If anyone has any objections,
please let me know.

------------------

From: Krzysztof Mazur <krzysiek@podlesie.net>

[ Upstream commit 4d1a535b8ec5e74b42dfd9dc809142653b2597f6 ]

glibc 2.26 removed the 'struct ucontext' to "improve" POSIX compliance
and break programs, including User Mode Linux. Fix User Mode Linux
by using POSIX ucontext_t.

This fixes:

arch/um/os-Linux/signal.c: In function 'hard_handler':
arch/um/os-Linux/signal.c:163:22: error: dereferencing pointer to incomplete type 'struct ucontext'
  mcontext_t *mc = &uc->uc_mcontext;
arch/x86/um/stub_segv.c: In function 'stub_segv_handler':
arch/x86/um/stub_segv.c:16:13: error: dereferencing pointer to incomplete type 'struct ucontext'
          &uc->uc_mcontext);

Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Mazur <krzysiek@podlesie.net>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 arch/um/os-Linux/signal.c | 2 +-
 arch/x86/um/stub_segv.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 7b605e4dfffa..2ac6a7e5a179 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -135,7 +135,7 @@ static void (*handlers[_NSIG])(int sig, struct siginfo *si, mcontext_t *mc) = {
 
 static void hard_handler(int sig, siginfo_t *si, void *p)
 {
-	struct ucontext *uc = p;
+	ucontext_t *uc = p;
 	mcontext_t *mc = &uc->uc_mcontext;
 	unsigned long pending = 1UL << sig;
 
diff --git a/arch/x86/um/stub_segv.c b/arch/x86/um/stub_segv.c
index 1518d2805ae8..fd6825537b97 100644
--- a/arch/x86/um/stub_segv.c
+++ b/arch/x86/um/stub_segv.c
@@ -10,7 +10,7 @@
 void __attribute__ ((__section__ (".__syscall_stub")))
 stub_segv_handler(int sig, siginfo_t *info, void *p)
 {
-	struct ucontext *uc = p;
+	ucontext_t *uc = p;
 
 	GET_FAULTINFO_FROM_MC(*((struct faultinfo *) STUB_DATA),
 			      &uc->uc_mcontext);
-- 
2.14.1
