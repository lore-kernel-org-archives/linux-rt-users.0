Return-Path: <SRS0=qNRq=SA=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF676C43381
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Mar 2019 08:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA572173C
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Mar 2019 08:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfC2IeE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:34:04 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54855 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbfC2IeE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 29 Mar 2019 04:34:04 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h9mxc-00035N-Ot; Fri, 29 Mar 2019 09:34:00 +0100
Date:   Fri, 29 Mar 2019 09:34:00 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Bernhard Landauer <bernhard@manjaro.org>
Cc:     Ralf Mardorf <ralf.mardorf@alice-dsl.net>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: firefix core dump with linux 5.0.3_rt1-2
Message-ID: <20190329083400.m4kx4spuvysoszlm@linutronix.de>
References: <dcf61b0e-31ca-0848-84c5-b200a15f3a89@manjaro.org>
 <20190328115559.275af3c3@archlinux>
 <f5d4ea60-aa23-a294-3850-42f35ca3d76d@manjaro.org>
 <20190328120022.bhwijbp2roizysiw@linutronix.de>
 <82482272-6912-c1d4-4a11-550a962f632c@manjaro.org>
 <1e1974c5-2ad3-98db-d160-577594a471e1@manjaro.org>
 <4ddfde7a-122b-5f18-f41a-b5e967217510@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ddfde7a-122b-5f18-f41a-b5e967217510@manjaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-03-29 00:56:01 [+0100], Bernhard Landauer wrote:
> Unfortunately the issue is still the same with 5.0.5-rt3 (and with
> firefox 66.0.2)

okay. How do I reproduce this? What do I need to do with firefox in
order to trigger this?

Sebastian
