Return-Path: <SRS0=o6M6=IG=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F6EC43331
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Mar 2021 14:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7B256518F
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Mar 2021 14:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhCHOM2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Mar 2021 09:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhCHOMN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Mar 2021 09:12:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F38C06174A
        for <linux-rt-users@vger.kernel.org>; Mon,  8 Mar 2021 06:12:12 -0800 (PST)
Date:   Mon, 8 Mar 2021 15:12:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615212731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lyIKqK5wLrUyNMr8Vn9EWnwNm9njaJ3gmuSF0PKWyVU=;
        b=G3xKbTwEq0wO20f5IuTmCpj64xguSM6JDXIxfHgqoIC2p1kg88Er1YuvfiVs/mdCnoYlQN
        FA6AdM6rDRllKLB5oj4H08+g+bX/I8QGioa1bZ+Lvwfpe36uTqQkbAHXUIjh+4UVgfkHNr
        JIggFhZnShNjlhNhlsj7xxbfHWcI7nAxaHbHdRQ6zz4Lko7RL419ECeqAwazm5+8CtPbmx
        pA5ZxCacUmKxju0FvI8UIJw+Ce1TOP5dMGSWBIvyzdz2gKFhhrcpXIdLs9EfLxFm7qPuJb
        Yjk7hGbB/s4hoM2lQUJqYgX0zih0MyzzfZXjkKsDzT2mmeSDUDHtwruXkcH88Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615212731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lyIKqK5wLrUyNMr8Vn9EWnwNm9njaJ3gmuSF0PKWyVU=;
        b=PHoFHJfu5UvLduMZeeTLxgnG+5hyiMfP2pMEHh8gVvOCxYldybM6xcFBgnTSUgwM9NHFWg
        RUJIMeoQdjfcGtBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     David Runge <dave@sleepmap.de>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net,
        Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]
Message-ID: <20210308141210.yoa37dsc26p4jsim@linutronix.de>
References: <YBVG/PG7syFIUBno@hmbx>
 <20210201083441.ocucdvdrv37goz2s@linutronix.de>
 <20210205112638.xuduvuefy3auycht@linutronix.de>
 <YB3TLNN39/XhUyUY@hmbx>
 <YB+5tdIpbTfnDnIi@hmbx>
 <20210208091940.csuyf7l73n4ofpmz@linutronix.de>
 <YCl28sXo7LEyCK8y@hmbx>
 <20210218083849.iitcrhdgv2oajfhv@linutronix.de>
 <20210218092751.ahn262llcpp2loz7@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210218092751.ahn262llcpp2loz7@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-02-18 10:27:51 [+0100], To David Runge wrote:
> On 2021-02-18 09:38:49 [+0100], To David Runge wrote:
> > On 2021-02-14 20:16:02 [+0100], David Runge wrote:
> > > The current config can be found on the AUR [1].
> > 
> > So this did make a difference. 
> 
> made _no_ difference. Sorry for the confusion.

David, did you had a chance to test the patch?

Sebastian
