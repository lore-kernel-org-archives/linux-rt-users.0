Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1FAC43334
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Jul 2022 13:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbiGYN0s (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 25 Jul 2022 09:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbiGYN0q (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 25 Jul 2022 09:26:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A38624F
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jul 2022 06:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658755593;
        bh=Fi3qy6ElAhIaJDSzvLZdGZtuRvMetLj0T6KmNKAlxLM=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=a/oBKENeCxDjtdnxXRAE0/j2xwbMPj/l2qv8NnzwuXfPGpzw+0q9P2a5o4zOdTQAz
         7Lg2wiFqnhlPM1IVyigFM+6/IBxBSNyRuaJ7wHUXchShuUuIkf2vBTdx3Y0CUvWusd
         rlejNb6aXwY5mZWcaUVE/C5dkx08hKqJqRHGBaL4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.149.139]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNbox-1nrXMo0Qvb-00P7tW; Mon, 25
 Jul 2022 15:26:33 +0200
Message-ID: <2d55bcc3544f349bbdd30908d3a9c04e56dbf718.camel@gmx.de>
Subject: Re: v5.19-rc2-rt3: nouveau might sleep splat
From:   Mike Galbraith <efault@gmx.de>
To:     John Ogness <john.ogness@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     RT <linux-rt-users@vger.kernel.org>, Petr Mladek <pmladek@suse.com>
Date:   Mon, 25 Jul 2022 15:26:32 +0200
In-Reply-To: <87h735ikdh.fsf@jogness.linutronix.de>
References: <01e0c6949e6f0611954016552da8f0795b20600a.camel@gmx.de>
         <YrV4795StT13AUC+@linutronix.de>
         <a35dc9666de31d406a2132fc9457349dc8ee10ef.camel@gmx.de>
         <YrWPiwtk0kAWxXI9@linutronix.de> <87wnd616ds.fsf@jogness.linutronix.de>
         <87tu8a16bm.fsf@jogness.linutronix.de>
         <daf9b4678af9a121ba85f30b04f1335b44639433.camel@gmx.de>
         <Yt5RDajSVTPqahV4@linutronix.de> <87h735ikdh.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TTiKmN9s4IZK7euqD6S2VIhwZkEkNw+XqAuANtcJQNy2Xq5dThq
 fiootJI+tynOs4qhNFebgPqfmlgje2cxXiTAlJWaPW6RlSXZlkltYlViQKt3vSR35kEE0LI
 Q5ZQpCCtmF0hLhpw1+I6vQ9CoymDfFvu0Rmk+sdVJK3oMPs0K1bQX24v7iVEd2YDPcNQ8J2
 hp6f6UwaiPa6ZWemEY3WA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7wVxtvgBCkI=:UZw1avi1glyx7lAU6bMIci
 FKh+2Jkacfg587CfuvHmQjnCbkZZGdn1W3gQmY2qS5/WjwCF9+4THvfHEzcaPnUnt8MmRZKkR
 vzb/Da9b0HCQl1n8iYO3zarRNX2LkHaBFCQSySPH2KaHsb5j50YP3nppyYWSnWEwRFLRFtg17
 yfRrdx7DHnMROXu6CUgQJUAR5ByMBolfimTOVPoJ1wllAWrv+cUa7821EwxoCR8Z989ItZh77
 DK/EHXLdEevEU5MaG39GjlbWARJ7WKEBuc7MgC85UsXshxKdOqtPNAJoWi63azPDd4bWdZMS/
 jVUJyvaU1eoS9aQICeC1EvELOOFdHyKjAyAc5BcrVW+SifZ64bP5p7fJmEOwDvI+hWjmNLSla
 Hxa2Ce485nEAubPrmi9Lb6nAEvlF6OLqs6rrc5SDJceiqzuu296EBdqm1GJWbKf68Ez5F8tFp
 uVTVzqe6dfCFJMMapkf8BtAL/OhsEspi6Rcs5UjNLSDikc2lSr8RGwA1CtXD94yziEG+ZIBrq
 WB+Vd3QdkeU941pvyPZRNCbGcXfVnlDu9Vkzw0yUHbp9Idp3Vbo7quAmo1pDrqOo+kk1YLEM/
 HTdx/1K/SkLsl3G4dasnmuQtbI+rcUHJDv3UPErXv40AH3DwKOFSOIo2NZGwN40CGn51HBLR4
 yMklG8P7OMG0avdnBl23ZOiK2S7IeO9GdW+cOaM1joMLov+3t24EbQ8abVq3Kb8FGxb/SUpOK
 P39G5EYtjlq9gpPlztMDt0aBey4kgmUuIVj/FFumsQ8QCwNnF+H68fhgklJEOP1Fwgsfd24pM
 CgtPGwTlLRfbTDvCZp+u/bzxiQp4zlJkeffxPQtHEMyw5P0XyDPqbb5kTrpR2CMjyzq505+Y5
 z4oXN84Fm9AkfU3kI5uHT30iqujjF2nqkJz2jQd/2yIii2ga+TsOvpBy7ZCebEbU6TcG9ZKoy
 22NEZOFE42mmi9awESedhgQpc1Kj3UsDybU0aHMEKuqWRbbsH0nF/erWj+GKPKD0vm8HshSHL
 sDXWosIKpjhSHljcaAsYYs0PyzfPLlGcB9OtA1OeOhvZTJu8leWWhOAcjASZrVU98kXJ8x/z1
 YPWTZmMckNWlyUyu8fPDCoCuvjrPYzVwdeuerDZsJU7rGRq43b0Dkw9VA==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2022-07-25 at 12:04 +0206, John Ogness wrote:
> I suppose this patch side-steps the splat because the first
> vsnprintf() already triggered the random bytes for the pointer
> hash.

Yeah, sounds right.

> I am preparing a new series that addresses this by completely removing
> interrupt disabling from the printk() path. This required changes to the
> printk_enter() macro, recursion handling, and the printk-ringbuffer
> itself.
>
> The focus of my new series are the various non-RT issues reported during
> the early 5.19-rc cycles. I still need more time to get the series into
> shape for LKML.
>
> If Mike's patch is reliably side-stepping the issue, feel free to take
> it.

It does, but I'm in no rush... and it is a bandaid :)

	-Mike

