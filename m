Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6C215217D;
	Tue,  9 Jul 2024 08:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720513568; cv=none; b=stR+o4Xn+WF4jcFH1k2qB2eW+E1X4jemBwC1/M7qjoHAH6uGaSq5drjOT8rEzT89vX1XTPqTj9w3UW/bRZeaMP71DLHCiRnMYqCKtGSWgrL9+Ic9gthHjAw97UEdTtsYT9j+50AWm3oXBgKIpHK6a2tA6ItaDF1aB0X9uvAo6aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720513568; c=relaxed/simple;
	bh=/Kcbq38F3t2lGyUAbSOrk4SsT5WKlUG23fqe0qwPa/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYCc3qLJE2pOuyOLN0hvyuc9BiD4sQgjiUeDqW9BD1I+/+eyydfjluvf0OLdDBbmNDSU+K3aDKziirKFMbS7OJ6PhQmPogDfDu7hkg8Na9Dm3il0GZHZXjV50U592i6tDgHDNCPRqElup9VVuMJTURh+msnxVds3aj5DAI3w27M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=0ZRmm3vF; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="0ZRmm3vF"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 282ACDAD0C;
	Tue,  9 Jul 2024 10:26:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1720513562; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=7NSbd3FG1+desO+r0VWZurfe63tFQccOAYvzD3pYTNM=;
	b=0ZRmm3vFk2VUvd2eWBKAS5BpHs8PsWwx3B+JL3BQPXbg22kdoC+40Rl/5mkxalhz1EZAAA
	l4fQf9/qKdKFPvfIYUCB/X5i4mYfhwG65iC5e3Q+B88Gi5MDBQYQStmuwJXqNS7Z4lBcDh
	FihaglNGI9fD9axDq7JSAEV1nLAc5CHVBTUILVZC7XFESyHwkBGsV8/owT+Ewsv1HYTDdf
	Rt8i9Upv+k+ORZ/tSLIvshwN/00Xlmbn705SZ4Ak9D/SP3rhq2WSnk0+rgpRw/AaXL8gjJ
	7eToZ5hEdgxuTOXFHl96w2BLUBOVn2D0IFPsG9b5w7hyjKNK6rtDeWXXLMMKrw==
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
Subject: [PATCH RT 1/1] Linux 4.19.317-rt137
Date: Tue,  9 Jul 2024 10:25:58 +0200
Message-ID: <20240709082558.11012-2-wagi@monom.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709082558.11012-1-wagi@monom.org>
References: <20240709082558.11012-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

v4.19.317-rt137-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index f824f53c19ea..41b444e910ef 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt136
+-rt137
-- 
2.45.2

