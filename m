Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679045A0FD
	for <linux-rt-users@vger.kernel.org>; Tue,  2 Apr 2024 10:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052726; cv=none; b=EDBP+8iIBJ4F5xA9eQzGzrhioFlfrq0NFbPEFLsbRb5G7AtIIN3389w0QB0QN/UPr1IwLKg8c+06i+san2XGEZiwBn2NopxfQ3scG1WWNJeM/fKT5skDJhSFEYyJh1gWuEahRjXSyRtfGKj2rm9osOMIp+XTejpBd/LxNWrE94Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052726; c=relaxed/simple;
	bh=JIJ4m0beE5jKptYP++AdtVl4SacYbYVy6XtOEgGxMBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iXFnFuQ40ON0FO9qU2C+NZEOD8GRJDl5H7g0enR/rc7mG9775Niw/8Mb96qkpUC0h+pEM8jdo0nwAMb8LX3ofGEjPbCff9xAHCNpeVmsY3vgpeXzLYdC+FBF+ogD18wx55D70hmT8+PTTKHZqsaLaNDpZwg029C/eLS2MCmOkyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=E2P7Elwx; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="E2P7Elwx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=PZWGI8yGQQtvew+R0/SI58Elx5RfY8sEwBlv/wfZEys=; b=E2P7Elwxl300FC6E58P9fgI4IB
	mY2LW9rNuzJhzvlMs6Be/1QuXZLQLSrUEvsCZQSWWTc7+4qb8b7ldqCg5XYWLvLEF4oMe2D7O6Zgu
	Y9dWTwtFs5joledPiA8MPXSi7bHy7vPz/4DW9SoQEZNaLluH/AytB3klOs8cpv97fkqugZ0Y4Lxj7
	fgpZcKnyOXwy23eU3oo+2/Ci7E01ikkzgdKqe6SSzkvD9+U9rZ0IVpzyEaDC/v7jhJoGU2MJAostl
	gJMQDJv9D8PVAvP8Icn2TGck5icOWI6kY9THadwPEcL7n2N8nAUAuZr+TAUNDhrR5naFZFhE7iAdi
	it/Cb9FQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rrb7a-000Dlv-5X; Tue, 02 Apr 2024 12:12:02 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1rrb7a-0001lU-0x;
	Tue, 02 Apr 2024 12:12:01 +0200
From: Esben Haabendal <esben@geanix.com>
To: Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-rt-users@vger.kernel.org
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 1/2] printk: export pr_flush()
Date: Tue,  2 Apr 2024 12:12:00 +0200
Message-ID: <d65ca57567e245aa99a944cefc195f2bc6974384.1712051763.git.esben@geanix.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27233/Tue Apr  2 10:26:21 2024)
Message-ID: <20240402101200.t6q7f28nw3d3bCLZl5BNKAapmaapqZ2KUlsHUNYOa70@z>

From: Martin Hundebøll <martin@geanix.com>

Outside prinkt users might wan't assure whatever printed has reached
its destination before continuing. E.g. during the shutdown-procedure,
where printk-buffers aren't emptied before the system goes down.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
---
 include/linux/printk.h | 2 ++
 kernel/printk/printk.c | 5 ++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index a2d40a637226..c8ac0f17d828 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -142,6 +142,8 @@ void early_printk(const char *s, ...) { }
 
 struct dev_printk_info;
 
+bool pr_flush(int timeout_ms, bool reset_on_progress);
+
 #ifdef CONFIG_PRINTK
 asmlinkage __printf(4, 0)
 int vprintk_emit(int facility, int level,
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index e29f77f4f8b4..26a63457ba6c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2484,7 +2484,6 @@ asmlinkage __visible int _printk(const char *fmt, ...)
 }
 EXPORT_SYMBOL(_printk);
 
-static bool pr_flush(int timeout_ms, bool reset_on_progress);
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress);
 
 static struct task_struct *nbcon_legacy_kthread;
@@ -2505,7 +2504,7 @@ static inline void wake_up_legacy_kthread(void)
 
 static u64 syslog_seq;
 
-static bool pr_flush(int timeout_ms, bool reset_on_progress) { return true; }
+bool pr_flush(int timeout_ms, bool reset_on_progress) { return true; }
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress) { return true; }
 
 static inline void nbcon_legacy_kthread_create(void) { }
@@ -4217,7 +4216,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
  * Context: Process context. May sleep while acquiring console lock.
  * Return: true if all usable printers are caught up.
  */
-static bool pr_flush(int timeout_ms, bool reset_on_progress)
+bool pr_flush(int timeout_ms, bool reset_on_progress)
 {
 	return __pr_flush(NULL, timeout_ms, reset_on_progress);
 }
-- 
2.44.0

