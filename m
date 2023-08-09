Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780B5C0015E
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Aug 2023 19:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbjHITY7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbjHITYn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2023 15:24:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89E62D70
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 12:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691608566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NBoUEPKuh6j+J2bDjgPsfwG7IR35x/1Z8xZvelysyQM=;
        b=VtXPlmCO9mgypfYgRyQeWzhvxvT5j3FAh4/hY4AMDa11UMuYYq/9VOPh32ZGCF+6sZqRl8
        Ny9Zm6UQRdE4cE+CH1mj4l47/QcLO/2NDHu4vW0aFWYL6VyYOVTDQqcBn/PkOQ34Zm96CK
        CR3K+WO1HLXWhR+aYKscmy6XiNrJTN4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-o3kcgsqIMdKrfIQ5N-yJBA-1; Wed, 09 Aug 2023 15:16:04 -0400
X-MC-Unique: o3kcgsqIMdKrfIQ5N-yJBA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C0BB8DC670
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 19:16:04 +0000 (UTC)
Received: from ezulian.remote.csb (unknown [10.39.192.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EBCAB40C6E8A;
        Wed,  9 Aug 2023 19:16:02 +0000 (UTC)
From:   Eder Zulian <ezulian@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, williams@redhat.com, ezulian@redhat.com
Subject: [PATCH 00/86] Use SPDX-License-Identifier tags
Date:   Wed,  9 Aug 2023 21:14:22 +0200
Message-Id: <20230809191548.359938-1-ezulian@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This patch series adds SPDX-License-Identifier tags to files and removes existing GPL boilerplate when appropriate.

The following files have not changed.
server/parser/README.parser
server/parser/rteval-parserd.sysconfig
server/parser/rteval-parserd.init
server/parser/sha1.c
server/parser/sha1.h
server/README.xmlrpc
server/rteval-parser.spec

The 'SPDX-License-Identifier: GPL-2.0-only' tag has been added to the following files.
server/parser/argparser.c
server/parser/argparser.h
server/parser/log.c
server/parser/log.h
server/parser/parsethread.c
server/parser/parsethread.h
server/parser/pgsql.c
server/parser/pgsql.h
server/parser/rteval-parserd.c
server/parser/statuses.h
server/parser/threadinfo.h
server/parser/xmlparser.c
server/parser/xmlparser.h

As the following files did not contain direct license references they fell under the project license, i.e., GPL v2 or later.
Makefile
rteval/modules/loads/stressng.py
rteval/rteval_dmi.xsl
rteval/rteval_histogram_raw.xsl
rteval/rteval_text.xsl
rteval/sysinfo/cmdline.py
rteval/sysinfo/newnet.py
server/Logger.py
server/gen_config.sh
server/sql/delta-1.0_1.1.sql
server/sql/delta-1.1_1.2.sql
server/sql/delta-1.2_1.3.sql
server/sql/delta-1.3_1.4.sql
server/sql/delta-1.4_1.5.sql
server/sql/rteval-1.0.sql
server/sql/rteval-1.1.sql
server/sql/rteval-1.2.sql
server/sql/rteval-1.3.sql
server/sql/rteval-1.4.sql
server/sql/rteval-1.5.sql
server/unittest.py
setup.py

For the remaining files, the GPL boilerplate has been replaced by the 'SPDX-License-Identifier: GPL-2.0-or-later' tag.


Eder Zulian (86):
  rteval: Add SPDX-License-Identifier tag to Makefile
  rteval: Add SPDX-License-Identifier tag to stressng.py
  rteval: Add SPDX-License-Identifier tag to rteval_dmi.xsl
  rteval: Add SPDX-License-Identifier tag to rteval_histogram_raw.xsl
  rteval: Add SPDX-License-Identifier tag to rteval_text.xsl
  rteval: Add SPDX-License-Identifier tag to cmdline.py
  rteval: Add SPDX-License-Identifier tag to newnet.py
  rteval: Add SPDX-License-Identifier tag to Logger.py
  rteval: Add SPDX-License-Identifier tag to gen_config.sh
  rteval: Add SPDX-License-Identifier tag to delta-1.0_1.1.sql
  rteval: Add SPDX-License-Identifier tag to delta-1.1_1.2.sql
  rteval: Add SPDX-License-Identifier tag to delta-1.2_1.3.sql
  rteval: Add SPDX-License-Identifier tag to delta-1.3_1.4.sql
  rteval: Add SPDX-License-Identifier tag to delta-1.4_1.5.sql
  rteval: Add SPDX-License-Identifier tag to rteval-1.0.sql
  rteval: Add SPDX-License-Identifier tag to rteval-1.1.sql
  rteval: Add SPDX-License-Identifier tag to rteval-1.2.sql
  rteval: Add SPDX-License-Identifier tag to rteval-1.3.sql
  rteval: Add SPDX-License-Identifier tag to rteval-1.4.sql
  rteval: Add SPDX-License-Identifier tag to rteval-1.5.sql
  rteval: Add SPDX-License-Identifier tag to unittest.py
  rteval: Add SPDX-License-Identifier tag to setup.py
  rteval: Replace GPL license notice with SPDX tag in rteval-cmd
  rteval: Replace GPL license notice with SPDX tag in Log.py
  rteval: Replace GPL license notice with SPDX tag in __init__.py
  rteval: Replace GPL license notice with SPDX tag in __init__.py
  rteval: Replace GPL license notice with SPDX tag in __init__.py
  rteval: Replace GPL license notice with SPDX tag in hackbench.py
  rteval: Replace GPL license notice with SPDX tag in kcompile.py
  rteval: Replace GPL license notice with SPDX tag in __init__.py
  rteval: Replace GPL license notice with SPDX tag in cyclictest.py
  rteval: Replace GPL license notice with SPDX tag in sysstat.py
  rteval: Replace GPL license notice with SPDX tag in rtevalConfig.py
  rteval: Replace GPL license notice with SPDX tag in rtevalMailer.py
  rteval: Replace GPL license notice with SPDX tag in rtevalReport.py
  rteval: Replace GPL license notice with SPDX tag in rtevalXMLRPC.py
  rteval: Replace GPL license notice with SPDX tag in rtevalclient.py
  rteval: Replace GPL license notice with SPDX tag in __init__.py
  rteval: Replace GPL license notice with SPDX tag in cputopology.py
  rteval: Replace GPL license notice with SPDX tag in dmi.py
  rteval: Replace GPL license notice with SPDX tag in kernel.py
  rteval: Replace GPL license notice with SPDX tag in memory.py
  rteval: Replace GPL license notice with SPDX tag in osinfo.py
  rteval: Replace GPL license notice with SPDX tag in services.py
  rteval: Replace GPL license notice with SPDX tag in tools.py
  rteval: Replace GPL license notice with SPDX tag in systopology.py
  rteval: Replace GPL license notice with SPDX tag in version.py
  rteval: Replace GPL license notice with SPDX tag in xmlout.py
  rteval: Replace GPL license notice with SPDX tag in Makefile.am
  rteval: Replace GPL license notice with SPDX tag in
    apache-rteval-wsgi.conf.tpl
  rteval: Replace GPL license notice with SPDX tag in
    apache-rteval.conf.tpl
  rteval: Replace GPL license notice with SPDX tag in configure.ac
  rteval: Replace GPL license notice with SPDX tag in database.py
  rteval: Replace GPL license notice with SPDX tag in Makefile.am
  rteval: Replace GPL license notice with SPDX tag in argparser.c
  rteval: Replace GPL license notice with SPDX tag in argparser.h
  rteval: Replace GPL license notice with SPDX tag in configparser.c
  rteval: Replace GPL license notice with SPDX tag in configparser.h
  rteval: Replace GPL license notice with SPDX tag in
    eurephia_nullsafe.c
  rteval: Replace GPL license notice with SPDX tag in
    eurephia_nullsafe.h
  rteval: Replace GPL license notice with SPDX tag in eurephia_values.c
  rteval: Replace GPL license notice with SPDX tag in eurephia_values.h
  rteval: Replace GPL license notice with SPDX tag in
    eurephia_values_struct.h
  rteval: Replace GPL license notice with SPDX tag in eurephia_xml.c
  rteval: Replace GPL license notice with SPDX tag in eurephia_xml.h
  rteval: Replace GPL license notice with SPDX tag in log.c
  rteval: Replace GPL license notice with SPDX tag in log.h
  rteval: Replace GPL license notice with SPDX tag in parsethread.c
  rteval: Replace GPL license notice with SPDX tag in parsethread.h
  rteval: Replace GPL license notice with SPDX tag in pgsql.c
  rteval: Replace GPL license notice with SPDX tag in pgsql.h
  rteval: Replace GPL license notice with SPDX tag in rteval-parserd.c
  rteval: Replace GPL license notice with SPDX tag in statuses.h
  rteval: Replace GPL license notice with SPDX tag in threadinfo.h
  rteval: Replace GPL license notice with SPDX tag in xmlparser.c
  rteval: Replace GPL license notice with SPDX tag in xmlparser.h
  rteval: Replace GPL license notice with SPDX tag in xmlparser.xsl
  rteval: Replace GPL license notice with SPDX tag in remove_rtevalrun
  rteval: Replace GPL license notice with SPDX tag in
    rteval_testserver.py
  rteval: Replace GPL license notice with SPDX tag in rteval_xmlrpc.py
  rteval: Replace GPL license notice with SPDX tag in rteval_xmlrpc.wsgi
  rteval: Replace GPL license notice with SPDX tag in rtevaldb.py
  rteval: Replace GPL license notice with SPDX tag in testclient.py
  rteval: Replace GPL license notice with SPDX tag in
    testclient_sendreportfile
  rteval: Replace GPL license notice with SPDX tag in xmlrpc_API1.py
  rteval: Replace GPL license notice with SPDX tag in unittest.py

 Makefile                                 |  1 +
 rteval-cmd                               | 21 +--------------------
 rteval/Log.py                            | 21 +--------------------
 rteval/__init__.py                       | 21 +--------------------
 rteval/modules/__init__.py               | 21 +--------------------
 rteval/modules/loads/__init__.py         | 21 +--------------------
 rteval/modules/loads/hackbench.py        | 21 +--------------------
 rteval/modules/loads/kcompile.py         | 21 +--------------------
 rteval/modules/loads/stressng.py         |  1 +
 rteval/modules/measurement/__init__.py   | 21 +--------------------
 rteval/modules/measurement/cyclictest.py | 21 +--------------------
 rteval/modules/measurement/sysstat.py    | 21 +--------------------
 rteval/rtevalConfig.py                   | 21 +--------------------
 rteval/rtevalMailer.py                   | 21 +--------------------
 rteval/rtevalReport.py                   | 21 +--------------------
 rteval/rtevalXMLRPC.py                   | 21 +--------------------
 rteval/rteval_dmi.xsl                    |  1 +
 rteval/rteval_histogram_raw.xsl          |  1 +
 rteval/rteval_text.xsl                   |  1 +
 rteval/rtevalclient.py                   | 21 +--------------------
 rteval/sysinfo/__init__.py               | 21 +--------------------
 rteval/sysinfo/cmdline.py                |  1 +
 rteval/sysinfo/cputopology.py            | 21 +--------------------
 rteval/sysinfo/dmi.py                    | 21 +--------------------
 rteval/sysinfo/kernel.py                 | 21 +--------------------
 rteval/sysinfo/memory.py                 | 21 +--------------------
 rteval/sysinfo/newnet.py                 |  1 +
 rteval/sysinfo/osinfo.py                 | 21 +--------------------
 rteval/sysinfo/services.py               | 21 +--------------------
 rteval/sysinfo/tools.py                  | 21 +--------------------
 rteval/systopology.py                    | 21 +--------------------
 rteval/version.py                        | 21 +--------------------
 rteval/xmlout.py                         | 21 +--------------------
 server/Logger.py                         |  1 +
 server/Makefile.am                       | 21 +--------------------
 server/apache-rteval-wsgi.conf.tpl       | 21 +--------------------
 server/apache-rteval.conf.tpl            | 21 +--------------------
 server/configure.ac                      | 21 +--------------------
 server/database.py                       | 21 +--------------------
 server/gen_config.sh                     |  1 +
 server/parser/Makefile.am                | 21 +--------------------
 server/parser/argparser.c                |  9 +--------
 server/parser/argparser.h                |  9 +--------
 server/parser/configparser.c             | 15 +--------------
 server/parser/configparser.h             | 15 +--------------
 server/parser/eurephia_nullsafe.c        | 15 +--------------
 server/parser/eurephia_nullsafe.h        | 15 +--------------
 server/parser/eurephia_values.c          | 14 +-------------
 server/parser/eurephia_values.h          | 15 +--------------
 server/parser/eurephia_values_struct.h   | 15 +--------------
 server/parser/eurephia_xml.c             | 15 +--------------
 server/parser/eurephia_xml.h             | 15 +--------------
 server/parser/log.c                      |  9 +--------
 server/parser/log.h                      |  9 +--------
 server/parser/parsethread.c              |  9 +--------
 server/parser/parsethread.h              |  9 +--------
 server/parser/pgsql.c                    |  9 +--------
 server/parser/pgsql.h                    |  9 +--------
 server/parser/rteval-parserd.c           |  9 +--------
 server/parser/statuses.h                 |  9 +--------
 server/parser/threadinfo.h               |  9 +--------
 server/parser/xmlparser.c                |  9 +--------
 server/parser/xmlparser.h                |  9 +--------
 server/parser/xmlparser.xsl              | 15 +--------------
 server/remove_rtevalrun                  | 21 +--------------------
 server/rteval_testserver.py              | 21 +--------------------
 server/rteval_xmlrpc.py                  | 21 +--------------------
 server/rteval_xmlrpc.wsgi                | 21 +--------------------
 server/rtevaldb.py                       | 21 +--------------------
 server/sql/delta-1.0_1.1.sql             |  1 +
 server/sql/delta-1.1_1.2.sql             |  1 +
 server/sql/delta-1.2_1.3.sql             |  1 +
 server/sql/delta-1.3_1.4.sql             |  1 +
 server/sql/delta-1.4_1.5.sql             |  1 +
 server/sql/rteval-1.0.sql                |  1 +
 server/sql/rteval-1.1.sql                |  1 +
 server/sql/rteval-1.2.sql                |  1 +
 server/sql/rteval-1.3.sql                |  1 +
 server/sql/rteval-1.4.sql                |  1 +
 server/sql/rteval-1.5.sql                |  1 +
 server/testclient.py                     | 21 +--------------------
 server/testclient_sendreportfile         | 21 +--------------------
 server/unittest.py                       |  1 +
 server/xmlrpc_API1.py                    | 21 +--------------------
 setup.py                                 |  1 +
 unit-tests/unittest.py                   | 14 ++------------
 86 files changed, 87 insertions(+), 1055 deletions(-)
 mode change 100755 => 100644 unit-tests/unittest.py

-- 
2.39.3

