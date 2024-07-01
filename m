Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297EF1607BB;
	Mon,  1 Jul 2024 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719859396; cv=none; b=ay5Gtc3rc2AcO6ukyE5C+/YdRn3U20lfwXomm8xt5EIwEr3sOhd1kgViTy+8Zoqf7PxjWD51Veeatonsv6oUW8IQideRdnLyfMHzp8G0OXyTjhtISdFow/DDC7KmKtCN2B09D4F98I4vmGbM+If/Gd7Owg83NI1LQTCMDNhI8LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719859396; c=relaxed/simple;
	bh=q7oEyAjSy5DFHSIwCMTeCMxS4QAytBiQTTx9DdVDZ+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LO2X6jCJYvyawkCyE2TVKQplOCez5YAduch/sjQI+UxiHEf9QHmFOsBSPrHmiFGpN2AKCITJFhUJAJXzFwsNxycj7WwiB/3o3bmQt/WPUfQpdDX48fc57QosYe01U+KB4uAZmAsWtLyJ9NSTEzeIdAzp0VMGTjBR5cxHpVBo2a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=P0j1HtUV; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="P0j1HtUV"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AF5E1DAD58;
	Mon,  1 Jul 2024 20:35:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1719858925; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Azlo5zzhAy5LswlCYq4vQqAd/U/JrBD0AwDg1T7XrBE=;
	b=P0j1HtUVu2P1YB47w+mYiEt31s6YBzDmth54SYDCRoiTgQHvtkNqv+1iyNd8W2pHiu9JPC
	dQU5mI0wfH83l5b97QWuE0f7F7XYq0KGkg/BpdeR4aGhT7ll5dSJw69bpvzcZMaK5rhUA+
	zjSWN5jhXbF8HHhlz1XcgOPFYkUX6kaTqxt+giE7/Rg+88QmjtobgQfUbDCRk8Po7XZ0zV
	I9N0Z2dKY0nqMOMUIxCt8vMJdjRTJSo++nDfqN4UyVAXMQ+ewScnO60vwMln9a3291KWOz
	h1pTZz6rGNiJm1kP8n2QRBMVV1FVk8nGWZ9ieWjW1On/bFMIJBIwOKBkb7acqA==
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
Subject: [PATCH RT 1/1] Linux 4.19.316-rt136
Date: Mon,  1 Jul 2024 20:35:18 +0200
Message-ID: <20240701183518.26751-2-wagi@monom.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701183518.26751-1-wagi@monom.org>
References: <20240701183518.26751-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

v4.19.316-rt136-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index e3026053f01e..f824f53c19ea 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt135
+-rt136
-- 
2.45.2

