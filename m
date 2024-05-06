Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413F8156C6E;
	Mon,  6 May 2024 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715027382; cv=none; b=aFVk454dIDhhkz6nFb3Nx4jPw6jVBkOVm1vV+aWvYuaX+zoVyl6arLVJtXM6c1oE+0bvb6f4Gk8NKDxeBOyiGfNf6sx5JGzrUpuqgaxR67GchDZIoAQaOowES4wMdALveZiVqnwISqWvNyxM0lHntyl1s2rNKK90c+9c1M9ZtKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715027382; c=relaxed/simple;
	bh=bDrH6w40P+otkeBcYrqIj9oL3tv73q29bNAfkNbebWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GSPHOlnxnuZsZyoIGq9H4EzWXUZCTJsczB67SZYpb4GgW4hzeGNYjh2tew3bVHNp4/9CB+iwTDKeCJCJF78DlpIJaXZIdQvr6pQGyxcjdI4ahMCgcWH7di+4k1Jf28shjAXKj8ATdd2ddYmwIY9pGV9FdbXFM+NAo7CSfn30xMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+wMTed8; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+wMTed8"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-61b68644ab4so21673257b3.0;
        Mon, 06 May 2024 13:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715027378; x=1715632178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Ry0EQOM3NwD6cVbYTHzhP9B94zYhZSGZbQGTNOWQPdM=;
        b=Q+wMTed8TEN5cQ1U5N/+g6GQL6f0Shyn9F4khyh3VSu8G9DQggd9F9oOE1IHBc4Cqi
         KfCwzGSn097fOsDUwy8hPxb2TT7noiLwtlXEQOaxtRlEdG9cwPsFRQcC/An1NAtU0uEW
         CmbuikroPtyyF7WWIUIRZDy3crc7ujETFHA2sAlYT5OuEws/wxgyrjYptBix3PQMvaPg
         97stQh73nt4bNYWtbYfpWaZuqkq28xPE+dAisAxIke0WdBXOydom2mJ/6RehQQNVUK4p
         VlupuQjGJSJyAHFnC+8GxlJV0CtoO2vo91OMNDZc8WyCKkId8Bi2AVN80xzmmLQr/tOb
         D2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715027378; x=1715632178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ry0EQOM3NwD6cVbYTHzhP9B94zYhZSGZbQGTNOWQPdM=;
        b=to8Mi9G02V3YZnlKOmn0LpUgyMrudjqsyPvseHNrchdfS6/pX1f4ULRiuEyod4KR87
         7PQ9vwDZH2wVcaTa5g6oWpljCOY6GCJr6fo3t0aZbipHeOxtgJ8tYRCb8Q79/K84Y7Kk
         FDoXAq3o+wzvwTHjznaYRrbrpVFcPd7184MT/YJWj1hqwGDgSX80F4EF5UeMYgF7raLG
         mGvMGSB+Sd0fvaUXsPgJ6PFAFdUab0vT8Tzmm1MF5I6zo3EfpkLAnEaBALXtYHSrxywJ
         mg1AY/1lN75Sx9RvD3ZYjs4AWwXgLynFIy4uKziuLMCcYo+Zuf99g9nQn0/WCnzPAZpa
         N3fA==
X-Forwarded-Encrypted: i=1; AJvYcCUIwUElwwkdcFWwcdbgbSQbfTPjy8nHv63Y7lKkB1RnynavR06UpbIEZvATHv3BOP+68pumWBTXl48t3ZPUM6eFG8N0wlNKwA3/WQcC
X-Gm-Message-State: AOJu0Yz63YzHMhc9PUOUAKAJmdg9kQjoI7YcI5pUJHJFAvTT3pMJkCEI
	xWsREw59klT2qUxOtrCq+NEbRgxj8frGt6icdin4NigzPOn/HDmLFADZfEXC
