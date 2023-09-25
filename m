Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540EC107B0
	for <linux-rt-users@vger.kernel.org>; Mon, 25 Sep 2023 07:09:17 +0000 (UTC)
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:4f8:1c1e:abde::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895F8BC;
	Mon, 25 Sep 2023 00:09:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0F429E1AB2;
	Mon, 25 Sep 2023 09:09:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1695625753; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=JkYjCs7ILpiJtOXzQu2HrCn6MowdDRKuBZyqH6Tx4Mw=;
	b=MOBvtkUKGumst0ndMJmwb708TBqUbag1ByY3R1lwi5G1oxLCiUNr5E+IH6RWmBJ+vAaPEj
	3TE9IB93dtaotNumnpFk4xAYH0+roGqIMTSJCr9SHSGXIyBCWV3kXVdkhVY9FMuIiUa9iL
	3/VLDIvQERjfuYBnN85hATTvme64z4WP9O2Y9EOFMzgqHXCjg2EGzSVwa6/C0DIVaTFuMn
	aTStNhLyyENtpjkQgbFnI/VUwtRXB5k8THnm31EBQJa8Cu6SDJBScvQujcv09g2BIXyY/5
	+wBaEzEYQ5tS7/Rq+sVbHnGa89udy0a+SFjoa3mODMT9NXfKUd9pV0BJh5uxrQ==
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
Subject: [PATCH RT 1/1] Linux 4.19.295-rt129
Date: Mon, 25 Sep 2023 09:09:06 +0200
Message-ID: <20230925070906.20584-2-wagi@monom.org>
In-Reply-To: <20230925070906.20584-1-wagi@monom.org>
References: <20230925070906.20584-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

v4.19.295-rt129-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index 6d2a676e2033..90303f5aabcf 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt128
+-rt129
-- 
2.41.0

