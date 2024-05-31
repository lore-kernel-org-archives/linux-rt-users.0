Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C3D26AC8;
	Fri, 31 May 2024 07:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717138970; cv=none; b=fIbqCPtlkC84y6GceLSvCvqjt2mCYGTnlZ5hhMcDJfDn6/iY7bz/S2MJHrN2nzOC7x02xv4Kc0jxLrXiZWgGyU20WaJv2YD7oFhqK3Y054bDaRm2oQpga23F2JbraVP9mFYLYgCOjuPSnE7GcxsIvwwvlagXZt5IoFpocBKt7pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717138970; c=relaxed/simple;
	bh=+qj0pjsVrP5Du0E6LXt9MVesXit8cTR7SOTl6erev3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATW9o7AodlN0sPgToaYj2/qMYRIvOBm5Gqe3CRFygz7gJFQyaiD7rwz/8ytmUnVbRISKrc5uaIVptNLIOgtSx/LGWJx2wzbxWR/eFZP3fdG2tOTQh76N3WBhCWEtBiYfXDHmUx0sDBbm96lExZTGWxlTS5CsAxygIwAkZi/O33w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=jLIva+GY; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="jLIva+GY"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 27F9BDB46D;
	Fri, 31 May 2024 08:57:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1717138638; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=LcHxNAVjNi8r6vtfjQ5RqoVt1L/zZdSoO2z8g2Scxlw=;
	b=jLIva+GY+Sa47mlJFKz99TeYtXAr+e9NzlP//nxx7JQ9ymha6eGn9uUQRJcUg5Ahd23l1V
	Rh1UahdU1Z3uiCRsGdFEDBQyle/vCdpy60sOm+jUUmOB0YFCTCDE6v2o1PmxpVcySa7K94
	o4nLHkIlvRxca2OX7SJ+aM25YOy83iH2GfZl9bnCAzCMirjiSYrY2NectIp54L7lW+OT2I
	7rD4XKzFodLXU4xIB0tUr7tT4hlcvvBcWZd5Dhr/F88Z61Zvf75R25vvym9D3EWfv2bJI9
	C7TPMZT5xldWkkp5sviiWHxacj2iqzZZrJ9Ixdqx81aATONSbxU7ghZMlClwPA==
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>,
	 <linux-rt-users@vger.kernel.org>,
	 <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 1/1] Linux 4.19.315-rt135
Date: Fri, 31 May 2024 08:57:11 +0200
Message-ID: <20240531065711.32484-2-wagi@monom.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531065711.32484-1-wagi@monom.org>
References: <20240531065711.32484-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

v4.19.315-rt135-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index 6067da4c8c99..e3026053f01e 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt134
+-rt135
-- 
2.45.1

