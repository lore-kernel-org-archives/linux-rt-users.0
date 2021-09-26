Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C78C433F5
	for <linux-rt-users@archiver.kernel.org>; Sun, 26 Sep 2021 04:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6607261077
	for <linux-rt-users@archiver.kernel.org>; Sun, 26 Sep 2021 04:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhIZEGw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 26 Sep 2021 00:06:52 -0400
Received: from mout.gmx.net ([212.227.15.15]:59003 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhIZEGv (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 26 Sep 2021 00:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632629105;
        bh=gNoS+1G//dKHqb2jotl+IpgDR3+gShgYQIagW7CLotk=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=g079cvit3j0Esdv10Ewrnb4IoMy/i0TpciLMrz1+/EHqMi9LAQAqCAxnr+eBR/p3w
         ZQc5VRXVQGk6mr+w0ZZSwBrvCnv0v+pV1tLHlMJMyPyqawxVRP0Q2MA6n36sZccIue
         RiOsGh6KLgPkVixdYwGZoQiziKtqv9LSZJ0iCqb8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.50.193]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdNcA-1n3PBB2FxA-00ZQS7; Sun, 26
 Sep 2021 06:05:05 +0200
Message-ID: <a105fecc71d4b721d4e025e2caf2b13336b5d0fc.camel@gmx.de>
Subject: [patch] Re: v5.15-rc2-rt3:  WARNING: CPU: 0 PID: 12 at
 ./include/linux/seqlock.h:271
From:   Mike Galbraith <efault@gmx.de>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Sun, 26 Sep 2021 06:05:05 +0200
In-Reply-To: <e903e245a501d230e90e32d00460ec0d19cc8878.camel@gmx.de>
References: <20210922210006.rmfpkps6hguyo5ll@linutronix.de>
         <e903e245a501d230e90e32d00460ec0d19cc8878.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/N/lsyivwQI/SKAAyRFvKxfKrhxHCctz8UQWEel/E509jfj81k/
 gbyeifFbTD3LZQSgC04CM3/yqNTcm45Ml7nyezTDbnvXZYkftc9siN4z+w6njLH10qDKn5a
 uMA7ueUX+HLyNZbOfKM9WGpO6fU7g0VmT9hxDeKXIcoOMt6e2mqMBLKoVffh1ajrCt2v9Ru
 7nXDJB3+7LRtGrX3guD+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F+w3ujr1+js=:mH76e+hzAPzKoGCi5+OQgo
 nFClCsnRU6w3Kedp3z3YWuui0HnMIu3+SKbzY53ZAlMI+WD4ysKzUoucVTLaFCrCyP0AJmEA5
 jPVrChnca4/Xknnly8VG1g5wKXITYsI/ZYvWtwEGyU3D1EqtFNbjlxP07riyAqHlP9mY+rMxi
 B/aRWcv9pQlwIHZsEW6ExoHQUOztVHCuV69vwydEcYzMQosBaIqGZ7OnUduBgUcFql0zg/1O7
 s3AVt0L+Aqm0Ax4n/pRaByLPVFGJ5k48aIdO4z9hFGJiFbgYQUbmj1FDSpN9k4A5SEiWFneG/
 +/6Cpu2JC8geoEhCGp1ACJMDF1ZaAPcB/wwJrOmhd6yrXJrXjozJtFh1k+ZZgAZ2fJZ7k0eYE
 8/VB3HXyI9U0O1lcwyUunnhbsiiG3LO2TzyZatRW6ehp4ddoFvScxkb3l/s4jcx/0/i+1Ceqe
 oY7Z5QoPv9mO/vPx8uMvcZIAnGACd7wW6+FLXfiIyiml4A4emsEYUOisei7x4lXgyAcf7t0CP
 rVwlqG1wD3gfxcFhXAJ0ChMwsIvZK6rldY8qiSeI2rZd7FJjyV88F4I3q7tsPOeNUiQ7LlXLn
 d6bDiCQZ0SQgcambmgI5vD5lwIKqAE/enWHdwjgq6v40LW5Q6hL92dlN++AzzPalYM3ll52Na
 UdGaAwpYLzoDGFV1fUNTRN75CfVi5fVxaeEs/eO039CBezMR9o16+Q1KYm3EqKeEguCYaY7fP
 /c8imaXiy7wU2E6gbRNON4ZvQ5oDRNfnx8NFv/sZR//wBafvy+gG0yfc1hSu6EpAzTDISPP0H
 D5xGwwWCQ1eamQbQTx5pQvBAzcAKAVoUgfQFuApGgUYWqaqmFDnK4xMMSn31OMWJB6wD6oOyE
 psymr3ra8qbCMLJQ/O9KJkbJ3KXYw1C62Jmtf+7Pf66EDo2iIFgWZVuH/Qg8IDX6ul60ECTRz
 ZOkF1czF2FY7+Of0gA46Tgv6FMmfUxRlpo+rRx2A9ZGZFAj0FNbQ5FG8sN4wOKoMY9m7uEuuV
 hNYaB7hywuJyuUPGN+j9XgoesF/2wq8iKwSQQ6JFjnDEIwYsI3d48epjc5N0fesC6x76y/ffy
 r7EWV89Mi6wvn0=
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 2021-09-24 at 07:22 +0200, Mike Galbraith wrote:
> Greetings,
>
> I met this lockdep_assert_preemption_disabled() gripe when starting
> ltp zram tests.

Before actually, I just wasn't paying attention.

<snip gripe>

net: bridge: mcast: Disable preemption in br_multicast_update_querier() fo=
r RT

write_seqcount_begin() in br_multicast_update_querier() complains about
preemption not being disabled during RT softirq processesing.  Since the
read side spins, disable preemption across the tiny write side for RT.

Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 net/bridge/br_multicast.c |    4 ++++
 1 file changed, 4 insertions(+)

=2D-- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1679,10 +1679,14 @@ static void br_multicast_update_querier(
 {
 	lockdep_assert_held_once(&brmctx->br->multicast_lock);

+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
 	write_seqcount_begin(&querier->seq);
 	querier->port_ifidx =3D ifindex;
 	memcpy(&querier->addr, saddr, sizeof(*saddr));
 	write_seqcount_end(&querier->seq);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
 }

 static void br_multicast_send_query(struct net_bridge_mcast *brmctx,

