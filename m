Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A6340B6F9
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Sep 2026 18:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152983; cv=none; b=OEktstHJEsdcpS4dJtLmLjEQFcceP3lnyNzK+946dNgc4xs+1fwvk8Vz0mH1pL9Syd0hkkGweRWzUb7MEjKluO53mSyuSiZJBtm2olR5Y+C06JQa/9xx8VIQ4Qx2vJ/lAfJNewQ58EBg305IsjBqkg8bOsaK7qVrxO52PVp94WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152983; c=relaxed/simple;
	bh=ctNgsR1cROD1FrHV5/d0Up1WQ0ZcEf3tdFZkhLoT1us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+8arTPDA604OiQHnBUnx0TZYEhapuU5Y5XbvB+SbGv4nFQw89bhg8rgLSGtjq29AEN8mzaPProvrjNAWaN6d1qvXWklBSmECEtURLVjV//Oignef0iePGc91ZIn3X4p19MvftUb3AUioltgRxlzsBhOhTTTjddceDXxBdxv5ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoXm8lf/; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoXm8lf/"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530de452c33so2498521cf.1
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Sep 2026 11:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789152975; x=1789757775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+zX4tLAgNE5Ra4IrQ+jPKzCCHlBp3BBOjDmDlC0ArtY=;
        b=eoXm8lf/yiUVRjrClTvRWzeXvK3Q4oy56gb25I8/Mhm/E4ZwzbraXTWnQ9MEpGVS3n
         E/cTReAcEeMMc5Vju3AsY0CC37aI6ZovezWvTrJOltmp6Rc+kqPMao9EuM5MxjtYLmcA
         HXfSAmdS6aSIWJU/97JdMzkegpFDaz9ni0ljiJjmxSnT+MjvZKO90YB6xZTw14jQfZc5
         D8qv9v9wxhv9siPyokJHO4yx4sFBAe1dz6bJcuJxxXHgK+t9ThLQuCE8yy14oLSSrg/7
         7l022Amv4mMEqDIc4fEzmx2A31VmejabnFLVTBaua5ArVRyKzh+i2Rg2c3CcqoJB0gET
         2HlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789152975; x=1789757775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+zX4tLAgNE5Ra4IrQ+jPKzCCHlBp3BBOjDmDlC0ArtY=;
        b=Q3lxD6egUQ7gvqNqj+rF6frM46x37QMJhV4LD56lxpqk/HYN10opZRbxASRdjx+2Br
         Xr5Vv/oMEPsYdE7STJ6760IXs8LFGzHXegFCVrQ1mF/H04+CNyIdqkS7ypjKx9fsBSTe
         vIOnlCMAkzFKFXnfHeaFFKL7jTLEsIeI1uO6ZbdYcZEwVyVGGniBufF7bTc8nLjWZ9bD
         VLGj2IH/7LR0Q6t97TMW+CaRTy1vu0eiMXHHYwrJMlh5/bZi2iBDtWh2mN76+1GBp8ks
         gDCk1HL7Jq9aThlWyMipmzaI5KE35zh56rOQz7dLzeLc/egbJltKQ6zM41isP9m18AE+
         Es8g==
X-Gm-Message-State: AFuF++lF5naeF8ocIEmtakE1VkJS2eVWjfEpLTi4sxwkPEhTJ27BC8TH
	8CtNcfTOqNVtdEywntPwfs8UTJYuyz8TGlpN/JtkV7FtCf3HV/gK81KC/gw2dw==
X-Gm-Gg: AYBFou1wnCBALZSA082rwNSiCxnhMV+eNlk1jMbUS1GquNah6GSZXQf12VoewfVm4dm
	tAqcerzgXzTjf+jxe4woykbnv9PM0kww161Oulyr1JZ2ASLT+lWGWra31rfwLi4GCdiw89j8mAi
	t94kSRUX6//GknxjV4M++X0gCXUtEO60CYu3cw3SU1MIUYfGaqGnSszwQE8j6jXzrsa7tNk+PcZ
	FNJAGLGX/txtcgHEu2AoszbsXuJNRj8CBFYH1Fs8++FPDeDU4ZZrWZ5jWsYqjmoQbwyWuIsPmow
	Dw6SZmoassmu/bHofk1PEjQnkrdQgSeXS5GoGXzt4erelJnIAyusBHOPViij/0ToHMkexv2LITG
	2oiA0gnoJsGBX+fXuakcXrNNH5ydcHdYzcIjIIu3cfNsQUL/W+kgPai6+oT31ImX6n0dM0FWlH1
	cUmbZ2oz/bgFJJ2BTpZcpNQIwfAdolG1uIqgNeYDxWF8iNgbhwmdPBAElAvrHJvwDA6gKsDbhp2
	y+3G1YifctOOmc9/2U/He4xsSoINO7DA49Rxe3YX5bOXaJUxRt89aL6x1JsoMzluxbG7Hb2QZk=
X-Received: by 2002:a05:622a:606:b0:530:4310:5398 with SMTP id d75a77b69052e-530c876f4f2mr81150081cf.48.1789152972862;
        Fri, 11 Sep 2026 11:56:12 -0700 (PDT)
Received: from Cumhall.redhat.corp ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4920c5sm27254726d6.32.2026.09.11.11.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 11:56:12 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 08/10] rteval: Do not use set -e in the cpuset test suite
Date: Fri, 11 Sep 2026 14:55:41 -0400
Message-ID: <20260911185549.604199-9-jkacur@redhat.com>
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

The cpuset test suite tracks results via the TESTS_FAILED counter and
decides its own exit code in main(). It also deliberately runs commands
that are expected to fail (the isolcpus validation tests) and calls
'wait' on backgrounded rteval processes that may legitimately exit
non-zero. Under 'set -e' any of those would abort the entire run before
the summary is printed, masking the real per-test results.

Remove 'set -e' and document why it must stay out.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tests/cpusets/test-cpusets.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/cpusets/test-cpusets.sh b/tests/cpusets/test-cpusets.sh
index 79a319cd09ff..fe0d26e7320c 100755
--- a/tests/cpusets/test-cpusets.sh
+++ b/tests/cpusets/test-cpusets.sh
@@ -1,7 +1,11 @@
 #!/bin/bash
 # test-cpusets.sh - Automated testing for rteval cpuset integration
-
-set -e
+#
+# Note: 'set -e' is intentionally NOT used here. This suite tracks results
+# via the TESTS_FAILED counter and decides its exit code in main(). It also
+# runs commands that are expected to fail (e.g. the isolcpus validation
+# tests) and calls 'wait' on backgrounded rteval processes that may exit
+# non-zero; under 'set -e' any of those would abort the whole run.
 
 # Detect rteval-cmd location. This script lives in tests/cpusets/, so the
 # repository root is two levels up, but also handle being run from the repo
-- 
2.55.0

