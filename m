Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFCB18029;
	Thu, 23 May 2024 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479748; cv=none; b=BrLs98Tq/vFT9LvpXlErPcQC2zsLelVW1nLUNtpwmwIEFH0w6apQo7+ZsHoTqmVq/o6h/bQqMdIWJzzUL20dGMViZvCnQ3xSGDAr4b0jFNlIrRJgADFGG0r1lPKQpyQt9ykl0l3KotNSHqWESvN/Sli2EdsHgPqm0c+RgiVGi9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479748; c=relaxed/simple;
	bh=gsY80Jzksl0YxrP84C2oha/PZ9voiI1msK1mtPRQd1o=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=MaL/6uDhb8z8nAqM8fUIQLzVzIeliX8tAzqPIN4fTVWMAbfzqoQzhJHTf37Apldmf7lhd65ekC2szfSyul5J6lLYjXaLolnz9dQl/Kv1WiNSdTXpWgZEBvgq1obyrDjp9zrGTPjz1TuHFRtRM94sUqe+lc1h5fjGJxsBJRA1oK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4VlXnm2gp1z8XrS0;
	Thu, 23 May 2024 23:55:40 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
	by mse-fl2.zte.com.cn with SMTP id 44NFtYS4076557;
	Thu, 23 May 2024 23:55:34 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp03[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 23 May 2024 23:55:37 +0800 (CST)
Date: Thu, 23 May 2024 23:55:37 +0800 (CST)
X-Zmail-TransId: 2afb664f66f9079-84b44
X-Mailer: Zmail v1.0
Message-ID: <20240523235537910_yxfGMbTcSOmMkcfuK2d8@zte.com.cn>
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
        <rostedt@goodmis.org>, <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIICA1LjEwLXJ0XSBwcmludGs6IGlnbm9yZSB0aGF0IGNvbnNvbGUgcHJlZW1wdGVkIGJ5IGlycS9zb2Z0aXJx?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 44NFtYS4076557
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 664F66FC.001/4VlXnm2gp1z8XrS0

From: xu xin <xu.xin16@zte.com.cn>

When we're in the unpreemptible context on the same cpu with which the
thread of console locates on, we should ignore this console for
pr_flush, because it's a vain and always lead to timeout until the console
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
+ /*
+ * When we're in the unpreemptible context on the same cpu
+ * with which the thread of console locates on, we should
+ * ignore this console, because it's a vain.
+ */
+ if (!preemptible() && con->thread &&
+ task_cpu(con->thread) == smp_processor_id())
+ continue;
if (!(con->flags & CON_ENABLED))
continue;
printk_seq = read_console_seq(con);
--
2.15.2
