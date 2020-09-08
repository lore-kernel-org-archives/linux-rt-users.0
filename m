Return-Path: <SRS0=F8C2=CR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661C0C43461
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Sep 2020 15:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 082C621D1B
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Sep 2020 15:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="RcInVbxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbgIHP1K (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Sep 2020 11:27:10 -0400
Received: from mout.gmx.net ([212.227.17.22]:48097 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730276AbgIHPYe (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Sep 2020 11:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599578647;
        bh=8DuJAfVQSI5mi44z7RncHDbEJKd6gWOvbmvHlAkeqYs=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=RcInVbxucCoTUTPwsHw8x0fmhFrdXVlQxVxCsG9ttgPP71NaIPjwsx4pc3ZmNw5HM
         ZxPAyaGQJ5Tv5jj0SGo+dpI2u+X2edsAc1cXh+RlrNEvJx4xcKIcvIECweFg62lLSE
         fkWEXOARsD/IUBDm26iFw0fDzei5WsLIBUw3lTCw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.191.217.72]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Ygt-1kH1Yc0IeJ-0034pj; Tue, 08
 Sep 2020 16:56:21 +0200
Message-ID: <3471761a379062a474ba32f9d0157eb3020244cf.camel@gmx.de>
Subject: Re: v5.9-rc3-rt3 boot time networking lockdep splat
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Tue, 08 Sep 2020 16:56:20 +0200
In-Reply-To: <20200908121902.zlfd3balosnu7ies@linutronix.de>
References: <20200902155557.h2wl2qpfn2rwsofw@linutronix.de>
         <46a2b89ec8d953a4be18c7389c7d8c66310a7ff0.camel@gmx.de>
         <20200908121902.zlfd3balosnu7ies@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M5FgYO2QJDW20nMv2t3ujKxQ22Mo1eRsB9uGCSrp6bT05KUNWqQ
 azozruWZ/7L98+6Rzkm0wb6thLQOgqZTIU1vyqLhMVhbyrdAwwf4RqvILSAd8RH/m/B+a6x
 4HdMXpZACnGm6sel6EYk8yFGjUDyHs3kbh38nHev9UVQLZJyh7Svui44XND6pSYuUbVYd/O
 p2Txib4+PDP1lVKScYedA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dpxL1i3JU0Y=:zmz30tFSWPxRetHJPZfOIy
 yNEJIQkiLdLldmC1GFDz+TFHOAffjprTNoH1Gn8fpITBF8dtWGSVvEldw/xFUoVY+j1mzJBo8
 ekbJpX73ZxuRL7i3rwdbOXeOZaaht+AiMiVUJetdppMilJjXA4rj2BFCoN2quK6XW+56XW6ar
 qxyI1Q+NA7wWOWSX2xKOZUqBcr+IhPR4pE4PzBSqxcm/zuQM9owmgjtxNsHUoIDXqFWnwtSII
 JL1WiY+P/c3bvJ/1P1T4X0EXeLB5LVmhYToXkaE4+kiQqBGLGE9XroRWfrnsdmF2YCLV6r0be
 hz/aIVLDNg+2aO8fa2LVouEVmUCHlgNJxe3EnKRS9ytfoCxwIUWf+CnC94av+I4Sq2DNfRGcf
 sOE7cOJlx1R8nd+VksGLnNFyBSaWmp51kNEKvuOZyBmLV1RKtcIK8wniSlB0/F8rXP1Sh2GJG
 RuQPaov34w+R29ESoczt+ahcQJL8SowOy1dxNgx4X0mZF+8KWRprCb6itEd4SxIeAuQlVq/Sr
 xQ2Vcqouvw37FJwOWkUArQ1qIcePOCbkDu9Q1+nae4AKzGAa+BB5kTa0B9xZ70a7pQ8CRdm+j
 n30XGH8gUXPtCcP2Rjv+VjtdcgL2B9jpRKVGQdHnSTJi7S8DRrxxY1r2LzAxhPj/w4vSBFcS7
 rPHgL+ELm45XIsawpsV2FwIcqVqt+fn11vrPzSt/eD5rqqUWRYdXsT1eT+mPVkVSvDtE3JdEJ
 qf3Mk92vAntfx7zmMsoYQL1QBd1EScWWNmyHvRmP7kp4/r4RqIpaZTjKtNBXr15a7BoPGc3Af
 Wk8PnErv+Hkkhctm//5boCfbA9gd7DdnwWzg/ZFAlEHLhXrRhiUpCEslKeVJAzOS4OHXtbSEj
 2cM44tXXOWShfV6xJ7Pa7KyyX9WsY8kEQSoBKflLyVjSOLfG4IfR+oszpif886whiNtCacjUL
 FHBgpPKaZgOMHnUqD7w9lGKvDyX3wyo6AxmSA/Mex0/FgtIJiQm0w+ct8QJ5GuAEsORNTjVIY
 Dz9/7tKOxFz/esWgOaNZNOP9ZBQ1oQHoN+emLa1PgaoHZ3x3YSQ4l2QbZuLTSuhgFbp78Il9r
 2zxSVXitUB/KrnyqGy5q4LchEJ4p3G7N6ivuHIbxnBWH5BJ3tZmrQxkK1PC+OfAWekmZXCvTf
 Az6WqcdQBqFDKodS5Bjal6q84oomLWoiDPuXEyXQn+iq3vgdc/5rPNpYcIE5lOoQI0n+ilOFn
 Trb2AUe8iSSWPtT/F
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2020-09-08 at 14:19 +0200, Sebastian Andrzej Siewior wrote:
>
> This has nothing to do with the bridge but with the fact that you use a
> non standard queue class (something else than pfifo_fast).

That must be SUSE, I don't muck about in network land.  I downloaded a
whole library of RFCs decades ago, but turns out that one of those is
all the bedtime story you'll ever need.  Huge waste of bandwidth :)

	-Mike

