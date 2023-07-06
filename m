Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6113EEB64D9
	for <linux-rt-users@archiver.kernel.org>; Thu,  6 Jul 2023 15:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbjGFPFy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 6 Jul 2023 11:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjGFPFt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 6 Jul 2023 11:05:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2CC10EA
        for <linux-rt-users@vger.kernel.org>; Thu,  6 Jul 2023 08:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688655900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=hzl1oBmdQuVl+ZNqL8T8RCyz6ttDV4G7nQumbbXOol0=;
        b=NKWWzBWIhXMwlmseE9qvj70S6or44C4cq9iWJZ4mU13yhxh4e0DyOm4TobbBCmBjR4Murt
        Mlgzj0zrNiqgCz3loNonS9aiwg8DuZTRubuKbpyMfL5xpbO8ngqno4/Bwmc/TbNMofg84N
        bJTu5Y/UMYkuRfYgyAsC0hwROeYAOfE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-44-SnlEUc1INPyZlv3934nZBA-1; Thu, 06 Jul 2023 11:04:55 -0400
X-MC-Unique: SnlEUc1INPyZlv3934nZBA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6EAA856506;
        Thu,  6 Jul 2023 15:04:54 +0000 (UTC)
Received: from localhost (unknown [10.22.17.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D65240C206F;
        Thu,  6 Jul 2023 15:04:54 +0000 (UTC)
Date:   Thu, 6 Jul 2023 12:04:53 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 4.14.320-rt151
Message-ID: <ZKbYFel0cWrYp/UN@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.14.320-rt151 stable release.

This release is just an update to the new stable 4.14.320
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: b0e6196114833f4b07008e8f0e8b223e7514c058

Or to build 4.14.320-rt151 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.320.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch-4.14.320-rt151.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

