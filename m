Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811F1277C86;
	Tue,  1 Jul 2025 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751381012; cv=none; b=KMBeEalvDMRTLAyFVyXdmuOKDESM81WpufQ1f6VDo6Fe7m9qKcUSNqD6ylsHHJrLlMjI328lpraZ0j8e1gnSWiq5t4A1m7CsZu1d2ZsHRaOkwPw2TxW0VGOCk4jTFjdHrJtNjLsVfvDuRpHigp6DWvLhQPQF6ituFRf975zzUtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751381012; c=relaxed/simple;
	bh=pHL/Qk22Rw/qWZR+v/CC9PbQbrDdfVYiZ3CevAfJu1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FYO4pojCa60dsHlJ8TyaefP3PdiliYxkZRkCN6yIJ8dMXDVwq71hGd9HWpmZE/7yVt4yZuHPSgq+O9AbVNkl/+yCkVsOioF/neXu0Dc9wXXcsero2qQZ2RekL9pHN2ngpZXhtzQxdPXQQNRxJy/3T+Ihmw39ye15Fw6ph0Z91DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=df2HB1NL; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="df2HB1NL"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7d3f5796755so530201985a.1;
        Tue, 01 Jul 2025 07:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751381007; x=1751985807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=xcWIGIvdCiX2uQmJI1Lhl0kixwPO/7xNgHt4UXZ8/Jw=;
        b=df2HB1NLdLUVl9CKgKD2NyUnc7cEEQyRfeK9edASlfOg6BPzkxBo6wpOA2+YvpKJyw
         za1y3Xs/xyke5i2ulziRmqtL5O86WF2eUX5uQCnyuh7SYNDnBYhA47Wuf50FULdUaZYQ
         Pb5Ulq6MQq9nozy9R9PKFbz8URHs5CPvb/PB8e8Mi/SQ59kjzOL+K+hjeMmg7whM6iqi
         Eys7uOVcWRTtOdfyLQ9zn/mvfhtb9Gy8bdM7W3WgeDLZWOFqXfpwgTU4cXuHfNR4ogTo
         StRMPVpZUY4HKwKjhJ/cgWI4uq7Xrcy+Ms0YtVrSIpAmrSzCbU7WRwI231/bdX8zous9
         dnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751381007; x=1751985807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcWIGIvdCiX2uQmJI1Lhl0kixwPO/7xNgHt4UXZ8/Jw=;
        b=DE0Iu5Tidjb+QZjGBcNGYXFyZRM3q4+VkYxo4vj2AVRub6TCKSZTsQF0bkaZ0+5qA5
         ErGolDVAbSaW6mD3ubKkA8N05CkhcyyYhT9f6bwBz5VOqtiLsgNSs0VWU5A4NTJrNbBP
         z33q3S+a483KAUWoKe/3GizfckQ/+OyPmcYsXez0/yo4FuemSIih3F6oOoHjZPgCkcRw
         O6FpLiIpiiceeaEQloTpv7BSchApLBNfp89aNCYSqiFa7kGb4Vyefm1ilTX4+DDbsbVm
         xdeb/2xzBZEk0VUtFPX+pxQm9tNJyl4YTp3vt0o+ctfCWLnbCtw7oFVXQ+SW52KVcxe9
         5eFw==
X-Gm-Message-State: AOJu0YwIgZ44PoicoKdcCcLd5sqkAHz3J0V/UFBUV89p5+3fvMhFbiaw
	B9CkEU0rwMJFA0RXFTzwFI+k4lfsZMrr/kQqTfUEBFcCJBPtyifAOy4DYtP2ag==
