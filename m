Return-Path: <SRS0=BfXC=CG=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57271C433E6
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Aug 2020 08:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CBE920665
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Aug 2020 08:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rld7OOkV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KCnZ0kNX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgH1INl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 28 Aug 2020 04:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgH1INi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 28 Aug 2020 04:13:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BD6C061264;
        Fri, 28 Aug 2020 01:13:38 -0700 (PDT)
Date:   Fri, 28 Aug 2020 10:13:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598602415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Umy8Ibimdkn45wVd+UqrXJS2qHyYICr5k+IIrkqy+pk=;
        b=rld7OOkVnaE73mz2Qt1rVu7NwmkWG8Gl4/zauWnyuHc+Q5yK5vDfhLGASpeWSj7Bu4+hsm
        KHKhdqIdZUBINoDBKvhPQ6GDo8w4a6vHuYOIoP70B2ntf4vFjbCIH6gzj+zc20iZXWH4iv
        WPzm5DXyPMAE61Hpey8cpcbdSnfJqpMciZInuFc9+7BsOiL8McCb1Zmj37NfvUcVqSEYIW
        nCuhGdX1g1gOStP6b1eEQPqZ4e+Iik8RcT+nKfOLgCnNNyfg3q6oo5qn8Ax30vf0F1xYFt
        X+bagUr2FifBhgsand8Yio1edfbnsnAdJL53zRwX3k0HAFcLPwaGIII8efd+bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598602415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Umy8Ibimdkn45wVd+UqrXJS2qHyYICr5k+IIrkqy+pk=;
        b=KCnZ0kNXS9NuIC2omiTT04NaxrOR9jr2IqklibVROXwjmbZAojAg1gIp6Y1k2zkBAMUwMW
        6VJ0xM1Fj1j87iCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     Daniel Vacek <neelx.g@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.9-rc2-rt1
Message-ID: <20200828081334.nkoing5b4ryiz45r@linutronix.de>
References: <20200826090518.m6vblobggnfdjau5@beryllium.lan>
 <20200826104326.xfexkwovwbi2q4el@beryllium.lan>
 <20200827091910.ibuyr53qprb7qmju@beryllium.lan>
 <20200827092743.kjl6hkaephx3a64a@linutronix.de>
 <20200827101622.xx4jzecouxrlwbii@beryllium.lan>
 <20200827102840.msv556nrah4h4vmq@linutronix.de>
 <20200827112705.uleixtdmx3pacr5u@beryllium.lan>
 <20200827124611.tsivo4xopvoenfmy@beryllium.lan>
 <CAA7rmPG1j0vD4rtv2piLF1UV9qD4mfcXVAHfA3vqGniPUAerrw@mail.gmail.com>
 <20200828073650.kq4qaon2u4xsqqlr@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200828073650.kq4qaon2u4xsqqlr@beryllium.lan>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-08-28 09:36:50 [+0200], Daniel Wagner wrote:
> On Thu, Aug 27, 2020 at 05:50:24PM +0200, Daniel Vacek wrote:
> > Maybe the threshold is 33554432, eg. 32 megs...
> 
> I've rearranged the load addresses for the kernel and the dtb and now
> the board is booting again. Starting with a full test run now.
> 
> The size list was mainly to see if the v5.9 tree is showing abnormal
> size regression. It doesn't look that's the case. All RT kernels are
> bigger than the rest.

Looking at the size increase, the v5.6 -> 5.9 increased way more than
5.4 -> 5.6. However this is also true for the ll config (and is not
limited to RT):

rpi3-image-ll-v5.4.59-rt36 -> rpi3-image-ll-v5.6.19-rt12 -> rpi3-image-ll-v5.9-rc2-rt1
0                          -> + 1.1 MiB (4.2%)           -> + 3.1 MiB (11.2%)

rpi3-image-rt-v5.4.59-rt36 -> rpi3-image-rt-v5.6.19-rt12 -> rpi3-image-rt-v5.9-rc2-rt1
0                          -> + 1.0 MiB (3.3%)           -> + 4.6 MiB (14.3%)

Sebastian
