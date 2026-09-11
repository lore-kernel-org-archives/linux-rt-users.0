Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FA43FB05A
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Sep 2026 18:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152985; cv=none; b=fWHW34MlYOxJ0zeJ9f78fmJtOCwqMz41NpELR2CcVLMH5LKxZV6NIOEQr3c+esWlnpEX5CPXjAJVfjWxVEhK9gRfB9UKsIs54mJwIfQlSqoL6yaAf9wPn/hLd/LRBh5JAqXQidVTjruN64m9Fx9fsphVBKOuQVsqtQEQ96nFLSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152985; c=relaxed/simple;
	bh=GacAw08DSS5oaKGgTk7p0CXwO0aK8D/Gb2rZSFMl1bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMd4HuGTchy9HZfIopUmw3Tz8piqTX1gPwdcz7VQaNITMNluTRjEcYPacZEnTYz9UzR2S/bHxyaGCrLy/Vu2zmSQOgWotvZB2owdJQalQwQiVFF4Tij/IfD0GzARG7yUeFzU2yh8GEqiMdk/lKoMTbjbpiFQO4rhPEtMcBXZ+QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYqATdqE; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYqATdqE"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-90e970f710cso12950126d6.3
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Sep 2026 11:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789152977; x=1789757777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TkUh0mJjCPQQEnTMMKYLEfLpqNaEGVxqNIr8YLU8U34=;
        b=kYqATdqEfULv9b0qlCnPkZPcPi2VV2kXHoO72jC1qCdyLDWesObRGsUz+EdVz1QC81
         MckFf0l/5gLOBVLczHGJIPID9+e4qZO204Ud9o94ws/Wg6Ed1JERLU1m257scka2RCjw
         ogETptjeOf5M8oKD65ln9kPLt+Rjl+URCzRHYwtJzkuYuITqOxKGTJVSEZwtc5LFgJlN
         BFUrHMuBiJEvtTJFUkS2kk7zlxY+vWnJEUty7uORahdbHDdcPWQr/nbxUcriL6lSuECO
         pl0dNY0fSBlGl4YTsKA7dfZdVwMikubAcpM8zv2gpk3qo2ZiMOG0lqk0vsrpt3XmoNy7
         ADGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789152977; x=1789757777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TkUh0mJjCPQQEnTMMKYLEfLpqNaEGVxqNIr8YLU8U34=;
        b=B1Xjc/eViGr+RiyprmbHfxK4piNuCbMzjobQb6PNx+uS/76mHTpKzVwHMm6SYgkynD
         +3DgkA1QzXPm37kZpwI+AKVKrPa8KQOkRxdBrEqblCnxkxfgBAEd6c3AfgLcjOaoPEDg
         2UhpKrYfw6Fr/LGDvYmiYNjDfFBGmhBb9NDoM/SufWWGmxkLd9S2UYVbnk1PIwQzZyCH
         D1rn1UcE9ljIEIw3WCj3EmyWwJryzU0T8m5Q4H4+81vWwbPxDvC4xxrnP28XJt7n6eVP
         9aIDeUPCJctHnpF7AGTFLwbfEfNuv6bzmHDtfznXbNsW8l1QCJxHSbUBIYEzP4TuSFPN
         rZjw==
X-Gm-Message-State: AFuF++m47KJaMvd1304lhzUjSuP8m8R67gjL8EKgUEAIN7WPz30bLOl+
	ruI810ifOoRpiUUfTSQqt9pyj6z3WjaGJMjyx3VHVRMFDaxWwXAF4BOlpAi77A==
X-Gm-Gg: AYBFou0Vx14lx55f+bpN3wTfnc0X2rbiG+tV1yDKVHVhnYhapYgiLoYTbrcOF8axmLo
	GnOW9gSljdAXyuIGKpyW3JzQnqFakEbOZJMvarvCr8q95GUUwN4zhtZpCcAeKPfA586L2kW5+6G
	u9l5xY0IL7wOer26hFer6snIJsKbbVIcRIeWUuvuYLtpQ9D21sS5+8ospIF29Es+hblVAXRdHgi
	KCnKKJGBt2MHO9mwo/oNVyQlJmpS0cnTF7FuX7zQseJhINdEfJ3+U0dz8q9WD3Grhv5O/UHDtZx
	VaPTxs1E/3nxJ8SlZcqsqVvI1sw7mIk4/xj1h57nCypCH45pARuTJUV07Q0G86u9pqgMBtRYfP4
	AQVl19ahDYowEO3vgdbimWRLmi3w7X30bsIr8M3zskQLGvHxofF9fFy+D6fweqP69pNis++csq0
	aDiHfb8X/sfjH7cPBs6OaEUY4CcG4bQx0mRPy+2Y6OpN9UxfzyfHp9MxImMw20g7ZVFr+788Cwn
	mdMgZkzG96rCc+Q7a3wr+1x4Mi7DznjlYcRZ4a4ptHEpUNMRkQXm9dPM1F4EBzb
X-Received: by 2002:a05:6214:310d:b0:8f2:5a3e:c619 with SMTP id 6a1803df08f44-9121207d6ddmr70119036d6.4.1789152971972;
        Fri, 11 Sep 2026 11:56:11 -0700 (PDT)
Received: from Cumhall.redhat.corp ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4920c5sm27254726d6.32.2026.09.11.11.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 11:56:11 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 07/10] rteval: Fix expected partition type in cpuset tests
Date: Fri, 11 Sep 2026 14:55:40 -0400
Message-ID: <20260911185549.604199-8-jkacur@redhat.com>
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

The no-housekeeping cpuset tests checked that the measurement cpuset
had a partition type of 'member', but the measurement cpuset is always
created with partition=isolated in cpusetmanager.py:

    self.measurement_cpuset.write_cpu_exclusive(True)  # partition=isolated

Update test_same_cpus_no_housekeeping and test_different_cpus_no_housekeeping
to expect 'isolated' so the checks match rteval's actual behavior.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tests/cpusets/test-cpusets.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/cpusets/test-cpusets.sh b/tests/cpusets/test-cpusets.sh
index e624086e6277..79a319cd09ff 100755
--- a/tests/cpusets/test-cpusets.sh
+++ b/tests/cpusets/test-cpusets.sh
@@ -238,10 +238,10 @@ test_same_cpus_no_housekeeping() {
         all_good=false
     fi
 
-    if check_cpuset_partition "rteval_measurement" "member"; then
-        print_info "Partition type is 'member': OK"
+    if check_cpuset_partition "rteval_measurement" "isolated"; then
+        print_info "Partition type is 'isolated': OK"
     else
-        print_fail "Partition type is not 'member'"
+        print_fail "Partition type is not 'isolated'"
         all_good=false
     fi
 
@@ -305,10 +305,10 @@ test_different_cpus_no_housekeeping() {
         all_good=false
     fi
 
-    if check_cpuset_partition "rteval_measurement" "member"; then
-        print_info "Partition type is 'member': OK"
+    if check_cpuset_partition "rteval_measurement" "isolated"; then
+        print_info "Partition type is 'isolated': OK"
     else
-        print_fail "Partition type is not 'member'"
+        print_fail "Partition type is not 'isolated'"
         all_good=false
     fi
 
-- 
2.55.0

