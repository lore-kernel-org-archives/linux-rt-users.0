Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4CF3E7BD0
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 22:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745458; cv=none; b=J8ospdoU1OrMydGQEl0CsmCiE6AT8vNOxI4Kvk55rWOu41NX7VIoy3+VY/M7tQ8Wk3pP25ysq64DJXwKf1cTvOzjoW2jlng07OtbnsgvbyPZiA9+98FtxqttZe72CwNvdXfv8ARcGIRG5K0LDSV2Y1w7bKf2Mla/mXp3Pu2rcUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745458; c=relaxed/simple;
	bh=fzJD5QMSqVd9TtsW0jquBo4sHfcIUQRzzxmsbNBTnYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwt7e2wKj9wC5GB0l7uxEnY5xVprAUT5opJdjZvVJIZuqvnHH575mRQoieis7E6ccnA5Ispn6WKwJ5J6ZD7HaOEqb4uS13KZMT/g8jr7VX8rmV/gWyLWEjvaXL8G/zilz/XAfBKeKbq10b6Kx70BLuqcHErge4RHkA0kwifG7aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nO1OP+A+; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nO1OP+A+"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8ee43b3e5abso9192186d6.3
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 15:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786745456; x=1787350256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hn9xnvOBfE3nE8blIyO7UbMzfAR4wUaCZ8KOiKHqY78=;
        b=nO1OP+A+WASi1db0b0Ca8+XbLVtdOnNYsqPgyrPLrirbUM2PBnk/R2XddYYZRHXXTT
         T63pKzALTZ83cHRxiovRhC7KnM2fKfyGp0KVHJgQUWhXn6peZzuB2AUFEE63TrkKCOk1
         7Dik6GxdbZmLRtYF2a21SnWxecVJnMOsakJGInejB2Os0DAScIulOWN5pHF3M3NCo3Rz
         iaXD7Kf6d4yPTQFKRFE/RfRP78AGXHWB1ZXBOcY7wnO34hVyfsdZOdPViZCPqyYjUvtj
         6jqjnzw5W3PfEoBwFVlOatwJCv5PDibtlKG8ox7B2Tlq8K/cjIsTZ/vv7hT8ZHW6oQZ/
         YK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786745456; x=1787350256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hn9xnvOBfE3nE8blIyO7UbMzfAR4wUaCZ8KOiKHqY78=;
        b=DCmgTvJJJ2BMpLN5MQmu1hlCoWpwcUxaE8ptOiNpkZw9vm9dY5K6Xg/JAfenwdt0sT
         N83OLzBCwR8eSl7pUb8hCehrLBhl32I7tlttMSsNAymH/2wReQ4KKaAsFSdJCCHW4Wsk
         U3EIE3fDWR+NRW6qnfApNcVgdITpTHA5UZlPRgZDH3BNj4RSJp/xe41Of79SvJRs3pwy
         SDXKFfJIZJdjP6BYekCFqYv4CvS3dNzUCNRFCsjIcvqviOtIaTkOOwg3wckMOp0IcsSM
         NiYabhQ9Uluuilw0No+wLSD7HnT17C88w71WdWMGyuQ3d+bdWHxFN5gOv1J3CYI0rrIS
         SHdQ==
X-Gm-Message-State: AOJu0YzEWL6RNB8rjFk80Ncq9c2XBM0mlcVBoqTFVn1jM8REYwH5hQG7
	O3BmwXwB3jrxtm3k/jt1L/ROAa8jg2c7ibLYmo3ImyO1Fl39jP7s/NUvgDkEew==
X-Gm-Gg: AR+sD13JzsyZR/2Z3QUi8PMQ4xiPTTFv2MUmjff0kmZ83KI5aa+vyWevIWezaJ943hr
	46gutsqR9qS2qgP4nJI4Hhoqt9J0ofyGrX19vi6xBQGGbzQkiiiXv5vqYzLAQcUuJOdLMRNeu+m
	E9JkphiwGnSx3tDHfX64NYyoL0MpzB9EHwqmSHCt1voEKuM8mQLl6Od8Y6X+hpxI+X++XN497dR
	bNF4U0iiFNGhfhEiHSIdFOSAjI1z5E/LnX1TUNRXWiPO+v/W3/vx+pYlE8lqkvs3YonC8ayHawA
	BsLwTdFUM0PiJECU1aKCBrywS6QsihwBGDWJrakSip9eTHOqu4dQxnLGRbEW+9kjdYrh5NrrEzH
	uVmBgRLQHeL8U8tbYy/9WOeqzwDbnxMyRF73+XsuTRNmRQWsEIgB5CPCnxDBTB4wohA+2yf826w
	BkRYg6FY7GjkIUT5d7uyaCaRI4K3EH2fhujzsLPZBlJujQyae7mipPjAiEWyKoT0lKz1EVu9HFR
	J2AFeu1EMe6tdc3PyGNCXMtV+jnFx5A9OjWWz7mAEJAB96oPcDqrwE=
X-Received: by 2002:a05:6214:19ef:b0:90a:8c6d:fe82 with SMTP id 6a1803df08f44-90a91de96d7mr113975806d6.20.1786745455817;
        Fri, 14 Aug 2026 15:10:55 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a935a2bf4sm26105876d6.49.2026.08.14.15.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:10:55 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 05/23] rteval: Add .mcp.json for project-level MCP server configuration
Date: Fri, 14 Aug 2026 18:10:04 -0400
Message-ID: <20260814221027.213574-6-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814221027.213574-1-jkacur@redhat.com>
References: <20260814221027.213574-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add .mcp.json to configure the rteval MCP server for the project.
This enables the server to be automatically discovered and used by
Claude Code when working in the rteval repository.

The MCP server provides conversational access to rteval test results:
- Query and parse XML result files
- Compare multiple test runs
- Access log files with filtering

Server is invoked as "rteval" and tools are prefixed with mcp__rteval__

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 .mcp.json | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 .mcp.json

diff --git a/.mcp.json b/.mcp.json
new file mode 100644
index 000000000000..1d0726d03acc
--- /dev/null
+++ b/.mcp.json
@@ -0,0 +1,11 @@
+{
+  "mcpServers": {
+    "rteval": {
+      "command": "python3",
+      "args": [
+        "mcp-server/server.py"
+      ],
+      "env": {}
+    }
+  }
+}
-- 
2.55.0

