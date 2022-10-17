Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F21BC433FE
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Oct 2022 03:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbiJQDec (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 16 Oct 2022 23:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbiJQDe3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 16 Oct 2022 23:34:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE24DCC
        for <linux-rt-users@vger.kernel.org>; Sun, 16 Oct 2022 20:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665977660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=6135VcNoJA1YgD9+TJuEy/9tE8F+CRD+TQ1pYtttp9o=;
        b=R/V8h740xf2q9CYzjPg/cC7997aLMl32k7WxQ4gxteSZ+IYa38dSoAIaMAeMWuyWmU5trU
        BdVCk0SDZq6NYgdwNToe8AAM8/Y+ivcd6BSNkiFBqg+wUO59vM0xPzwOdglK/dJZXrOWR4
        gIf3ibjewhMs95L5QnUlCyTmvASGteQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-381-H29MLwItM_mczmBTBsaGww-1; Sun, 16 Oct 2022 23:34:15 -0400
X-MC-Unique: H29MLwItM_mczmBTBsaGww-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9671B29ABA33;
        Mon, 17 Oct 2022 03:34:14 +0000 (UTC)
Received: from localhost (unknown [10.22.8.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82F29E77BF;
        Mon, 17 Oct 2022 03:34:09 +0000 (UTC)
Date:   Mon, 17 Oct 2022 00:34:07 -0300
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
Subject: [ANNOUNCE] 4.14.292-rt138
Message-ID: <Y0zNL/Tk5s9m9xz5@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.14.292-rt138 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 8dc9b9827fcd4e43b4e2ca3694d041cd83627914

Or to build 4.14.292-rt138 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.292.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch-4.14.292-rt138.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

