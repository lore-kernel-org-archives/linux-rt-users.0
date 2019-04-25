Return-Path: <SRS0=auL/=S3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11557C10F03
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Apr 2019 10:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E93206BA
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Apr 2019 10:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfDYKnm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:43:42 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58392 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfDYKnm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 25 Apr 2019 06:43:42 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hJbqt-00036E-CC; Thu, 25 Apr 2019 12:43:39 +0200
Date:   Thu, 25 Apr 2019 12:43:39 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Bernhard Landauer <bernhard@manjaro.org>
Cc:     Ralf Mardorf <ralf.mardorf@alice-dsl.net>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: firefix core dump with linux 5.0.3_rt1-2
Message-ID: <20190425104338.yootmttwafvd4gnv@linutronix.de>
References: <82482272-6912-c1d4-4a11-550a962f632c@manjaro.org>
 <1e1974c5-2ad3-98db-d160-577594a471e1@manjaro.org>
 <4ddfde7a-122b-5f18-f41a-b5e967217510@manjaro.org>
 <20190329083400.m4kx4spuvysoszlm@linutronix.de>
 <4f5db7b4-e129-075a-f5f7-81fc0c0a1d82@manjaro.org>
 <20190408153014.q5hnrz3dwphudeq2@linutronix.de>
 <9c56b47b-042c-d799-5e61-c114b77355fc@manjaro.org>
 <1df65102-3ccc-fa4b-635d-262a81133430@manjaro.org>
 <d46fbb6d-92dc-84ef-a2a5-ea12dc8a3a43@manjaro.org>
 <20190410085959.bwvqpllrjdzvlyri@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190410085959.bwvqpllrjdzvlyri@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-04-10 10:59:59 [+0200], To Bernhard Landauer wrote:
> On 2019-04-10 10:55:24 [+0200], Bernhard Landauer wrote:
> > So no. The patch definitely doesn't solve the issue I'm afraid. Just
> > tested now and situation is still the same.
> 
> Do you have another box to cross check that? I have here an i7 with i915
> and I don't have the problem. I killed firefox in the middle of the
> operation and then restoring last session just went fine.
> So whatever it is, I can't reproduce it.
> 
> Can you enable lockdep / debugging and check what dmesg says?

did the issue vanish in v5.0.7-rt5?

Sebastian
