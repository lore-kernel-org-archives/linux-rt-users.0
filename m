Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493BB219A6E;
	Thu,  5 Dec 2024 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733407032; cv=none; b=udnV4U5YiRuGIB8X8jqWLO09W8QJLzwfYeMJ90lpWtm0dFA/VfTp1SslXKlmwt+ssVeXfa6DrOZ+tVYgOGZXCn74Z/oAmCyXUfJEPbPUKwOEyiiTOYvidRreTacnjwMjs4vsvgIu8O0Rt74rXkygCDHruU2NHVVRwcNhgWLsKOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733407032; c=relaxed/simple;
	bh=kI8RADT4lFns888QehYb4sl9ujkIsUSDxjmnPnQi5a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGhoTnJ0F0AvqZXNQt6pEB6w2DUra0VMrdctRCa8fhoefiyYjMUJb+fEjRlpIJBtkkpB6BKtH98bAHvqZJQ5AnR2bbNZEctozoKsnWwDmYKw2znxnmaZLu7nIwF4qFZNhjoZMDhbzAZSzuo/4QqJ3+1pfDqJ+YA46QW5BSTCuwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=mZ+fUHvX; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="mZ+fUHvX"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 12E23DB0C6;
	Thu,  5 Dec 2024 14:57:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1733407027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6EoPy1mb1V2MeYF/g1tlnGZBrQ+0UN2xWc+Fwrb7JQ=;
	b=mZ+fUHvXIC9s+fZC3xfBIIby/3TpN9/h9Fj6ZCoEZ2+zuj+9qhv//8Te4v6f5DqtfKY3sp
	bmhDmY3dH2DxUB3pzb7Dcf6YoYaG04/RQhZJ1WVfGKaSXtISS2kEG6DtbFt/MB6y6XQsxS
	FrZLHcIr9Bk/5gMFGqmene2SF7k6lE7IeqACfWRBx/Lmv0qA5qYt/EJmaNl4Z2KfyfLziW
	iB+1rp+AhXMyKEy6+f8t0C+oacuew3/yWjNDwwBzNw9+Wu3bB0gE7IzeItvwYHMNff8siq
	fDmfMBkWq0nZZ9r11+ZqCc2Kx9KPeyeIjpx5t8o6T9OyXllxYzZi7sb3k8V5Cg==
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
Subject: [PATCH RT 1/1] Linux 4.19.325-rt140
Date: Thu,  5 Dec 2024 14:57:03 +0100
Message-ID: <20241205135703.20341-2-wagi@monom.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241205135703.20341-1-wagi@monom.org>
References: <20241205135703.20341-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

v4.19.325-rt140-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index e0b93414dc30..e27678f73d17 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt139
+-rt140
-- 
2.47.1

