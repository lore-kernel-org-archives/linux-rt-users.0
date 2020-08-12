Return-Path: <SRS0=Foxt=BW=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1254C433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Aug 2020 13:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 711E9206B2
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Aug 2020 13:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3CKEgAVL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A87MKS8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgHLNvt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 Aug 2020 09:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgHLNvt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Aug 2020 09:51:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D07C061383;
        Wed, 12 Aug 2020 06:51:48 -0700 (PDT)
Date:   Wed, 12 Aug 2020 15:51:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597240305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+3kVoq9w4ldqVEl5dCV3XCb9BX8aAVM+5QyIJqtT2VM=;
        b=3CKEgAVL9t6YI4g1rGc76lWIBGe1bW3Q9/dhUqA0Nslk4DPhrSnsvRTRsTU3vWZKP1VvLF
        v06eZigwAm1zj4vY1KJCNmjAIYqzv7Nwnuxs1avq/J3gpmNL6iJrJ5PQFxzCn4VPf3Iw/q
        vShMgA+aTsWWX8JbK/Q7BRJcavUAg8ltqBMfc7e/DBof5U/YPP/XmqMqK92B9gXFFJ5LM3
        N3NN2BXj05RIdYyoc0vaPy97+YiTEs9Ls1mkMWW9jsD0jDG1MEh0/sRKA0c0KJh4DveIlv
        mdXBfnSuWiB16t/O/im8Zv4dIlzMXE8XvCdEmFyECZA0geSU7Qr9FJLlF/JtXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597240305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+3kVoq9w4ldqVEl5dCV3XCb9BX8aAVM+5QyIJqtT2VM=;
        b=A87MKS8BjGXHLbw5Coalz+9eS/4MKePNmq2StRQ1Wpm88yPjaCZNCm2EIgL8LEfYS+o1a4
        6MgO/lYYsLitfYCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     David Miller <davem@davemloft.net>, Jiafei.Pan@nxp.com,
        olteanv@gmail.com
Cc:     kuba@kernel.org, netdev@vger.kernel.org, claudiu.manoil@nxp.com,
        ioana.ciornei@nxp.com, yangbo.lu@nxp.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] enetc: use napi_schedule to be compatible
 with PREEMPT_RT
Message-ID: <20200812135144.hpsfgxusojdrsewl@linutronix.de>
References: <20200803201009.613147-1-olteanv@gmail.com>
 <20200803201009.613147-2-olteanv@gmail.com>
 <20200803.182145.2300252460016431673.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200803.182145.2300252460016431673.davem@davemloft.net>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-08-03 18:21:45 [-0700], David Miller wrote:
> From: Vladimir Oltean <olteanv@gmail.com>
> > The driver calls napi_schedule_irqoff() from a context where, in RT,
> > hardirqs are not disabled, since the IRQ handler is force-threaded.
=E2=80=A6
> >=20
> > Signed-off-by: Jiafei Pan <Jiafei.Pan@nxp.com>
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>=20
> Applied.

Could these two patches be forwarded -stable, please? The changelog
describes this as a problem on PREEMPT_RT but this also happens on !RT
with the `threadirqs' commandline switch.

Sebastian
