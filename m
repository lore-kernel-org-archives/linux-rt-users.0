Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C379423959B;
	Mon,  3 Mar 2025 22:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741042382; cv=none; b=d7TeZ1HHbx4Pf2Ivpkae7k6OZeozZ0+fTfkh21D98z5rr70dvwHW3KAP6B46NwUK7xPC/Xl9iEp2BJBugmpLaWML96PR3ne7pY4Gmk5MRXqoFUO9RHVs6jUNK/oeZ2eMJbSoXpBQ1btG/25avgTLqUIazhGQ9+EOlrfp2c10KFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741042382; c=relaxed/simple;
	bh=sor4RPR8AkE4RMrn6yjMcCsIKCkzTu3ehkf4YiV6WaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lz3pp6Wgohz9tIuT73GGEm9n2eFKZe0ITUalbXjgSch8aVuZ3oSY40q2ro3QrBM6ghSCVn45ei+xT50UGboBYFMd6V/P115R1MQTxhzLhUSlxxgVP2nVWodNvyxrV5UqyyU1X6w0rVnV9/yad6aZI1Uhhn4KmR+E7lrb3rPCYzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ba+q9rVo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ba+q9rVo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2835FC4CEE9;
	Mon,  3 Mar 2025 22:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741042382;
	bh=sor4RPR8AkE4RMrn6yjMcCsIKCkzTu3ehkf4YiV6WaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ba+q9rVom0aFHsmkQzWAJrhvdEtu1qoHPAk65iAsnlxx+41v1Rz1y8Y7nK3gEpXID
	 eqwjAchnl3ALJaoAdNt91XBZc4U55WVfoOaHbkTuE+FtkUa5R8i5NmJbXeRazZ7h2b
	 VGMtLoz3EVw4Gj1YPGboQoAERXAJWvpL5++p4pIm++yxZ4ESg/LCxNanebj6FNzKkb
	 k6kGu7nQ2uXyFJQ05VWkS5c/VGP5O8KBFfjj5OeT+r7JWFr5ZNo3VMsY1tnCX4jj7i
	 qhiXNg645Ua7O8woBVp1saf5e7g3cM4qwtuacW6iF0MbEOnOyuluBeQm6RHpATSeAL
	 1oeeUSsrFpIcg==
From: zanussi@kernel.org
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <wagi@monom.org>,
	Clark Williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Joseph Salisbury <joseph.salisbury@oracle.com>,
	Tom Zanussi <zanussi@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH RT 1/4] u64_stats: provide u64_stats_t type
Date: Mon,  3 Mar 2025 16:52:55 -0600
Message-ID: <4159ba68c4b989be05e493a0dd95e10310a30aea.1741042351.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741042351.git.zanussi@kernel.org>
References: <cover.1741042351.git.zanussi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

v5.4.290-rt96-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 316580b69d0a7aeeee5063af47438b626bc47cbd ]

On 64bit arches, struct u64_stats_sync is empty and provides
no help against load/store tearing.

Using READ_ONCE()/WRITE_ONCE() would be needed.

But the update side would be slightly more expensive.

local64_t was defined so that we could use regular adds
in a manner which is atomic wrt IRQs.

However the u64_stats infra means we do not have to use
local64_t on 32bit arches since the syncp provides the needed
protection.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 include/linux/u64_stats_sync.h | 51 +++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
index ca40163933e33..a1f656fc317e6 100644
--- a/include/linux/u64_stats_sync.h
+++ b/include/linux/u64_stats_sync.h
@@ -40,8 +40,8 @@
  *   spin_lock_bh(...) or other synchronization to get exclusive access
  *   ...
  *   u64_stats_update_begin(&stats->syncp);
- *   stats->bytes64 += len; // non atomic operation
- *   stats->packets64++;    // non atomic operation
+ *   u64_stats_add(&stats->bytes64, len); // non atomic operation
+ *   u64_stats_inc(&stats->packets64);    // non atomic operation
  *   u64_stats_update_end(&stats->syncp);
  *
  * While a consumer (reader) should use following template to get consistent
@@ -52,8 +52,8 @@
  *
  * do {
  *         start = u64_stats_fetch_begin(&stats->syncp);
- *         tbytes = stats->bytes64; // non atomic operation
- *         tpackets = stats->packets64; // non atomic operation
+ *         tbytes = u64_stats_read(&stats->bytes64); // non atomic operation
+ *         tpackets = u64_stats_read(&stats->packets64); // non atomic operation
  * } while (u64_stats_fetch_retry(&stats->syncp, start));
  *
  *
@@ -68,6 +68,49 @@ struct u64_stats_sync {
 #endif
 };
 
+#if BITS_PER_LONG == 64
+#include <asm/local64.h>
+
+typedef struct {
+	local64_t	v;
+} u64_stats_t ;
+
+static inline u64 u64_stats_read(const u64_stats_t *p)
+{
+	return local64_read(&p->v);
+}
+
+static inline void u64_stats_add(u64_stats_t *p, unsigned long val)
+{
+	local64_add(val, &p->v);
+}
+
+static inline void u64_stats_inc(u64_stats_t *p)
+{
+	local64_inc(&p->v);
+}
+
+#else
+
+typedef struct {
+	u64		v;
+} u64_stats_t;
+
+static inline u64 u64_stats_read(const u64_stats_t *p)
+{
+	return p->v;
+}
+
+static inline void u64_stats_add(u64_stats_t *p, unsigned long val)
+{
+	p->v += val;
+}
+
+static inline void u64_stats_inc(u64_stats_t *p)
+{
+	p->v++;
+}
+#endif
 
 #if BITS_PER_LONG == 32 && defined(CONFIG_SMP)
 #define u64_stats_init(syncp)				\
-- 
2.43.0

