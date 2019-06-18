Return-Path: <SRS0=oonB=UR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C63C31E51
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Jun 2019 09:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A952080A
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Jun 2019 09:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megamailservers.eu header.i=@megamailservers.eu header.b="Kwk/e2PV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbfFRJrO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 18 Jun 2019 05:47:14 -0400
Received: from mail152c50.megamailservers.eu ([91.136.10.162]:51262 "EHLO
        mail50c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729203AbfFRJrN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Jun 2019 05:47:13 -0400
X-Authenticated-User: ralf.mardorf@o2mail.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megamailservers.eu;
        s=maildub; t=1560851231;
        bh=LywJL7xD8BX/e799uR2LQj5lfJfWHKtZyC4UetZzC9U=;
        h=Date:From:To:Subject:From;
        b=Kwk/e2PVybsrbko/OYo/rt7mPEDaHPy2OsrO4BQvvBE69+uZ4+0HWe1TMVnbm8pin
         ehF2RqYsipGAiocNQO+sqMZAuNB6hRvKM5DxMDN74OvX12Y3Xk1GB1JvhP39DZtWk8
         fRQwqGCLPKLeAq8qu93deePXOFrb2HcE6KI9UiO0=
Feedback-ID: ralf.mardorf@al
Received: from archlinux (x5d876d00.dyn.telefonica.de [93.135.109.0])
        (authenticated bits=0)
        by mail50c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id x5I9l9FH029594
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-rt-users@vger.kernel.org>; Tue, 18 Jun 2019 09:47:10 +0000
Date:   Tue, 18 Jun 2019 11:46:59 +0200
From:   Ralf Mardorf <ralf.mardorf@alice-dsl.net>
To:     linux-rt-users@vger.kernel.org
Subject: kernel.org slow download speed
Message-ID: <20190618114513.4e2cfa7f@archlinux>
X-Mailer: Claws Mail (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CTCH-RefID: str=0001.0A0B0208.5D08B31F.0005,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-VOD: Unknown
X-CTCH-Spam: Unknown
X-CTCH-Score: 0.000
X-CTCH-Rules: 
X-CTCH-Flags: 0
X-CTCH-ScoreCust: 0.000
X-CSC:  0
X-CHA:  v=2.3 cv=VLnzYeHX c=1 sm=1 tr=0 a=FBE1MhIdAX9q/Ny6aTeDuA==:117
        a=FBE1MhIdAX9q/Ny6aTeDuA==:17 a=VwQbUJbxAAAA:8 a=kj9zAlcOel0A:10
        a=qEgFrD8PemeKtOPIB6AA:9 a=CjuIK1q_8ugA:10 a=pRQRx_yQ9a0A:10
        a=fqMFh-b0cAUA:10 a=AjGcO6oz07-iQ99wixmX:22
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

for my Arch PKGBUILD I tried https://www.kernel.org/pub/linux/kernel/
as well as https://mirrors.edge.kernel.org/pub/linux/kernel/ to
download the sources for 5.0.21-rt12, but download speed is that slow,
that I manually interrupted the download.

Is there an issue with the kernel.org server or is it more likely an
issue by my ISP, an IXP or whatsoever?

Regards,
Ralf