X-Gm-Gg: ASbGncsluGGdg3HBmBfyvqD/zZCimFLgDWVbJsiSKKhQJmg1fkukRDESuD/Tjwcf8kd
	VD4Q4gXuM9XKkZWzAcxK/GVcl8w+9pQIigAywiYTHFGcrMfQGlBYSA+tq7X3pchor8hniROD8ZO
	7Q0tJy7BllIck8WA4ZgXStaOaiocv/ESVwHkDi8DC8+7EGVkpuneL/QozBlYjPKRYDjQ3Ue3WZD
	/VqMU8+5iHjF+r3VI0iSZ62zwqB5RbMbbJInzJyzavtOTYZwWxeyaf6F/g+gm0lg1aRxP5o/wTx
	3e4sjlM1ywdMi18OHkTmr/zFm78LsfUTTg/zDPSKfIQLm9LuA4YlDyCsH+NhbxXu
X-Google-Smtp-Source: AGHT+IGunkHC4NtsY2M0lv/LhYLeUdoVJlKWE1bVLj9BVbU0aKhxKNLbEFfSUIj8l50fqJZaizfJTg==
X-Received: by 2002:a05:620a:27c6:b0:7c5:3c0a:ab7e with SMTP id af79cd13be357-7d443909f4amr2528147385a.5.1751381007486;
        Tue, 01 Jul 2025 07:43:27 -0700 (PDT)
Received: from fionn.redhat.com ([76.71.123.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d45ac68268sm384041785a.68.2025.07.01.07.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 07:43:26 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
	Clark Williams <williams@redhat.com>,
	Tyonnchie Berry <tyberry@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] rt-tests-2.9
Date: Tue,  1 Jul 2025 10:43:06 -0400
Message-ID: <20250701144306.32234-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are pleased to announce rt-tests-2.9

To fetch:

Clone one of the following
git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://kernel.googlesource.com/pub/scm/utils/rt-tests/rt-tests.git

Branch: main
Tag: v2.9

Tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests

Older version tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests/older

Thanks to everyone who contributed
patches, bug-reports are always welcome

Cheng-Yang Chou (1):
  Makefile: Use -Wno-error=unused-result

Costa Shulyupin (1):
  rt-tests: hwlatdetect: Add a grouping separator to tracing_cpumask

Crystal Wood (3):
  rt-tests: Turn off -Wunused-parameter
  rt-tests: Enable -Werror
  rt-tests: Remove unused parameter annotations

John Kacur (4):
  rt-tests: cyclicdeadline: Fix usage for duration
  Revert "Fix rt-tests build with glibc-2.41"
  rteval: pi_stress: Change PRIu64 to llu to match upstream sched_attr
  Makefile: Use -Wno-error=format-truncation=

Khem Raj (1):
  sched_attr: Do not define for glibc >= 2.41

Shizhao Chen (1):
  rt-tests: pip_stress: Add option --usleep

Tomas Glozar (2):
  rt-tests: Put variables in test-feature in quotes
  rt-tests: Handle -lcpupower flag outside LDFLAGS

Yaakov Selkowitz (1):
  Fix rt-tests build with glibc-2.41

 Makefile                              |  6 +++---
 feature/test-feature.mak              |  2 +-
 src/cyclictest/cyclictest.c           | 11 +++++------
 src/hwlatdetect/hwlatdetect.py        |  7 ++++++-
 src/include/rt-sched.h                | 10 +++++++---
 src/oslat/oslat.c                     |  4 ++--
 src/pi_tests/pi_stress.c              |  6 +++---
 src/pi_tests/pip_stress.8             |  6 +++++-
 src/pi_tests/pip_stress.c             | 10 ++++++++--
 src/pmqtest/pmqtest.c                 |  7 +++----
 src/ptsematest/ptsematest.c           |  7 +++----
 src/queuelat/queuelat.c               |  2 +-
 src/rt-migrate-test/rt-migrate-test.c |  4 ++--
 src/sched_deadline/cyclicdeadline.c   |  4 ++--
 src/signaltest/signaltest.c           |  2 +-
 src/sigwaittest/sigwaittest.c         |  4 ++--
 src/ssdd/ssdd.c                       |  2 +-
 src/svsematest/svsematest.c           |  5 +++--
 18 files changed, 58 insertions(+), 41 deletions(-)

-- 
2.49.0

