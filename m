Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="dVZfU63b"
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69A710A;
	Thu, 14 Dec 2023 00:50:07 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7F3B2E1DD4;
	Thu, 14 Dec 2023 09:50:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1702543805; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=PKmlC2Km/Y8eCB+0kfLSs9rB2YE5pcQXkdIsAFTfZ6Y=;
	b=dVZfU63bBnhJJKMZyswhjBYq6mcVVSq+GVuLtZwxL76u2xHeQLx/jBKGlbmKwITj61IfNq
	3BFlDd5ce80k+S0J+eVqqqD2+phPOv/mYQSQzu2e69j9ppCwNNPspQMVSpyhB30wgXXVPo
	V6BPrl1lteY3lsIXcPtZhjgCact5oWBpmLV9joovWeRNKYAx926plHJCa6QqMHKf44HBOM
	6xll6TAfn+Ojbs+Ar42icUPWWQtCZ7BZr/jLOKZ08W5ODyS5Mu8PRLjacZvc6T9ks6wF5W
	dLWh8JtyNZAFwjLBRMEEolxq0+hBdm2cnIsugQE8JfoK/n/tAL3toxTdLP99+A==
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
Subject: [PATCH RT 1/1] Linux 4.19.302-rt131
Date: Thu, 14 Dec 2023 09:50:02 +0100
Message-ID: <20231214085002.9264-2-wagi@monom.org>
In-Reply-To: <20231214085002.9264-1-wagi@monom.org>
References: <20231214085002.9264-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

v4.19.302-rt131-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index 6fa797e5b850..a328b97369c2 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt130
+-rt131
-- 
2.43.0

