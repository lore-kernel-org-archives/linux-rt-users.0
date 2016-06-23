From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/3] rt-tests: Makefile, change version to 1.1
Date: Thu, 23 Jun 2016 14:11:49 +0200
Message-ID: <1466683911-10994-2-git-send-email-jkacur@redhat.com>
References: <1466683911-10994-1-git-send-email-jkacur@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466683911-10994-1-git-send-email-jkacur@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Rethinking the naming scheme, so changing the development line from 2.0
to 1.1

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index a54d82bd8964..d60282e05931 100644
--- a/Makefile
+++ b/Makefile
@@ -1,4 +1,4 @@
-VERSION = 2.0
+VERSION = 1.1
 CC?=$(CROSS_COMPILE)gcc
 AR?=$(CROSS_COMPILE)ar
 
-- 
2.4.11
