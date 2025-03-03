Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FDB23AE9A;
	Mon,  3 Mar 2025 22:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741042384; cv=none; b=J32G0y/SqEMK6a5WGttwJ93o2B3/rJL5C8mAfdffJvn1c4AIt6gULmHc/Zi3ggfIyg8wwdpitLSHGEeDvLz5DLOQBZ20slFxZKGTF61pfBbdfnrrYfSybORrhK2oQLjMJ/xd6mNpCt8XU1MMH3igm/isrEE/6mRN7gxLK0TiDLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741042384; c=relaxed/simple;
	bh=5PDd9P7Q48zvxj9nWm103R4PqBL3obiE2ckN/i5QNBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckW1xWELEkjuaoHIKlRvbejGv98x2r3yWbhuT0/2Cc8hU1G5iEKghrCAazqxPJR0oOkbUdPhMHVcbLucloAEU/cSDQqpEIdHiziTVmyCAJE44zDwVngXtYaymq7ohMJYL5RS+BXyd9xV4dzY5LxE3y8md6O9JoRykPbxMTMdP70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuTsYsz/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuTsYsz/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD43C4CEEB;
	Mon,  3 Mar 2025 22:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741042383;
	bh=5PDd9P7Q48zvxj9nWm103R4PqBL3obiE2ckN/i5QNBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UuTsYsz/bGnrF+Anbf4aEisFt2efzFY0cZk4PFv7cq9bZ9IfuLVXocAjpcQBl6M92
	 4YZzVW7kN5GVzbxmhCmteT58yUdb/ChZkzJFR4t+yOtyPJcNUZ4HKlQ2Bbflqp8cgT
	 szEP5E34V2qRtBpcnzvFVGD8UMQTEPCRoqWYSLjXrzHJEUnRIeEV4B7qwP/gQ5M8kU
	 BUeb4cKgqzlc5/EZ7xyrFhIPLqzZz9EwJvDOP/RTmRzENK3g8qB8Ca3tq/fACWrPB4
	 WoXJfntzI4CCsUfTgAr2q8u2SmiYMxo+BVqg+j/fidgKdrrixkayUytVh0wHizpP+K
	 US3e09Kh3d6Ew==
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
Cc: "Ahmed S. Darwish" <a.darwish@linutronix.de>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH RT 2/4] u64_stats: Introduce u64_stats_set()
Date: Mon,  3 Mar 2025 16:52:56 -0600
Message-ID: <e5ff954bdcc8d4f56a6a7b538f71175e08bb1f04.1741042351.git.zanussi@kernel.org>
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

From: "Ahmed S. Darwish" <a.darwish@linutronix.de>

v5.4.290-rt96-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit f2efdb17928924c9c935c136dea764a081032006 ]

Allow to directly set a u64_stats_t value which is used to provide an init
function which sets it directly to zero intead of memset() the value.

Add u64_stats_set() to the u64_stats API.

[bigeasy: commit message. ]

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 include/linux/u64_stats_sync.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
index a1f656fc317e6..cae87feb82d6e 100644
--- a/include/linux/u64_stats_sync.h
+++ b/include/linux/u64_stats_sync.h
@@ -80,6 +80,11 @@ static inline u64 u64_stats_read(const u64_stats_t *p)
 	return local64_read(&p->v);
 }
 
+static inline void u64_stats_set(u64_stats_t *p, u64 val)
+{
+	local64_set(&p->v, val);
+}
+
 static inline void u64_stats_add(u64_stats_t *p, unsigned long val)
 {
 	local64_add(val, &p->v);
@@ -101,6 +106,11 @@ static inline u64 u64_stats_read(const u64_stats_t *p)
 	return p->v;
 }
 
+static inline void u64_stats_set(u64_stats_t *p, u64 val)
+{
+	p->v = val;
+}
+
 static inline void u64_stats_add(u64_stats_t *p, unsigned long val)
 {
 	p->v += val;
-- 
2.43.0

