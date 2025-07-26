Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B88A2288CB
	for <linux-rt-users@vger.kernel.org>; Sat, 26 Jul 2025 09:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753521536; cv=none; b=nGPGANpJnm/VATCVD6S+wQkjDdSd+qq8RTC/zP+n4F/6ctm8yW+rTQdYaSeFy1JTrCG+eeCO6ilYFO5i1y6CD3jbLQacEmPLNqav5USh9RNVtGGCIE8vtPCszmET4ddltRbLN1NoU+HUvPAaHwvXWUI4RXcFsrwpQNmHLDPy79o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753521536; c=relaxed/simple;
	bh=IYJ8L5EddUeHSJbTZSq7yTJtpV5X2cjxLK4heYRvmug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zl8c7YSErmKFSAqrPd46cVcoU75S1bJQrKB1yJNeH2dABi2Y8Tch2zhV0PC6BqpYBjPfvs0hggCTQtAB/OF6JXGP0XbcYSHsASmLwPmMR5haf28R3z3NZ3kcUUt3n3V/Ytw9WIlYjOEYQQzj9TnwLofoAxAwgoyp9yXCcy3RXDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4/37169; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4/37169"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-74ad4533ac5so2084947b3a.0
        for <linux-rt-users@vger.kernel.org>; Sat, 26 Jul 2025 02:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753521535; x=1754126335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58bC5VY2IuXSQz5qc+Nq+Vw5h4o8xlEXZDJaccgNcYA=;
        b=A4/37169HToxXEXuJGP+YFNtWHz4FvCSDN21nVb06OVaDhDgSUuMOs5BRXH0o9Qqak
         fZ3MjU+ZPtLmE1vidgUob1Fjz3DYQjSePkxLKvftGe0inpw11xvzRvQaOwPBhnJfVrO3
         Y+v9b1Zj9/LQJzhvmCtvJ21wLSLVyoA2hQlorq9UIiXIenWBr1UcNm5eS5Lmc4ebOveg
         fTOAaizimbIo+qXsAvpYtrnjg3jFpHsWAzbVEkHaJp1tm7y99cwSsErDYkZYOCPSSfMO
         rQl8hWsjDI+27CyX3P1K5lZ2mSWr4F/g58y+vtNIJmpwhC97giE3HGB5cqBoUXQ1xOq+
         f5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753521535; x=1754126335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58bC5VY2IuXSQz5qc+Nq+Vw5h4o8xlEXZDJaccgNcYA=;
        b=vn5VOIVHm9A2jgjevyqN2HNQUawHxpBDMnb1qnNzFnbr4/88LLMcAbamLt5Iq9JzFg
         lPPhoMAZBICTmHbZBq7USNY1zUOASdqCEswl4f7jAvWqBT4RjYQgOwxf0yVSS+0FyNT/
         HaLfKDcpYl2w807OBkdDhbs8SC+Arq/T6Z7YrxRwgD5J69jsEB/HcUJcmfMl0DBi/BoB
         8khEWlY5n4G9gGTIfJ+bzYwsWImcW89F2HQxMicm5jpCUc0Nd4EOaCGMKhqR0zqmujTW
         ccgUzTUvn3Pd1I/i0snn7I2+F8mqyf9j2JAzvOGLHzgEJetP8MZeNLuz8rmpbYpbqIMv
         iDgw==
X-Gm-Message-State: AOJu0YyKIlaZ2NlATrBeuOlGfPgwwiXAqvb8kUHqjdbqdeQAqThpCucl
	PseSmOETSP/mdG8ysafZUlSR2nACTYEpp02U0W/T0KD9yp5J42MYAwOo
X-Gm-Gg: ASbGnctJV45wXyHVYgKD7/nbvUc+ut+CBMsP0jhLNVzMiVR8Ls0YNxwSDunTin5crmp
	ftQ3h5lFq/DAb8HreOpfVN5cDXgdgolSB7b6amnoI3wYxebii97fubotP6izO/lmX0Ndfhxf+E/
	SmZSQ+6C7JbI5L/golSf0/yb8PD4Hjyyuh6jByXRT6GdAyi973ibCTo4G+vIMQf91KICo3Z5TuF
	4md4ulz4AhW0o6YFannR9p7/ty3/NXBzRTJ7NSRlFRkJfg/V1DATyWX/BL2demDd2P0lkTq2lmD
	t0hoteedsfOzHc/Gbuwr4+uOXzNrAlD+ELnNjGBTfOeI+rCfCtD2iT0QPvT/0Q/4gcinwkfWNXd
	3EetczLloVyGaZJaFQbBrYs9XVMOF5i+qvXXTl62ZW8Y3iKI1Hl8A
X-Google-Smtp-Source: AGHT+IGgLsyeCDD4bG16b23YzYbZCwQ+hb6qEkZUHtbrRbZV/YLmlooFdMIdjdyePnj7m3AVY+ROVQ==
X-Received: by 2002:a05:6a20:3d8b:b0:234:4f73:e657 with SMTP id adf61e73a8af0-23d5b3e126emr15916501637.0.1753521534530;
        Sat, 26 Jul 2025 02:18:54 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:3fec:e266:6de8:8b66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f569d24sm1295025a12.1.2025.07.26.02.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 02:18:54 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: williams@redhat.com,
	jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH v2 8/8] svsematest.c: Check return values of write() and ftruncate()
Date: Sat, 26 Jul 2025 17:18:37 +0800
Message-ID: <20250726091837.493915-9-yphbchou0911@gmail.com>
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
 src/svsematest/svsematest.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index f3cddf8..bdc82bc 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -84,6 +84,7 @@ void *semathread(void *param)
 	struct sched_param schedp;
 	struct sembuf sb = { 0, 0, 0};
 	sigset_t sigset;
+	int ret;
 
 	sigemptyset(&sigset);
 	pthread_sigmask(SIG_SETMASK, &sigset, NULL);
@@ -175,7 +176,10 @@ void *semathread(void *param)
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
@@ -544,7 +548,12 @@ int main(int argc, char *argv[])
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

