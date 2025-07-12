Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEB6277C9B
	for <linux-rt-users@vger.kernel.org>; Sat, 12 Jul 2025 13:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752327772; cv=none; b=g/Gc5fqjmLpW6RDc3tnSLmo8wOsUVQs0EtVFhhMMIyJAz7/C4gndubtHOj9opivsPfd3KTwVYrh75Y+z/JtpTY0SJ4uJVYRwIHrZRTUsSf6Y6Sh+k0W58UUJMUfFiSN7snKKCwSLGEdeT2E62UyTnPJw6EeEomW647SOVJx16aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752327772; c=relaxed/simple;
	bh=2U624OqlP3NitnDsdXUhzFeEOy2+ZjgUI2Ia3sqCPdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/J46BiBrYqHd6s1UTuj1ZM8AOg4rd0nLVcdWsO4dUU44pmZCWUEJUWswWAaHoPbyHUi55mLWQZCKRBV4XDEdexCimVqgJd/QrYSog2u5Au2lDURrUkWWN3YeVlNVTYk5teLjFXHdUh7EqPPlD3M2JfHpjCUdQI9IcQ/+EDKmxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AB+2jITc; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AB+2jITc"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23636167b30so27353505ad.1
        for <linux-rt-users@vger.kernel.org>; Sat, 12 Jul 2025 06:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752327770; x=1752932570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwkGb7D0zZM4jcVoUSodRasE6/Q89BNWw+Ej+D7IXTw=;
        b=AB+2jITcmPCkQ5QGOC3f1afUvQVMNhKE1ZSvUWXQn9fR+OTzgrejQV5mNx2LLiYz6T
         TtVq0uob1DDTuzy6fDRW6/yyznvrNedNejfpN2jkpWzgUxV/fF4bpO43X8gpQuCurTPd
         0zEzHSbEqV6dmxzxEGPkT1sUpkE7bVV9t4rNUOLfs8X1AWqmS08xsCSQUJJ1vN1k7GOR
         MjwJK4C3hPucAoWJHfHVLCiNy2eTm9qYuKt0wY81WJOdC9L0Ej2G74aDND6Bq0VIfpfZ
         r0FFR5HVEfAVez2NH6k9y5mGihyCU7NqVmR4pKnWMKlyEATYRI8Xq2wiZFL622Sl1QNR
         /1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752327770; x=1752932570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwkGb7D0zZM4jcVoUSodRasE6/Q89BNWw+Ej+D7IXTw=;
        b=W+h4lRlV/zf6lsSL76EE7+/6U5UKAeTtXznYhgDLr+2Xyljh/TaW3zl6ps6a80sMi1
         5ea1bb2dCYbhG3QPtlnvE2THw5NQsKWsqwTIXnfcagfkUEXRzSZSMz+Nz5uB/FwhOYZH
         mTM+W4SAFHCi1ZZA0EO4P6Ra1bhBTLjvK82EhXYiM8FwHNrpslJkCIyaY0Q+ATYKZwjH
         Fcs5yYNqcAUnIl2qK6k6jDst/OFL3BDbQQqBE9C8bCxzIY9s44JxvZBIXQgVUTteEiSW
         YxvAIaDtDUQlSoe2+fYm0CoIo50i5ADlqZU7FZMgaxwHrKsfdJzT5IzIcKEVxJ6uyOO6
         wM4g==
X-Gm-Message-State: AOJu0YyPXONu/JT0e7F78rez5fNAqRO1IlMelnePA80J4NZeaTOXIfy5
	W0+M1SHHZjVS0wxwrUfJw20mWRdpPBtkvvmMAnSYuF3DEWkeimOK58l+
X-Gm-Gg: ASbGncs3UdopJiETnI7K7yg983+v6BWKf6+vkAtryZWMjnfygRPtoBfbvbCtZM6bLb4
	+2p1E2uBvZAr9ugjf64EuEcMDU/FnUtb3EzLZGfBFqiKp/1cpdv6OgAD6SUbRHmTjD7xrP1GMrm
	U7sXLIgPJHMXfQ5xAXXpS0enmHn1Ydwr91IQm7LV6UGKe7m8ykmqbAOKjdUpcnR4K3AT94n5iFb
	FWo+Fd3T+e+5KEMtvsglWC4sNv/WQYqqffQ3lH4TkU8u6C6dN1gOFDZV/T7eIQTGuhkPrV22oJv
	3SIuRYv5h4WplabGbSZgYCtwcYyElvXiDCE+0Pd6OdpQZ6RasgyvQVLKrjcll+6cv7sG3cbZLN9
	z+nLLf5dEydRYtnz5hIi9i/bi+iUi/SGpV3pxd2LyId7I3r3Juewm
X-Google-Smtp-Source: AGHT+IH0bGXb6aR72r2DFY9q/xp21+3/XcyY/p5viuLV/I/J6U4yKfPE6CBZCuS5rlEM7/r8CKjJ+g==
X-Received: by 2002:a17:902:e808:b0:235:91a:2c with SMTP id d9443c01a7336-23dee0d17f7mr89631215ad.42.1752327770118;
        Sat, 12 Jul 2025 06:42:50 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:90c1:8214:37cf:b3e5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ae865sm64193205ad.72.2025.07.12.06.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 06:42:49 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: williams@redhat.com,
	jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 8/8] svsematest.c: Suppress warning
Date: Sat, 12 Jul 2025 21:42:13 +0800
Message-ID: <20250712134213.58582-9-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250712134213.58582-1-yphbchou0911@gmail.com>
References: <20250712134213.58582-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

