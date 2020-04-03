Return-Path: <SRS0=GZ+T=5T=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A085C43331
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Apr 2020 16:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2579B208E4
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Apr 2020 16:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404251AbgDCQgO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:36:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40696 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728420AbgDCQgO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Apr 2020 12:36:14 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jKPIi-00017d-CU; Fri, 03 Apr 2020 18:36:12 +0200
Date:   Fri, 3 Apr 2020 18:36:12 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     linux-rt-users@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Nori, Sekhar" <nsekhar@ti.com>
Subject: Re: [v5.4.28-rt19] ARM64: nfs boot issues
Message-ID: <20200403163612.3art5cvyayxxgtpt@linutronix.de>
References: <0d05e716-5575-d4bd-64be-187c85244c12@ti.com>
 <08852afc-16f4-d2c3-7f52-37181d341232@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08852afc-16f4-d2c3-7f52-37181d341232@ti.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-04-03 14:22:27 [+0300], Grygorii Strashko wrote:
> Sorry for disturbing you it was IRQ driver issue.

Thank you for the update.

Sebastian
