From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH 1/3] Makefile: Include arch Makefiles as late as possible
Date: Wed, 4 Feb 2009 18:08:35 +0300
Message-ID: <20090204150835.GA30027@oksana.dev.rtsoft.ru>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Steven Rostedt <srostedt@redhat.com>, Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:60206 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751755AbZBDPIg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Feb 2009 10:08:36 -0500
Content-Disposition: inline
In-Reply-To: <20090204150755.GA24163@oksana.dev.rtsoft.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This patch gives arches more freedom on overwriting CFLAGS, specifically
on PowerPC we want to remove -fno-omit-frame-pointer flag.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 7715b2c..d1ba93f 100644
--- a/Makefile
+++ b/Makefile
@@ -525,8 +525,6 @@ else
 KBUILD_CFLAGS	+= -O2
 endif
 
-include $(srctree)/arch/$(SRCARCH)/Makefile
