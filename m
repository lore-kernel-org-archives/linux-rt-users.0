Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0906C64E8A
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Dec 2020 13:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49D58206EC
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Dec 2020 13:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbgLCNpb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 3 Dec 2020 08:45:31 -0500
Received: from mout.gmx.net ([212.227.17.21]:44643 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbgLCNpa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 3 Dec 2020 08:45:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607003038;
        bh=2mIqir140EzE4BPmL+hfWQuToYMW/fjvsHFlkHjV/EA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=KwfsYGzzwrC1Ja7/ApKjdNvQwUWk4omYNXZi4mqs+h09N6rzL/mkvI+nbP4g7HLqD
         rcC1CJFFKdI7IobY3M81T+6OC1Te/S2WjT4+4jS8BqyQB7Lj5f9RWmhrOuTqB5ByiE
         uafXpDv8AIMUzEymrM9NLO6IQQ2DOx2NWtQyWa+M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.149.242]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mn2aN-1kMAvp2SgR-00kAFg; Thu, 03
 Dec 2020 14:43:58 +0100
Message-ID: <f19f4df85d2469e5d186268f60be2657b7b8e99f.camel@gmx.de>
Subject: Re: zswap explosion when using zsmalloc pool compression
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     RT <linux-rt-users@vger.kernel.org>
Date:   Thu, 03 Dec 2020 14:43:58 +0100
In-Reply-To: <13b102c659c2880fcd98541a2844f0f9a028826e.camel@gmx.de>
References: <20201130132014.mlvxeyiub3fpwyw7@linutronix.de>
         <856b5cc2a3d4eb673743b52956bf1e60dcdf87a1.camel@gmx.de>
         <20201130145229.mhbkrfuvyctniaxi@linutronix.de>
         <05121515e73891ceb9e5caf64b6111fc8ff43fab.camel@gmx.de>
         <20201130160327.ov32m4rapk4h432a@linutronix.de>
         <fca7ecadf1bddafb7e88cbeb4a57d1464c87b044.camel@gmx.de>
         <20201202220826.5chy56mbgvrwmg3d@linutronix.de>
         <abe48cb9ab522659a05d7e41ce07317da2a85163.camel@gmx.de>
         <64ab382309c41ca5c7a601fc3efbb6d2a6e68602.camel@gmx.de>
         <345fdb33f5bc0046b80c6319e61e9ee33b83cac6.camel@gmx.de>
         <20201203094805.dhk3f7mlth3vm6ck@linutronix.de>
         <2b297170dbf98b36526f876650a2707e59d4ae92.camel@gmx.de>
         <7d4e36c78320ec01b56a12bc14ac3ddce3e26827.camel@gmx.de>
         <13b102c659c2880fcd98541a2844f0f9a028826e.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R6y3DfutfDX0fIqN/fmoBUh2gxpRiEqVPDY/TiFh134t8s1a3Ld
 CjmTWZc4hu3+n27vdD6nzfYn+0j6MeuUAec3rTbimgoSfOxcqkII/ToOceMGoTHIxchYNhb
 rJgCiMsOZtVLJ7rh2HFAYdQhp0Rn2XApelgB8qBbG+5XxuR3YdmkWQuCnWO9q3Ph+hSos+Y
 2HjKADiGiv9d4Cq6VP1Ew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uYQ5H8O4ZRY=:RNt7LYHpbWNUtMRI2UEdbt
 gznG+QZIfsiqwtlRNcrIcsTvv/NAxlAKpxJU/JUtGvpr3jbc/8FfmAeCbopi33yDrQihnCikq
 JVl6NrVAtZBPCgzvsHsbqqiLNsqRv2J0KFuJUr8qTe1B6qMhWGmzk33rlaUs55m7Xkhjs8Wfe
 xRivzH8TdwHjEy49Jp8Y6FbKfEr/q51FWZjGQxw8yddWy5Pq+Q+16cJAWCz2/tCu3YVeIeX7V
 xddllaC+MTcRf95N47yyQrcd2JE0fqtaZV4qtqWb0jp+yj7bpw55kWWMjoYZ5ZuJOA5b4UlJD
 48Mx0mMH+fx5wvpWFK8GR56t28kCZ+zCCMH6mUXLzZjY1CmX1Gfd32pyKTtQYjncsvw73+hhU
 MOaJ9EtAwJF3g5g+U8vpHRa1DTB1Xbp3IHqTvZVorl4DRWGyMXR2JLYVSs0TrtNhZ2xhEDI5z
 kbq8kzbI+Hp0cnm90HptneuL85CoIeGPEraV+Er7lblWLYSYfoT0MzCyx9u017gW3XVdn6lTX
 UHeq5++xx6ns9gU1/NpRiHHgRfD7PNJzLE1ge98bQ1bvg6/kM/TcUm7JoUIzJ2iwB19P0Rpqs
 2fp1TbKC/4dTb+bEhwy903iwBXG3JetAtYHbejjuQcFnDeo2r4ZMKJRm3sJKilzUMkpZp2LrE
 hUni20+1hMNgBxY5kz0Z5hoUMO04fHQlUEd+tBFDTQZSUiDd6NQvgX7AI+qi9N1w7wb1QG+gU
 jt7ZAPMW5etEKRmF+aMHmt7CAh60FdiJpIbxKXaCl3jN6Vjt3xyF7YCUImNwzVbo8bXoVPXSa
 Sq3Y7BiRY6MghyG1r3JdpBYKGLlzcVFAoY0xfqe+ughrZ/urZdjn4DBcsfNzwRXVfU399k5hi
 tuQ8yIa78hzURz1n/4UQ==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Well crap.  I lost the zswap local_lock initialization fix in my 5.9-rt
tree during an update, so will have to retest.

	-Mike

