From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 3.10-rt] disable slab: add subject & author
Date: Thu, 1 Aug 2013 16:12:40 -0400
Message-ID: <1375387960-5224-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Sebastian Sewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:51900 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218Ab3HAUNB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 1 Aug 2013 16:13:01 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

To fix:

 [...]
(93/275) Applying: slub: Enable irqs for __GFP_WAIT
(94/275) Applying: slub: delay ctor until the object is requested
(95/275) Patch format detection failed.
git am of mm-disable-slab-on-rt.patch failed.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 patches/mm-disable-slab-on-rt.patch | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/patches/mm-disable-slab-on-rt.patch b/patches/mm-disable-slab-on-rt.patch
index 0a85bf4..a061dc1 100644
--- a/patches/mm-disable-slab-on-rt.patch
+++ b/patches/mm-disable-slab-on-rt.patch
@@ -1,3 +1,5 @@
+From: Thomas Gleixner <tglx@linutronix.de>
+Subject: mm: disable slab on rt
 ---
  init/Kconfig |    1 +
  mm/slab.h    |    2 +-
-- 
1.8.1.2

