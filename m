Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507ABC47082
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Jun 2021 20:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D0CA6008E
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Jun 2021 20:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbhFHU1d (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Jun 2021 16:27:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30536 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234953AbhFHU1a (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Jun 2021 16:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623183936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=zlHhUt2bpdgq+Wakvku5Uf132tRpf/xlKxOC2NbaV+E=;
        b=jMVFVc0JWAud2oqLrvL8cDQhXltFMgkAsYmZpErEkW0g72Osq8RkOL5gx+UWpvPICDadFZ
        utrECP5vfyWyLo6IovN2Wl+7P2ToVZ3SDAYNExoca5REQ/Y2uSLb7CbT+8Qn/fDy0rB+L6
        2yNnZdTVi6ii0CpJY4W30ZNiVI16iDU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-AKHuFTNzNB2NIkqlC32dkw-1; Tue, 08 Jun 2021 16:25:32 -0400
X-MC-Unique: AKHuFTNzNB2NIkqlC32dkw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A984107ACCA;
        Tue,  8 Jun 2021 20:25:30 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-119-82.rdu2.redhat.com [10.10.119.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E4C65D6D3;
        Tue,  8 Jun 2021 20:25:29 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id A00CA3C0174; Tue,  8 Jun 2021 17:25:27 -0300 (-03)
Date:   Tue, 8 Jun 2021 17:25:27 -0300
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
Subject: [ANNOUNCE] 4.9.271-rt182
Message-ID: <YL/SNw5fOK0Sxb98@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.271-rt182 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: f11e2b11b6871c031fac201cd2625de4696a63bf

Or to build 4.9.271-rt182 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.271.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.271-rt182.patch.xz


Enjoy!
Luis

