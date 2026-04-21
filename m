Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B95535F185
	for <linux-rt-users@vger.kernel.org>; Tue, 21 Apr 2026 18:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776796007; cv=none; b=efyvEdAnLgUU1zZZkQbtEqaiMcF2za8gg4TZlRckC5S0cdWdxPdVmj0VSQ4ajXrLN/2vwBVJSaC2kZV5jZaxkD38K3fdzTuQJYtff1cS1aGB7SUjgPbCy0v+wneiEJPXB2lPM4SXy3ABcnB+ULDWX4hgy9CpdnvtiTGZqHcMwG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776796007; c=relaxed/simple;
	bh=/A3YophDKUXKG5VrOXY87TZiIWWBSrF6l6ehFOFVyic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UtirAzUla5C+hEH5kjMqZ9IJA8e7Kqglgctl25XTzkp48NC8792GXqpsziDReCeaxKbwY9S4MAt2MYN3ghUvhfFV9AMxLBwQOPKFchH+u9Y6BwMETzqkr0mk9QcHJgeah0aIsYEannNtw7yF+xZ8TpARbmP0A5GLt7t+EAJJ4XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjaOKkgx; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjaOKkgx"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8d4f78fc9f6so495744985a.3
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Apr 2026 11:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776795993; x=1777400793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=XuRN65UX6oYHRRdTSUEsoyHneMjcUnijZKnL2k9erko=;
        b=IjaOKkgxmPX76L4bf+7wU7gzqQ0XJGbiET8w3CWCG9oHlYmrdPynwya21Xce1ToOVX
         +wUa7ZyP5vm7Kd/KuvNPstnxgNQ4a9kzh8Vstyk/nnkXn3RVRayGEaQJpxTw7FvmKRhe
         hWbbnvww/BZ8YNtONeLYODA/xvFZoWhbyONbNbUyrmPkXOPuxQLHs+8i76+nG1EJpbiH
         ObfEQTCIgr9DjAQTGV7cCgEA8gUUQvIWI+yOQoAXIRIe3dEAu6vx5fnQO+Y4Ea3hn0hp
         4h65PpGaymhgsI54ruA5YX6PHjlbGEIT8yzqdNhIKcVr54H49MaaRi0YR8S7hd5QaPhQ
         Ii9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776795993; x=1777400793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuRN65UX6oYHRRdTSUEsoyHneMjcUnijZKnL2k9erko=;
        b=pbES/eeQC2B9BKQQhYx++y+3+8+MKwfGr3zFDHEDyOyAGFngsrui1LWz2DcgJF7eWx
         DbZ/CgLw/bDSrse8EfSUuWBJtx+deWBjR3s18wEoxKLa2v8iul5elmHxWyuuKfaFNpZY
         LBLp+l+hosVSyxd1RoH0w8+rHylcu2Gt1Uf5SHJ4xAazNuq/QqC049WT0W+lPwdstoR9
         uitHGKveYCKza2WBE63vat01uopJHc1DGpLqsYe10nbLkKPn6C5rsuo9c5tkKjIbvGl/
         dOsgwlXnSrtDEs+wwAmSJaryXXgaSJnzzLWinGMkEB98wBsCPnDCiKxGgCzKFED3Ld+l
         7rYQ==
X-Gm-Message-State: AOJu0YwX2n9lInZNTmNysGECGTxyRdKldQtH3XP0euo1GOELj4Xf2kmS
	3NLm7qyGj5cHsJDO92x55APjSQNiXhVNnHzSg1MsDLpwT53bts54JjBVvTUBLw==
