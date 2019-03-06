Return-Path: <SRS0=D0cg=RJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C900C43381
	for <linux-rt-users@archiver.kernel.org>; Wed,  6 Mar 2019 20:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6BF20684
	for <linux-rt-users@archiver.kernel.org>; Wed,  6 Mar 2019 20:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551903184;
	bh=juDD4D+mC2bHGEi8oZPfS7cdjKPDDAIyc8PJ07qZkE4=;
	h=Subject:From:To:Cc:Date:List-ID:From;
	b=0rhxrj+i0qkwm0TiQlgUHsoUfVv9WY25LNXrSRybf1wkPPsg81pIRQvjes5bqoHmS
	 6rkhDj/1jLrESgIuiZRlt2pXLXA/DiEXjUmiUgTK/54vJBBxDlWOIFbHjZiH9t9JCI
	 9ZW6G/A+yPSDxL7GMD3F6iOiFa2lcDAS/FS/RuA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfCFUNE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:13:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:47786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbfCFUNE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 6 Mar 2019 15:13:04 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E268B20663;
        Wed,  6 Mar 2019 20:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551903183;
        bh=juDD4D+mC2bHGEi8oZPfS7cdjKPDDAIyc8PJ07qZkE4=;
        h=Subject:From:To:Cc:Date:From;
        b=gUh0yQqGxFhcu4jB6jCAIh0feVSwV6nDBPKik0bu6Z6vf09mIqxYG/j+TKO/CE4XT
         XnrgjjGTboFzIB8D7iSGH0cfXyhkOJLkUvh/dPd5MKmOOjB+BLGBcN7SoTygMcILwl
         s+DfH0ry19lRSiJajWKu3Rv7zZvAhx+EipF1jMaU=
Message-ID: <1551903181.4293.7.camel@kernel.org>
Subject: [ANNOUNCE] 4.14.103-rt55
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Julia Cartwright <julia@ni.com>
Date:   Wed, 06 Mar 2019 14:13:01 -0600
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.14.103-rt55 stable release.

This release is just an update to the new stable 4.14.103 version
and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: cbdc409470f2a897b5cdb529ca78c248c984fb02

Or to build 4.14.103-rt55 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.103.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.103-rt55.patch.xz


Enjoy!
   
   Tom
