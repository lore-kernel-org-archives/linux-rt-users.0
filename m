Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A421624CD
	for <linux-rt-users@vger.kernel.org>; Tue, 25 Feb 2025 22:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740521352; cv=none; b=AlIvSkAwX558ZSIkyv+Qs5akXVVtUO0nKb8LOItDC7QBUStnpfixANlot/mzDJ442kbw7KPIoBBYysl6gIpXwf7qNPkyic+xx0RfoqKFe+oK4UWhtnwYdkiZ6LOR99V1t1j6HyVt/te+f03mwwYDhTp7OZcN6nc8pJ1TRx93E70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740521352; c=relaxed/simple;
	bh=C7RzzJfa9E8EM4Z9VGzmJ6WO5e9c47t318xYpLm6EqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLwpNKii5nH9BppK5DaVZUIMTYJKx9Rd9JtRGWgDKKELsQD8th05/VvkubTihJNLE4G/yTNhJIBLesxh/8Rl4qKez31Kc/uwL7BYNSv5NhInNeqJNQtCdF304n7DBB0cz/rA50y4teaeq65uBae/IRPprOHKAMQqFnU1ViszCGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YCtTgrxo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCtTgrxo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740521350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GisQvOF5Kbq0B56DD+jpUPJESxrvtbreJtb4bQPW9J0=;
	b=YCtTgrxoPsnhy01uOIPFztsdkAjIBsVbAqtkRAOE4j7T/yQIBBJ/rGX2LL0kLnnoFAwyTP
	zGT7SP/Ch7LlASD3Mf7a+h6KYLkdoKaK6gsh/Y/JE//9opmQ4Goit1Sh/48zwEPAqj/aL3
	VxqsM/Ua7OnzOMxNk3OfOzQp9OSvEXc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-UFoGOpp4OZqbudMdSOQSxQ-1; Tue,
 25 Feb 2025 17:09:07 -0500
X-MC-Unique: UFoGOpp4OZqbudMdSOQSxQ-1
X-Mimecast-MFC-AGG-ID: UFoGOpp4OZqbudMdSOQSxQ_1740521345
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01CD31800264;
	Tue, 25 Feb 2025 22:09:04 +0000 (UTC)
Received: from localhost (unknown [10.22.80.185])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C73001800352;
	Tue, 25 Feb 2025 22:09:02 +0000 (UTC)
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>,
	Jeff Brady <jeffreyjbrady@gmail.com>,
	Wang Yong <wang.yong12@zte.com.cn>,
	Xuexin Jiang <jiang.xuexin@zte.com.cn>,
	Yang Yang <yang.yang29@zte.com.cn>,
	Xiaokai Ran <ran.xiaokai@zte.com.cn>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Luis Goncalves <lgoncalv@redhat.com>
Cc: "Ahmed S. Darwish" <a.darwish@linutronix.de>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH RT 1/4] u64_stats: Introduce u64_stats_set()
Date: Tue, 25 Feb 2025 19:08:54 -0300
Message-ID: <20250225220857.216591-2-lgoncalv@redhat.com>
In-Reply-To: <20250225220857.216591-1-lgoncalv@redhat.com>
References: <20250225220857.216591-1-lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: "Ahmed S. Darwish" <a.darwish@linutronix.de>

v5.10.234-rt127-rc1 stable review patch.
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
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/linux/u64_stats_sync.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
index f23192d55528..af6fc08d2fca 100644
--- a/include/linux/u64_stats_sync.h
+++ b/include/linux/u64_stats_sync.h
@@ -83,6 +83,11 @@ static inline u64 u64_stats_read(const u64_stats_t *p)
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
@@ -104,6 +109,11 @@ static inline u64 u64_stats_read(const u64_stats_t *p)
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
2.48.1

