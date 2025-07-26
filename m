Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF342D052
	for <linux-rt-users@vger.kernel.org>; Sat, 26 Jul 2025 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753521526; cv=none; b=eImlsPkhNPaaN/qpyNHuIfqhNH/Xq6hhpyKzVtwlqJNpC0Zr6uj+sfQwE/02Csk25E+3cWAG7zMdv2xFNBUpknUB3+nmxU3wi34NTQ6iqXdlEgUb/7UnIiyGY7RRnvPza+4p8ZGy+WqTRzteOfB+LCOwMxsSkiHkZ+4Ff0UnXFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753521526; c=relaxed/simple;
	bh=TinAafR7WPrIgoGFDjbEIiamKOnDgJayObhvvajIdd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mMN++rcIcKFbm2ef5kwxlu7oMPiMO/gouvJAA+OZSpoE/9Vr2607Rvt02GVpsEHLG81mYjuRlwabLH5EA4Ig8qrP8KgOHyY9Pe9hikCBZvKILlxGgV189iAVpJpPqIpuQIkJxUKWLtNdTB6qW31hBQAoCNVQjFSeqwQdh6nhcZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQHzF5Ow; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQHzF5Ow"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3139027b825so2452070a91.0
        for <linux-rt-users@vger.kernel.org>; Sat, 26 Jul 2025 02:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753521524; x=1754126324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HUkek/YB4uQcM4GmSDr/TxnHNI3PV2LrgYZ710sWuTQ=;
        b=DQHzF5OwW2qOY8s1VI3cpyqtQSifPloISyy6VjrRWN9oJ3Ui2kHISQqtoTI08/cfdp
         +bE+3JJo0VI4wR8Qq+AfJ1v6a4Kd99sYbYionH3YbbhPqjMFHQGsPPqdzTYpJtGRR+/V
         lfq0i8o7qH4g78Lksw7d2Jm6yql2D4RcJ7r+7y/9Qi/RpYFnhyxfmMu9YEKo6cMH/6/1
         lTVdHeLhjeieVRIZGx2EKf2b3vQjlrxC8mI/B/Osa+2AITNhp9/hzEzL36JVb+SPF6qq
         6bHZEjIPl1W3O9AfUojdTGLEHA1gwHuhgU9bGwB1MgArHjyQUjzdE5+L0c3MkjkuYo0m
         hG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753521524; x=1754126324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HUkek/YB4uQcM4GmSDr/TxnHNI3PV2LrgYZ710sWuTQ=;
        b=f51ZfJyYGjcl5mi7deZisEYynjjAmVXoFcu4bDL6v14rdShH/TZ+8sF/hoZNVmJWfK
         eTYUMFTBr0HldeEoZsCqrFDG05wKEXbJ17lRkFcZZrUDumEb5kMLNJbMCROonB8kt1ff
         4F+Xr/67+g49AJjjjKtmxGtZIXVZZBiZDuiKfwo3NyRboj+/o19xFRXF2uKzgofeiLPZ
         cpb1hu66aaxrTWV7ylbSALO7R56Zrzlm+bhMUw1MZHyCqRygHtQNWcTGKPOL42Fi+nl1
         xXw5q1ikcK261urjHgH7YCR/2ynTQJQ4CPUNwu92j12sVVqzpF6bZjklYc8hbMTc0yn6
         XbSg==
X-Gm-Message-State: AOJu0YxlwN+spxWNCk0voURu//IclnUo4TKu1tzRyJ3Tcvmtp1De3AAm
	i8xKeA1atAPU0GBRTeJuii8ncWE/7h5LkgBTHPcQqmvnKKQ3SErIDbZ7
X-Gm-Gg: ASbGnctjZI9P5tgMau4r5tRKMjx/WbId+FMnUlVASfqKBGnQWqpqmghDqnHRzyKxY9J
	iFVTfQIgOWUEymVi1e2PnDHcwnODcMrWVX/7KSsyKXicUDAsbMSEyqMluZrJqJAtEBRPWD+QieI
	JhQDVs+5leZAqlP6i1QKZfpQNAsvLGmE2uRahXJmeOZTIG0LXdwLSZamUI8aaA5m1yauaWAHETD
	MNkgyxhqXED0htFvUDji+Xj1/kuhEVisvnZ2M7j/W+DJ6duUaJ+TyI6u/iMghdvdMFNtX190i2k
	8nvq61/ZerzLU2ka/0ZBcd9J4/upri6l8wW0x4c+L7wbZmdKPWBI52dylrwstxBD92LtWz/gwoj
	31VPeqK4MkImK6PPYcUTVaonGiMtQEIqv8mya1K+9Jo5KABamGhKN
X-Google-Smtp-Source: AGHT+IGSK8pMmRu20n7mrIqzJ8/jv+/DXUjx8agkU1gkyrvTeHywaKMYuJmhDu8BsRa4Pt3MJcAntw==
X-Received: by 2002:a17:90b:4b4c:b0:311:e8cc:4264 with SMTP id 98e67ed59e1d1-31e7785eed2mr7134219a91.12.1753521523709;
        Sat, 26 Jul 2025 02:18:43 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:3fec:e266:6de8:8b66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f569d24sm1295025a12.1.2025.07.26.02.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 02:18:43 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: williams@redhat.com,
	jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH v2 0/8] Fix -Wunused-result warnings by checking return values
Date: Sat, 26 Jul 2025 17:18:29 +0800
Message-ID: <20250726091837.493915-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This v2 series adds proper commit messages and addresses coding style
warnings previously reported by checkpatch.pl.

All patches have been verified with checkpatch.pl and show no errors
or warnings.

Changes in v2:
 - Add commit messages to all patches
 - Ensure all patches pass checkpatch cleanly
 - Link to v1: https://lore.kernel.org/all/20250712134213.58582-1-yphbchou0911@gmail.com/

Thanks,
-chengyang

---

Cheng-Yang Chou (8):
  rt-utils.c: Check return values of write()
  pmqtest.c: Check return values of write() and ftruncate()
  ptsematest.c: Check return values of write() and ftruncate()
  rt-migrate-test.c: Check return values of write() and ftruncate()
  cyclicdeadline.c: Check return values of write() and ftruncate()
  deadline_test.c: Check return values of write() and ftruncate()
  sigwaittest.c: Check return values of write() and ftruncate()
  svsematest.c: Check return values of write() and ftruncate()

 src/lib/rt-utils.c                    |  9 +++++--
 src/pmqtest/pmqtest.c                 |  6 ++++-
 src/ptsematest/ptsematest.c           |  6 ++++-
 src/rt-migrate-test/rt-migrate-test.c |  5 +++-
 src/sched_deadline/cyclicdeadline.c   | 32 +++++++++++++++++++----
 src/sched_deadline/deadline_test.c    | 37 +++++++++++++++++++++++----
 src/sigwaittest/sigwaittest.c         | 13 ++++++++--
 src/svsematest/svsematest.c           | 13 ++++++++--
 8 files changed, 102 insertions(+), 19 deletions(-)

-- 
2.48.1

