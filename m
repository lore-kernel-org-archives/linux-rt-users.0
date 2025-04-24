Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7923C27FD4D
	for <linux-rt-users@vger.kernel.org>; Thu, 24 Apr 2025 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745527738; cv=none; b=COOjK5THaOvb3qWpIbiIASoOuSn3IAsVToIFdrZnXTlSu7gl91tDYNbFeR4kLHr/ifUbCDTU1OCuBMmTCGfoL5mF6FM/l3EJss3dTOvHgD8gGLA2ITW76vhv1Pco/L2T7MyHGJTOXUPTZJbprtxoaF03idzBUUzgi84qz9bLNX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745527738; c=relaxed/simple;
	bh=F6dZdCWe5XHYSt+hHTarZrLISFMJsKCI5dAVlhmOu90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwGe6pllKbMfBc/FQOaEb6BwU/oQ+gqSJlXRP61zkQoxETrP3RhlRCvTTL55V5K5xygwBrrWkRzLX1Vk85pafWJZ95qc+V6PgR02Wu3tTYpHII2slAvIlEHJ50BX5sWjVhzrkVdzSsCJ6jy2Tn9c6kP2WRXXnH40MY1+FhtvQGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIcG/eKP; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIcG/eKP"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c546334bdeso139655985a.2
        for <linux-rt-users@vger.kernel.org>; Thu, 24 Apr 2025 13:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745527735; x=1746132535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TlrxpIUCqXGrsdVLF8+ODCIOkly/68Y5+itALcf+E4=;
        b=aIcG/eKPSsEhyzjbBor7WguPk7Z4g4vvoHQjICnFYTuy/pgjNunFNmJ902ZKxQP33b
         bP86cCJs3Hd8+9zihTsvmLGjkVcTtyn+7PbBbqVTFOagmoqGQnZklzp2tRmsSt5cPPZ1
         mhxWrvysVFm0LVjg9QVe0zvl8dXOpuhiC/TuGS+24VMz+0H6JaIyZSZJhfpCObuXihTN
         sQ1aRctpMWlCY/RyCIA6w+qlnWiy1mxVRC+mHY/CAL/oBuUSqU0wG5f7RCH4hTTVUvRh
         vrsMk5MBAZ1DGO5dsLBuylh8vT7sykyFb2hfgOlvBSgsVODI9NxicqhHvORGmFJ8NVum
         U6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745527735; x=1746132535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9TlrxpIUCqXGrsdVLF8+ODCIOkly/68Y5+itALcf+E4=;
        b=IB26BiURp986DEV91buQqe+MmN6E//J6otpd8mork+iI4bILJS7NICHf80+8rqaX+9
         NwvIQm3CBCIu3fF7HNh63lrPmEDVe4oNhbtvygLKS2p5/Ns2Cb0qQFmnHUWNGGpTYGU6
         3l8Kp9wpYxWwS/FBx1sBS33u8cwNE/4loMW20M3XvOyKxn03dlh3jGpXX0B7pZfqpn9f
         4QQsk01ao3mCzxMkcOgJKaKUtsFCuBNZWU/5h8IG0nUczeyY7N699KFHw9oCAGv6vyt5
         WPoBsqEtLfy//+jRtMlToZhoHvMazdyHFLIUqRPGQeSWv1id+LvytCTncFhw8WUVWVUe
         Jvzw==
X-Gm-Message-State: AOJu0YzX3iP102VE9lTuhZHor9vEsRQlitGbk/n4bQVhT7yclnUYkr3/
	Su9bYKt6JRc4/QK2t+euhlzvq8oh+rVEA1K6GOYol2kTnNBm59e3JTgqXw==
X-Gm-Gg: ASbGncvSgDKHFx+dOe32kGIEbaRBPZzOvNzhzAxt4z4yoSDvo/P2xaz0oB7O+EFC8GO
	Nx7PgAQmx+fgKS8vbbAaqLncF3ndhxXv8pM73QvRdhXAbVBnGrzhrflS/eT8ocyy9PjbHU4OHLI
	/w6juwgG/0yc1JWGb7vqwYQ2ZZCy/kUaBtu5vmxMb28Y8iy7Nwklk1++8r6u2AYwYEE/K+huKBG
	OZAsmB6rJesohlT2g3ZKlTDgj4o9WhJXNb+VCOatUYbLWccXqacgMTdMmpCJPdBnEp//cbnsWp8
	t2BiHzPqXcs9lT6JmoXHVoYUED+dGnMfFLCYIK8J89El2g==
X-Google-Smtp-Source: AGHT+IF3wXR/8xbgUgdTSwazIbzkyu/e7eOHC1woYIuDd1M5l62IMoAbokondr7snQ5hY8ULPfC/AA==
X-Received: by 2002:a05:620a:1712:b0:7c9:443b:84e9 with SMTP id af79cd13be357-7c95eee6857mr129561085a.3.1745527734906;
        Thu, 24 Apr 2025 13:48:54 -0700 (PDT)
Received: from fionn.redhat.com ([142.189.102.216])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958d86c19sm130932785a.85.2025.04.24.13.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 13:48:54 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 4/5] rteval: pi_stress: Change PRIu64 to llu to match upstream sched_attr
Date: Thu, 24 Apr 2025 16:48:42 -0400
Message-ID: <20250424204843.79193-4-jkacur@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424204843.79193-1-jkacur@redhat.com>
References: <20250424204843.79193-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Change from PRIu64 to llu to match upstream glibc sched_attr.
This change is for when we are getting the definitions from upstream
glibc

- Change our definition in rt-sched.h to match upstream glibc
  This change is for when we are using our own definition of struct
sched_attr

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/include/rt-sched.h   | 6 +++---
 src/pi_tests/pi_stress.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/include/rt-sched.h b/src/include/rt-sched.h
index 9cf0e3a937e5..767b1d8df485 100644
--- a/src/include/rt-sched.h
+++ b/src/include/rt-sched.h
@@ -56,9 +56,9 @@ struct sched_attr {
 	uint32_t sched_priority;
 
 	/* SCHED_DEADLINE */
-	uint64_t sched_runtime;
-	uint64_t sched_deadline;
-	uint64_t sched_period;
+	unsigned long long sched_runtime;
+	unsigned long long sched_deadline;
+	unsigned long long sched_period;
 };
 
 int sched_setattr(pid_t pid,
diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 6f8c5632bdd7..74e7bde0c21f 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -1294,7 +1294,7 @@ void print_sched_attr(const char *name, struct sched_attr *sa)
 		printf(" priority %d\n", sa->sched_priority);
 		break;
 	case SCHED_DEADLINE:
-		printf(" runtime %" PRIu64 " deadline %" PRIu64 " period %" PRIu64 "\n",
+		printf(" runtime %llu deadline %llu period %llu\n",
 			sa->sched_runtime, sa->sched_deadline,
 			sa->sched_period);
 		break;
-- 
2.49.0

