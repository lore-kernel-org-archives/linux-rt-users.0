Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE7EC47080
	for <linux-rt-users@archiver.kernel.org>; Mon, 31 May 2021 22:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C8A61287
	for <linux-rt-users@archiver.kernel.org>; Mon, 31 May 2021 22:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbhEaWtv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 31 May 2021 18:49:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57050 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232081AbhEaWtu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 31 May 2021 18:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622501290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=r1QfqfOaQihhNE8P0qHansZnvOeq4jXAuhNKx9fD71Y=;
        b=AEndOMZYmSLVv20aDkLdaS/4QsUMzvsBXasZSjRq1zmTBAPVTGzzVLMMCkIBlqdjYSs9AJ
        D7zFi5C61brMHE+t93iBEdPGnXvl07LGg9paAJi+TbPSKEItY50QflpOXj+H/2Ttu1eb/q
        g+T0k0vM8L+MEW7skKqJMbjrwIM3Xyg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-zEHhGOjKMNOT1ziAiL8ElA-1; Mon, 31 May 2021 18:48:08 -0400
X-MC-Unique: zEHhGOjKMNOT1ziAiL8ElA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 716621007467;
        Mon, 31 May 2021 22:48:07 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-113-131.rdu2.redhat.com [10.10.113.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 06A0E5D9D0;
        Mon, 31 May 2021 22:48:07 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 3FB333C0174; Mon, 31 May 2021 19:48:05 -0300 (-03)
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
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [PATCH RT 0/3] Linux v4.14.232-rt112-rc1
Date:   Mon, 31 May 2021 19:48:02 -0300
Message-Id: <20210531224805.45914-1-lgoncalv@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT Folks,

This is the RT stable review cycle of patch 4.14.232-rt112-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release on 2021-06-07.

Known problem:

  There is a printk build warning that would be fixed by commit 43a17111c2553
  ("printk: wake up klogd in vprintk_emit"), already present in v4.19-rt. I am
  trying to decide whether it is justifiable to suggest the backport of this
  commit to 4.14-stable or if I should write a simple rt-only fix. Comments are
  welcome.


To build 4.14.232-rt112-rc1 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.232.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.232-rt112-rc1.patch.xz


You can also build from 4.14.232-rt111 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.232-rt111-rt112-rc1.patch.xz

Enjoy,

-- Luis



Luis Claudio R. Goncalves (2):
  printk: revamp "Make rt aware"
  Linux 4.14.232-rt112-rc1

Sebastian Andrzej Siewior (1):
  timers: Redo the notification of canceling timers on -RT

 fs/timerfd.c                   |  5 +-
 include/linux/hrtimer.h        | 17 ++----
 include/linux/posix-timers.h   |  1 +
 kernel/printk/printk.c         | 11 ++++
 kernel/time/alarmtimer.c       |  2 +-
 kernel/time/hrtimer.c          | 36 ++++---------
 kernel/time/itimer.c           |  2 +-
 kernel/time/posix-cpu-timers.c | 23 ++++++++
 kernel/time/posix-timers.c     | 69 ++++++++++--------------
 kernel/time/posix-timers.h     |  2 +
 kernel/time/timer.c            | 96 ++++++++++++++++------------------
 localversion-rt                |  2 +-
 12 files changed, 130 insertions(+), 136 deletions(-)

-- 
2.31.1

