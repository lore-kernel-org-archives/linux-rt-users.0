Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501B929415
	for <linux-rt-users@vger.kernel.org>; Tue,  3 Oct 2023 16:52:56 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717179E
	for <linux-rt-users@vger.kernel.org>; Tue,  3 Oct 2023 09:52:54 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-65b162328edso6601386d6.2
        for <linux-rt-users@vger.kernel.org>; Tue, 03 Oct 2023 09:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696351973; x=1696956773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=j3hmNPSrsT2h5lRTa3Pb49GXuaROWcAVdjwyYbsIhME=;
        b=Nd9j9pTqjyHN4LQR7WNbKGDblDLcGiZ2pfpQqbK9Q5VJMP63DSoIDcdPB+K3bYCb3m
         vilmqkVjerhjNV5IEbwvTVM1hti7C5QpM6fz9c88QaxYtGoEEpBcz9mvQYIQNXLfS8OI
         ZBYbBlhyvlO1vjCEYpXtXRFXPIqA8BwTe5veoD31R6+AZo1YNhglvv+cdZBDaWr3qC2h
         LL7cfp4u6+/vH44cSA5j9EDBp8UzoqWEf0Vjj716wvh49QwK9v1nLR7hvRtlyQgY3Kq5
         n434mzVjhWrr0JJ2g6fJcNFKMxCwgTZxOas1uj6T5WGTw9ehNGf+Z/k5HFWJVMWkHT0+
         z6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696351973; x=1696956773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3hmNPSrsT2h5lRTa3Pb49GXuaROWcAVdjwyYbsIhME=;
        b=hnNRJycGTkozzL4FYdMPytRi/PHWgEp/WmpjL1V883F1a+726cBd8xeeWthfx/7C2B
         RPM+u45oIzgj0xaL9cve9//KLy9djl1SU+D9ZWzrSxa3YP4hpDSoYu3zj4CqINpw3JFF
         qUiYBGV3mIdkWSxGtKud6i4BdZAervU7yp398S5aD05xfNwRCKrpVTfA9FQ3YWzU0OEj
         MnkYDp7KfyFKSujhMC5u7OLDhC9dI1aGwB1fUo5SG5A7ujQfCBWT9iMoR64Zw0r6BH8U
         UGKPRtga+Lqzo8GNur1hCQUOn9zeZTcF9ce3jiqXO0+LfoJ3hRvh5UMXnynVyIuG72Y3
         /sjg==
X-Gm-Message-State: AOJu0Yw2gZ5gNe76B+YHmmHWGgFWPZ0MrBmgfvWpuC8zAkz8kUZXw2oP
	vlsmIGiwKwORnzgHd1LeGz4TDCBaXks=
X-Google-Smtp-Source: AGHT+IE4R5OwQ/MZ1UQMSnSXKQ0bqnKadsHzEufRhoAez7Hwuf96NlLSd/qwNEEgWfP94q4zMkFJDg==
X-Received: by 2002:a0c:aa08:0:b0:647:42ac:d7f2 with SMTP id d8-20020a0caa08000000b0064742acd7f2mr11615638qvb.63.1696351973004;
        Tue, 03 Oct 2023 09:52:53 -0700 (PDT)
Received: from fionn.redhat.com ([174.88.88.29])
        by smtp.gmail.com with ESMTPSA id d6-20020a0cf0c6000000b006583270ea64sm615774qvl.139.2023.10.03.09.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:52:52 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Kate Carcia Poulin <kcarcia@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] rteval-v3.7
Date: Tue,  3 Oct 2023 12:52:36 -0400
Message-Id: <20231003165236.22558-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,URI_NOVOWEL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I am pleased to announce version 3.7 of rteval

Some highlights
- You can use rteval to download the kernel for the kcompile load module.
- deprecated optparse was replaced with argparse
- SPDX License-Identifiers
- isolcpu fixes
- Addition of --measurement-run-on-isolcpus, to run the measurement
  modules on automatically detected isolated cpus
- Various fixes

Thanks to everyone who participated!

John Kacur

To fetch

Clone
git://git.kernel.org/pub/scm/utils/rteval/rteval.git

Branch: main
Tag: v3.7

Tarballs available here:
https://kernel.org/pub/linux/utils/rteval

Older version tarballs are available here:
https://kernel.org/pub/linux/utils/rteval/older


Anubhav Shelat (17):
  rteval: Use f-strings in rtevalclient.py
  rteval: Use f-strings in rtevalConfig
  Added code to check if the proc/net/if_inet6 file exists while loading
    IPv6 addresses in the IPv6Addresses class
  rteval: Use f-strings in cputopology
  rteval: Use f-strings in kernel.py
  rteval: Use f-strings in memory.py
  rteval: Use f-strings in osinfo
  rteval: Use f-strings in services.py
  rteval: Use f-strings in tools.py
  rteval: osinfo.py: Added code to use 'sos report' instead of
    sosreport.
  rteval: Changed files to use argparse library instead of optparse
  rteval-cmd: added code to handle downloading kernel versions of the
    x.x
  rteval: added code to download default kernel version if no version is
    specified
  rteval: fixed comments
  rteval/server: edited files to use optparse instead of argparse
  Fixed bug in kcompile where run would fail if kcompile-source version
    had the form x.y instead of x.y.z
  Edited code from previous commit to exclude try-except block

Eder Zulian (1):
  rteval: Add SPDX-License-Identifier to rteval

John Kacur (3):
  rteval: Fix the unit test in osinfo
  rteval: return empty string in compress_cpulist for an empty list
  rteval: Update version to v3.7

