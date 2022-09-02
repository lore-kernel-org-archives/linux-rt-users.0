Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F25FC6FA83
	for <linux-rt-users@archiver.kernel.org>; Fri,  2 Sep 2022 06:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbiIBGwa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 2 Sep 2022 02:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235561AbiIBGw0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 2 Sep 2022 02:52:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B55B7281;
        Thu,  1 Sep 2022 23:52:21 -0700 (PDT)
Date:   Fri, 2 Sep 2022 08:52:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662101540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4CGfTf4nVmZv2iyB8AOtoXxr8kILd9xnWGJfgZcAGkc=;
        b=pXBQKmIknV4FL15w9+JHN/wWIc6SbQFj3XmyXjGrFcN0HUmaHNBGaMha3FvL+y6kN1EcAP
        F7IvW3HqrzrwdsCws2pojjViUnMcg/KnIVG5rXkkIsORG4Czur1UCCsWo9bEF/TRarX5E6
        Zjgq85xScimmJYvpWBXyeTXmPAaLb3XHITAZ8db/4aQowwcLDCca/qCeULrx0paREgf19F
        iC3DtcffdIAJgJJKA9Tlpz/+yT2T/sIBuHkRxB1fnlW3R3OBW9gItyyUydRlVicXbLQvkg
        Th2H+baq0mfR/i06AyK6pNAyIA0mx6pgQze9/s05lKqvIirYcdxXjhR6N/zAZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662101540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4CGfTf4nVmZv2iyB8AOtoXxr8kILd9xnWGJfgZcAGkc=;
        b=HFibHFJmycuhgyD9fipGZhlzrJxAmvZHdRo0zzh1aUuKVFvGhUDYNZe7gIb+XCWIpSZ5N7
        GWiLm9Uy16UNPUDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mark Gross <markgross@kernel.org>
Cc:     linux-rt-users@vger.kernel.org, stable-rt@vger.kernel.org,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: [PATCH 0/9 v4.9-RT] Backports to fix random core
Message-ID: <YxGoItZaDcwxRcV5@linutronix.de>
References: <20220819092446.980320-1-bigeasy@linutronix.de>
 <YxEhJqm40AIPxCTX@T470>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YxEhJqm40AIPxCTX@T470>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-09-01 14:16:22 [-0700], Mark Gross wrote:
> Sorry for taking so long to start working these.  Are these patches to be
> applied to v4.9.320, or to the RT patches prior to the linux-stable merge?
> 
> Or are these patches the updates to the patches that conflict with v4.9.320 as
> I rebase?
> 
> I'm guessing the latter as the patches don't seem to work on just the last RT
> release or v4.9.320 directly.
> 
> Bottom line, I'm not sure how you expected me to use these 9 patches.

The commit I cited was backported into v4.9-stable, I *think* it is part
of v4.9-stable as of v4.9.320. If you apply the RT queue then you should
have conflicts. The "old" RT patches for random are obsolete if I
remember correctly.

> Sorry for being dense.

No worries. If in doubt, make a -rc and let me look over it or if
completely in doubt yell and I prepare a complete queue.

> --mark

Sebastian
