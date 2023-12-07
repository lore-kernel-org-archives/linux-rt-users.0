Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="mB0wlUBd"
X-Greylist: delayed 597 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Dec 2023 07:23:58 PST
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:4f8:1c1e:abde::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A8810C2;
	Thu,  7 Dec 2023 07:23:58 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6CADBE1A67;
	Thu,  7 Dec 2023 15:58:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1701961103; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=oz0c7Is7QI/c/jVxuy5gKuSAUsDwxVIB55INpmNanLE=;
	b=mB0wlUBd7Fk2NmKgefjKbOHRxPqLP2x7XGKAwqp4WafXUwXeaCLzzWmtRRZyo3SFKC+SOI
	TkqXRZYng0a/OaSBl3wU9JO3n0bxBp3N3hgxlL8vPDd3q24MCFxbXXQCWFq2gw9ZwolxmM
	RBn8XVxqZ2OEAHcWvr0hc+Azd5qAKlkzJPJj6u8KVb4TlPOzOqcSEyaj/GLoavfkqEl2Pj
	K2oWZsfMtzIcgKEFrATwKwKBtTru82M6P1bG8tefXP6RXzF1+Bx54YvSBMvJJCsP/oiZqx
	O++OJIVeyWJCanOz3+IvvsZHtB9OSK7Xdiyj41OoUQHA9ZJC45QsxkELLKzX5Q==
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
Subject: [PATCH RT 2/2] Linux 4.19.299-rt130
Date: Thu,  7 Dec 2023 15:58:15 +0100
Message-ID: <20231207145815.30461-3-wagi@monom.org>
In-Reply-To: <20231207145815.30461-1-wagi@monom.org>
References: <20231207145815.30461-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

v4.19.299-rt130-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index 90303f5aabcf..6fa797e5b850 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt129
+-rt130
-- 
2.42.0

