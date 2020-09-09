Return-Path: <SRS0=FZAt=CS=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8126EC433E2
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Sep 2020 08:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 180BE218AC
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Sep 2020 08:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GmIkY3te"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgIII5O (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:57:14 -0400
Received: from mout.gmx.net ([212.227.15.19]:57119 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbgIII5M (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Sep 2020 04:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599641802;
        bh=6yeIcnDlDXF/cSX3A7mQFqErPV2eGD3O9fY2RZ1wFK4=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=GmIkY3te10cRNduDS6hxKQ6NZ0UfffmI2SeR8JEux2LiQWcwrFFnZwLB78BRJCpTj
         1UWKZxauF7JXXbprqZbmbGAJ68Zh3s3BvbCOTBaWAIZ9E4VMquj5aOUY+VggP27B0x
         w7/ng8mWULqkIODglI3gJXLcGjSXrb+ORYmWZuUg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.191.217.72]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOREi-1jtQwe0KT8-00PuUJ; Wed, 09
 Sep 2020 10:56:42 +0200
Message-ID: <327d42059a3d31bcb3439d5fae8b3c36019d8a68.camel@gmx.de>
Subject: Re: [ANNOUNCE] v5.9-rc3-rt3
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Wed, 09 Sep 2020 10:56:41 +0200
In-Reply-To: <20200909082056.sw32jevyhdm4mzcm@linutronix.de>
References: <20200902155557.h2wl2qpfn2rwsofw@linutronix.de>
         <6ed14b9743f5ce400137a4ae5561604575e72b13.camel@gmx.de>
         <91828ea63ecd61d40bba0358e1c0efbe62976ba6.camel@gmx.de>
         <20200909082056.sw32jevyhdm4mzcm@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JU2hlvyH1gZLoT6yKMTSk4BnOfqMWqbqPq61HMG9Q7GDn8YDh/7
 uyvXqCNvQHop2HM0mF4Lkmznsg273ZbmghMChAIvSDnf60ItvpJqlyFsttnJks4eQvhZ+6O
 rMat6m2jhMuPrXKhHeQT8XcGT8BsM9gP2O7tP59Q5GBb4pwrwltXzEi6bNd652gNe1LqFzH
 OYZCwTPeSC6ntOJMk2hGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u9OekmghEaE=:vktCdVt+n2j8cOVgp4YR/A
 T/V885UrR+hpFffWOjIll9l7NxubdT/VIU1JQhIK1qMhz2EvHNyf0ZzBZi/pkx6i87omYC47I
 9evwd7yhramsIhS5JC96HJYDZ86zjUlG+9ESr1kC1wGISj9fPvg+I7HEtLqwaRY+KxMJxB/gt
 /2EkeqwuSDpBNTPGYXcm6MZmLa74bsOnOPod5VO75G2kyC8TIPK10bW0dGGAP8eI52Zrfb5cF
 yI+yvkaX3xN8FoGwM7s0bMP5Eb8CrAaMEqMYUo0to1gZooonsj50d1eKR7klRluxTdMZZZSGK
 fhcKOC/zr5meOZRAxBCce7tEtRmIUQy0trL/1HB+Y/vlaRwIAsrkMRSl2T876vdzxz0XTMiAy
 tD+FNY35VAqoJIK2wGOuobiTaWFPgkOpYdakVlrMZhBExbbSC6RnZ6aSSTyiI0LNie/ljvqVb
 M/KNn6N+Rx0y+sVL8yphzB8M6licdKDMD4Xzj08dSaYESQt+TTKlPsObKJxeGmVrovMW8l2X4
 vAXATWPQH5KYj0TRS72uMvobtGOB+rm00yn6rzg6Y0hy9FZCsm1UmrweUyFz6Q60YBztENUiZ
 dA8vTII2nP1ofemCEGXatAPLWaNQ9EI+pGa6Nz1FYHqIdQJIBr1SPyTR0rLVpeorUj7Z+8Lzx
 WP2l+GkE+tAATyL5nN9NHRXSVwzERlH5PDb0aIBUNeMfMttKxMf8+QeVeJf57DOMKuHcDcrgz
 YmfpaeKE0DLH8Zv2hPedehdiKTdySqSPlsK3tvDNXtGRezhb3Ny3/dSWvUL1wE5v/zsBnai7t
 Tt5rKEvAKfneJO4TdYRZRM516wSOAxt+LtcUD7Lg45motwiWI1LSWxWoiSx92x7f9cJiFzV/A
 9I0dD+P/SikNkg9YEi/giGmcotBObDWdn1Bl/QM/U+eiCqLkPwOAk6IBo62URb7qkP6Vgh4jX
 z7n0355ML94ouVEoFsivv6oKlE+NcbrjYN2534A3XJPB/xWaDyE7aLGg41kSFAzyF7/pXFcC3
 ABidcSzbTPeDpnkt6+PSI46vS+WTdKpZSYaSmbi6t4LCK5WTP3VJLUPf01/+lwYiGAGQ01WKw
 L9HrL5rV2Ls10XjbX6k7VUnJkF+lOTT0rLGYd+gvoUjIh9UYHh33Qibn9IB6cQAQfswxHxcep
 zMKyZxwD+J6gDsjKs9SvWjpLAn0ht4Vw6IIdZxTB8sYBN5tBdJzIXYNEFerxodISrmpE7OGg8
 865vRGlwq5giyLqBT
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 2020-09-09 at 10:20 +0200, Sebastian Andrzej Siewior wrote:
>
> Do you see the lockdep splat without nouveau?

Yeah.  Lappy uses i915, but lockdep also shuts itself off.

BTW, methinks RT had nothing to do with the nouveau burp.

	-Mike

