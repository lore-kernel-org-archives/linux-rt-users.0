Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA863C47083
	for <linux-rt-users@archiver.kernel.org>; Mon, 31 May 2021 21:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8061E6128A
	for <linux-rt-users@archiver.kernel.org>; Mon, 31 May 2021 21:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbhEaVav (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 31 May 2021 17:30:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60899 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231708AbhEaVas (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 31 May 2021 17:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622496548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=H/fkeNJk7Rb6yIVVI3sH7RNnpi5UwUOZvN66YodwnkE=;
        b=HSKyzY6d4yCW2rfUzkNcHa2Rjg4ynwEul6BO/uzGcvjyQ6Go6b8UqizDMqDrrtKwaoKmd5
        7T6eGjQwtJ45CFq5HE2e9X2bvygXVEpqZ1fwtwbI+Rn4orgEuWl/SD6NAvU8QH3yWta3+9
        mJLB70gZO/I7ShyuDd1ONG5ohHfARhY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-sD-ktHjbPqqJEIPkeAWI5w-1; Mon, 31 May 2021 17:29:04 -0400
X-MC-Unique: sD-ktHjbPqqJEIPkeAWI5w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A84941005D47;
        Mon, 31 May 2021 21:29:02 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-113-131.rdu2.redhat.com [10.10.113.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF72D5C233;
        Mon, 31 May 2021 21:29:01 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 1343E3C0174; Mon, 31 May 2021 18:29:00 -0300 (-03)
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        "stable-rt@vger.kernel.org"@redhat.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [PATCH RT 0/3] Linux v4.9.268-rt180-rc1
Date:   Mon, 31 May 2021 18:28:57 -0300
Message-Id: <20210531212900.37969-1-lgoncalv@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT Folks,

This is the RT stable review cycle of patch 4.9.268-rt180-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release on 2021-06-07.

To build 4.9.268-rt180-rc1 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.268.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.268-rt180-rc1.patch.xz


You can also build from 4.9.268-rt179 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/incr/patch-4.9.268-rt179-rt180-rc1.patch.xz

Enjoy,

-- Luis


Ben Hutchings (1):
  futex: Fix mis-merge of 4.9-stable changes with 4.9-rt

Luis Claudio R. Goncalves (1):
  Linux 4.9.268-rt180-rc1

Oleg Nesterov (1):
  ptrace: fix ptrace_unfreeze_traced() race with rt-lock

 kernel/futex.c                  | 39 ++++++++++++---------------------
 kernel/locking/rtmutex.c        |  3 +--
 kernel/locking/rtmutex_common.h |  1 -
 kernel/ptrace.c                 | 23 ++++++++++++-------
 localversion-rt                 |  2 +-
 5 files changed, 31 insertions(+), 37 deletions(-)

-- 
2.31.1

