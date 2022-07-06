Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE05C43334
	for <linux-rt-users@archiver.kernel.org>; Wed,  6 Jul 2022 11:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbiGFLvM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 6 Jul 2022 07:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiGFLvK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 6 Jul 2022 07:51:10 -0400
Received: from mx0.woks-audio.com (mx0.woks-audio.com [88.99.2.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A558286F7
        for <linux-rt-users@vger.kernel.org>; Wed,  6 Jul 2022 04:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=woks-audio.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=woks; bh=oLhaS2stL0RW8ISQyvWH
        Pswsr/QG0OMsRfm7WqZNq/8=; b=fieo69g8FZ0st+kiWoRxtRnNpHU1P9CS4264
        hvJGuSXylHqdOiJ8qNATXu0TCDoybfZAE91tYNVM/7TzXW139KjZRZDUSKsjNS8E
        D3bbUTM927JpuCNPjbL+0e2i2h8Dz7ZI3jMgNoRqu0XG9DIBQd3AsyFzPCt+2OId
        kuuO2ssB/zBpzg7rpegovBhz+/m+uvbqKH2YVDSDsKg2HnDmhzQ6m/BZL39y5pmz
        B/OTqxAXd6mYseFugkzAhZNYN9AzbivAY4n/h0DlQLZSOP5opBqg6cutus3aYgoO
        fwwuteJhZUa5lhN63Dw55vcICMLe+rMk5359TK3x9gYvN6xDBg==
From:   Benjamin Steinke <benjamin.steinke@woks-audio.com>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
CC:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        "linux-trace-devel@vger.kernel.org" 
        <linux-trace-devel@vger.kernel.org>
Subject: Re: stopping ftrace on event
Date:   Wed, 6 Jul 2022 13:51:06 +0200
Message-ID: <5900013.0QKTdidtKr@desktop>
In-Reply-To: <c8aa45af-9a64-8318-71d6-91511afed8e6@redhat.com>
References: <4044532.36S9Iv5CRb@desktop> <c8aa45af-9a64-8318-71d6-91511afed8e6@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: EX1.jas.loc (10.100.2.20) To EX1.jas.loc (10.100.2.20)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Am Mittwoch, 6. Juli 2022, 13:31:00 CEST schrieb Daniel Bristot de Oliveira:
> On 7/6/22 10:50, Benjamin Steinke wrote:
> > Hi all,
> > 
> > I'm hunting sporadic high irq-handler latencies in a pcie driver by using
> > ftrace. I'm currently using trace-cmd record but get way to large files
> > due to the event being so infrequent.
> > 
> > Is there a way to stop tracing or dump the current trace buffer when a
> > specific event occurs?
> 
> https://www.kernel.org/doc/html/latest/trace/events.html#event-triggers ?

Oh, didn't see the forest for the trees. I probably scrolled a number of times 
over this section. Thanks a lot. 

> 
> -- Daniel
> 
> > Thanks for your help,
> > Benjamin




