Return-Path: <SRS0=AM/X=2C=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30DBC43603
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Dec 2019 07:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9756F2173E
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Dec 2019 07:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfLLHxB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 12 Dec 2019 02:53:01 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37487 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbfLLHxB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 12 Dec 2019 02:53:01 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ifJHH-00069t-6j; Thu, 12 Dec 2019 08:52:51 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1ifJHG-00014E-EW; Thu, 12 Dec 2019 08:52:50 +0100
Date:   Thu, 12 Dec 2019 08:52:50 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: devel branches in rt-tests
Message-ID: <20191212075250.7yc36dghunlw4t6t@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rt-users@vger.kernel.org
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello John,

I wonder about the two branches

	unstable/devel/latest (at 07a73b6ecf748c424c676f1ba8030ca678360e0e)
	unstable/devel/latest-devel (at c5aa9a877b146846da21e5d63597a2a09a3c96d7)

in the rt-tests.git repository.

According to

	git range-diff origin/unstable/devel/latest...origin/unstable/devel/latest-devel

the two contain mostly identical commits. It seems to me
unstable/devel/latest is a rebased version of
unstable/devel/latest-devel as the commit dates are newer and two
patches that are duplicated in .../latest-devel[1] only occur once each in
.../latest. Also .../latest has 5 more commits.

Does that mean unstable/devel/latest-devel is the one to ignore?

Best regards
Uwe

[1] git range-diff 97632deddf783249e0e3d34630792c7696b7d5d5...90449d993fc9973381f1c37fbda37c39a43ab503

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
