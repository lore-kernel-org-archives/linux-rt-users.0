Return-Path: <SRS0=2Bnr=75=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B8DC433E1
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Jun 2020 16:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D647C20882
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Jun 2020 16:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JmwrWt5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732342AbgFPQPW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:15:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24840 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731921AbgFPQPU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Jun 2020 12:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592324119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=Sc4OR5A24njzBYo2XyZ6e1pErQVd9vzc9p6oV8BP3Ms=;
        b=JmwrWt5j3NUWU6Ws/+ZgZWGx8JuskC8Ibyae28MAi0A9kJGGIYA8J/agar6tf/rf06uZrK
        1L9eE5p1NLqxvOvoYiS2aX5oeV9Xw2AOCGvOryOPgf2OxwKuFfXGnCZp+6m7hGGmAkfEfF
        vyOCpteVPhnHl4IvU7tpwCIiiaClvKI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-xmAOxgy-P9W6UOk_u-DFjA-1; Tue, 16 Jun 2020 12:15:16 -0400
X-MC-Unique: xmAOxgy-P9W6UOk_u-DFjA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6CF88005AD;
        Tue, 16 Jun 2020 16:15:15 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-9.gru2.redhat.com [10.97.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD6296ED96;
        Tue, 16 Jun 2020 16:15:12 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id B463541887FC; Tue, 16 Jun 2020 13:14:49 -0300 (-03)
Message-ID: <20200616161149.392213902@fuller.cnet>
User-Agent: quilt/0.66
Date:   Tue, 16 Jun 2020 13:11:49 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 0/2] re-enable remote per-cpu-pages draining
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Remote draining of pages was removed from 5.6-rt.

Unfortunately its necessary for use-cases which have a busy spinning
SCHED_FIFO thread on isolated CPU:

[ 7475.821066] INFO: task ld:274531 blocked for more than 600 seconds.
[ 7475.822157]       Not tainted 4.18.0-208.rt5.20.el8.x86_64 #1
[ 7475.823094] echo 0  /proc/sys/kernel/hung_task_timeout_secs disables this message.
[ 7475.824392] ld              D    0 274531 274530 0x00084080
[ 7475.825307] Call Trace:
[ 7475.825761]  __schedule+0x342/0x850
[ 7475.826377]  schedule+0x39/0xd0
[ 7475.826923]  schedule_timeout+0x20e/0x410
[ 7475.827610]  ? __schedule+0x34a/0x850
[ 7475.828247]  ? ___preempt_schedule+0x16/0x18
[ 7475.828953]  wait_for_completion+0x85/0xe0
[ 7475.829653]  flush_work+0x11a/0x1c0
[ 7475.830313]  ? flush_workqueue_prep_pwqs+0x130/0x130
[ 7475.831148]  drain_all_pages+0x140/0x190
[ 7475.831803]  __alloc_pages_slowpath+0x3f8/0xe20
[ 7475.832571]  ? mem_cgroup_commit_charge+0xcb/0x510
[ 7475.833371]  __alloc_pages_nodemask+0x1ca/0x2b0
[ 7475.834134]  pagecache_get_page+0xb5/0x2d0
[ 7475.834814]  ? account_page_dirtied+0x11a/0x220
[ 7475.835579]  grab_cache_page_write_begin+0x1f/0x40
[ 7475.836379]  iomap_write_begin.constprop.44+0x1c1/0x370
[ 7475.837241]  ? iomap_write_end+0x91/0x290
[ 7475.837911]  iomap_write_actor+0x92/0x170

See individual patches for details.


