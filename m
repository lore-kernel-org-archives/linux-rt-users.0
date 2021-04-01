Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD64C433ED
	for <linux-rt-users@archiver.kernel.org>; Thu,  1 Apr 2021 02:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6765A6109D
	for <linux-rt-users@archiver.kernel.org>; Thu,  1 Apr 2021 02:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbhDACLp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 31 Mar 2021 22:11:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42647 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230073AbhDACLY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 31 Mar 2021 22:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617243083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=Nj8uknRswd0IM8P2GRa9gwEspXaVeAU0G9ngfBH5B0Q=;
        b=g19VA/cXcr5TFzRWj4JJGhkeCyDIqhrnVEu+N8vD6mSoGeJR6XpQqHU0jlDqyb81vEwe7D
        d1b3I1UGK3dL0Wtp1lZAkFbrBkGFy93RlGluFmpZwYCtgt/y5k5soY8tAiFnOY2Mjqhzvp
        GzJ2INPPY7lpnV6t3WXPbEkiscMV+bk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-KFIMaPeQMJuSojXRBbSk1A-1; Wed, 31 Mar 2021 22:11:20 -0400
X-MC-Unique: KFIMaPeQMJuSojXRBbSk1A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFC6C1005D5D;
        Thu,  1 Apr 2021 02:11:18 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-116-45.rdu2.redhat.com [10.10.116.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 16D285C1BB;
        Thu,  1 Apr 2021 02:11:18 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 547F13C0025; Wed, 31 Mar 2021 23:11:16 -0300 (-03)
Date:   Wed, 31 Mar 2021 23:11:16 -0300
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
Subject: [ANNOUNCE] 4.9.263-rt177
Message-ID: <161724286334.400702.6621333628010277704@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.263-rt177 stable release.

This release is just an update to the stable 4.9.263 version
and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: 35149e17e6832cf94a4c078fafb0ab3d8794e11f

Or to build 4.9.263-rt177 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.263.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.263-rt177.patch.xz

Enjoy!
Luis

