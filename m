Return-Path: <SRS0=VClK=45=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F669C1975A
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Mar 2020 08:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6D020650
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Mar 2020 08:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgCLIKx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 12 Mar 2020 04:10:53 -0400
Received: from mail.monom.org ([188.138.9.77]:39592 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbgCLIKx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 12 Mar 2020 04:10:53 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id CBED15005A3;
        Thu, 12 Mar 2020 09:10:50 +0100 (CET)
Received: from localhost (b9168f9a.cgn.dg-w.de [185.22.143.154])
        by mail.monom.org (Postfix) with ESMTPSA id 9A8A65003BA;
        Thu, 12 Mar 2020 09:10:50 +0100 (CET)
Date:   Thu, 12 Mar 2020 09:10:50 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     Marouen Ghodhbane <marouen.ghodhbane@nxp.com>
Cc:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: complete_all warning with 3 waiters
Message-ID: <20200312081050.ldxfol4yupln7phw@beryllium.lan>
References: <DB3PR0402MB3708A4D019B384FE29CBDD96F6FC0@DB3PR0402MB3708.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB3708A4D019B384FE29CBDD96F6FC0@DB3PR0402MB3708.eurprd04.prod.outlook.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Marouen,

On Wed, Mar 11, 2020 at 04:32:03PM +0000, Marouen Ghodhbane wrote:
> My question is: is there any good reason for the value of 2 in the
> warning condition ? It seems to me like a warning put earlier to
> check if we trigger this condition and work on some unresolved
> issues. Do we need another filter like the pm_in_action ?

The check is there to find code paths which rely on waking many
waiters. The problem is, swake_up_all_locked() is running while
holding a raw spin lock with irq disabled which can introduce unbouded
latencies on the system.

> Any idea/suggestion is definitely appreciated

The warning is harmless in your case though annoying.

Thanks,
Daniel
