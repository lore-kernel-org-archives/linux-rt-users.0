Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFF933B6E8
	for <linux-rt-users@vger.kernel.org>; Mon, 22 Jun 2026 20:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159708; cv=none; b=c4vHEMSrArv+n3aU0RNoj5U3KV74NhgbJbhb+d9zTQdNCO6BwDV5iSUoMi+EfvUJJGMoX2t7lS9tPWRFgWsoaYA2hiltqhxvyhCxQbzTd1gVYhRoQm/8v+/mO9Tds434lpk03EiDHxdwZMfy1q3dm+ke75/uWyYbk5VPtyJeszQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159708; c=relaxed/simple;
	bh=0usnInoF5+DWthDPQkntP1zAXd4giok5XyQFY5q7j4o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GwNYB1hqKbJv8WZ5IUwzt7YJimjLXu7Ruph5uHBcQusDa2/RViglp71nHIBEATOCjHbyumd/Nr/Ts175Q18mu7WcDJiP7qu91PYmVrz0u6Hk+7+vtrNwpgAAbERlVwJcHHTi0m/6dmeLCFuOgNqFAwE+qKtikC9t7XIDmMJBH/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3YMJEES; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3YMJEES"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-9159da9bba5so365129085a.1
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Jun 2026 13:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782159707; x=1782764507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Onzig8ODLSOSHf73t0VF43FjDX0uP9rQ6mhfwAizA4o=;
        b=d3YMJEESX3QiuS3jkaDc18LyyQM8dSN2HNIp//mylcgiFrv1MfTPEm8XAFT7TI0cAw
         WXsSMBLjQqYkdcTsPZZwGPapVmViVe771uJZAXhsjlhsIi8vioRTW/6UKD3Q/UpcaRWC
         gubKhssM1rHAvIkBdUFtHceEZaTHal0M7Kc47pX1KBqO4VOigrx8P+6TqqVPrGGFO5wd
         /McTj9qd3cWaqSd/m2XkY2h1dNyHzocSBUiyTr7We/bly2KIoiODYJIFMNsu6xxnHgfB
         yeS8Cvp6JJ2ZQdC8FDP3l2qWjaWW6h1wRE+aAF95VOksd4QI/9xpLhKY/KCU08ZtxQBj
         xlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782159707; x=1782764507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Onzig8ODLSOSHf73t0VF43FjDX0uP9rQ6mhfwAizA4o=;
        b=GuDJS821TbQpI2S45WvJWxX49gU81s7N2IxeIXD/5KiyiT3F4GPLNOtsGKJ5jTGZV9
         bLBP4Q00kTDHMADbA3drjjN0KczEcwNcA7nXKTE28P0n7k1w7tBgsqOMmi/y5SW5ySaL
         rvjTd5rPRKS9bb/rTE5208dqTbDy59+0YxCen2YKxIxAc0peDCWXVV2l13Nu33k4uLlc
         l+2Ut1mS3pK+Ihri4HxfX5GGCSEQMinDUhoDXOtiM6YJHy/YMlN1jAtAqIRmHemuWMTx
         SMJ0CSxEXaZ7qpJiCkucRtIKDtmRRsZWXBbdDdseAqBGvMpOWfC6a/FhzyNI+wXz7j7x
         fjhg==
X-Gm-Message-State: AOJu0Yzcnv4oybk70Nst7RPp8fGcbOOLON/M8gA1kjBuEO6EIXoB1T5w
	HsvcNp0KrPUUznRryPStOG2coMuGGyz7rV9k5FFpGgWkXvDS3V/BKINUd7gXBg==
X-Gm-Gg: AfdE7cmbK/9epXAAInzPoXyLYD4ZA/lZYx1L5j7yBanWRwjkP651kM2bOkVvIkArFPz
	uLoxOhqEm3hdGCBfHuOjqcC7qA4Rc3b9nkg6zT8pqBepREDYaWI+V7jb2qky+D9H1wi2E1B9ZMA
	D53DVFWHWEZ0J+1IIrUOHF3BTwTiByIASitrCLotJT0zkYekrVJ/R2Ja6esgoG69fpld6tnZjbs
	uEUeCLCQQnmS80fpEFOFysomgNpOl4H9tdUtV3ey+Q1aP4SxY4RQKDmJVVvXpKr4Bj7F6xtC330
	bFvpa8kkLW4Jlb3f5Xe0RRffFF0cZ3t4rb+N5Arv8/QUKkZ5e8KP/0cm4EDa6quXzaF7RAkNRAE
	nRjFX8NLWqo2DmnZEZOjbHkV8Wh/hkPiS6YSX6utP/wRYuq7exCSZ915j8SjkdWouV+MA9TCIeD
	1254SxysJ5WnhyBo1JG7JlIImmZwK+CW1EizeCt0m2V03RxBLnDhV/NEhYHJCcg6OtsceHcC/rk
	xnFZjeQPQ==
X-Received: by 2002:a05:620a:6492:b0:902:5778:d312 with SMTP id af79cd13be357-9208a9bdab1mr2633619885a.12.1782159706568;
        Mon, 22 Jun 2026 13:21:46 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92600c7bd89sm70661285a.45.2026.06.22.13.21.45
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 13:21:46 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Subject: [PATCH 0/6] User experience and code quality improvements
Date: Mon, 22 Jun 2026 16:21:25 -0400
Message-ID: <20260622202131.182067-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series improves tuna's user experience and code quality through
several enhancements:

Patches 1-3 improve pattern matching feedback by warning users when their
thread or IRQ patterns match zero results, with an opt-in -w/--warn flag
to control this behavior.

Patch 4 enhances the what_is command with updated kernel thread descriptions
for modern kernels, including jbd2, kworker, irq/, and other commonly seen
threads.

Patch 5 adds comprehensive docstrings to all converter functions, improving
code documentation and maintainability.

Patch 6 adds centralized input validation for CPU numbers and RT priorities,
providing clear error messages instead of confusing system call failures.

John Kacur (6):
  tuna: Warn when user-specified patterns match zero threads or IRQs
  tuna: Suppress output when pattern matches zero results
  tuna: Make warnings opt-in with -w/--warn flag
  tuna: Enhance what_is command with new kernel thread descriptions and
    usability improvements
  tuna: Add comprehensive docstrings to converter functions
  tuna: Add centralized input validation for CPU numbers and RT
    priorities

 tuna-cmd.py  | 211 ++++++++++++++++++++++++++++++++++++++++++++++++---
 tuna/help.py |  26 +++++--
 tuna/tuna.py |  51 ++++++++++++-
 3 files changed, 269 insertions(+), 19 deletions(-)

-- 
2.54.0

