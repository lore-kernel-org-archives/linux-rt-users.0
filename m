Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E065738A734
	for <linux-rt-users@vger.kernel.org>; Tue,  7 Apr 2026 06:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775544688; cv=none; b=fzqMVauhh1/WfnyDUGkE6ZRNiZ0+xx2w2vUrSExcGu5zbJAMIqcr3b7GAxbUj6ZDR6p2aJ51Hw1IbcRQGz+eQX3dx7MemIITu9VJLhwbmpkgsSPdWYVxZPsb01xAdytBLADAE1/lncE/JL773k+EiNO94PlARioxud8DzDCj63k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775544688; c=relaxed/simple;
	bh=2NabicHggRDNu9fmA3O7dcRmTVGn9soVazFqcGZ1oiE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=et8aqXPCnUtTynbcWOkXpRrZiKv8Kv1jhZm7kLKDDiAp7ezwCVWBODhBP5OJc22CLhuaBvm02tB99APfQ10pE9H6m5dJfT3Dm9p8+uHRVzXLjvIaXj1aryhZVzgN3CcNCGuPEfIEC1nnrxo/EDvQ4HiXrdwPKWMByTvmwmJE2dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MPDlIysI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dGn/Wyje; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MPDlIysI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dGn/Wyje"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775544678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n7pevMom6/WYJsoO8/CU/Xdhn2SA4Sea2UUHqQ5iuLE=;
	b=MPDlIysI4SeLA8fEfnxJSuMHLkgLiYN4LulhS/iH7rxJT3FwKJo5inYJiZWxdaB+4YzPhZ
	ATXng+zFAAcnHYd1vfvAn7Kd0t2uU4mX551QETxx0VMu6QzthM+uzaA9tjC1GwM+P0JYgP
	nb1R48+GztgmyOti3d1eE4txU2jjMBCddDiB4FcGnb6KvGBNy+9x0/JQGQm5ht9jS1P5Vq
	8YR4+JEi8VKYgPZRbHd3gEMsjcpKvit7/ZLzJLq6xB3gHkzu3xujJg1CR0D61OUJkwgSt1
	qXklHMMcx6wAlPWuVeV6sDpHxOZ+mHrfS1hh4jghbdELY3gfkk8Ij4ZbPbRUyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775544678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n7pevMom6/WYJsoO8/CU/Xdhn2SA4Sea2UUHqQ5iuLE=;
	b=dGn/WyjeYexkJQ9yIMxuaAXLmwx8AE1/n/VqVpHfAvxr6ViDpqhQ5S6GEDZ2/Ny/yVTyDA
	cQ62+RZ7868VTOAw==
Subject: [PATCH 0/6] cyclictest: Add support for auxiliary clocks
Date: Tue, 07 Apr 2026 08:48:40 +0200
Message-Id: <20260407-auxclocks-v1-0-1ef80d14eb0a@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQyND3cTSiuSc/OTsYl3zNONEQ+OkpGRDS0sloPqCotS0zAqwWdGxtbU
 AkaR2dFsAAAA=
X-Change-ID: 20260121-auxclocks-7f3a13bbc199
To: Clark Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775544676; l=1039;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=2NabicHggRDNu9fmA3O7dcRmTVGn9soVazFqcGZ1oiE=;
 b=EaveVUzLa0l7Zb5GxOsXjnBR4SzcKj4b9woSQTg31ExaSlVjTXFR9ibXuDA9AUE2M2cyFIIMW
 qJU8lEzwvxRBSGZLTFr/48NI3Yd7er3U/RssLQIU7w3ZwwnZy4fWvoj
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The Linux kernel provides support for non-standard auxiliary clocks.
These run independently from the system clock and each other.

Allow cyclictest to also use those.

Signed-off-by: Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (Schneider Electric) (6):
      cyclictest: Centralize clock option parsing
      cyclictest: Test the return value of timer_create()
      cyclictest: Fix error error returns for uclibc clock_nanosleep() fallback
      cyclictest: Correctly print clock_nanosleep() errors
      cyclictest: Allow symbolic clock names
      cyclictest: Add support for auxiliary clocks

 src/cyclictest/cyclictest.8 |  6 ++--
 src/cyclictest/cyclictest.c | 80 ++++++++++++++++++++++++++++++++-------------
 2 files changed, 61 insertions(+), 25 deletions(-)
---
base-commit: f9c82184ce88d8de3ffe588279b0bc41d3887998
change-id: 20260121-auxclocks-7f3a13bbc199

Best regards,
--  
Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>

