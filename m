Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8332F3614
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762540029; cv=none; b=jmab2DAm5fJ41Wy9ghl2vlpfs/7JfU23LBsiB9MIciE2phOYFotHJzIkKxyrzEe4ToH/NpaEQOls9LwWUBQpOSYO1PQOaEInthJKI9NipXae4YWpPiwILRJJFqdNdc83nN5GagnYuIHEJFkjJEE029n5R9u8HLn8IBlZN2aMcK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762540029; c=relaxed/simple;
	bh=fp7SgW5KZprKu6+3dOldGPvbIjT2w52Sjin2PBtpCoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1GUR6NAnbBYEYy7MB0DXjCtBFYZ3l06mINLBViX6tUOumsMbQcZYdAa6pPPq31O447Inw4GTbW2JXZkhTt7t6EDB3Qxa+K7rsZs7Bhhl4yPCx4ke/KNmnXV0d0Erf5zjS5viUnCBQvm8c1P7rhwJ36Ya2V+clYf66orDi98rEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+V+YUva; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+V+YUva"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b13120ed52so86188485a.1
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762540026; x=1763144826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8xNYyZkbOIrvJVIf7xCxokXgtghkMhzADpf7IS6udw=;
        b=J+V+YUvasJdTeW/wNPjoM0qTjbv/sWpNIVTj1jkiz7x7O6O5bP59Wvg/U2W3rGghZA
         ZaMlfaFUFUJraemWv1YZlbOzVLLaBMkpQ5NIlYdmWPmGnaH/vfvNWxPTALmTZ8tH5l2K
         EpLl2jlM3h/k7N7YNRy4DoRu5bR6SC0VaEuomO0amv/u4sGHdwrGOMKUXVBQzO4N8gao
         uxPfhEcZs+kMFTxmvWBpDEtwzNLQd6AF3W4XQIceIZqMpX39sYTeuHFmyY4V6BwHR+Nm
         zggh7cEC1RcxXnr6+aMJLcGhpAByAlxhlYMBXtRGfsBFDv0ym/1R1x3/QtN7feUkSAn/
         HWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762540026; x=1763144826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m8xNYyZkbOIrvJVIf7xCxokXgtghkMhzADpf7IS6udw=;
        b=nNAINcf5gvOoCJPfOvYUYEiSzfnhgQBSbsUwreFUQ1Gt7RdX34XxpeE7r/nVZ6ori8
         jDFhWe9gmMYnZ4gfoXoP/OCvlEhKJm8HFtohTEkg6S2cJbt95vbUyQrhGCOet1a1fApL
         31VddDWG9n7b1Y+k87eJLKJIU8iX9ypfw4PPTLLqtmukDJNd+mXIIFzMBL7PcAFr1IHX
         rBfXmBGe+JZmkGoek0k78ODjhOgFyORJEix7iS/FNAhFTjjRSvH/1LA6DwE1ekzKBs8x
         dyJpu31ZlLStWewdJNHWa25CQW+PVAkj6XwZZqJVrZwSHO4XYzczfksxXvTCJrKhh47w
         54tQ==
X-Gm-Message-State: AOJu0YxfPMFU2MHE12hFPJm5HoBk4Y8WlxDn2CpYrmSTTxp9Hc83su2R
	KTgNuUEy9sXfpxS0IcosZ/fmT8To5JovfQ8k5w2jeE4qisVX/JjDnxRo6XEXkNBb
X-Gm-Gg: ASbGnctbTKr+1X2UkoKtog9T1m5d0xR2HzmB4MywJUYFu5YRG3wTaB3ubAxemth0swL
	MHOhU8ymXnOkxVWgYG/OmBtAJKnvISeUtvsmhSAH//gmsIbEjDV0pmb9peCHzUcFKihFeUrxAlg
	B88EHqWgG8AB2CgUOeX+Hr6dTRLbzdEWKNME25TZM9JMTwgLlX7TpPByUwIfAkfvs7hyx80BiM+
	IKR3OKklP9PX8WizAvnEbLe7/ePTz2xQuWzwwMkwRws/gMUuvd6rbdSilWq8gRq2K1YhREhhfWT
	D/w6pDYu6cIkv19qCLsUW8mXBSi+KTFCXqY5xyfJlQmxVc4hDF9TO2KCUVgPElRug4H3mieDfm1
	A052ToG8Bb4UgvtN511qPhXyqJWpMAqO8G9RX/dYqmzGwjAB796Uv/ujJHl58ua8=
X-Google-Smtp-Source: AGHT+IHQMP93zUZiPhf43v4qasPzGwNLIecu6r+8jvFdbKgaEdXOFu16oJ/LkCFUiLtGnuHG7Y0x+g==
X-Received: by 2002:a05:620a:4891:b0:89f:3fa9:d2d9 with SMTP id af79cd13be357-8b257722920mr63062785a.7.1762540026574;
        Fri, 07 Nov 2025 10:27:06 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm452141085a.53.2025.11.07.10.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:27:05 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 01/12] rteval: Fix spelling of 'occurrences' in measurement modules
Date: Fri,  7 Nov 2025 13:26:24 -0500
Message-ID: <20251107182645.19545-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107182645.19545-1-jkacur@redhat.com>
References: <20251107182645.19545-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed typo 'occurances' -> 'occurrences' in both cyclictest.py and
timerlat.py measurement modules for consistency.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/cyclictest.py | 6 +++---
 rteval/modules/measurement/timerlat.py   | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index 3d25c20b69cb..f32ad2690f45 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -92,7 +92,7 @@ class RunData:
         mid = int(self.__numsamples / 2) + 1
 
         # mean, mode, and median
-        occurances = 0
+        occurrences = 0
         lastkey = -1
         for i in keys:
             if mid > total and mid <= total + self.__samples[i]:
@@ -104,8 +104,8 @@ class RunData:
             lastkey = i
             total += self.__samples[i]
             total_us += (i * self.__samples[i])
-            if self.__samples[i] > occurances:
-                occurances = self.__samples[i]
+            if self.__samples[i] > occurrences:
+                occurrences = self.__samples[i]
                 self.__mode = i
         self.__mean = float(total_us) / float(self.__numsamples)
 
diff --git a/rteval/modules/measurement/timerlat.py b/rteval/modules/measurement/timerlat.py
index 5bfc495217ea..733929666784 100644
--- a/rteval/modules/measurement/timerlat.py
+++ b/rteval/modules/measurement/timerlat.py
@@ -84,7 +84,7 @@ class TLRunData:
         mid = int(self.__numsamples / 2) + 1
 
         # mean, mode and median
-        occurances = 0
+        occurrences = 0
         lastkey = -1
         for i in keys:
             if mid > total and mid <= total + self.__samples[i]:
@@ -96,8 +96,8 @@ class TLRunData:
             lastkey = i
             total += self.__samples[i]
             total_us += i * self.__samples[i]
-            if self.__samples[i] > occurances:
-                occurances = self.__samples[i]
+            if self.__samples[i] > occurrences:
+                occurrences = self.__samples[i]
                 self.__mode = i
         self.__mean = float(total_us) / float(self.__numsamples)
 
-- 
2.51.1

