Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67E316132A;
	Tue,  7 May 2024 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715095021; cv=none; b=Q9yqlzPPVeQVetaVBHlKReU9Hxfm5ukm9oc1NSEFWhvBGsBjKDBFE4h0iE2z1vxuOrgSTPwiAEOrb1hiXbUrZUHzm9ms87+ESk5QpkJAI8wvV+1kbd93bAotSEMsaBf9TnKE/85GVs++4/TuJFOv2BiQT6VPTkmfWB0qGkl9Ndw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715095021; c=relaxed/simple;
	bh=pj+rRRnJ//cpd1dCxUwjzWTtiuE4tkK8iURQhRZdoUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9AGxmjvcSR3OdnEBRzWKdrPr3Rfhch4RFyHixbAb3NlyZCM6rfDFQJB1XG/v/pSAvMbaAQCkqwVuq38vK0J2OAbiLB8lGu+uUcO6jBVrRwpeD+N6WJ1+YTnXTuPTXaMLo+tt851yYkvsKnrM3VHqhxW3sqf5z+FZqfr1zHRsB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=UlqmJ5p4; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="UlqmJ5p4"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 25FF4DB443;
	Tue,  7 May 2024 17:16:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1715095016; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=YOMGMkH+XITc7boKTbyMryoJEokCnAKEzkDlct7BX7Q=;
	b=UlqmJ5p4lQ8qQs0wrajQ9w4pQi3Egvn9KMw7BTl9bGmngLglr5UR4WPz3gv5FdTDwPU99Q
	oiaWxhWLzZ1RJ27/aoJx+sTTR/hz6zhQPkIVRA0wLsBZXGSTrgAM4+uzblbLd4M2GWZpO9
	869v1uQL0jNd+/wTrCdQHSlPjcqeIxFjFpVhItS7AGEY5rAfzFxqYdQelznCr2j9isxkIH
	aUkGgqjjPhGwdQxGk1wxwQZzco04OyV15uOLwpPuHG+XCLEFlA9w9Hm2d/tIjAhOrQVXE+
	9yFC9j9uG9mxtmPRWZ4rtBVr8NBvdlDfwntKPKtdZwF0OJIRpxSiPBXjkkL0/A==
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
Subject: [PATCH RT 1/1] Linux 4.19.312-rt134
Date: Tue,  7 May 2024 17:16:48 +0200
Message-ID: <20240507151648.17883-2-wagi@monom.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240507151648.17883-1-wagi@monom.org>
References: <20240507151648.17883-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

v4.19.312-rt134-rc3 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index c2c7e0fb6685..6067da4c8c99 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt133
+-rt134
-- 
2.44.0

