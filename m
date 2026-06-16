Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C527B3BFE5A
	for <linux-rt-users@vger.kernel.org>; Tue, 16 Jun 2026 18:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634231; cv=none; b=b8wC/KW3yP5UEm0rvhcND1m1BpaEXFO5THpMWDBnbiB0UAjRMf0bVlS2u5ZQUdoQbEw+zFWzxpM2zoDfaIR/ctljPRaky1+zA8A1njSuLwzsZ45zpPkREKjnDrMIi260aXZGoT/kNwKW0it+HjWJDqywTDbR8UKRq6qM+KrelhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634231; c=relaxed/simple;
	bh=0G6TExASI4ZYVfMLbex1rqmIDoJbxLPT5iHrdQpQeOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HPGaN7/SzuJcO36RuE4yJItZCI3I1i9gRaaQT6HATLCV+2hrAANgynyhECYK7BF7gcpHz84lyR77zCZ5uLufwVhUINIuSWqxlhFypS+5jkRzNVHZagY87Hgdpgc4IN5jCvv8boVa4ROvDdOcZ9bZXz1141Cgz2SUY1enxW+Xq0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jP+vUfiN; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jP+vUfiN"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5178a42caa3so1445311cf.1
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Jun 2026 11:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781634228; x=1782239028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+EbcMPgV8gygv5r0PAOtLgwEhJ/wXSI2218Eha+dl6A=;
        b=jP+vUfiN2OgqjMb+/bbOEgf3mk/FmyCumbYfWkSdWlPzYcnT2vw/IwtjX8Gb7j1iWm
         fubl/hxAW/yDYGGolZA2IUtc7LLZzrfFx0eUWc4d/9JfqNBmikQyl6zC9gNkxoPuyGOv
         xe4Rjfzsg3jYkH7J1t86P/4Pi5HgExM252ZBbrV/3ERwXnFL86pDhj5bJU13VV27Y/PE
         1DP9N4try55+jl2iMSgdlYonRr9SG3+ZS1Fpjhv6/DYUVifutOag91Iz3p0yN5i8CSfT
         zS88lIrsRSyxeQodZR6dEv7RfL4BVbA0fhtYqrZitjkhirJ2QE5N6sE19/Ysoi/BQFBL
         tUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781634228; x=1782239028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EbcMPgV8gygv5r0PAOtLgwEhJ/wXSI2218Eha+dl6A=;
        b=MStc7kxZXr0F6S7VoE36+mQ1bucmZ7xvXVJahXdmS8GnA7tkTuN2qg6dioic2NGiKY
         f6ohy8wgC44Q+y9V9OmOCKbjS8uAJb5hTKYqVUCfWxfOWG1q9JACUgV1GrcdKUFIDVBn
         UdxFK2vpkZ4KcS/luXoRTD8aZALST6n5YOk3FsXC9jCnimgo+NgSlHJm+scIAfrgPby6
         av98F3r9E6AdwC33sto9EM1a+Jx2VItsclLvCaVio84H9UD/I7mqWr9rNind8nURzfu8
         XJvaaP1U4lqfXr6GLaTqTXDGJcsMQyANRsYIpbnCvuH//He/v7DoXPetawb8ChfYf4bV
         X8Wg==
X-Gm-Message-State: AOJu0Yzg4871VP5vLFvWCg2sYMLlkV/uqs6A+/1fBv3ke+zG3kMix5hw
	gBPhHVZ4VVYvQecVXBJC5Bnao0GqW8oTANDbmf0YxOnNcPmOfvYvLsm1YlO6fw==