X-Google-Smtp-Source: AGHT+IE+l6JMLRLjcoPHufQQff/zc5z7tmmg36Asm3DP/t7BrxgGiEmWDP/fZWpTTahGqvlPFX/tiA==
X-Received: by 2002:a05:690c:3811:b0:615:6d2c:2cf6 with SMTP id jx17-20020a05690c381100b006156d2c2cf6mr12192659ywb.47.1715027378111;
        Mon, 06 May 2024 13:29:38 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-16-74-12-5-183.dsl.bell.ca. [74.12.5.183])
        by smtp.gmail.com with ESMTPSA id ju1-20020a05622aa04100b004399f2d06d1sm5481473qtb.74.2024.05.06.13.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 13:29:37 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Daniel Bristot de Oliveria <bristot@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Lucie doskova <ldoskova@redhat.com>,
	Kate Carcia Poulin <kcarcia@redhat.com>,
	Chris White <chwhite@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: ANNOUNCE rteval-3.8
Date: Mon,  6 May 2024 16:29:14 -0400
Message-ID: <20240506202914.49968-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I am pleased to announce version 3.8 of rteval

Some highlights.
- Chris White has added a Dockerfile
- Crystal added a number of changes to make development more pleasant
  for short test runs by decreasing startup times
- I've added timerlat as a new measurement module
- Tomas has added relative cpulists for measurement and load modules.
  This means you can add or subtract cpus from the default list instead
  needing to specify the entire list.

Bug reports and patches are always welcome.

Enjoy!

John Kacur

To fetch:

Clone
git://git.kernel.org/pub/scm/utils/rteval/rteval.git

Branch: main
Tag: v3.8

Tarballs available here:
https://kernel.org/pub/linux/utils/rteval

Older version tarballs are available here:
https://kernel.org/pub/linux/utils/rteval/older

Chris White (2):
  rteval: Add interactive source-to-image Dockerfile
  rteval: Add Dockerfile README

Crystal Wood (6):
  rteval: default_config_search: Return None on failure
  rteval: kcompile: Fix path lookups in _remove_build_dirs
  rteval: Break out of main loop faster on interrupt/stoptime
  rteval: Remove 30 second "settling" period
  rteval: Use -j with make mrproper
  rteval: cyclictest.py: reduce: Fix exception with missing samples

John Kacur (17):
  rteval: Change the default kernel for kcompile to linux-6.6.1
  rteval: Remove upstream spec file
  rteval: systopology: Fix incorrect test to invert a cpulist
  rteval: Makefile: More rpm cleanups
  rteval: Disable use of python-dmidecode
  rteval: More formatting using f-string changes for readability
  rteval: Cyclictest.py: Make standalone file work again
  rteval: Add rtla timerlat as a measurement module
  rteval: cyclictest.py: Fix the description in the xml report
  rteval: cyclictest.py: Remove unused method sample
  rteval: cyclictest.py: Fix the median calculation
  rteval: timerlat.py Add statistics and generate xml
  rteval: Add summary reporting for timerlat
  rteval: Generate raw histogram data for an existing timerlat report
  rteval: Use get instead of setdefault for calculating range
  rteval: stress-ng: Use inherited method to set exclusive module
  Create rteval-3.8

