Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CBFC4332F
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Jan 2022 02:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345321AbiAGCPN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 6 Jan 2022 21:15:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27392 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345317AbiAGCPM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 6 Jan 2022 21:15:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641521711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lgwRn+0uXaM10gYAXkzf5zxn0GLEX2m9Vt4LZFOEhkU=;
        b=gfnsudgh3nr+mkGNdBXtD86nn+lzLinjX/pHhR9a7wcEXzf+SaHKmaLcsRLbct8yHqspWE
        /+oO/lg56suDQM/8IOflqIyZGCVloKVpyWA9Dnfu4SrqJd5SX3HHxlA9RjyoeJ4a/ZonXa
        3GGrjZmhGzWYSD+g2YfYk5l/nQl1MfU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-vdM9nPeXNJ6p8M4eHti_vg-1; Thu, 06 Jan 2022 21:15:06 -0500
X-MC-Unique: vdM9nPeXNJ6p8M4eHti_vg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F7C4100C610;
        Fri,  7 Jan 2022 02:15:05 +0000 (UTC)
Received: from lclaudio.dyndns.org (unknown [10.22.8.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 486145BE0D;
        Fri,  7 Jan 2022 02:15:04 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 9E4763C0038; Thu,  6 Jan 2022 23:15:02 -0300 (-03)
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        "stable-rt@vger.kernel.org"@redhat.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jeff Brady <jeffreyjbrady@gmail.com>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [PATCH RT 0/3] Linux v5.10.90-rt61-rc1
Date:   Thu,  6 Jan 2022 23:14:59 -0300
Message-Id: <20220107021502.1121597-1-lgoncalv@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT Folks,

This is the RT stable review cycle of patch 5.10.90-rt61-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release on 2022-01-13.

Known problem:

  There is a printk build warning that would be fixed by commit 43a17111c2553
  ("printk: wake up klogd in vprintk_emit"), already present in v4.19-rt. I am
  trying to decide whether it is justifiable to suggest the backport of this
  commit to 4.14-stable or if I should write a simple rt-only fix. Comments are
  welcome.


To build 5.10.90-rt61-rc1 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.90.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/patch-5.10.90-rt61-rc1.patch.xz


You can also build from 5.10.90-rt60 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/incr/patch-5.10.90-rt60-rt61-rc1.patch.xz

Enjoy,

-- Luis



Luis Claudio R. Goncalves (1):
  Linux 5.10.90-rt61-rc1

Sebastian Andrzej Siewior (1):
  stop_machine: Remove this_cpu_ptr() from print_stop_info().

Thomas Gleixner (1):
  eventfd: Make signal recursion protection a task bit

 fs/aio.c                |  2 +-
 fs/eventfd.c            | 12 +++++-------
 include/linux/eventfd.h | 11 +++++------
 include/linux/sched.h   |  4 ++++
 kernel/stop_machine.c   |  6 +++++-
 localversion-rt         |  2 +-
 6 files changed, 21 insertions(+), 16 deletions(-)

-- 
2.33.1