X-Gm-Gg: Acq92OHB2DsuszjAAjpETNLQYGlW0LJ7DJVexImT0DTHp0tpVfACZGJfPYC2UU8qMmZ
	PMY0h62TrRem4TqTRwYB3ZpX7q3lSEIRYnrLbE3FprWIj8CMk3XBB99nrDh4SABK9nIxYK7jy37
	geYfS83Vw5hQKxMzlebdVQEnfQpLcReiLdw4bYP8rK2F7VCc4mDbr1YWcq1eagysBs31c83iyc9
	zTcxanWe8Hg6Jnmk4kIdlDyKUeV5wMNYRit6v21sZg5OYwSaJtgUHF0rIAvjtMSqD3iY5v1dP8u
	baMRl/8u9MC/k0P4/LBgnY+lTrYEeAOyQQGlbvszuhuH8EUmHYS/b26wroc7wrhk2HHBJ9BNIWO
	EoA4Lg0+z9n1SnyOxAMMOwg02vtsNQJP9A7yTS30dlZuDtd1CL2YK/hwcJyHymT8jDzupU5bbWr
	GUAiYjdeNYWaGpZsL5x8UZXB6xx23AQkwlEVOduQoLHZOGwUs/AuQOQG9potdpZOZpBP+US6Ik/
	L8/ZRnyPcqE5DWTSKqerjJH98vGiyQyBhMkhM5LoMzCQa9Rr0n6LkWQWHAdq1nZWfxulUadK/wr
	bABvZZy7
X-Received: by 2002:a05:622a:1e9a:b0:516:35fe:5524 with SMTP id d75a77b69052e-5198de0f2bcmr62397271cf.5.1781634228512;
        Tue, 16 Jun 2026 11:23:48 -0700 (PDT)
Received: from Cumhall.redhat.com (bras-base-rdwyon0604w-grc-03-216-209-112-32.dsl.bell.ca. [216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb544533sm145389911cf.0.2026.06.16.11.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 11:23:48 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Subject: [PATCH 1/2] tuna: Update copyright notices to reflect current maintainership
Date: Tue, 16 Jun 2026 14:23:31 -0400
Message-ID: <20260616182338.310541-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update copyright notices in core tuna files to add John Kacur as
copyright holder for the period 2015-2026, reflecting the current
maintainership of the project. Arnaldo Carvalho de Melo's original
copyright is preserved.

Changes made to:
- tuna-cmd.py: Main command-line interface
- tuna/__init__.py: Core tuna module
- tuna/gui/__init__.py: GUI initialization module

The copyright format has been updated to use single line per copyright
holder for clarity.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py          | 4 ++--
 tuna/__init__.py     | 3 ++-
 tuna/gui/__init__.py | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index d83e57732360..293044920223 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -2,8 +2,8 @@
 # -*- python -*-
 # -*- coding: utf-8 -*-
 #   tuna - Application Tuning GUI
-#   Copyright (C) 2008, 2009, 2010, 2011 Red Hat Inc.
-#   Arnaldo Carvalho de Melo <acme@redhat.com>
+#   Copyright (C) 2008-2011 Arnaldo Carvalho de Melo <acme@redhat.com>
+#   Copyright (C) 2015-2026 John Kacur <jkacur@redhat.com>
 #
 # SPDX-License-Identifier: GPL-2.0-only
 
diff --git a/tuna/__init__.py b/tuna/__init__.py
index 614e3e4c7ed8..2dd132b98268 100755
--- a/tuna/__init__.py
+++ b/tuna/__init__.py
@@ -1,5 +1,6 @@
 """
-Copyright (c) 2008, 2009 Red Hat Inc.
+Copyright (c) 2008-2009 Arnaldo Carvalho de Melo <acme@redhat.com>
+Copyright (c) 2015-2026 John Kacur <jkacur@redhat.com>
 
 Application Tuning GUI
 """
diff --git a/tuna/gui/__init__.py b/tuna/gui/__init__.py
index a40f86292e6f..4ecefcf8cad5 100755
--- a/tuna/gui/__init__.py
+++ b/tuna/gui/__init__.py
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 """
-Copyright (c) 2009  Red Hat Inc.
+Copyright (c) 2009 Arnaldo Carvalho de Melo <acme@redhat.com>
+Copyright (c) 2015-2026 John Kacur <jkacur@redhat.com>
 
 Application Tuning GUI
 """
-- 
2.54.0