Tomas Glozar (11):
  rteval: Detect isolcpus in systopology
  rteval: Report isolated CPUs
  rteval: Exclude isolcpus from kcompile by default
  rteval: Exclude isolcpus from stressng by default
  rteval: Fix CPU count calculation for hackbench
  rteval: Exclude isolcpus from loads report
  rteval: Add missing docstrings in SysTopology
  rteval: Correct Python version in doc/rteval.txt
  rteval: Allow arguments specific to module group
  rteval: Add run_on_isolcpus option to measurements
  rteval: Support run-on-isolcpus in cyclictest

 Makefile                                 |   1 +
 doc/rteval.txt                           |   2 +-
 rteval-cmd                               | 119 ++++++++++++-----------
 rteval.spec                              |   2 +-
 rteval/Log.py                            |  21 +---
 rteval/__init__.py                       |  21 +---
 rteval/modules/__init__.py               |  51 +++-------
 rteval/modules/loads/__init__.py         |  23 +----
 rteval/modules/loads/hackbench.py        |  27 ++---
 rteval/modules/loads/kcompile.py         |  33 ++-----
 rteval/modules/loads/stressng.py         |   6 ++
 rteval/modules/measurement/__init__.py   |  38 +++-----
 rteval/modules/measurement/cyclictest.py |  33 +++----
 rteval/modules/measurement/sysstat.py    |  21 +---
 rteval/rtevalConfig.py                   |  29 +-----
 rteval/rtevalMailer.py                   |  21 +---
 rteval/rtevalReport.py                   |  21 +---
 rteval/rtevalXMLRPC.py                   |  21 +---
 rteval/rteval_dmi.xsl                    |   1 +
 rteval/rteval_histogram_raw.xsl          |   1 +
 rteval/rteval_text.xsl                   |   5 +
 rteval/rtevalclient.py                   |  23 +----
 rteval/sysinfo/__init__.py               |  21 +---
 rteval/sysinfo/cmdline.py                |   1 +
 rteval/sysinfo/cputopology.py            |  36 +++----
 rteval/sysinfo/dmi.py                    |  21 +---
 rteval/sysinfo/kernel.py                 |  25 +----
 rteval/sysinfo/memory.py                 |  29 +-----
 rteval/sysinfo/newnet.py                 |  29 +++---
 rteval/sysinfo/osinfo.py                 |  43 +++-----
 rteval/sysinfo/services.py               |  33 ++-----
 rteval/sysinfo/tools.py                  |  23 +----
 rteval/systopology.py                    |  72 ++++++++++----
 rteval/version.py                        |  23 +----
 rteval/xmlout.py                         |  21 +---
 server/Logger.py                         |   1 +
 server/Makefile.am                       |  21 +---
 server/apache-rteval-wsgi.conf.tpl       |  21 +---
 server/apache-rteval.conf.tpl            |  21 +---
 server/configure.ac                      |  21 +---
 server/database.py                       |  21 +---
 server/gen_config.sh                     |   1 +
 server/parser/Makefile.am                |  21 +---
 server/parser/argparser.c                |   9 +-
 server/parser/argparser.h                |   9 +-
 server/parser/configparser.c             |  15 +--
 server/parser/configparser.h             |  15 +--
 server/parser/eurephia_nullsafe.c        |  15 +--
 server/parser/eurephia_nullsafe.h        |  15 +--
 server/parser/eurephia_values.c          |  14 +--
 server/parser/eurephia_values.h          |  15 +--
 server/parser/eurephia_values_struct.h   |  15 +--
 server/parser/eurephia_xml.c             |  15 +--
 server/parser/eurephia_xml.h             |  15 +--
 server/parser/log.c                      |   9 +-
 server/parser/log.h                      |   9 +-
 server/parser/parsethread.c              |   9 +-
 server/parser/parsethread.h              |   9 +-
 server/parser/pgsql.c                    |   9 +-
 server/parser/pgsql.h                    |   9 +-
 server/parser/rteval-parserd.c           |   9 +-
 server/parser/statuses.h                 |   9 +-
 server/parser/threadinfo.h               |   9 +-
 server/parser/xmlparser.c                |   9 +-
 server/parser/xmlparser.h                |   9 +-
 server/parser/xmlparser.xsl              |  15 +--
 server/remove_rtevalrun                  |  37 ++-----
 server/rteval_testserver.py              |  33 ++-----
 server/rteval_xmlrpc.py                  |  21 +---
 server/rteval_xmlrpc.wsgi                |  21 +---
 server/rtevaldb.py                       |  21 +---
 server/sql/delta-1.0_1.1.sql             |   1 +
 server/sql/delta-1.1_1.2.sql             |   1 +
 server/sql/delta-1.2_1.3.sql             |   1 +
 server/sql/delta-1.3_1.4.sql             |   1 +
 server/sql/delta-1.4_1.5.sql             |   1 +
 server/sql/rteval-1.0.sql                |   1 +
 server/sql/rteval-1.1.sql                |   1 +
 server/sql/rteval-1.2.sql                |   1 +
 server/sql/rteval-1.3.sql                |   1 +
 server/sql/rteval-1.4.sql                |   1 +
 server/sql/rteval-1.5.sql                |   1 +
 server/testclient.py                     |  21 +---
 server/testclient_sendreportfile         |  31 ++----
 server/unittest.py                       |   9 +-
 server/xmlrpc_API1.py                    |  21 +---
 setup.py                                 |   1 +
 unit-tests/unittest.py                   |  14 +--
 88 files changed, 346 insertions(+), 1186 deletions(-)
 mode change 100755 => 100644 unit-tests/unittest.py

-- 
2.40.1

