Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7F5C433F5
	for <linux-rt-users@archiver.kernel.org>; Sat, 12 Feb 2022 21:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiBLVxQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 12 Feb 2022 16:53:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiBLVxQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 12 Feb 2022 16:53:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E56D606FA
        for <linux-rt-users@vger.kernel.org>; Sat, 12 Feb 2022 13:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644702791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=ZYoI4t4aOs9vYFmU2KxOKzf4EPJhf5pQaKO/he1Stuk=;
        b=eqdOyGNfgJ6lJsLnGEt3D+Qu0VziU1uhm9dKCpdTcjMUGgXtj3X9HgGExa/wjkjvX36p0d
        smnuWsEim30v+nSO7fGvRHJ8kzKP0rbCtyucXQtguDqWNNKJ8QKRuYOvrWfst5TA4XRXb6
        SPbRt/bKr0YtNferMfoByLthGAkCyzg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-D_dgcEfVOxiQ6V23MGoXxw-1; Sat, 12 Feb 2022 16:53:07 -0500
X-MC-Unique: D_dgcEfVOxiQ6V23MGoXxw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D376814243;
        Sat, 12 Feb 2022 21:53:05 +0000 (UTC)
Received: from localhost (unknown [10.22.17.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 672644531D;
        Sat, 12 Feb 2022 21:52:50 +0000 (UTC)
Date:   Sat, 12 Feb 2022 18:52:49 -0300
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
Subject: [ANNOUNCE] 4.14.266-rt129
Message-ID: <YggsMYFxI8G+dEvr@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.14.266-rt129 stable release.

This release is just an update to the new stable 4.14.266
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 30e466937f86764e9be27db71a3c53ef616d7d1d

Or to build 4.14.266-rt129 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.266.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.266-rt129.patch.xz


All keys used for the uploads can be found on the following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git


Enjoy!
Luis

