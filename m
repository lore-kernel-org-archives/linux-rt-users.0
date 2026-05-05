Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808534A33EA
	for <linux-rt-users@vger.kernel.org>; Tue,  5 May 2026 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003081; cv=none; b=H2cB08/cJBmIvck5uwg/vW+TBH4P+D/VSiedv5PVhTfTCuCPu/JVAAoWS+klxptjSsMbXRjPH1Cn5/AOANvZfgPFA8kD0eFN9sDdGTYUqgavQMrCFqxSWHFy0YuSr/pHarFRE+yUHjmljkoex9LQnlUhqJqyBEwpaqUWY5+SkcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003081; c=relaxed/simple;
	bh=o3v8pZxos5vyj20GJr8qQyi+d6fEiCHs2+ybazAZVM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YeW0gDtp1cJ2cJ8Ql44gVsGgFntmlyK0/FbH4/wUpj3xyp2MnW+BZLaMYWx9rsJYIRplkTCV4xg/ROQlnKZLaOZacj8o+Htn1H4Dac5aAXiYtoB6seS4ROuf91W8Xp7mmFJTFA3fHXuQpLKg7+MmliazGPz67MXX7Np+Fumrhl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggDQll6Q; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggDQll6Q"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8b6dd874471so41490336d6.0
        for <linux-rt-users@vger.kernel.org>; Tue, 05 May 2026 10:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778003079; x=1778607879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46UONKE7QX8tSWa7AjOsG5906iLvu+fEZhcbYkLyy3g=;
        b=ggDQll6Q4geS/05g25dJSnag46qgzyIuEbeSQV/JcR8ADgnSyWU2LdAzJtb1UyTujn
         KboPGNWVUm7FLPQXrpKs56ssCkFLlfHSvlmwdWVm9jBQqY52qGP2wwImdk7MsxHRmRYS
         GTJbk7jYU9MFIyrpu0GkMmX0yqeIs91DM3e+h6fJvg1Hnvvg12XJPfqFLgxah2KojO/u
         3oYsShQ5nAViCHEkUyHuKD+AdFNWGpcNDZEKpUTg/rae39xNc7+gBHhPOSddVdj4S79W
         qquFK36gsAN9lKNSXVWpnwbBTIf+sxJG3zHWYN7b0trULJDpvSumU1swbRp5sqty9OxY
         Ufmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778003079; x=1778607879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=46UONKE7QX8tSWa7AjOsG5906iLvu+fEZhcbYkLyy3g=;
        b=lapHzwwqUsaybEGzI12cIqVV2JgfMAWX064rO8kNsclgaOPumXJnFKSHlIr5JNcNkJ
         wSRoz1DDCUR7fN0LwdMeRlJgviBECPCp10qrVC9rE8AQEyKODF4c8g8DughlxRhoTT5e
         m8cOzJU94wYWWx0SfXALJx7Mr+45+MTiQLyUeSXdN+GTSi7mfHcWDxWBQcF/18UjbMCN
         rbd9FVZg6rYasCpBhztmyV8bcS8rC2RLMVzVrtv7YW2mi0TvXJmo+aZUW+9TCw6F1Skn
         9sYStnta4/oxeYU2D3GwSo5S7JyEy3kIb4Z9vW0IGJZXhQ1pD1nJ7PA1rGWeuRPL34o2
         hv9w==
X-Gm-Message-State: AOJu0YywAKwHNoqOymzwBu8hPXMMFBaUGyWWLwV8kP/uzIReVvthn+41
	5u7z1STIpVObPO1PoCa9iC188/ntVH+mrpLdgq4nJ/LlxHCzuU7GLD2JvYKbbg==
X-Gm-Gg: AeBDietou5h1nWpFW+6uMjKGtPeacnkTjMZHQDzhPQcZtNn50ET+WnYfGMGqyGaIGaf
	3YXliJulJqHuOFnEV3HOvIBarPZdtVdHfB87iQhpjC8PZtE7TrZjqMOmxOlzXyLWYrN3HwfoRdQ
	lGCxmFa09AMcSAcGKSIqm0/zItJ3WZi/WzXkkflOxYsqzdNcR4tH2R8hE6UBDDWpB14gpIgDbtr
	Vei4rCJGQSDDxpfA7zrrk1YjpcZ3oySBPZ2QKez4Y9DmAW4GPISyrt4/Zv0HQKst7QRvtXBBRIp
	NbOMpERsdwhV3Gig10omdYcvjuLKnKsfix8MxbuJNHqoNOFQntfu4tBM48yY1JsK4fDmT5N6jay
	i758ykEtaSx9gliDc03YXH0TMZPnjhdVJOa7Rtl75+R+gMQIajD3QcLd+WYFYaRDRxFwkv6ivQZ
	yQz5qZdbsjOXl7EzQPHN9m/EQ/D3MZgcP8MG6/Ku9W6VF+XavpjQUjU+qXR/t+BRQYytcQuCcI8
	+k8szn55dzIWVeBXvCAPWJMcpb8aQ==
X-Received: by 2002:a05:6214:dc2:b0:89c:6ba4:e306 with SMTP id 6a1803df08f44-8badccc7defmr68134906d6.43.1778003078650;
        Tue, 05 May 2026 10:44:38 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5391e3636sm161817896d6.13.2026.05.05.10.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:44:38 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <clark.williams@gmail.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 7/9] rteval: Rename unittest target to unit-tests for consistency
Date: Tue,  5 May 2026 13:43:51 -0400
Message-ID: <20260505174410.169442-8-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505174410.169442-1-jkacur@redhat.com>
References: <20260505174410.169442-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the Makefile target from 'unittest' to 'unit-tests' to match
the naming convention of other test targets (e2e-tests, regression-tests).

Changes:
- Rename unittest: to unit-tests:
- Update test: alias to tests: for consistency (all targets use plural)
- Update help text to clarify tests is an alias for unit-tests
- Update .PHONY declaration

This provides consistent naming across all test targets:
- make tests            (alias for unit-tests)
- make unit-tests       (unit tests)
- make e2e-tests        (end-to-end tests)
- make regression-tests (regression tests)

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 5e429b41e1b4..eab950775d8d 100644
--- a/Makefile
+++ b/Makefile
@@ -45,11 +45,11 @@ sysreport:
 	[ -d $(HERE)/run ] || mkdir run
 	$(PYTHON) rteval-cmd -D -v --workdir=$(HERE)/run --loaddir=$(HERE)/loadsource --duration=$(D) -i $(HERE)/rteval --sysreport
 
-unittest:
+unit-tests:
 	@echo "Running unit tests..."
 	./run_tests.sh
 
-test: unittest
+tests: unit-tests
 
 clean:
 	rm -f *~ rteval/*~ rteval/*.py[co] *.tar.bz2 *.tar.gz doc/*~
@@ -88,8 +88,8 @@ help:
 	@echo "rteval Makefile targets:"
 	@echo ""
 	@echo "        runit:            do a short testrun locally [default]"
-	@echo "        test:             run unit tests"
-	@echo "        unittest:         run unit tests (same as test)"
+	@echo "        tests:            run unit tests (alias for unit-tests)"
+	@echo "        unit-tests:       run unit tests"
 	@echo "        e2e-tests:        run end-to-end tests"
 	@echo "        regression-tests: run regression tests for measurement modules (requires root)"
 	@echo "        tarfile:          create the source tarball"
@@ -109,4 +109,4 @@ tags:
 cleantags:
 	rm -f tags
 
-.PHONY: test unittest e2e-tests regression-tests
+.PHONY: tests unit-tests e2e-tests regression-tests
-- 
2.54.0

