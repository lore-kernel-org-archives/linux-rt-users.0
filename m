Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED45559151
	for <linux-rt-users@vger.kernel.org>; Tue,  2 Apr 2024 10:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052805; cv=none; b=p0U7QBA40PR6mg00xopxhWM4gYdlbyisFnIGxLw6eaw73boJexF6bt6YcKCrqjp/DpqFPOHNc64ND4WFKx6NBfNllz4z+DgcRH+wG0E8w+R16bSdL0Cqlk+fXA2Bd9jX0PmnFaggA9qnSp1lR9VFUwGtoOPV3m2BphBcaDTBy08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052805; c=relaxed/simple;
	bh=G0Z84NOgv9fIRLZmPUycLJPiiycfiBeZrpeCfe1Sn/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i7LsKnyic6XcTLdsejfbnhKdIDtdKZHV3R7Du36iJ8OqMXEixqXpCbo2oQ7cVQEaLeWy6L6XJCjPE4A3VMDX//P+ESgdvxolr9DuynvRHv8FqBuk3+SVUTFPKQHJcD/EWD9vRzImWNS+rN/ZJ+rCprE+Ofnrb9bH/1q+CEG4Qdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=psSvFULe; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="psSvFULe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=2IHlE4/TvlDXxFLKZdtrQTGpUSp9/pOnQW8E+0WWSek=; b=psSvFULex/CKqRSbCYMGOEgY3g
	+K3MMALYfFKMkhqWxIhCT+9w0WAJ+SxM58jXa0brkYWpDwc5ynVrMyhQVjxEytEmuhoSboehTd/Ls
	+xddwS4ae8LvpvUD//nrQz5xLbPQjQUtzuayXgA3+fFr/wVnwuU/Dsxsh3DnZwNQtONcCMnB30BOE
	5d6nftWW4y/iHlGbiztiUkyM5WTeYoGpVx7vCTUilpN7zb543yVlcRBl7DsNBtHiOSznPqb67wAQi
	dbLVyt9xcpAAuDAbbqqIMDUAgsV6t0FgkDXDzFcARRFF/aXQSU+RDaIUDXVqjPW/c6+nO9C6yZIn2
	mR8F7IlA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rrb8r-000E0U-4X; Tue, 02 Apr 2024 12:13:21 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1rrb8r-000DIf-1Z;
	Tue, 02 Apr 2024 12:13:20 +0200
From: Esben Haabendal <esben@geanix.com>
To: linux-rt-users@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 2/2] reboot: flush printk buffers before final shutdown
Date: Tue,  2 Apr 2024 12:13:21 +0200
Message-ID: <a64dd2c6829f07caae9e93c37d5a2bcfc3dbd6e9.1712051763.git.esben@geanix.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <d65ca57567e245aa99a944cefc195f2bc6974384.1712051763.git.esben@geanix.com>
References: <d65ca57567e245aa99a944cefc195f2bc6974384.1712051763.git.esben@geanix.com>
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
Message-ID: <20240402101321.9Rs841l6bGOhscIw75U071GQKNibE3wH6Q5WJp-TQKk@z>

From: Martin Hundebøll <martin@geanix.com>

Make sure printed messages are in fact printed before putting the system
down.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
---
 kernel/reboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index 22c16e2564cc..e3fa5613257f 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -283,6 +283,7 @@ void kernel_restart(char *cmd)
 	else
 		pr_emerg("Restarting system with command '%s'\n", cmd);
 	kmsg_dump(KMSG_DUMP_SHUTDOWN);
+	pr_flush(1000, false);
 	machine_restart(cmd);
 }
 EXPORT_SYMBOL_GPL(kernel_restart);
-- 
2.44.0

