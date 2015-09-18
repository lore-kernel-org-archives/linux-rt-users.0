From: Henrik Austad <haustad@cisco.com>
Subject: [PATCH 6/7] rt_test.h: add numa_available() for !NUMA
Date: Fri, 18 Sep 2015 18:52:49 +0200
Message-ID: <1442595170-6229-7-git-send-email-haustad@cisco.com>
References: <1442595170-6229-1-git-send-email-haustad@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, Henrik Austad <haustad@cisco.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from aer-iport-3.cisco.com ([173.38.203.53]:13740 "EHLO
	aer-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754286AbbIRRE1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 Sep 2015 13:04:27 -0400
In-Reply-To: <1442595170-6229-1-git-send-email-haustad@cisco.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Code will snould not call numa_available(), but compiler will complain
with:

  src/cyclictest/rt_numa.h:263: warning: implicit declaration of functi=
on =E2=80=98numa_available=E2=80=99

Signed-off-by: Henrik Austad <haustad@cisco.com>
---
 src/cyclictest/rt_numa.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
index 06c9420..172d9b2 100644
--- a/src/cyclictest/rt_numa.h
+++ b/src/cyclictest/rt_numa.h
@@ -200,6 +200,7 @@ struct bitmask {
 };
 #define BITS_PER_LONG    (8*sizeof(long))
=20
+static inline int numa_available(void) { return 0; }
 static inline void *threadalloc(size_t size, int n) { return malloc(si=
ze); }
 static inline void threadfree(void *ptr, size_t s, int n) { free(ptr);=
 }
 static inline void rt_numa_set_numa_run_on_node(int n, int c) { }
--=20
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
