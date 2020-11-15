Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF4EC61DD8
	for <linux-rt-users@archiver.kernel.org>; Sun, 15 Nov 2020 04:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8E5E22409
	for <linux-rt-users@archiver.kernel.org>; Sun, 15 Nov 2020 04:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="P3tVUlQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgKOExK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 14 Nov 2020 23:53:10 -0500
Received: from mout.gmx.net ([212.227.17.20]:37151 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbgKOExJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 14 Nov 2020 23:53:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605415954;
        bh=dmBd2cfK4ZQ819sShRi7EdQJWAYvfrEQtwdzIS/N99M=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=P3tVUlQQy+dNSieoEvCXmUBYvqhBVzg3npY2p4mQp3vk6sD7hft6Ch6m1MovCe45K
         jOjnqp/wWbjnng7YoMykL3MBDsGXNDuLg+hEDYsgPUF45w/fkvLCw4xld8iGZRwd/u
         IzVL+qTzp9QKrq3hfauYREmEVIZ6oBnMf2YLwG74=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.172]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUGiJ-1knp5t2nRb-00RKVi; Sun, 15
 Nov 2020 05:52:34 +0100
Message-ID: <c09b5a4153cfea8ed181bfb48ade0aafa9dab6fb.camel@gmx.de>
Subject: Re: [PATCH RT 1/5] net: Properly annotate the try-lock for the
 seqlock
From:   Mike Galbraith <efault@gmx.de>
To:     Tom Zanussi <zanussi@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        stable-rt@vger.kernel.org
Date:   Sun, 15 Nov 2020 05:52:33 +0100
In-Reply-To: <0936e53c297ef3202ce3a48a135053f468c427af.camel@kernel.org>
References: <20201110153853.463368981@goodmis.org>
         <20201110154024.958923729@goodmis.org>
         <617eb5e8478df466afa9013b02a2425f7c4c673f.camel@kernel.org>
         <aa57c01bceaaac362d4da6e25427827fabe4d37a.camel@kernel.org>
         <6209c8773bb1d361266046323f266526a810f850.camel@gmx.de>
         <0936e53c297ef3202ce3a48a135053f468c427af.camel@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RqZ35syf7Y2e9Rxu29QwF2gNJps7COVQy/Rn7NnDHlryKpNypst
 OQSUYv7jfMta05/S8K9DLs/VVhvBfCdcGMIXVftkRHccrD6Npwn/7FHOBL/Bk1ALhUVz0tb
 j2X+VeWs3BEkg9la8AZvLCOpcQqdMfNPQgVYZZ6jlu/ZIOZlfuF/RhB/F+bbOSJEx21AhLf
 bp2TjQk8p6zcKDA0R7P1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E7jYevKY1fc=:cRIcrBSYL/5CgvhGhK4MzE
 fZ2fl2/DwZl8FK9xO9+Lc3NpzqIsd9GcdTDobbYtgYFxoHcoejH+ZUK+R9W8gl6AlIjXxjChj
 +biznzAI/ti48q149o5w6urpSRuIbUY/IsjD5yyO7WJ8EPIUUUFdkj6dit+CMrSFAp/zKdivW
 Q1wMzScS8siCOMIjr5aaYz4abuLkAitYX15LT8TePIU+pPVOSZCIRyObNGILzk0PdYvooIk6P
 TCxcUAzAcXw10JnQCP/NT+e2xhPshfRiGLNe0+mdBICcG0etSIsF8YwJFKSp+XWG1UZMfCEl8
 0OTvwp7gpJ0Vjz6vQguxfNjdL1/cJnJdjwaE8UsxBfxaheJboOvENrMTwwhvFlkGxfPAr+dhB
 TgrpX5RJAu9Yr46EhLODDgijGcpqVldPrEDJtpMuPQ6J6IIWYngDb1EDiaUFfCy21hSCy/Wzq
 zJncApby8ks/Hvsonxsmt3k5AizbCn/F0ZDzGPWK1JAM8mSp6sqPyrP1OH+tJMs5mpVx6nkiL
 GS/X5+Lz9D89vPcA+qBafoWH/j9iBqryr7HLJ1E92Elye7OxBMWQKOYbGyxO5uh5F1s78+/O9
 1yn8mSjvDe0gnj4F7SpE0DWLIvcRMy/2hj7lzp4AaOemRa1nT49H2gVkMghFhrxOdNdeLjrMH
 uKWfRK29ZUAW3Spio/ZYyEDBgxBskv16gnnRGed1BnzgOV1q3ljOdFAj79+bL1Su/OnpHrBX7
 gUbhAtFSP+BM4r0Bw8EoOpg/yQnsqNYsyMNcbYib2BI2HU6zUDmB3CmawTtJKao2MH4SPgK82
 flCWrWtEUjLsCj0/MRYuaSEiOXQ17CqFnOuEKUg4Rztz18NGbSd6gBThykaPWpS+x6Oq2gu3Q
 DMGpKhpKNJum8Oucr9Xw==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sat, 2020-11-14 at 13:24 -0600, Tom Zanussi wrote:
> On Sat, 2020-11-14 at 20:00 +0100, Mike Galbraith wrote:
>
> > __raw_write_seqcount_end() is an integral part of write_sequnlock(),
> > but we do seem to be missing a seqcount_release() in 5.4-rt.
> >
>
> Yep, you're right, it's just the missing seqcount_release() - I'll
> resubmit with just that.

Or just drop the backport, since it adds annotation, while the original
was fixing existing annotation.

__raw_write_seqcount_begin() called in 5.4-rt try_write_seqlock() is
not annotated, while write_seqcount_begin() called by the 5.9-rt
version leads to the broken annotation that the original then fixed.

	-Mike

