Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295C9C433B4
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Apr 2021 04:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBE6F61424
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Apr 2021 04:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhD3Ecc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 30 Apr 2021 00:32:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55900 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229448AbhD3Ecc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Apr 2021 00:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619757104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=LQn5wsXQ24l2g+rynnQ5m0SJbNAE6IJo0PeSAozfaxQ=;
        b=Tdg8rE/ij0whgmfOsAiCNTFTIqsDDbqRhxTceFQVQ8Bn9HI1LWeFpugp1TqqGdxOLDTM/Q
        zNOxOgtcgggRdQYWKDkCYcfkAOaO3bGfiMp7C+SwsOYv50OZlS8hrECyLrstQhClGUicgv
        45zTnRpKqoMbKJdJ/xb95OO7nXj1MJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-8liIQNz5N1ujcOMGXPw-dg-1; Fri, 30 Apr 2021 00:31:42 -0400
X-MC-Unique: 8liIQNz5N1ujcOMGXPw-dg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79E7C80362D;
        Fri, 30 Apr 2021 04:31:40 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-117-234.phx2.redhat.com [10.3.117.234])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E1D460CC5;
        Fri, 30 Apr 2021 04:31:39 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 62ABD3C0053; Fri, 30 Apr 2021 01:31:38 -0300 (-03)
Date:   Fri, 30 Apr 2021 01:31:38 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 4.9.264-rt178
Message-ID: <YIuIKqtTSbrV7nmm@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.264-rt178 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: 177d997aefde5a4b750eab679c89fe294211e12b

Or to build 4.9.264-rt178 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.264.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.264-rt178.patch.xz


Enjoy!
Luis

Changes from v4.9.263-rt177:
---

Joe Korty (1):
      Balance local_irq_{disable,enable} in irq_forced_thread_fn

