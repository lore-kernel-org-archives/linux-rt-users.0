Return-Path: <SRS0=1+vS=TX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84120C282DD
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 May 2019 20:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE18217D7
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 May 2019 20:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558643537;
	bh=NElWUzJvif1deH6MO8Vjb5akrs/yWZctQSPiNSP6HTQ=;
	h=Subject:From:To:Date:List-ID:From;
	b=sMBbCImTulnjrQTfvFWR2agWCBqA1K01768Kb3GtV08xEArbSGzVylI+LXe1WZOu/
	 NJGz0f08MqVVHaw0XeKmshiopUKe6r570yVTPTWwoXy30scY4daKlgbD7uezypHEBR
	 aZVPRnIsc4/DOU8MWnfpX1RQ8xpVILCXLwRZ5QG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387901AbfEWUcL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 May 2019 16:32:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387666AbfEWUcL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 May 2019 16:32:11 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B95DE2175B;
        Thu, 23 May 2019 20:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558643530;
        bh=NElWUzJvif1deH6MO8Vjb5akrs/yWZctQSPiNSP6HTQ=;
        h=Subject:From:To:Date:From;
        b=cuuuCEyaO0+tVw1eQ0dQR8jPOtypqqL8Cc8zic90c7MmH6RxafnnFzEZe06rXWdC2
         kqBah+LhE21Q4qImSE9Aqff5WyHEK1R5n1UwJZDqZu9+nXzOcRN/Qwsd97JmP0mDcl
         gtjvqqDnc3vS/rXMLxhdMB+udIeCjrPY0B0PN428=
Message-ID: <1558643528.2934.3.camel@kernel.org>
Subject: [ANNOUNCE] 3.18.140-rt117
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
Date:   Thu, 23 May 2019 15:32:08 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 3.18.140-rt117 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.18-rt-rebase
  Head SHA1: f7fa9a750011e58fbc407b2cd6e58207a187f4b9

Or to build 3.18.140-rt117 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz

  https://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.140.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.140-rt117.patch.xz


Enjoy!

   Tom
