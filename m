Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78C5C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Nov 2021 17:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE6FC61183
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Nov 2021 17:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhKERU7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Nov 2021 13:20:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42180 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbhKERU7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Nov 2021 13:20:59 -0400
Date:   Fri, 5 Nov 2021 18:18:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636132698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wm1TcDaabKSrLTJXoH5zsCc9hgRA+id4UtV1gmRyEQ8=;
        b=ni8LrFCESpRWTzoasmRe8PYAfVjoRiIo4Br4m7XGObQ1GCXK4Kd6bpPc2x2n9N25ldYUOp
        YYPMhuWpjKX3QsxevJwYuJYgqlNLZARz6rncsWzZhcPGr2bn2/tGicTrYlnvRg/zmfK1h1
        4+5PESqHFCR700gxYqyaEBOdcq9s94lFlQQRKeZulFJvAGgoPrUisrqLdOPP6r6i900DFL
        1nTCqzmAFGxmUGRjqa056N7LGa2jI/1o2vyemRO2ujud4BbgedaMA76XX25n2YwUV/bjzX
        QkXvsux3hvL6YoeoCThn4czFtK01HCcoP+UPQ62UY48EAY4hVdrOGN255adOAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636132698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wm1TcDaabKSrLTJXoH5zsCc9hgRA+id4UtV1gmRyEQ8=;
        b=fd5iNvfk1uVxZqArfcv1LY6HbkhtlcclwLqAKlGCThp3xAg11tO+A6LiaciaZG/Ve7FWkt
        miUJbuEhwBdBnfCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Luis Goncalves <lgoncalv@redhat.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        stable-rt@vger.kernel.org, Chunyu Hu <chuhu@redhat.com>
Subject: Re: [RFC RT v5.10] [rt] repair usage of raw_v6_hashinfo.lock in
 raw_seq_start()
Message-ID: <20211105171816.3osasfqdxcv7wjr4@linutronix.de>
References: <YVuwBEWw4F7NGUd2@uudg.org>
 <20211011163333.2o64amr4qks4gpdm@linutronix.de>
 <CAD8J---eDMZb7Z39vYLY+vZZYhvTokv3NgsCCa=oJhH_hTYH6w@mail.gmail.com>
 <20211027090650.fqpqtze6wfetihej@linutronix.de>
 <CAD8J---Dxofu+k3yxyMxvUBd5sQfBZEHM8N3Q-S8f8-1dfa4Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD8J---Dxofu+k3yxyMxvUBd5sQfBZEHM8N3Q-S8f8-1dfa4Fw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-11-04 15:48:46 [-0300], Luis Goncalves wrote:
> Yes, sure!
> 
> Just as a reminder, I was able to reproduce that backtrace in v5.14-rt
> up to v5.14-rc6-rt11. But starting from v5.14-rc7-rt12 I no longer
> reproduced the problem.

So I'm about to this but patch but this mail confused me. Can you bisect
which change is responsible for that? Based on the arguing, the same
callchain should exist in v5.15, too. And a diff
v5.14-rc6-rt11..v5.14-rc7-rt12 didn't show any change in that area.

Sebastian
