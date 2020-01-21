Return-Path: <SRS0=QguH=3K=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33D2C2D0CE
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Jan 2020 20:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DC524656
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Jan 2020 20:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579637454;
	bh=kvocdgJcl8ds3fXm6JZVZDMNPHGRqlhuKAmVopKG0zk=;
	h=Subject:From:To:Date:List-ID:From;
	b=K+NjInXEcZfFOP3fgj4QRXHanXlzshFg8ngrNyfS8ap4afy+5hI0wQlAcobjOAMNk
	 dCicS6efywSEdqscW0B6X9aBl5pP+NtxsoiY9YdBar7OuXlp/SN4uE1ZI6EFPutzI0
	 t4PVX/LUqM1a2guWl1UXnDdSulfxFiXTFTBMdE5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgAUUKy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 21 Jan 2020 15:10:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgAUUKy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Jan 2020 15:10:54 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A039F207FF;
        Tue, 21 Jan 2020 20:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579637453;
        bh=kvocdgJcl8ds3fXm6JZVZDMNPHGRqlhuKAmVopKG0zk=;
        h=Subject:From:To:Date:From;
        b=TKxlbnX8+QtDmS3D0gZt/uezz3meJpsnUXZg5jJ4mr3IhRz1HrP5SW46pkzFinRww
         LR8r8KkLmBv3LtlzfTtVi4XZVaS3DdyFj1VF2nsM8y5MTiLmrp3+D35CbHRlyCjOUn
         8iZM0UHm08V0X0Xu/Zpnus/gpY9Z5SK1qtfVFLnY=
Message-ID: <1579637450.19595.9.camel@kernel.org>
Subject: [ANNOUNCE] 4.14.164-rt73
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Date:   Tue, 21 Jan 2020 14:10:50 -0600
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.14.164-rt73 stable release.

This release is just an update to the new stable 4.14.164
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: aa78b8aa811088d338796a14f3f618878635759f

Or to build 4.14.164-rt73 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.164.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.164-rt73.patch.xz

Enjoy!

   Tom
