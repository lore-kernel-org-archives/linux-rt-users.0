Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90683DDAFB
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Sep 2026 18:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152982; cv=none; b=ED6XrNFj8BeR49L41tklRQgxa92XvWAtmSi8kR/zyp46ofvNvRN8hK830jqLMROwxCw4/33E5xYBcrGoCeD1Wof5Wizl06aBsMUlnGVbabm/W8wDrNqLwuuYEq61XMu7pJet3Up4VZgQ59lIdhoRsdEJe5aTQm+raP5xUuZdyqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152982; c=relaxed/simple;
	bh=/NqUOFVpt0OyEqBmiXpobRrHgyfn/QCow8RrbN4Ua9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UO9jjWNCVl84izIG5LWxYoMguTBfGipYIhakk1hLAKfUCZq922soyLCqU+BUoH+oiyojj18ahuy2yUvcx5ZqShV9d3GEG8Uwrx9Ktou4qbJzOkwW1pWCyVStrLjvaSZK3e+vS9HEYhmeM71f+A9pC1f70jA2kG5W+dEj747sJdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcWuAzsV; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcWuAzsV"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb766bfd3so2542581cf.0
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Sep 2026 11:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789152971; x=1789757771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o/72uAXaTsVr7uPmyAJWc84sqjae8zX2aydobF64zbo=;
        b=NcWuAzsVQTn75hM2Mv45REGfF9fGy1QY/Qp3HpqT0zGSYZaWT1JwcgD8nkLxV15867
         Wkja9ZMluutypHQGPSpM8dUy4q8DVmGlwdGuNeXtKg1bziXwvhljmWloizftqX6rbQCK
         kZ7vcvT61OSJcEE6YVxaMLlllu7OWsbnKBLI2cp3dFhSswjR0xrZkVMkATtOJjuP1YVq
         9hwp3NndqY6hlpfi4mZ0B61w1z0va5yVSsPeZBDMLj2zJ0P7wztARGVw0YJtFxj/h+vH
         S/VC/1jrSp/CqnuYmkGvrkVRL4KQWEOEYzOV93BcYgnODEIOPVtWjgkqQ91k3eL7zppn
         v3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789152971; x=1789757771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o/72uAXaTsVr7uPmyAJWc84sqjae8zX2aydobF64zbo=;
        b=BZHXHMZECHH2Hjv1X4HA55+/+BxgrkfmsAcmvezEch+Mcspg/uOx/N6gJi2ieo8NDV
         /TYxYmixvS1x1+144MG8QBYMxbGfvIHYjpX9o3Bqg9T0nivorHBbXzN7u/8h85xh/fRf
         yThdJ80UZAGkK+G54FIwU85LOU5hv72PprZbB4PK/okjIuSxhf/PmKWVxxn+tRdXZgyV
         qOy9DOXR7z5pv9fNgTQ58SpidNFs9cr182+27AliEn0unxxML6hv/I/1O5UWxcbjkVFA
         +uoVufn4Mxqe6TCh1b2LLKIXiepoSMHdinW/wrh6CgXs7i/kysxhrvgJxuuJwfWOEG9X
         lcMQ==
X-Gm-Message-State: AFuF++n0hoFd6Czz4KCWevsZ4hVwieGrlAAuttvQ4KQnfVz/JxtdrTsB
	LJBA7egpEuMu5XHbdeVvZ2jSEUtyqzzk3GMZdTUkVb2NfEvQLw9lWfW0M7GJgQ==
X-Gm-Gg: AYBFou3Olg4vlXS8yGrRX7gp1OelIpWC5lpwB3duW/bBcI297mizC0qwheVmAppa7EM
	CWYLBZp1FC31nIR4//+QUVXDzaAfA4yDENKZWuzXKZWna9I+gzYMaKITsamX44w8OTSdkH8ulYy
	H4WmN48Y97++/K/kn+liiM1LCzKcg009gBFguP36awKd1hwbUzxHUF8Ajshf+kxMbDrvqtoam2o
	9zIRoAs3xZmNeEox56nXE3hBVSeYx7TqbXN+vkj7DKARlrb6dSwkxGIJbizuugBw4D5MGf9yxFK
	XwkvbMTSha50xTNQ+JtwCeR8UWJaztrYtUryHVcOTqndTcSIIROPTbEZwcN8bUDpDaFJc4rxoFp
	K/7thzUxsJgrRIwYiUJRYX+ES8Thc6tfCpMIuuw5DQrYS7gKoQ+jWBUTt/Z+3BUndVbJuFpfo3V
	96Y4ahyAlA1GOihgQn0cNGVhNmwwG9PSBAce4mwtyksSBLioZYjdHaQYvtzrKyFdZjb6rQMzWg/
	eTNll7wqzH50DZfFHhvDCzANuq9vSUHBsdjcznfjabBY8Qs3qyuy7us+WR5k25+5A==
