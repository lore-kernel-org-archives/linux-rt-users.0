Return-Path: <SRS0=gcb+=EK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A3AC388F7
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Nov 2020 13:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A52D122243
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Nov 2020 13:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="AsgEp9Vf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbgKDNn6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Nov 2020 08:43:58 -0500
Received: from mout.gmx.net ([212.227.17.22]:40043 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbgKDNn6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Nov 2020 08:43:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604497426;
        bh=ZE5ZUrz+eX6JUUIXYlmohOjZHy554fCZe+KD4mKq4xw=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=AsgEp9Vfer2g4DcB8vChLXFbR1k/LE3P8PcXVnUeNqii1Eq61HBOa8WndSxaQc1kB
         /6Lit2G5cmDzsyKjy2dtyU485BaA+tzrIY2CImnYMMUjdSwnQptmBUbSV5sqsAkwoz
         tEG5P3h/qbIylZUevFnuVSYcktddqbaXuvqz4vVs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.148.80]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7R1J-1kHmGN2xfp-017qKb; Wed, 04
 Nov 2020 14:43:46 +0100
Message-ID: <a9e88887c027b11596cd7fb96c425011c36e5d29.camel@gmx.de>
Subject: Re: BUG_ON(!newowner) in fixup_pi_state_owner()
From:   Mike Galbraith <efault@gmx.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Gratian Crisan <gratian.crisan@ni.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Brandon Streiff <brandon.streiff@ni.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        James Minor <james.minor@ni.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Wed, 04 Nov 2020 14:43:45 +0100
In-Reply-To: <87v9ell0cn.fsf@nanos.tec.linutronix.de>
References: <87a6w6x7bb.fsf@ni.com> <878sbixbk4.fsf@ni.com>
         <2376f4e71c638aee215a4911e5efed14c5adf56e.camel@gmx.de>
         <5f536491708682fc3b86cb5b7bc1e05ffa3521e7.camel@gmx.de>
         <874km5mnbf.fsf@nanos.tec.linutronix.de>
         <871rh9mkvr.fsf@nanos.tec.linutronix.de>
         <87v9ell0cn.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1KBT2LI65IuXMXwAZatbzWllDiPxEaD71wwzDGPRUU0jLD6H8tb
 nIig2MJ/Ty/XbQ4CmTs+spo2l4WWXSdWw2MUDZLVOkvy/MuzUHdDFRmh/9I/EugfET//Lsv
 ll+zQtFWfDeX4u2rXxHSpaOk8sWWmjjO61d9ZL6WRT2N/9UCZ1yV0Y6o2vfEuTDzU71rHnM
 8/FJ75I+rMmfm3CIH8qhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lqj8mH/0E/4=:1HbYdIVEdTTdwtxi4IgKB2
 6AsgF3edf0Xc/nXC0hATTWqkWBRTQkhhlivO5s5B8Drjj/EyWXr0/O9G/9FLKXHlyczKp6wu2
 LByyxIxgGk5edSxIs4xL65wPJLzItMJJLQJxlYP80FhgQ2WEJwJGwT9SikPMtKfKT+XsJXwQ0
 lc8WZDOr/CyzpDXOAIDzKkMMxkBTYnkGOK47+5k5t38WkfP92YLVFwocl783YKjP9BOYPw/EA
 s6qfeyku4UJjqdEYR9CdB8CL8jfwI/9TVeCH3FhmhbnoygSC85IMHQqQoUE0BrT6HCRoeJNpY
 VA7NrMX/ddrP6x52VUGGaXJFR6g42Ej8X1enG+v4P9W2NioQEaUqgWq8oqpBfIFYOav7A9MJI
 uaFGXhp2tHJ8QLJW9TO7Yt88uR5JJi54HbzFe8xwectdpiI3I22bV7ljewekSnqH6VAJO0rws
 hjdtxduSvAKyqVWXVqiCvFC7j0hRjt50p/YLXWYch+BDbX78YCXsGlngQKarH9fWWwVU+q7pH
 hby6/PP0Lf3ZZL66VqvCYwy7SxyGhkwvwXsISnAz/npT7BaJyleiELmhU1PnoXSb4N3dugbC4
 9H73OzfJCShRGi+EC05KIzvdjZ3GknmhtlzKu7ixpRM1N2SCVPY+xIYq2fuhgR+J6fk1xkzcE
 lickej3BmdoK/sOUKYpA5+ZfH82mideJBn6BYLOd2jYr1JTLenmKsnBDjvX/c8WP1rqU3UAsN
 rZDrlt1LRssy4tCb5Qb1n1LBruHpVqujU1H/9yD5/6CDp2jWxXSdymbc73YuwXjIsL6JFmBvs
 +mAPIYhQi35jNm1YlqFlxcijweBe0XkZ/f2ijcY6TDab60oMji4nrN9Pe3CqvTML1q+hUmJQg
 ZQjL4rVlp4xxZgLRwFwA==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 2020-11-04 at 14:26 +0100, Thomas Gleixner wrote:
>
> I'll post that with a proper comment and changelog. Mike, can I add your
> Signed-off-by to the thing?

I suppose.

	-Mike

