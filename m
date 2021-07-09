Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7C8C07E99
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 05:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED4236140F
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 05:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhGIF2O (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Jul 2021 01:28:14 -0400
Received: from mout.gmx.net ([212.227.17.20]:41035 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhGIF2N (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Jul 2021 01:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625808328;
        bh=FOeUf08WqLoHmu/8I01nIYShZyGwrXzOQuPTKkKudUQ=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=G8f+CqlAvw4r7W/ycWq09UDhQUtZ7uNyarzwUbOzNcczDdXZ1hCF3lQDNkYIGJGEi
         DwA22dZvEiIaiu9gv1ySrBlrZCn/OSW483qH9gVcTgXH+6YW7UWAmw+yr4ZlYhNYzZ
         ErAkW01p7rLg3JXvZA/f8GGWWa146pOQ+636X6i0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.33]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTiTt-1lc6Sb0oJB-00TzDQ; Fri, 09
 Jul 2021 07:25:28 +0200
Message-ID: <549a464f75f7613f91cc0a790c323cc1b32c193c.camel@gmx.de>
Subject: Re: [rfc/patch] mm/slub: restore/expand unfreeze_partials() local
 exclusion scope
From:   Mike Galbraith <efault@gmx.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Fri, 09 Jul 2021 07:25:27 +0200
In-Reply-To: <8c0e0c486056b5185b58998f2cce62619ed3f05c.camel@gmx.de>
References: <87tul5p2fa.ffs@nanos.tec.linutronix.de>
         <8c0e0c486056b5185b58998f2cce62619ed3f05c.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:BfNFj66KZL79QjqskSwG5ol5YKT/U0oLW1yIGG/4HniXgk6PLBu
 9jg5fZUX9f76aCNO2AXcvGooDHwqSkaaRtrjOFQMELoHYKNLuZGFlJxiihA8WATwKmKmlxJ
 Eo9THZf84DKhlc7H+bl/y+xX/Jv9/QFpvwdH7Q2JVOSmzZ/95Z0Dp9a7S3BRK7Gen//lMV0
 Tuzl+1swmUeDRZZ6PYgww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BaX6uV6cDng=:RDlLNvEGQbjmuHIQVhUh8p
 D+N4QXIoFBWxuBHGO/a1SbQFkEPqB+yDTGH3REgMnNDujVZm5U/PE/opSvZYtBE5xarvLfKCX
 R9JWyJxd+Q1HNXElCCn2POSmV1S9u/JObp8/kFG+yArY+KL+ELc46LUOb7YJjTYPEXLylmyzB
 63qNLbA25Gn2BQzDCQ/QcJQ2YOL+G0ObdN2tdhY/1gkFk1Wt/n8g33jrJUk5ve5bMQyr5ASx0
 rplnyUbeB4+mkZRfkTwMFTrMOk03k5YZVjikyCmFPGfePZ/yIl9oVPx4XiT7YCRmN3F4r5/eg
 5Sm11qPB+uZUHMa4BM9Fom4ae+0zhAtBPDev3U5DqFCPWXUhVVLhYd+CVY8OMyXqF4pKFw+tL
 vRHKbInuzNoxoB47IW8s1Meeie1jgO/OYnIB+GOE5n6ji32fKdv+gkot5Qk5BfLYtltk6ufif
 gazMhyLpF+JOt3fNJkRaDxI76lIKfnapwJDqzhDv0pmrA3lZaXiExu/C2eU31mwtuPTOZ7Huz
 M8AU0Rt/b25myT62wP4jbzFPCOM5Euzq3FDT2qjwMzfNWMrMmckwrgljydXNsQaTsdBrHT6EJ
 D1F2N8JjBLu26bkiqSH/efXI1YlwlkVRQjI+Jhhxec9Xhb6H+KHhKewD08fCS2PMLLiH11dvY
 adXIueGVTCzvsa25RSYhSHdWypFVywb5Y/ao2ixONXdlQzBRb/Ds1/FysqFkPatH8TMwA7eA2
 lhvDdWxeJy58nMR2C/qnAStnCXdveWGFIZv62c3hE5tDrTgt0uQ4l9jElcCLxMYNng8MO1KHF
 sNMjymHe1VhnceitBYlxK82OefnDGg0Bp5p10ybqVuAs+vBATiY17uEi/HRoqvOq4F5z3LTjU
 vbcLqfDVUku2w7bmZLhKsexNabQfLwYHdbPClgv4f5pqtreCzLX7GUwbbwx8IFvxiOVaGOo7y
 9m38ZV6R8ttx47shBpZiUO6YcKEMlswqG/w7zGrkMm4lRIt+SddMpXb0ijRfufnn9OGAm9C7l
 9lSWfI5dWayavPPA7KJw3wiF+0gP50iK0BvwlOQdIw1RTahFCepNjwuarLpi2lpJpKZty77fA
 R4hOBQ+1vH4mHK3erxOdoCRB+T76ybihgmN
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 2021-07-09 at 07:21 +0200, Mike Galbraith wrote:
> Well, bug report in patch for actually.
                            ^^^form

