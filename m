From: Josh Cartwright <joshc@ni.com>
Subject: [PATCH rt-tests 1/4] rt-tests: Allow for user-specified PYLIB
Date: Thu, 27 Aug 2015 19:19:48 -0500
Message-ID: <94d6daa3898ca4a5e8c210247638a2c3b80f1a51.1440720422.git.joshc@ni.com>
References: <cover.1440720422.git.joshc@ni.com>
Cc: linux-rt-users@vger.kernel.org,
	Darren Hart <dvhart@linux.intel.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:41291 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751876AbbH1ATx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 27 Aug 2015 20:19:53 -0400
In-Reply-To: <cover.1440720422.git.joshc@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Darren Hart <dvhart@linux.intel.com>

Allow users (build systems) to specify PYLIB. This allows for a
cross-build-system to specify the target PYLIB rather than the host
PYLIB.

Signed-off-by: Darren Hart <dvhart@linux.intel.com>
CC: Clark Williams <williams@redhat.com>
CC: John Kacur <jkacur@redhat.com>
Signed-off-by: Josh Cartwright <joshc@ni.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index a48e759..1ec7f6a 100644
--- a/Makefile
+++ b/Makefile
@@ -34,7 +34,7 @@ ifdef HAVE_PARSE_CPUSTRING_ALL
 endif
 endif
 
-PYLIB  := $(shell python -c 'import distutils.sysconfig;  print distutils.sysconfig.get_python_lib()')
+PYLIB  ?= $(shell python -c 'import distutils.sysconfig;  print distutils.sysconfig.get_python_lib()')
 
 ifndef DEBUG
 	CFLAGS	+= -O2
-- 
2.5.0

