Return-Path: <SRS0=Kj7U=AB=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D565C433E1
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Jun 2020 08:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07D8B23A32
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Jun 2020 08:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgFTIIk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 20 Jun 2020 04:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgFTIIk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 20 Jun 2020 04:08:40 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE496C06174E;
        Sat, 20 Jun 2020 01:08:39 -0700 (PDT)
Received: from p200300d06f23b4e5c41e49015ae3a59e.dip0.t-ipconnect.de ([2003:d0:6f23:b4e5:c41e:4901:5ae3:a59e] helo=kmk0.localnet)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <kurt.kanzenbach@linutronix.de>)
        id 1jmYYH-0008Kf-2s; Sat, 20 Jun 2020 10:08:37 +0200
From:   Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
To:     Vladimir Oltean <olteanv@gmail.com>,
        Jiafei Pan <jiafei.pan@nxp.com>
Cc:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Colin King <colin.king@canonical.com>,
        Jiafei Pan <jiafei.pan@nxp.com>
Subject: Re: [EXT] Re: stress-ng --hrtimers hangs system
Date:   Sat, 20 Jun 2020 10:08:29 +0200
Message-ID: <11546107.O9o76ZdvQC@kmk0>
Organization: Linutronix GmbH
In-Reply-To: <AM0PR04MB47726B40110E1B02471EEEDF8A810@AM0PR04MB4772.eurprd04.prod.outlook.com>
References: <4781d250-9a29-cef3-268d-7d83c98bf16a@gmail.com> <87y2ovzcmd.fsf@kurt> <AM0PR04MB47726B40110E1B02471EEEDF8A810@AM0PR04MB4772.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Jiafei,

On Friday, June 12, 2020 2:49:17 AM CEST Jiafei Pan wrote:
> Hi, Kurt,
> 
> May I know whether you used "root" user to run stress-ng? using "root"
> user will change the scheduler to be "SCHED_RR", so would you please
> share test result with root and non-root users? Thanks.

Performed the test now as root and non-root user. Same result: No 
problem.

Thanks,
Kurt