X-Received: by 2002:ac8:6112:0:b0:530:5152:75f0 with SMTP id d75a77b69052e-530c8598ec0mr105793181cf.22.1789152966357;
        Fri, 11 Sep 2026 11:56:06 -0700 (PDT)
Received: from Cumhall.redhat.corp ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4920c5sm27254726d6.32.2026.09.11.11.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 11:56:06 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 01/10] rteval: Update E2E tests to cover multiple recent changes
Date: Fri, 11 Sep 2026 14:55:34 -0400
Message-ID: <20260911185549.604199-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911185549.604199-1-jkacur@redhat.com>
References: <20260911185549.604199-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tomas Glozar <tglozar@redhat.com>

There have been multiple changes to the command line passed by rteval to
rtla:

- Commit f2c619a7ca08 ("rteval: Fix timerlat module for rtla short
  option parsing bug") changed the format of rteval's short options from
  "-o<arg>" and "-o=<arg>" to "-o <arg>".

- Commit 5153f0e854cf ("rteval: Refactor timerlat parsing and fix max
  line duplication bug") commented out "--no-summary" to get more
  information out of rtla.

- Commit daf3e54bae7c ("rteval: Fix timerlat stoptrace trace analysis
  capture in XML") makes rteval not pass "--no-aa" in runs with
  --timerlat-stoptrace.

Reflect the changes in E2E tests to make them pass again. Note that
some partial matches were extended with more arguments in the process
for the purpose of more clarity.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tests/e2e/measurement.t | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/e2e/measurement.t b/tests/e2e/measurement.t
index 9d1f4380e94c..62c39eb6e0e2 100644
--- a/tests/e2e/measurement.t
+++ b/tests/e2e/measurement.t
@@ -72,30 +72,30 @@ check "timerlat duration" \
 
 check "timerlat command, with --measurement-cpulist" \
   "--noload -d 1 --measurement-cpulist=0-1" 0 \
-  'Command: rtla timerlat hist -p100 -P f:95 -u -c0-1'
+  'Command: rtla timerlat hist -p 100 -P f:95 -u -c 0-1 -E 3500 --no-aa --dma-latency=0'
 
 check "timerlat command, with --measurement-run-on-isolcpus" \
   "--noload -d 1 --measurement-run-on-isolcpus" 0 \
-  'Command: rtla timerlat hist -p100 -P f:95 -u'
+  'Command: rtla timerlat hist -p 100 -P f:95 -u -c [0-9|-]+ -E 3500 --no-aa --dma-latency=0'
 
 check "timerlat command, with --timerlat-interval" \
   "--noload -d 1 --timerlat-interval 2000" 0 \
-  'Command: rtla timerlat hist -p2000 -P f:95'
+  'Command: rtla timerlat hist -p 2000 -P f:95 -u -c [0-9|-]+ -E 3500 --no-aa --dma-latency=0'
 
 check "timerlat command, with --timerlat-priority" \
   "--noload -d 1 --timerlat-priority 80" 0 \
-  'Command: rtla timerlat hist -p100 -P f:80 -u'
+  'Command: rtla timerlat hist -p 100 -P f:80 -u -c [0-9|-]+ -E 3500 --no-aa --dma-latency=0'
 
 check "timerlat command, with --timerlat-buckets" \
   "--noload -d 1 --timerlat-buckets 4000" 0 \
-  'Command: rtla timerlat hist -p100 -P f:95 -u -c[0-9|-]+ -E4000'
+  'Command: rtla timerlat hist -p 100 -P f:95 -u -c [0-9|-]+ -E 4000 --no-aa --dma-latency=0'
 
 check "timerlat command, with --timerlat-stoptrace" \
   "--noload -d 1 --timerlat-stoptrace 1" any \
-  'Command: rtla timerlat hist -p100 -P f:95 -u -c[0-9|-]+ -E3500 --no-summary --no-aa --dma-latency=0 -T1'
+  'Command: rtla timerlat hist -p 100 -P f:95 -u -c [0-9|-]+ -E 3500 --dma-latency=0 -T 1'
 
 check "timerlat command, with --timerlat-trace" \
   "--noload -d 1 --timerlat-stoptrace 1 --timerlat-trace trace.txt" any \
-  'Command: rtla timerlat hist -p100 -P f:95 -u -c[0-9|-]+ -E3500 --no-summary --no-aa --dma-latency=0 -T1 -t=trace.txt'
+  'Command: rtla timerlat hist -p 100 -P f:95 -u -c [0-9|-]+ -E 3500 --dma-latency=0 -T 1 -t trace.txt'
 
 test_end
-- 
2.55.0

