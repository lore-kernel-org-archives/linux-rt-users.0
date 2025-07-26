Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5449A21A95D
	for <linux-rt-users@vger.kernel.org>; Sat, 26 Jul 2025 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753521528; cv=none; b=gP323GreLpXeIu1gMBMWAacHWqL2jv97lonKz+eEGw1kpSTzp/xRnOdg4LXPsr9VSnCXiLR+QWOr9A6XJxYvAoydZZ7SuRH5fadYZqjpgohZEN8ZpCDFN24guf9Xn8P2EDVJuN3HCcxzl8vCJwScDNRG6jIuoUscp1pmV+xLrUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753521528; c=relaxed/simple;
	bh=sh5rDXPLe1RjzcwcnUo7t4tEFD3Y/PI7+noNaJD+9m0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAJpR/6qhdqbyheC+bUEOT3RBf0/5wMuYCesnX5FmnsD7zZXNORfQz5gFJHUnN+SvAQE9DZN5sHZgFQG9m+NpjGyNGekogSJEBR/lUUbLDoQBUumC81byWl9hkRkolLMMURt9ZN6cBARQED71TWnSM8IkuON1G7vrdtw5maxspA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKx//tTu; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKx//tTu"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b31d489a76dso3097515a12.1
        for <linux-rt-users@vger.kernel.org>; Sat, 26 Jul 2025 02:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753521526; x=1754126326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIkmbdqbRqQ7RXytvm6wSqUM6ftZINRtF4AGrWlK8Fs=;
        b=aKx//tTu1mJK9MsvRDB7gUkr3pHhgI8rC9tmXH8hzFYJLBcoUuphnC9IBVt8ujEG3G
         L6y4ajC2UitIkyUkz5HPx1zO10+abW69gClGO5xhlMTrHY0pv423x34Q5o94it13P1oQ
         hX5L0px7GrMxQfM39oSqz94qbffki3kBNxNYN1UW4ge0JjDu3U6D1ey2jcnJcAazlBW9
         JOJ9T1kKeXP/1qJtMez85suWrE4iioXrI0ly71BBsQnSNQQgvVoYcZStTSBbG8DihfwP
         ueW8/SaMYH64TfvoBNh4+8CJm/4PCg9JMrXrQk3TmgCd3KLMA0gOK343//WZnTpOTK3H
         ZPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753521526; x=1754126326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIkmbdqbRqQ7RXytvm6wSqUM6ftZINRtF4AGrWlK8Fs=;
        b=iPSIdMF7B/NVewtjpPUL6qQ9DjQFXN5FT80bL3xxyVgcHctyB7AZrNBEAE596ZzDOs
         7fiv3Lng7JiylTAzTs+L35ZfI/tw3G+Bq8dZEinyw5pqtS83b7antvy/HwDw2UcVeh/c
         cgptm+KcHKmCDdeNvOnuvZpMTDXKziwWcGpCh0rE0WH693oQswa6exHGYLLahaCyAjPk
         kMjQ67cqZ6qoaKu3y3FBAKJ3AvNW1sM6pg3hI111lNtcHs6+etNFufR2eoj134hOARuT
         9FYV23ZJmHywhZKf282/WvTqQBrn2qdWU2zXOyuyR7GjRoaoMn2asspDAbaU6LIdTtpY
         RS0g==
X-Gm-Message-State: AOJu0YyIn51vRei2R7HFJ7d3rLDeEh2o+m9aC8rIknCeEC1B/qzlzPOL
	erhLUPl8G2p213Lm0SSQsugo+erFEREQFvFToMwncqo6YPzZU32vIIxv
X-Gm-Gg: ASbGncubqL8DQ8aExQwekKJy5KhlAwnTEL3sYANoCOWMBznn2RFNkfbPDjPqUNTugBI
	GJ0JnqU76xbyhdSnfQTeoY3F8SFiLODDw1FKpMhmXzmPXjQOsFLI01R73onltpJYUQrw7IcclUg
	Gre2NUYmoqrlCQe1CqZQVm8Lx1XBA/wXoF335xjQ50Vqf+NnC6YYR9GTh4yq5fx0C3maVC+vibj
	S7GPMlq/elobKjSAlfRmc8Zy6ihNNjoeRwE8P2RVxkYLdWDkXBfFrkgsnI8u+4A7z4/yiNVdlNt
	R+jse5Kdt661eLQlFP8Pqij2RVYxEL2W9IUukC7oyOjn0IZKPOIP29miCx6ZCmqo7d8d+mWdqkx
	zA0jBsVpcxnmsk1M0XUsrzEmR+o6Ii1PtqswMNUU3IINaQHbujOXbD0xPeSvx3KE=
X-Google-Smtp-Source: AGHT+IHS3E4cqYXCeAhtW+UNaiRpUmb+MKbb7mxKPLb5lnmtjYTzgeOC5oA1q9D7bImxVJzlpDYT0w==
X-Received: by 2002:a05:6a20:7488:b0:215:eafc:abd9 with SMTP id adf61e73a8af0-23d700e9754mr8979610637.14.1753521526394;
        Sat, 26 Jul 2025 02:18:46 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:3fec:e266:6de8:8b66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f569d24sm1295025a12.1.2025.07.26.02.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 02:18:46 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: williams@redhat.com,
	jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH v2 2/8] pmqtest.c: Check return values of write() and ftruncate()
Date: Sat, 26 Jul 2025 17:18:31 +0800
Message-ID: <20250726091837.493915-3-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250726091837.493915-1-yphbchou0911@gmail.com>
References: <20250726091837.493915-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add error handling for write() to tracefs and ftruncate() on shared memory
to avoid ignoring errors.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 src/pmqtest/pmqtest.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index 04e36a1..eb20baa 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -75,6 +75,7 @@ void *pmqthread(void *param)
 	int policy = SCHED_FIFO;
 	struct sched_param schedp;
 	struct timespec ts;
+	int ret;
 
 	memset(&schedp, 0, sizeof(schedp));
 	schedp.sched_priority = par->priority;
@@ -189,7 +190,10 @@ void *pmqthread(void *param)
 				int tracing_enabled =
 				    open(tracing_enabled_file, O_WRONLY);
 				if (tracing_enabled >= 0) {
-					write(tracing_enabled, "0", 1);
+					ret = write(tracing_enabled, "0", 1);
+					if (ret < 0)
+						fatal("Could not write to %s: %s\n",
+						      tracing_enabled_file, strerror(errno));
 					close(tracing_enabled);
 				} else
 					fatal("Could not access %s\n", tracing_enabled_file);
-- 
2.48.1

