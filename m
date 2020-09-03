Return-Path: <SRS0=hc4Q=CM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B4DC43461
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Sep 2020 21:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2823F206D4
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Sep 2020 21:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599167891;
	bh=H+zisSn0FrInHXhGoTyvgsvnRNCUi468hEUisSJ0ngg=;
	h=Subject:From:To:Date:List-ID:From;
	b=tJFSq2z3/DTbyeRKqjkvHrcwMJTpcRgFMOYaROf2JVplIVjUFV4uSXmjfv2gU6dZs
	 FtJaUabiZHRgKeeeE6MYJMdroonnL7WMfQS3ZJVA7CJKm2uryEBg91cYGQ0fwFf2Cz
	 UkAvh70VNWTEZibgM6U0YyX8EFL/dEAYL1+Y2Ki4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgICVSD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:18:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbgICVSD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 3 Sep 2020 17:18:03 -0400
Received: from tzanussi-mobl (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 816C0206CA;
        Thu,  3 Sep 2020 21:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599167883;
        bh=H+zisSn0FrInHXhGoTyvgsvnRNCUi468hEUisSJ0ngg=;
        h=Subject:From:To:Date:From;
        b=soemoY/r1RNQiVg/7DIajZG1+z+Iy97Jw9sRT2KzXXm0R6fpLxhAyncNFC3Nzxy66
         /prLiORA3GCXtVWLhP0hRLEQNpMAqZf55dECJaYU6v3aFE/0sTk63YvWCxBnMlqMXX
         DJpuMwsO3zNZkO8zAnXU5yGs06miFynCXPVmJp1E=
Message-ID: <e717ef103955ba2aea8ab58a0a53d12ef7b1a1c8.camel@kernel.org>
Subject: [ANNOUNCE] 4.19.142-rt63
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>, Tom Zanussi <zanussi@kernel.org>
Date:   Thu, 03 Sep 2020 16:18:01 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.19.142-rt63 stable release.

This release is just an update to the new stable 4.19.142
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: ea94598e25b40fa394519bf9ece3f0032c6f3301

Or to build 4.19.142-rt63 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.142.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.142-rt63.patch.xz

Enjoy!

   Tom

