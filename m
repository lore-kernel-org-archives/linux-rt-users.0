Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2732C9D
	for <linux-rt-users@vger.kernel.org>; Sat, 12 Jul 2025 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752327761; cv=none; b=VmVD6fJ8fI2m6X8Wnmou4FgzBk+tqh7XkRMvrQDNB/PTYVDlmkeyugJnnLxAQj3Z2RwbbXYI+AwojA2GeErFxNIxFN+SQDIHqVOwrmytzHfHR4aNL1kbqhCjws0k7nA5Zj0EMg8VUK4nX0gJ4GvcTFQ4LX/qroD8DvUBsk4PScI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752327761; c=relaxed/simple;
	bh=iSZM65ViLYNNffdcBJisW7U2YoGIyi2C/gK3NBRkNPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p64xcRGTQNzL+h666HCG9E6SzFFfnAGJR8TGfPl9jpfhgDmehaZLcK1wLSAqoUOMUUWkkiaIw+RNnHpppyELBeXSbbYDS9vHo9PgWkriHC4bp/+QxTpUA0MsvaS4hbDfRJ4MuYXTYfZvNSHnE2VrmnQxVbu0obqGAP38ebDZCL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kN6/3iwF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kN6/3iwF"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-235ef62066eso43346505ad.3
        for <linux-rt-users@vger.kernel.org>; Sat, 12 Jul 2025 06:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752327759; x=1752932559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+FDrOTNUUyln3ayJPJo58Gevz4lshTWFGEcDT6Pak6k=;
        b=kN6/3iwFzoNvZl49lY4SR44TCtJskxn47FDeEayZcAAMmp698eA4Z1g8GolaTP33E2
         3vUGILV17YjR/kwMVvPg/Ilx9zcozFAs+oWsQTHZ0KDNz/bqL4kcP52GZwrEXOocHrLS
         muMMudQdohYAQ19Xitc1iVNbGSh1L/56xgrg4RhJ9e3iNFGIv6Cs6Qab6cE4nqPMLIvw
         OUq23h15cWi8ofxeuQ96IWKBjYaYpt+TRvgQ3cstqzPG2O5TgX1wFiA/nMd1v0TdEqye
         HrlCDIP/6QOiqSSe1Nu1wvCp4xcYyoKKWPVVWYK3yMRn8JhvBsMfEzKYzOlMyJN3lAgt
         0B3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752327759; x=1752932559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FDrOTNUUyln3ayJPJo58Gevz4lshTWFGEcDT6Pak6k=;
        b=mEAy/mQbkcgtlk70o8DtrtsgeQ5Ww1iyTyM5jZnFxd4rWwBwR0sldbr6/feQVuUlbx
         3kd8W35goEAy+9KpLKx7YIXjJarJdx0MFflFFKX4K5vQbaOuay/LEN0LiGXmjI8v3+GZ
         MBQRqBwcNnUf51JuU/IC+Z0GpxrL+mfheoaMo8xl0/mdnP2EaSlW6NAPq+of1rvIjo6a
         amKePoxPm83m0J20i+4WJsO7kDZpmJ7aKr++QVvZZJ+L959w9rxRMEMSxJ9rlL6NhYZ1
         LhWI15eC+JlseLCJryHXOJbSJhatmwNoIc+ax9tt3D81tqkXNl08IGGrxbuFFm57T806
         rxRQ==
X-Gm-Message-State: AOJu0YzLoa/3ya2lUjRKB4U83F+PZSRh14VZiEnn1MZEPuEdSYx2aKtW
	RdTPP1kQE1MebdigjQ5IHkvCkweWLXb2ZWIavwdXbRdmFI9SD5MIbfNR8zzwJrdHWj8=
X-Gm-Gg: ASbGnctXVJCKPmaKkk3la7zkN+33uU2h3A/j+LC4fP1597z57JzI1kFQRW1xdgbY/Mu
	JZSWTsSBXycbIL7bJ7cBzuWayCReYQbvzerL7Ysfm64N12LZZV1YDRFrpuWax/dIi28DoGfp2jZ
	V89/Yj80gLr3TtaxTc7hyCev15GeI/Tf4KZJlNabJI2yeFfZF7mN+kxJPoZJTTkzKqjSjcJ3pYT
	hTXr9u4YeDdtDHstItGOojr2mw175seBGTC/4v50qvTtE6vlAbFRl+31gcNrt7Cd/+bcbMngOU7
	zH5xTqnvQ2nd3U/wpie0UUdTuimwYe8IvqXJtrkIeSDH2H+ZHUZjiUTyrAybCdWvS3o4+0D2PyN
	m2L8+xfnpe8Id908h6kmIAIVRCSnX3R4JvBwbjDfKontLiayCSAyy
X-Google-Smtp-Source: AGHT+IGf9P3POvJkKcQjPfgDJeCq9erAqBPtLQfdb3AZt/grZSGjF4JI8Q2ULb4fd64IpXJdwtXt4A==
X-Received: by 2002:a17:903:2f87:b0:235:e9fe:83c0 with SMTP id d9443c01a7336-23dede81d56mr122015025ad.27.1752327759291;
        Sat, 12 Jul 2025 06:42:39 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:90c1:8214:37cf:b3e5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ae865sm64193205ad.72.2025.07.12.06.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 06:42:39 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: williams@redhat.com,
	jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 0/8] Fix -Wunused-result warnings by checking return values
Date: Sat, 12 Jul 2025 21:42:05 +0800
Message-ID: <20250712134213.58582-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds proper error checking to functions such as write(),
ftruncate(), and system(), whose return values were previously ignored.

These warnings were treated as errors under -Werror due to the
__attribute__((warn_unused_result)) annotation. Instead of suppressing
them with compiler flags, this series addresses each call site directly
to improve code robustness and clarity.

A full list of compiler warnings fixed in this series is available at:
  https://gist.github.com/EricccTaiwan/a78d6f1950d3cba27be757e405b6626a

Tested on Ubuntu 25.04 (GCC 14.2.0, glibc 2.41).

Thanks.

-chengyang

---

Cheng-Yang Chou (8):
  rt-utils.c: Suppress warning
  pmqtest.c: Suppress warning
  ptsematest.c: Suppress warning
  rt-migrate-test.c: Suppress warning
  cyclicdeadline.c: Suppress warning
  deadline_test.c: Suppress warning
  sigwaittest.c: Suppress warning
  svsematest.c: Suppress warning

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

