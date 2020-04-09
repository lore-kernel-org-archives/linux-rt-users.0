Return-Path: <SRS0=rlXa=5Z=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D06AC2BA19
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Apr 2020 17:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6785E20769
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Apr 2020 17:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586453011;
	bh=64LlGCCv4Ujdsj2HjK37xEdnG7YXQ8NbifNQr7sh4yM=;
	h=Subject:From:To:Date:List-ID:From;
	b=Mr0EtfolcPJ0QnjTonp3KyClg0dpDlmBAgq6NTps9hNl0ZGQcIYMrTE9feWA2V6hK
	 az5pNNFlxfGF63RGgyhWpKXctCHUzuiN2gYojyRP2rBOFxf3PPVgsuAoDMjFopsGKK
	 ohBQg1Dzt8UIroNgDpkV/RGPoRDxMn8HcojQePLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgDIRX0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 Apr 2020 13:23:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbgDIRX0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Apr 2020 13:23:26 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C981B20768;
        Thu,  9 Apr 2020 17:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586453006;
        bh=64LlGCCv4Ujdsj2HjK37xEdnG7YXQ8NbifNQr7sh4yM=;
        h=Subject:From:To:Date:From;
        b=DGsrSHs/eLYC41ZAlE1CHLK7q4AiiyzjoROJlfTR1MRi5K2uAmF1vCBQyA8hffmt1
         GtD3dkdiJCCI2y7BpSRzo25JrC9T4LVsgPTF4d6c8tLf7P9gbCLmaIQW4SwWH9TH8i
         HJ2lCpnI4maQuwvjX2UHw/G2TVxwPopKPVb4iPZE=
Message-ID: <d238dd91974af6b667eca52d6890be39db9acd0e.camel@kernel.org>
Subject: [ANNOUNCE] 4.14.175-rt80
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
Date:   Thu, 09 Apr 2020 12:23:24 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.14.175-rt80 stable release.

This release is just an update to the new stable 4.14.175
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 4bfc4a805b681b2320f9e9c11636ee8543616583

Or to build 4.14.175-rt80 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.175.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.175-rt80.patch.xz

Enjoy!

   Tom

