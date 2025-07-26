Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CF5225761
	for <linux-rt-users@vger.kernel.org>; Sat, 26 Jul 2025 09:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753521535; cv=none; b=hQWbJrJJiaGUhOzkoMAy8otHNCM/8fVnwQCJy3Cbbb42cLRA8n8qxZ/mFFNDtzGNs0k4XQLzKo6xeQs0P0C9BhEGg3+exeW424LIOCM1sXAJuC2haWdEUeM2dFkVTY9AQaD3mRNz9mnLjITXOmEALLleQ/PFgtcJML3GMsWAGiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753521535; c=relaxed/simple;
	bh=AqJX4unFC2DkQSW99HjXh89N5W5zCEfYZrSC93M21TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUkMbuQTbZ/hYTTYnaGrmkNLbrJEeDMubkk1dZFU9900VUuVHnCGunO3b0FFYHxRqqwWvedoaVpFNgwgPzMr9t3VizbbUQRb3JaSP3w7jjFhs7FURc5018QGq0goMaRdJWPIBXXJKSJEOf4XTySNyCkc9VcmDECNerA2wte6ZSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QClMV8bn; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QClMV8bn"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74b56b1d301so2059114b3a.1
        for <linux-rt-users@vger.kernel.org>; Sat, 26 Jul 2025 02:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753521533; x=1754126333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrUiQmAPoD4Onife4VxBwk4CqsK8Sl6rF7/ZkLo+CzA=;
        b=QClMV8bnx1T5lMZ5yGkUXH065ABI8n/EvDEQUDAAnGifnCEQpzu5XCVqmo75KfZ8f+
         FhUKd6An7RWGDdvRwPQ+rnuvIRor4IW2OWKFcuIZjPXFo96OdAyJhf+Lyet01sw1tI0C
         f3rn+0bVyAxnkZpkyrQJuekcTdpO4wOjCehEDiXN4H/tn5xwhmai65DNiVtmWnPdpbeB
         WTmbPvAyRoidKJGB9D9MmDdF+OmkzLIVNHeHJOCoHqVcFS2h1YFQhk7rUN+bLiaGoG3/
         UgckOG70BxKm9BAAzyf4YTZUP8eMspXMFcYjecVnFithM0dEQ17fVs57sEDeOLZsiyB3
         tlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753521533; x=1754126333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BrUiQmAPoD4Onife4VxBwk4CqsK8Sl6rF7/ZkLo+CzA=;
        b=ClKP3F/Y7I9r6O057YQLHM8oIwV+33KEO1OHEwBquw3X0cmoT0BAa6I1i9XFVOV/X6
         JO/e9TJeJYKO5jSByBGLgUsWr7YiRxe7aGZuLexzdjrL0OgRsy4rh2KL84CNFzPcCjsK
         XugrsaSWnQK9FEoEOVRfq4lsbpQeZ8cCqLVs3VbJwxzOwOnqsSo8PK9h7o538EuMS3GC
         S9dkHaJyn+n2LCgcihVEYytVFsW8V9YW28zY/Bmc2YvYLF9rTo9KzumM2+V3YJv5DcUJ
         miz7q7jGhpwp43HKf6GgeeIBCHuD2cB4HqWyC9L5gn3hyExrBH6jaxed4PH134tORKYi
         Y6Bg==
X-Gm-Message-State: AOJu0YxDSjfcVmMpcDZ8TZUA9n493uJ02nhEyUNcMZJalupPcikWyrdC
	AvPSk8FOe9PKeXfSn7NSTYJ93t0wq2S1Qp5Y6OJwRoTr0i2d7h4u++o9
X-Gm-Gg: ASbGncubfryRUpkCNBz1BUO5tVDgr5b40xAHQd2F1v7J/vBbQgG7Y8ASnIuBEmTNuAm
	AT5XsF/9xBtmDTK3haxuMgSZN0SfHIOxslj0q6iMeXZUH5F0SjzDgEdQ5uApXnZPPEEt60SMycq
	yiWU83X5Ldz3i0QtUHBct0nxvG3V7Y9OnuQRIPMYP2y+IdEkJvIfNej0eiOYzxDgrFEYU+FX2E7
	t5Gp2WD9nVlQkQ0CEYLcplscZxX7QOzuYmCrxnQgc44dH4UefrxvICGyU3vVZsfGlihf6z9vily
	iqwKB23mLOizUqEnOCku/y3H/zETyWP9I47fG88BFRDpByOGb4B2f9RDjhgqKCJhNyGPVC5kxeJ
	Lx5p+Kgrtw7YI9xdkD7mnnMQYoI060bRqgC6W4YlOwQXHESqcCp1lrJ37DJd4BC0=
X-Google-Smtp-Source: AGHT+IElqV2NesybV87P5eBgY/wIrxO3n5jhdCMZDPSQIetSu4LSOgwJdIiO2Pff6e/XLfR7tS8oHQ==
X-Received: by 2002:a05:6a20:430d:b0:1f5:95a7:8159 with SMTP id adf61e73a8af0-23d700982admr7815305637.10.1753521533180;
        Sat, 26 Jul 2025 02:18:53 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:3fec:e266:6de8:8b66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f569d24sm1295025a12.1.2025.07.26.02.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 02:18:52 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: williams@redhat.com,
	jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH v2 7/8] sigwaittest.c: Check return values of write() and ftruncate()
Date: Sat, 26 Jul 2025 17:18:36 +0800
Message-ID: <20250726091837.493915-8-yphbchou0911@gmail.com>
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
 src/sigwaittest/sigwaittest.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index 026cc81..3944b54 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -72,6 +72,7 @@ void *semathread(void *param)
 	cpu_set_t mask;
 	int policy = SCHED_FIFO;
 	struct sched_param schedp;
+	int ret;
 
 	memset(&schedp, 0, sizeof(schedp));
 	schedp.sched_priority = par->priority;
@@ -168,7 +169,10 @@ void *semathread(void *param)
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
 					fatal("Could not access %s\n",
@@ -489,7 +493,12 @@ int main(int argc, char *argv[])
 			fprintf(stderr, "Could not create shared memory\n");
 			return 1;
 		}
-		ftruncate(shmem, totalsize);
+		if (ftruncate(shmem, totalsize) == -1) {
+			perror("ftruncate failed");
+			close(shmem);
+			shm_unlink("/sigwaittest");
+			return 1;
+		}
 		param = mmap(0, totalsize, PROT_READ|PROT_WRITE, MAP_SHARED,
 		    shmem, 0);
 		if (param == MAP_FAILED) {
-- 
2.48.1

