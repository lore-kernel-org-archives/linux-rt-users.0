Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59CBC7EE26
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 May 2023 09:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjEVJcO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 May 2023 05:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjEVJcN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2023 05:32:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81119D
        for <linux-rt-users@vger.kernel.org>; Mon, 22 May 2023 02:32:11 -0700 (PDT)
Date:   Mon, 22 May 2023 11:32:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684747929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+YKnhCOrQjLmvdL6RO8dcPWlxzCXuav6W3JYHQCkGnM=;
        b=0kAqUAqm8SBmO04Zj8EWVNcCngurHPQ17806et6a6mVdG2MvQpttwJppM4/1bz38idozNw
        McQUA4Dp3g0/7UM68LV07F+d4aCe6GUhFElXyrzHZo1+/7SX7hdXPCRQNVagljzzcld+Zf
        fT9cKZnvlIlLflVW/KQfrF9RyQ2SbcGerAMUdctFc6mNDPt9VoQEIbe13df1QyNGo79htB
        7KXlpmOSCBwJViHM73TjRY2JaW9FeFx0VYoUi/QeVCyhfh+p5ZTSJb2mkThEyQ4oSu0N+F
        67yXNPTF49RCU012yV0vEb8d5umKGRa6ix3+cARZvUVDfMGupIllQ7tdoF6c6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684747929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+YKnhCOrQjLmvdL6RO8dcPWlxzCXuav6W3JYHQCkGnM=;
        b=YOc4I9cr1sBje1Q/9SZsIYlYrslhjOJ6JSYwNfOpCAupz/70qEAMSwSrtcwbbo/tl4ypAQ
        NkFx2KJ/VQvsavAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Rod Webster <rod@vmn.com.au>
Cc:     linux-rt-users@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: Excessive network latency when using Realtek R8168/R8111 et al
 NIC
Message-ID: <20230522093208.NtKNYiYn@linutronix.de>
References: <CANV1gkc9KvkGNPkEsjXCiV4mUcdrrPcaQ1ueRri9ypjvJbU94g@mail.gmail.com>
 <20230428085123.HX02J4Ym@linutronix.de>
 <CANV1gkcr4jBUY-iH-iJJPdrVMp+1Nq1YrNPONferMC1AutJgkg@mail.gmail.com>
 <20230428131236.9MfVxN3s@linutronix.de>
 <CANV1gkdZWRu=g1yLBOC_=Y37H=9FEOHRCdAOBhf5j3+3T4_=qg@mail.gmail.com>
 <20230516105950.kSgA5y-v@linutronix.de>
 <CANV1gkftrZvhUhXV-mJ-mYmsue3ER33cXCNmVD1bGAc6TmTHuA@mail.gmail.com>
 <CANV1gkfsAfDt76=STFrekQA4M6sfVKyq7bujA=Tu+S6k+EGYcg@mail.gmail.com>
 <20230519083745.AB0-5kD9@linutronix.de>
 <CANV1gkcah59yVOMZ-s_0TMeMEgpwOaDKSWbdL3Y2Y86RQ+UsKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANV1gkcah59yVOMZ-s_0TMeMEgpwOaDKSWbdL3Y2Y86RQ+UsKA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-05-19 21:41:30 [+1000], Rod Webster wrote:
> I will do some testing tomorrow now I know what's going on but I
> wonder how relevant it will be given this turnaround?

I'm not going to look at the dkms/OOT driver. If there is an actual
problem or something odd with mainline and RT and I will look into it.
I managed to find an older box which is using the r8169 and I'm going to
boot and see if there the driver is doing something odd what I didn't
see earlier=E2=80=A6

Please make sure that you are using the in-tree driver. If you
experience high latencies then I'm willing to help investigate.

> Rod Webster

Sebastian
