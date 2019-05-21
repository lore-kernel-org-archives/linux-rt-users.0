Return-Path: <SRS0=3Yn1=TV=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BA3C04AAF
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 May 2019 19:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0E9217F9
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 May 2019 19:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558468498;
	bh=h1xx92l5nqd/qYNS+wyRkS2AwUm9f2Ch9PbuYX/0z7U=;
	h=Subject:From:To:Date:List-ID:From;
	b=mntDTOgTjEM5qqCmRcDYxAebWOuZdNWeYV2LIwP/u1mRGXzMetcfGftRyBKFYMGSy
	 OH3IqKFH+7PowCFBtrqdrvfsbvoSW0L/U9xramcGahU2/L0Mj3wyv/jfW8+0l1I3nH
	 02IGXAlwjdDFgifU5ffrvvR1iMw6ZVZS8A+qxooY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfEUTyy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 21 May 2019 15:54:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfEUTyy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 May 2019 15:54:54 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3724217D7;
        Tue, 21 May 2019 19:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558468493;
        bh=h1xx92l5nqd/qYNS+wyRkS2AwUm9f2Ch9PbuYX/0z7U=;
        h=Subject:From:To:Date:From;
        b=P76UUBQEGfSDa25/fzsc/iQUoYkPFhwUkIvIMdgGqGITF2+TzKDfocZXk3bZqhK98
         CSGgz4wI2OMTg1OlalneC/U7jZOFXWAqqFMuFAgeCWSHCg/0nYLuI1BMBdC+6UGsc8
         KvO+eDBmv/sAMPZrsHShKoHnJuPF1brXlwlMwbXU=
Message-ID: <1558468491.3056.6.camel@kernel.org>
Subject: [ANNOUNCE] 3.18.138-rt116
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>
Date:   Tue, 21 May 2019 14:54:51 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 3.18.138-rt116 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.18-rt
  Head SHA1: 32e860e0679fce1ccfa8395df41f8790e24172b6

Or to build 3.18.138-rt116 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz

  https://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.138.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.138-rt116.patch.xz


You can also build from 3.18.138-rt115 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/incr/patch-3.18.138-rt115-rt116.patch.xz

Enjoy!

   Tom
