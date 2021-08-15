Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BE3C432BE
	for <linux-rt-users@archiver.kernel.org>; Sun, 15 Aug 2021 03:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A36E60F51
	for <linux-rt-users@archiver.kernel.org>; Sun, 15 Aug 2021 03:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbhHODN5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 14 Aug 2021 23:13:57 -0400
Received: from mout.gmx.net ([212.227.15.15]:33501 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbhHODN4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 14 Aug 2021 23:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628997192;
        bh=e51c0SCycBJIAAANBaUWBL1Psc1wSIcAuol7HpYOH0Y=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=BXrJ729V1PeUtoEvIA7aooOtmv46CUyvxPbNbHps3a5sgxw2FVHgzcLwNyEgeEe2d
         z6KEqS1MsPDIPi60A5euT5fW55UczfXXKNDLZ+guzAqqeIfe/5+DDMW/lsVzBQHT3I
         58jpgkL3UD72VskQZNnlAFKHW1P/triOsDINwSGg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.48.238]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOA3P-1mQTVB29kX-00Ob8b; Sun, 15
 Aug 2021 05:13:12 +0200
Message-ID: <0044f090d3919eef03048527f1baa34aec5198a8.camel@gmx.de>
Subject: Re: [ANNOUNCE] v5.14-rc5-rt8
From:   Mike Galbraith <efault@gmx.de>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Clark Williams <williams@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>
Date:   Sun, 15 Aug 2021 05:13:11 +0200
In-Reply-To: <96ceab8e-4bf9-147a-e931-848676003c3f@suse.cz>
References: <20210810163731.2qvfuhenolq2gdlv@linutronix.de>
         <20210812151803.52f84aaf@theseus.lan>
         <5f0c793d-5084-4607-8475-209fa7310ba2@suse.cz>
         <20210812162448.26274298@theseus.lan>
         <bb98b54c-6d88-2a56-4998-51a304c19e8c@suse.cz>
         <20210812164440.0426d8b7@theseus.lan>
         <96ceab8e-4bf9-147a-e931-848676003c3f@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d0d+Y/hFGZGYSxF11c8gaf9/joXkscGwd0hFKjj0pvkVAmfMMAg
 bNr0rumtmMykjNNeyGvhfBQePTbnntT79BIz47VUX24H8KN5EWWYnpHZN0YXKlOIMVrMmFt
 cjNQrpA3l34aY8qPMs5DpmW4WBIj0XCxvpInRt51kFYr8xn2K1GnQ8xwojiOeT7o/K5Dcm4
 Ij4eL61IlizqsiyfXIXoA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2PooYY8Xq/g=:mJoCJIw5uS+jm02/czlfYP
 9RLp6bEgsrepvaHL15KZNnzG66OxIE4EsxHmkx67Oriy8ggnZxU7jJbECBqAAZddgwbNtGuVB
 LjVlW+iHh+S9fXu041in7d6rmvr7tIJ4lD/bfS8pfhn4kBvzOWFQUhgeZ3sOk0Kgv/WbuPgzj
 nIv1JyENs7mL/Xs+rg5aE7ANPPmILoxg25o0EADizu1ZEMbZx4vpEJCNY0zjsUHudroSDcZwP
 PgT8DiQyrAk+yTkYPEHRyh1E4FWUBlusEBBB6cfW/LlmYWfv2JuZ813WkEEDttGNfCfkf7NQF
 p0PNybCANnk/L/7tXsEJx8g7ktsLsCilOgNFZKUB/W3a5gKsGGUKGZINetrSkLxPOQLj4tJQO
 TkqeKgnXPfcADUiVWS54KBJH3xNf1yfv/aZBo01559E4Z0TU7ky1pjk8NPzh+Np+QTjFa2irc
 W1d5wq9lmPnf31ZgpA0QwH7kxQ+EnTir69zDFOnzgHq2sPpIZth1KltPeKxx/FeNhhS4EB9a0
 6YuOuJeNTrvcbUAxvq9Enob8l40CeDqVxtIwjxdZYF3vOZzl0guqE888jbbXvTeCGOWj5Dayr
 kWCTNRwtfyfx0oQM/+tquIrhHXsgKZCLcXQVOX6V4ysFl15U2mFr7Eh+nL/rvqS9XrB3KiBvj
 OXPmrEFQ4WLHffVBa/FXqlbr2r9wbUJWb7dYTepF/lDytFD4ywSI+ZOKPzUzzqImbS6AiUjn7
 3QWTQ0pD9N33qVLtt8lWQjTzbg7y/pYBZu94ELtqtC+3Wm2gJlkrhQPOLu38VopbP+QZBkUnB
 VJS8lvFfg+iyfyhGe5/kU8EfKkO9lcOFvGaqOZZVwSX50tnWj3GWBUeT0jGj4bE9B8BMuNAyn
 H32189Mmzks1dn0Y3/TgR8o+K+WRP4e7wm0yVAirHNyyl41d7pUinKFc3uGllb5a/nUxXboci
 dEDmQTSRL0ndAlLa6tMgkcRkw8An/ud4opBGAgIm8RP/vfH4rDADvo7paQ5o+ly4gj+kiqQZw
 93suI/6dpUvNJ10ZdE7u6Td+JXAlbJLjELuGj6iAqzOcCQ7ROPg5R9FWCf+YlmLrFv+x8Rqrv
 fOou3vdVuUhuWW6fAZIJZTHD1/rXnhBXk9s
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sat, 2021-08-14 at 21:08 +0200, Vlastimil Babka wrote:
> On 8/12/21 11:44 PM, Clark Williams wrote:
> >
> > $ ./scripts/faddr2line /data/o/linux-5.14.y-rt/vmlinux ___slab_alloc+0=
x340/0x940
> > ___slab_alloc+0x340/0x940:
> > PageSlabPfmemalloc at include/linux/page-flags.h:814
> > (inlined by) pfmemalloc_match at mm/slub.c:2772
> > (inlined by) ___slab_alloc at mm/slub.c:2874
>
> Aha! That's helpful. Hopefully it's just a small issue where we
> opportunistically test flags on a page that's protected by the local
> lock we didn't take yet, and I didn't realize there's the VM_BUG_ON
> which can trigger if our page went away (which we would have realized
> after taking the lock).
>
> So hopefully the below diff with uninspired naming should help?

I bet a nickle it does, shall let box slave away testing that theory
while its master pedals around the sunny Bavarian countryside.

	-Mike


