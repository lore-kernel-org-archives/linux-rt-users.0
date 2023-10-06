Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3C53B28E
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 20:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEHqDEee"
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35DF83
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 13:04:15 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-7741c2e76a3so152393385a.1
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Oct 2023 13:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696622654; x=1697227454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8EUQFngGRPxXgmPI7a/2AWRCEGawT7JEWVMNf/9QP1k=;
        b=YEHqDEeek/ChVuip/QGS3v1mT1LSUZubEIdDwJdIFfTn0YJ9mXcsHM17gqFFdaDVe7
         Sm5H06omGe3EYqH62AqVFQ2oKD0lsCJEghhoqnrhWZjVlwau40B2ObE5SVfmIaDuNqvN
         Kq4ESmOlx9Pn5OrqZlNFCFmyzt1LOChHzBIXcQ1U1zX060AhcrwZ9/wnuJ+jH4tllRHn
         /bncta+4Kjg9oAHrd3F88ISaoFF6dr3q8HBRex/QhhvQLReY7ZS1Vdu/+3H9twnpXA3i
         c4ZMZiZCBVtrROhFuH8CsWtoV60/t45VhIozI+m6ZMBQcXuT+j5LGPjzOiMlzbj0somP
         u2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696622654; x=1697227454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EUQFngGRPxXgmPI7a/2AWRCEGawT7JEWVMNf/9QP1k=;
        b=AlHrnQK9cnaUSTdoaGZ9Ks+AL3HOIvIoafzSolhdNo0T5KYISxwpum75A2lfLhaSbn
         e7e61JYjvv7ArQv1KZ9JXvCVSmMQdAlKxB5bVkCXEYLZU7p89mAq4a6wrj/1hpbIPkCP
         KfkBgDHuGhrtZqmcTvo5lcxup9Z/4O66aIRzfcxdPgzmbUzJusSpUkuOM8Rc9Ptd5cmz
         hYg5KeJlifO8WukEWsbEmVCdhhlxegSES4QBZc8dSnZ/WsQ7RpzCR+KiLT00gxxiEqrV
         mhvTM2I1llnmQjXM4z0vIrizK0o+FfWfl0eMu4OH9CzjTevhmiR708PSU5UTdKulYdhs
         E/6A==
X-Gm-Message-State: AOJu0YwEHoWEjpxc7IZql3o+ZJsAkhVP1j0pJO9dQtLiV1TXvp7s5iL+
	Blue7o2wzCbNVN8nY5aQ8c21UetGhxw=
X-Google-Smtp-Source: AGHT+IEXAV/il9oY+L90lpTBQvcreOoUB039mswqOVnNkoO3QnNaDEyJplvmk4q5TEcods4+sgLS/A==
X-Received: by 2002:a05:620a:3728:b0:76d:5126:65d8 with SMTP id de40-20020a05620a372800b0076d512665d8mr9500023qkb.6.1696622654352;
        Fri, 06 Oct 2023 13:04:14 -0700 (PDT)
Received: from fionn.redhat.com ([174.88.88.29])
        by smtp.gmail.com with ESMTPSA id a12-20020a05620a102c00b007759a81d88esm1541311qkk.50.2023.10.06.13.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:04:13 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Kate Carcia Poulin <kcarcia@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] rt-tests-2.6
Date: Fri,  6 Oct 2023 16:03:45 -0400
Message-Id: <20231006200345.53658-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I am pleased to announce rt-tests-2.6

Clone one of the following
git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://kernel.googlesource.com/pub/scm/utils/rt-tests/rt-tests.git

Branch: main
Tag: v2.6

Tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests

Older version tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests/older

Anubhav Shelat (3):
  cyclicdeadline: removed unnesessary text in usage message
  cyclicdeadline: removed extra pthread_barrier_wait() calls
  rt-error: added conditional to info() and debug()

Costa Shulyupin (1):
  rt-tests: hwlatdetect: Add field cpu to samples output

Eder Zulian (2):
  rt-tests: Add __pycache__/ to .gitignore
  rt-tests: cyclictest: Remove warnings due different signedness in
    comparison

John Kacur (20):
  rt-tests: deadline_test: Fix spelling to "single" in comment
  rt-tests: Makefile: Use sysconfig instead of distutils for PYLIB
  rt-tests: oslat: Fix compile warnings
  rt-tests: cyclictest: Suppress unused parameters warning
  rt-tests: ssdd: Suppress unused parameters warning
  rt-tests: queuelat: Suppress unused parameters warning
  rt-tests: cyclicdeadline: Suppress unused parameter warning
  rt-tests: svsematest: Suppress unused paramters warning
  rt-tests: pip_stress: Removed unused parameter
  rt-tests: sigwaittest: Fix some warnings
  rt-tests: rt-migrate-test: Fix some warnings
  rt-tests: signaltest Fix unused parameter warning
  rt-tests: cyclicdeadline: Fix comparison of different signedness
  rt-tests: cyclictest: Fix comparison of different signedness
  rt-tests: rt-utils: Suppress warnings about fallthrough
  rt-tests: rt-numa: Fix comparison of different signedness
  rt-tests: pi_stress: Fix various warnings
  rt-tests: pmqtest: Fix various warnings
  rt-tests: ptsematest: Fix unused paramter warnings
  rt-tests: Change to version v2.6

Marcelo Tosatti (2):
  cyclictest: remove inclusion of unnecessary headers
  oslat: remove newline from tracemark message

 .gitignore                            |  1 +
 Makefile                              |  4 +--
 get_pylib.py                          | 16 +++++++++++
 src/cyclictest/cyclictest.c           | 29 +++++++++----------
 src/hwlatdetect/hwlatdetect.py        |  5 ++--
 src/include/pip_stress.h              |  2 +-
 src/include/rt-error.h                |  4 +--
 src/lib/rt-error.c                    | 28 ++++++++++--------
 src/lib/rt-numa.c                     |  2 +-
 src/lib/rt-utils.c                    |  5 +++-
 src/oslat/oslat.c                     | 25 +++++++++-------
 src/pi_tests/pi_stress.c              | 14 ++++-----
 src/pi_tests/pip_stress.c             |  6 ++--
 src/pmqtest/pmqtest.c                 |  9 +++---
 src/ptsematest/ptsematest.c           |  9 +++---
 src/queuelat/queuelat.c               |  2 +-
 src/rt-migrate-test/rt-migrate-test.c |  6 ++--
 src/sched_deadline/cyclicdeadline.c   | 41 ++++++++++++++-------------
 src/sched_deadline/deadline_test.c    |  2 +-
 src/signaltest/signaltest.c           |  4 +--
 src/sigwaittest/sigwaittest.c         |  6 ++--
 src/ssdd/ssdd.c                       |  4 +--
 src/svsematest/svsematest.c           |  7 ++---
 23 files changed, 129 insertions(+), 102 deletions(-)
 create mode 100755 get_pylib.py

-- 
2.40.1

