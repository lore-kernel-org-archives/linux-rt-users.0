Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31C71401F;
	Thu, 23 May 2024 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479654; cv=none; b=MOS9yabakVyQMV6mqcC/RHWmYjm1JRnQ/fzu587G5nQJdcYbsTAyAd8DHkVWbS1ern+Oo+jYES2SFp4jt97Uv13t0b9lccoiXIzGkoiOqxZL0nU4VE4IRa3yt16ArgqJvIqsX2x+u/Ae2czA1xB7PA5hR5pXwGGlEYueAPyKTN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479654; c=relaxed/simple;
	bh=Y9betDNBqCFVsZJxrcEUDGZqwDErzrwnHGGuVKgsbko=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=dzrVz3425e5VZrUwReuH9fZx4h7MC9wQdiaebY0ATqhQ7xTFZQ4+ald8qeCsmLkr00TlNjNoRxhRHve+u2FWTJgIpTB2meVI8Qq0SomSnVp/Ak6XHgMRP6adCucorEVkZCvp4242PKyGWODAhr/x57Zk21wZcHSLPF/Rf1c6vVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4VlXlq38Lcz8XrRB;
	Thu, 23 May 2024 23:53:59 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 44NFrvFY075406;
	Thu, 23 May 2024 23:53:57 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 23 May 2024 23:54:01 +0800 (CST)
Date: Thu, 23 May 2024 23:54:01 +0800 (CST)
X-Zmail-TransId: 2af9664f6699fffffffff57-3b67f
X-Mailer: Zmail v1.0
Message-ID: <20240523235401355RFqSAGtIPwMKV39mUulN1@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <bigeasy@linutronix.de>, <john.ogness@linutronix.de>,
        <rostedt@goodmis.org>
Cc: <zhang.yunkai@zte.com.cn>, <yang.yang29@zte.com.cn>,
        <liu.chun2@zte.com.cn>, <si.hao@zte.com.cn>,
        <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>,
        <rostedt@goodmis.org>
Subject: =?UTF-8?B?wqBbUEFUQ0jCoCA1LjE1LXJ0XSBwcmludGs6IGlnbm9yZSB0aGF0IGNvbnNvbGUgcHJlZW1wdGVkIGJ5IGlycS9zb2Z0aXJxLg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 44NFrvFY075406
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 664F6697.000/4VlXlq38Lcz8XrRB

From: xu xin <xu.xin16@zte.com.cn>

When we're in the unpreemptible context on the same cpu with which the
thread of console locates on, we should ignore this console for
pr_flush, because it's a vain and always lead to timeout  until the console
thread get cpu resource.

Fixes: e65be5f4dc3ed("printk: Update John Ogness' printk series")
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Cc: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 kernel/printk/printk.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 7f27cfee283e..faab85dd4439 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3735,6 +3735,14 @@ bool pr_flush(int timeout_ms, bool reset_on_progress)
 		diff = 0;

 		for_each_console(con) {
+			/*
+			 * When we're in the unpreemptible context on the same cpu
+			 * with which the thread of console locates on, we should
+			 * ignore this console, because it's a vain.
+			 */
+			if (!preemptible() && con->thread &&
+					task_cpu(con->thread) == smp_processor_id())
+				continue;
 			if (!(con->flags & CON_ENABLED))
 				continue;
 			printk_seq = read_console_seq(con);
-- 
2.15.2
