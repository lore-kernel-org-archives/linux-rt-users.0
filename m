Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D4A17BA6;
	Sun, 24 Nov 2024 19:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732475393; cv=none; b=m2g10gi/uBE2HZw+fpFxtmaWeWi8ISaKznVuw3prVtCBqdyNSy1WKYeSw+Na9DsgtrEKLc8eNQUrRZ2MZIRgLVs9Osj1plTcNE+cJKZUub4TljkPrWG2MMUZw6zNTC1cnXUO55Pi5vG3TiHWGY8eY7sNBHQQS964UNYH43YCXU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732475393; c=relaxed/simple;
	bh=dSrSYmLwBNRD2o0M1qZFt4oafAREqSdYHL66ejJqjXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQUQOQMlFMEUJEZJ/v98Ki/iVRWu4/9rLiIgkrAz0Cv1yG76AjMWXLNSXg1kGh/9pfA8Z1vpoIGXl9DpEjBrjRf95cjrXSqlIgB9cmMppq138Hfjpwtya548pmO9glVIBuDoZQdQmZmFZAE/iJ4DwNruTzGJPn9Tn+2ApHJSf3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=M+B8iwGq; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="M+B8iwGq"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 99BF7DACC2;
	Sun, 24 Nov 2024 20:02:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1732474949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4TqlMcqQVTQnvN4uZe/bTH9mohtno+oNgmQfgr0kZV8=;
	b=M+B8iwGq+ugQtnBkH8iExNZ62blDED9X4RFZOcVNjAzkksS93gKMv7O8QBl8j0Bl25+znu
	G4n7D/FHjOBupSo23Z80pUEep0zCzwAEfPrgt7zIEiLac9HWfsV1cOaePdJdony0vq32NE
	m8REmaxaUExqKZkEfkZL5+hUE2l4dOWx7fcGCvwfoGfKWdpaTM0p/0aAS1gi+Ey64RS1Pe
	LEPbHZun9RRPBrNlBLIWVZxrjuqBFXf7bqlC4lChYiOTrUo8PsksqiNpcVpWIYHEg1ySl0
	PEGD135TwtkRnZlgdQdk7hPH7D6IHslvQD6bvkmzRJT4qvZbpm2fGYRAIEi/Ug==
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
Subject: [PATCH RT 1/1] Linux 4.19.324-rt139
Date: Sun, 24 Nov 2024 20:02:22 +0100
Message-ID: <20241124190222.112239-2-wagi@monom.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241124190222.112239-1-wagi@monom.org>
References: <20241124190222.112239-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

v4.19.324-rt139-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index 9f63718d5731..e0b93414dc30 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt138
+-rt139
-- 
2.47.0