Tomas Glozar (8):
  rteval: Refactor collapse_cpulist in systopology
  rteval: Minor improvements to CpuList class
  rteval: Convert CpuList class to a module
  rteval: Add relative cpulists for measurements
  rteval: Implement initial dmidecode support
  rteval: Remove XML-RPC server
  rteval: Add relative cpulists for loads
  rteval: Make output work with new dmiinfo format

 .dockerignore                            |    1 +
 .gitignore                               |    5 -
 Dockerfile                               |   69 ++
 Makefile                                 |   65 +-
 README                                   |    6 -
 README-Dockerfile                        |   49 +
 doc/installing.txt                       |    9 -
 doc/rteval.8                             |    6 -
 doc/rteval.txt                           |   18 +-
 rteval-cmd                               |   48 +-
 rteval.conf                              |    1 +
 rteval.spec                              |  484 ----------
 rteval/__init__.py                       |   40 +-
 rteval/cpulist_utils.py                  |  161 ++++
 rteval/modules/__init__.py               |   81 +-
 rteval/modules/loads/__init__.py         |    8 +-
 rteval/modules/loads/hackbench.py        |    9 +-
 rteval/modules/loads/kcompile.py         |   22 +-
 rteval/modules/loads/stressng.py         |   10 +-
 rteval/modules/measurement/__init__.py   |   11 +-
 rteval/modules/measurement/cyclictest.py |   96 +-
 rteval/modules/measurement/sysstat.py    |    2 +-
 rteval/modules/measurement/timerlat.py   |  383 ++++++++
 rteval/rteval.conf                       |    2 +-
 rteval/rtevalConfig.py                   |    3 +-
 rteval/rtevalMailer.py                   |   51 -
 rteval/rtevalXMLRPC.py                   |   97 --
 rteval/rteval_histogram_raw.xsl          |   29 +-
 rteval/rteval_text.xsl                   |  117 ++-
 rteval/rtevalclient.py                   |   60 --
 rteval/sysinfo/__init__.py               |    2 +-
 rteval/sysinfo/dmi.py                    |  178 ++--
 rteval/systopology.py                    |  226 +----
 rteval/version.py                        |    2 +-
 server/COPYING                           |  339 -------
 server/INSTALL                           |  302 ------
 server/Logger.py                         |   19 -
 server/Makefile.am                       |   38 -
 server/README.xmlrpc                     |  201 ----
 server/apache-rteval-wsgi.conf.tpl       |   22 -
 server/apache-rteval.conf.tpl            |   18 -
 server/configure.ac                      |  130 ---
 server/database.py                       |  238 -----
 server/gen_config.sh                     |   14 -
 server/parser/Makefile.am                |   30 -
 server/parser/README.parser              |  204 ----
 server/parser/argparser.c                |  140 ---
 server/parser/argparser.h                |   21 -
 server/parser/configparser.c             |  171 ----
 server/parser/configparser.h             |   25 -
 server/parser/eurephia_nullsafe.c        |   54 --
 server/parser/eurephia_nullsafe.h        |  103 --
 server/parser/eurephia_values.c          |  301 ------
 server/parser/eurephia_values.h          |   48 -
 server/parser/eurephia_values_struct.h   |   38 -
 server/parser/eurephia_xml.c             |  147 ---
 server/parser/eurephia_xml.h             |   43 -
 server/parser/log.c                      |  228 -----
 server/parser/log.h                      |   43 -
 server/parser/parsethread.c              |  370 --------
 server/parser/parsethread.h              |   38 -
 server/parser/pgsql.c                    | 1093 ----------------------
 server/parser/pgsql.h                    |   58 --
 server/parser/rteval-parserd.c           |  533 -----------
 server/parser/rteval-parserd.init        |  126 ---
 server/parser/rteval-parserd.sysconfig   |   23 -
 server/parser/sha1.c                     |  615 ------------
 server/parser/sha1.h                     |   66 --
 server/parser/statuses.h                 |   33 -
 server/parser/threadinfo.h               |   38 -
 server/parser/xmlparser.c                |  620 ------------
 server/parser/xmlparser.h                |   75 --
 server/parser/xmlparser.xsl              |  607 ------------
 server/remove_rtevalrun                  |   65 --
 server/rteval-parser.spec                |  133 ---
 server/rteval_testserver.py              |  107 ---
 server/rteval_xmlrpc.py                  |   71 --
 server/rteval_xmlrpc.wsgi                |   94 --
 server/rtevaldb.py                       |   57 --
 server/sql/delta-1.0_1.1.sql             |   15 -
 server/sql/delta-1.1_1.2.sql             |    9 -
 server/sql/delta-1.2_1.3.sql             |    6 -
 server/sql/delta-1.3_1.4.sql             |    6 -
 server/sql/delta-1.4_1.5.sql             |   31 -
 server/sql/rteval-1.0.sql                |  189 ----
 server/sql/rteval-1.1.sql                |  203 ----
 server/sql/rteval-1.2.sql                |  207 ----
 server/sql/rteval-1.3.sql                |  208 ----
 server/sql/rteval-1.4.sql                |  209 -----
 server/sql/rteval-1.5.sql                |  235 -----
 server/testclient.py                     |   37 -
 server/testclient_sendreportfile         |   36 -
 server/unittest.py                       |   91 --
 server/xmlrpc_API1.py                    |  100 --
 unit-tests/unittest.py                   |    1 -
 95 files changed, 1107 insertions(+), 10566 deletions(-)
 create mode 100644 .dockerignore
 create mode 100644 Dockerfile
 create mode 100644 README-Dockerfile
 delete mode 100644 rteval.spec
 create mode 100644 rteval/cpulist_utils.py
 create mode 100644 rteval/modules/measurement/timerlat.py
 delete mode 100644 rteval/rtevalMailer.py
 delete mode 100644 rteval/rtevalXMLRPC.py
 delete mode 100644 rteval/rtevalclient.py
 delete mode 100644 server/COPYING
 delete mode 100644 server/INSTALL
 delete mode 100644 server/Logger.py
 delete mode 100644 server/Makefile.am
 delete mode 100644 server/README.xmlrpc
 delete mode 100644 server/apache-rteval-wsgi.conf.tpl
 delete mode 100644 server/apache-rteval.conf.tpl
 delete mode 100644 server/configure.ac
 delete mode 100644 server/database.py
 delete mode 100755 server/gen_config.sh
 delete mode 100644 server/parser/Makefile.am
 delete mode 100644 server/parser/README.parser
 delete mode 100644 server/parser/argparser.c
 delete mode 100644 server/parser/argparser.h
 delete mode 100644 server/parser/configparser.c
 delete mode 100644 server/parser/configparser.h
 delete mode 100644 server/parser/eurephia_nullsafe.c
 delete mode 100644 server/parser/eurephia_nullsafe.h
 delete mode 100644 server/parser/eurephia_values.c
 delete mode 100644 server/parser/eurephia_values.h
 delete mode 100644 server/parser/eurephia_values_struct.h
 delete mode 100644 server/parser/eurephia_xml.c
 delete mode 100644 server/parser/eurephia_xml.h
 delete mode 100644 server/parser/log.c
 delete mode 100644 server/parser/log.h
 delete mode 100644 server/parser/parsethread.c
 delete mode 100644 server/parser/parsethread.h
 delete mode 100644 server/parser/pgsql.c
 delete mode 100644 server/parser/pgsql.h
 delete mode 100644 server/parser/rteval-parserd.c
 delete mode 100755 server/parser/rteval-parserd.init
 delete mode 100644 server/parser/rteval-parserd.sysconfig
 delete mode 100644 server/parser/sha1.c
 delete mode 100644 server/parser/sha1.h
 delete mode 100644 server/parser/statuses.h
 delete mode 100644 server/parser/threadinfo.h
 delete mode 100644 server/parser/xmlparser.c
 delete mode 100644 server/parser/xmlparser.h
 delete mode 100644 server/parser/xmlparser.xsl
 delete mode 100755 server/remove_rtevalrun
 delete mode 100644 server/rteval-parser.spec
 delete mode 100644 server/rteval_testserver.py
 delete mode 100644 server/rteval_xmlrpc.py
 delete mode 100644 server/rteval_xmlrpc.wsgi
 delete mode 100644 server/rtevaldb.py
 delete mode 100644 server/sql/delta-1.0_1.1.sql
 delete mode 100644 server/sql/delta-1.1_1.2.sql
 delete mode 100644 server/sql/delta-1.2_1.3.sql
 delete mode 100644 server/sql/delta-1.3_1.4.sql
 delete mode 100644 server/sql/delta-1.4_1.5.sql
 delete mode 100644 server/sql/rteval-1.0.sql
 delete mode 100644 server/sql/rteval-1.1.sql
 delete mode 100644 server/sql/rteval-1.2.sql
 delete mode 100644 server/sql/rteval-1.3.sql
 delete mode 100644 server/sql/rteval-1.4.sql
 delete mode 100644 server/sql/rteval-1.5.sql
 delete mode 100644 server/testclient.py
 delete mode 100755 server/testclient_sendreportfile
 delete mode 100644 server/unittest.py
 delete mode 100644 server/xmlrpc_API1.py

-- 
2.44.0

