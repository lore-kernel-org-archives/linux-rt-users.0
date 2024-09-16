Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD1C14A0B7;
	Mon, 16 Sep 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726481944; cv=none; b=afQaVcp/oaFq+fuZCBF5w3bIDW31UZ6cBVFyUYYG30EKIC8un7TrHE13fldbG1rO6E/WIOurk3BIWbof0uVHH12s9grRuVaHdEkIBstaUgLTLGTTlhJCCFTov+P3j+h2QVzO9XAN4eptkXK9CFl4zxhOX00hw+Vg4CnDRnZ5BRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726481944; c=relaxed/simple;
	bh=aE2ZuRNkpR8lWiZyGc6eXcn3rbGPF8R4n9L+y441/gY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EwR96/eL+6HxKDbBHMChsl7NMq+rF161gkjvn2TkNrZDYuCiXOEIRBKiSUEryv2dFQgY69HxBiclLkizRTuUzuxpxRydEubkd9jSsJlhX4sHaBjwv+Ka847hCAiFT50+7cKuG0qHpgns0GTrNb7WAlJL3FeGY//8x2BRMAoHJIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=uxi2lr7G; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="uxi2lr7G"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EA8C0DB25C;
	Mon, 16 Sep 2024 12:18:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1726481933; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=E59lMmvEEjwBR5jqTACOtU7Ga/pt9xTdExM4qjOnG9Y=;
	b=uxi2lr7GX0CCcbJbSWSp0XpPn+LIHRKpYoXzPnUM08a3GjjKZtJdC0CtMRlQWFvO9pQeqU
	tc5Cl4/QLnly6K2oXpeFYVz2GuMqIDPk4qeaAcOCnkvMQJFXqojoDwTuU5zAz5ic5XwO+8
	bx1rsrsAO/bJ85bQhKaR3pWTvOUn58uudSkYgfCyZ/Ztzf4Wi3bEDZmBMBBZ2UCieN76VQ
	EAsg/5s/MLlWyqu5jqRCUYd4c3gKggIW1sVOE8EqBt6vfTtBioJxIQiQLRcvoWKAg9coMi
	bS0RmQC6gCYm2+OTlqSkcGBVx9MJkUSX6ukuNOOujjVXVZoRye9cQbLrT6L/xw==
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
Subject: [PATCH RT 1/1] Linux 4.19.322-rt138
Date: Mon, 16 Sep 2024 12:18:44 +0200
Message-ID: <20240916101844.280673-2-wagi@monom.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916101844.280673-1-wagi@monom.org>
References: <20240916101844.280673-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

v4.19.322-rt138-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index 41b444e910ef..9f63718d5731 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt137
+-rt138
-- 
2.46.0