X-Gm-Gg: AeBDievhpN8UMBBGK/3BHCIzo/jZ2gGFaX4CAs6SjNARwUhQ9R+O7actthUoFm1DTkA
	R3y0zAhq0UMGOmZdbKoOWaEOgYsp3BQ0n1DHTK5/9aOmpzcTyHdnM+D38tCp//lRXyyO3mbZOmH
	84iQt8LMAhJQEjmLhEFfhaVrB+pLIvXH7fOJldlfx3BL8OH3tqJcPPKIrMNLwFazvxVft7wfeIA
	J3KeXzk7kDiBWX8Y/KsB8AUZha3UEuM8VDXjWiH/Sg93sAnUm2eEXoR69XZPETbHzclLgzd5yNc
	YPNGSmkAAdMxCVqejXO+V2ohCU8yVhHZm3k4d2QVDZLLAWetShzj/TLUmGSV6raytwWmmu3weco
	4i24CjAsQ0gD5zriosirUHNCE57FpMWgQ5JnsMyxeX/I1AamcXB5aA0z13d1U10a7jn67KYwOAX
	Sy8X6pNtDMqqa3YZRVtbxb8FqP2gs7vg9LNXf9Kw06RKaIKyB022gGhfx6f2fdWeNdFhPjew7Iq
	eR14tBUj/F3t4qOLjwpIjaIP5SOItmpcYXtTIjUBYVhNVizDghPdS+R6vmGkCwIksg9/TizwWTb
	+sY5xRbAGzvZH6tb/jM=
X-Received: by 2002:a05:620a:28d1:b0:8d7:3f45:b95f with SMTP id af79cd13be357-8e78fb18dc2mr2626832585a.16.1776795992823;
        Tue, 21 Apr 2026 11:26:32 -0700 (PDT)
Received: from Cumhall.redhat.com (bras-base-rdwyon0604w-grc-03-216-209-112-32.dsl.bell.ca. [216.209.112.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d64caf37sm1112713685a.11.2026.04.21.11.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 11:26:32 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 0/7] Core sharing validation for CPU isolation
Date: Tue, 21 Apr 2026 14:26:11 -0400
Message-ID: <20260421182618.261347-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds validation to detect and warn when CPUs sharing
physical cores (SMT siblings) are assigned to different workload types,
which can defeat CPU isolation and corrupt real-time measurements.

When SMT/hyperthreading is enabled, CPUs sharing a physical core also
share L1/L2 caches, execution units, TLB, and other core-level resources.
Running different workload types (housekeeping, measurement, load) on
sibling threads defeats CPU isolation and can create unreproducible
results.

The series implements:

1. CoreSiblings class - Provides a simple interface for querying which
   CPUs share physical cores by reading thread_siblings_list from sysfs.
   Works with any SMT configuration (1-way, 2-way, 4-way, 8-way).

2. Core sharing validation - Detects when isolated CPUs share cores
   between housekeeping, measurement, and load groups. Warnings are
   logged to console and included in XML reports.

3. XSLT integration - Warnings appear in text reports generated with
   the -Z option via a CoreSharingWarnings section.

4. Optional stricter validation - --warn-non-isolated-core-sharing
   flag enables warnings for measurement vs load CPU pairs even when
   neither is isolated, for users who want maximum isolation assurance.

The validation is purely informational - it warns users but does not
prevent execution, allowing informed decisions about CPU configurations.

Testing includes comprehensive scenarios with both isolated and
non-isolated CPU configurations, verified with real isolated CPUs.

John Kacur (7):
  rteval: Add CoreSiblings class for CPU core topology queries
  rteval: Add core sharing validation for CPU isolation
  rteval: Include core sharing warnings in XML report
  rteval: Add temporary test for core sharing validation with mocked
    isolated CPUs
  rteval: Display core sharing warnings in text report
  rteval: Add --warn-non-isolated-core-sharing option for measurement vs
    load warnings
  rteval: Include --warn-non-isolated-core-sharing warnings in XML
    report

 rteval-cmd                     |  18 +++-
 rteval/rteval_text.xsl         |  13 ++-
 rteval/sysinfo/__init__.py     |   3 +
 rteval/sysinfo/coresiblings.py | 116 +++++++++++++++++++++++++
 rteval/sysinfo/cputopology.py  |  35 ++++++++
 rteval/systopology.py          |  64 ++++++++++++++
 test_full_validation.py        | 151 +++++++++++++++++++++++++++++++++
 7 files changed, 398 insertions(+), 2 deletions(-)
 create mode 100644 rteval/sysinfo/coresiblings.py
 create mode 100644 test_full_validation.py

-- 
2.53.0

