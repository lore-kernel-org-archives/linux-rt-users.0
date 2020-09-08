Return-Path: <SRS0=F8C2=CR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32431C433E2
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Sep 2020 17:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9CAF207DE
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Sep 2020 17:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gc3h5XfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbgIHRFp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:05:45 -0400
Received: from mout.gmx.net ([212.227.15.19]:40355 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731821AbgIHQTa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Sep 2020 12:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599581951;
        bh=HWiMzpzminiOVacuWioGGyuiL2hWzG3gNGSjFXXRoG8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=gc3h5XfMH4RVyM5NCIao46ULk4KlGnqNCS1d4O4/lVDFuvc/QY7Lc5dA180o6lRNX
         QqlM9bR6H+f6DOUGaBT0teU26GFuJwS/hU4PORWL2VL7/NO+d36Nymjx1zoOMsJnB4
         /Jbj0raPDuzYs5s/8yI5GjDpRDC8YflR5CDgYG2M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.191.217.72]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVvL5-1k5XQo0x1x-00RmTD; Tue, 08
 Sep 2020 18:19:11 +0200
Message-ID: <c6fb1171ce01388378ac437cad35972a1004cc6c.camel@gmx.de>
Subject: Re: v5.9-rc3-rt3 boot time networking lockdep splat
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Tue, 08 Sep 2020 18:19:10 +0200
In-Reply-To: <20200908150612.6qlygag7e7pzhr22@linutronix.de>
References: <20200902155557.h2wl2qpfn2rwsofw@linutronix.de>
         <46a2b89ec8d953a4be18c7389c7d8c66310a7ff0.camel@gmx.de>
         <20200908121902.zlfd3balosnu7ies@linutronix.de>
         <3471761a379062a474ba32f9d0157eb3020244cf.camel@gmx.de>
         <20200908150612.6qlygag7e7pzhr22@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+Slpmx5AMAJQKYsgHk2THLvnoAUIvKwiHsNyyyFmrTjb+Mce/rz
 MOAvXzJz0l6QYKITGyt3xgOcKztvQlwLPapvijl8ChjpcOmoGYl6cTd+tRow1s6ypV/rLpn
 2JRImdbpaz97n//4Yq/pMipctE61QIhO5oFTrDCsL5TKg+muYC9PmEu+EDPKfqyjW1dgIn3
 zQ08KCaGbOpqLA6cOjkWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5MGe4RmY4Kk=:LiurtD7d0bQ62pdy1T2iVK
 4WiSmFz3s0iSAhIerYW30IALshOpOrZB/M8T6fGO35iIQycK7OkUUi3EpJcsIHz8JYqCZUhnH
 93M/K25lvYWCb9VqxM3pI6zyGZMebs4IouT9GjjH1UhdCGOKR0+56V2NRFRMiqr89EaHppM0e
 +dMq7Zm8TXKZ2guWbospNAg+MTQxNScQspiKw0GoP+2Y5yB4sBQjIpqYTqvqrNeMVeOK3XKD5
 TqfxEjdnuHuXnaZ0kV0ol70qpZYjJxOe3mKeESzUpHmeDV5p22M8S1zNUv4QkSReTvwoYdmU3
 WVfK8u58TcolqSK2H8xObYoMtcTrfapNodNHo7+9SKI6o1Zmg7YgYWkURRTc/7/FjCcT0zYVk
 csHS4R+bd41DNBPcK+CJd6yzU6n57Gs9V+jbMuOaqjAIF+mrfCs+K2XPc1UrpgmqpWiKqVIMO
 Rxu0Nz2jNe8n+Uu2ALLG/lwc/l+IwCVTPhFi7cBsNR1C1NobRHRo9OBCqJNo1+YDB02t1LzVs
 QdlV+GB6zPwiHiSV3vK2K6zA1FhwWFFAeMCwvH7ZK0BvQ1m6AkKTYGzX4hMwHY50azQTYZNgz
 A4Dzt2mmMH1VywxLo2T0odLf70RzAADfaadIYVy/s3xEbJG8Um6LtCnsYl6tmpfJLeQ6HnED2
 qIiqaaxUuNudxSTZsTsrhREp91UPO/FNY70n3xSzLm+K/vtEHWX3a7OOYd4otiJ3VJ5EjnhmY
 YVrXNhXroBSw9WTEi6IlKQotl/RPyvkN7VvS707q8FLRzRLNJwwOyh9JmE4G+sDsVRKIVYH5V
 plT6c79nLGqqhM5iUrbz8y2Vt/uoplAenMqqSGDlzyG/BbJOlaMHQK1Bd76X5vktndb7P8XN0
 6Sqb0RyQ3B0vw5gt2ugIwBQL9fS1UYyV4GDGNJN6dP9dFf/J7X0oPrdZxOVtAPkq1E+RywKHM
 hwNFLP0C2xu51xS9nFgKzbT8Rxm9ftw71FJ5vGdVnTC3/Vzd1QjXiNDFQ5uPymR/DcaPw6Nqm
 2umBHu4y8yqlByHjwFbQQ8nEdCVebaItSLy9k7FDvUNV81BmK8T2AJIaoLECjeRje2Gpu3tKa
 DXGJh1Bek011lovRZG0f6CoTAMUMejQKOnDsIyjQ6yn66vfokBfdKfyKr3L+m0RyY6/DjTj/B
 60/IGWt5ClTncob+sxIXEG+do3Tu9NISseInZ1UT2JI8i2XfI4CdTksuxMO11WI34YYKmM5y8
 m/1tMUBNbj9jvvS/U
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2020-09-08 at 17:06 +0200, Sebastian Andrzej Siewior wrote:
> On 2020-09-08 16:56:20 [+0200], Mike Galbraith wrote:
> > On Tue, 2020-09-08 at 14:19 +0200, Sebastian Andrzej Siewior wrote:
> > >
> > > This has nothing to do with the bridge but with the fact that you us=
e a
> > > non standard queue class (something else than pfifo_fast).
> >
> > That must be SUSE, I don't muck about in network land.  I downloaded a
> > whole library of RFCs decades ago, but turns out that one of those is
> > all the bedtime story you'll ever need.  Huge waste of bandwidth :)
>
> I see.
> This should cure it:

I'll give that a go.

	-Mike

