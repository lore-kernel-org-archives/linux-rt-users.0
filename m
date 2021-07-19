Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5BFC12002
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Jul 2021 04:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82039610C7
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Jul 2021 04:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhGSEEm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Jul 2021 00:04:42 -0400
Received: from mout.gmx.net ([212.227.15.19]:57755 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhGSEEm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Jul 2021 00:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626667299;
        bh=HCJDDIc8iDe4AoIykd92qO5vSXF85+DD8a8vNQB+A8g=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=cGo4NqQKp7+AFWiGcuyrcHSR27bvHkaj2gecQE2SB1a2UjbW05W2QXrEprXW0y4J0
         dGzRp2vKu0T+oYyqSQcAr9neYJaMR+Wkgw0FkbZQQXJTcy8CjMWPcFZRC/ZHO6ApgC
         BmdAEwW4MzhncpjQ8Bm4d3J2867C4oofpXnOZk3w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.216.243]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mw9UE-1lDEPv0Rca-00s8YH; Mon, 19
 Jul 2021 06:01:39 +0200
Message-ID: <00a7c04b109c01a7668abc2a8192a6b889765de5.camel@gmx.de>
Subject: Re: [patch] v2 mm/slub: restore/expand unfreeze_partials() local
 exclusion scope
From:   Mike Galbraith <efault@gmx.de>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Mon, 19 Jul 2021 06:01:38 +0200
In-Reply-To: <dd10ebb3-7687-6e8d-8984-3dfb9cd0e927@suse.cz>
References: <87tul5p2fa.ffs@nanos.tec.linutronix.de>
         <8c0e0c486056b5185b58998f2cce62619ed3f05c.camel@gmx.de>
         <878s2fnv79.ffs@nanos.tec.linutronix.de>
         <6c0e20dd84084036d5068e445746c3ed7e82ec4b.camel@gmx.de>
         <7431ceb9761c566cf2d1f6f263247acd8d38c4b5.camel@gmx.de>
         <476d147ab6eec386a1e8b8e11cb09708377f8c3e.camel@gmx.de>
         <dd10ebb3-7687-6e8d-8984-3dfb9cd0e927@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UkBuBQ5jP2bFLgAIB0WM8jYjER0ZRFI9JiJltyIlE3wLomFEH2i
 Sv/KZr24o4ZDf8yWg9J+OTW3xeW48IJRmJY7hFIR2Qpece0IbgvJ1t9exJqW8gv3Sd4fHjA
 /VIUzo4uRM/O3NJkA+CSr8rJi4HXGRxVyaPCWmise3W9n9bP3232/MK36wjPOTpLkiow1Gb
 w/S4c6y2I2AmEHkqFZB8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CtdQEPmWUWI=:hYCyshGp2oYcnAnuvPJTr+
 QBq0eJ/7MJgQgmmlCoqytu4GZMMbMtm9vjFt4nHUQqTPUpvy/wXS07Ih5ejpFHKJUO44bW9Cz
 xC0fw2GwFMe4Ecl+Ioj+Tks/+jlBRkizUoioI1Ol8zc+F9ozMp1NsmMKpc0RYcsT//w54sl5/
 Bs17QStd9ESQC3YpRYC1VpT2Wzs5Oa62/gs9oV/WSYjI5+h46ch0UxIKbfbIGk6Wjm8BCITFA
 EUtwf0nG5bUOGrEFnCI0Cy0/1H5xdtGrvVPv2g6FWzdEPSkhACLrbEZ7WYTuihX6IzwNMcsyC
 8R+vliVX43aUPNAibJwdUG9GpS4t59PcmDY/zzQsDGw1B+wjQX5cjbDm4z5RdHPX1U2Q4RzG4
 eaUAfuiduNCVMt04CjVzwVxtAFXp2VAUFeNw+F6GL6N1IEgRzzw7APQiCmShrmuwkts2itNsk
 2oJiCXzoba/bV4EhNW8+LScWTzwlfju9heSkbh7vM8RY299Bp/gvIepBWD9OwYmznBOgLqboc
 ljlFpfROT6py9A0U0qsw6KtLgXnLatULR3waP2PbvSae7CXEmvhdFg4bUaNj6NjTsmOYY8e1Y
 2StdaAtRNerjpObVYj6VlN5f3u3gCnN77aN4EKcgih6wLCJIIhlUj2YTk0yD4oQA3ra31jDt2
 hoWUtlyEHfwRz6/YzdO22F3KbQwHdBeC1/sp1QHonIH5x4Hg6KBWzstdF3/mSDniz+y2nLmJw
 nFTEgRjdpNq5k4oV2+LFQYFhLIcWrIxuE+0AUK0MQEV779I8o5g84IgBEB+dNPXIYQJfBO6+/
 c9yMyXK2OfYQEvzNF/RxNRR+21K1jNcJP2i3d9NQsNjUs85JCaanYXrlwCTrnSYA1jqZ3DjrJ
 4QK+4UwgExBCFaX5BLdTRvSZq0kxCJJQgUwnegp/Z4Vtr++9zypLfGdL/s61HMx82HAOQb6l0
 HERxif3awRCHKeY8hGaifZL/B6IgJ8enTU0wUVfx4pa+1DR46w9Bg2FteVdvw4rOam5zO6FhC
 S2XwiNCT1x+NH+UpH8Yv+Ea6CDX/W5oKIlc7lKqP3JfnTDMYvKrSsiKbrMRTtk7pJDVE0kXir
 ErrY8Vao8FeDrGVGalTwUgxmz4m0WL4vpkm
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

(a pox on whomever broke evolution text quoting yet again)

On Sun, 2021-07-18 at 23:19 +0200, Vlastimil Babka wrote:
>
> Hm you mention put_cpu_partial() but your patch handles only the
> unfreeze_partial() call from that function?

Indeed, and that's because when I poked that slub_get_cpu_ptr(), it
poked me back by real deal deadlocking on boot, so I posted the
restoration of previously existing exclusion points with the
unlock/relock to appease lockdep (big hairy wart) bit instead.

>  If I understand the problem
> correctly, all modifications of cpu_slab->partial has to be protected
> on RT after the local_lock conversion, thus also the one that
> put_cpu_partial() does by itself (via this_cpu_cmpxchg).

Yup, that's what I concluded too, but box disagreed by not booting when
I did that, while seemingly being perfectly fine with the one in
put_cpu_partial() itself.  I figured my slub_get_cpu_ptr() replacement
had failed due to list_lock/local_lock order woes that I didn't notice
until after box bricked on me, but despite the unlock/relock in this
patch, it still manages to be a -ENOBOOT.

	-Mike

