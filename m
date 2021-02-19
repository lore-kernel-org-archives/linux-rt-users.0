Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF3EC433DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 15:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56D0364E60
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 15:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhBSPyA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 10:54:00 -0500
Received: from mailout04.rmx.de ([94.199.90.94]:55357 "EHLO mailout04.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229524AbhBSPx7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 10:53:59 -0500
X-Greylist: delayed 1880 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Feb 2021 10:53:58 EST
Received: from kdin01.retarus.com (kdin01.dmz1.retloc [172.19.17.48])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout04.rmx.de (Postfix) with ESMTPS id 4DhwKZ0xZxz3qttH
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 16:21:54 +0100 (CET)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin01.retarus.com (Postfix) with ESMTPS id 4DhwKW56MQz2xbk
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 16:21:51 +0100 (CET)
Received: from n95hx1g2.localnet (192.168.55.15) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 19 Feb
 2021 16:21:47 +0100
From:   Christian Eggers <ceggers@arri.de>
To:     Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        <linux-rt-users@vger.kernel.org>
Subject: Re: [rt-tests v2 v2 01/20] cyclictest: Always use libnuma
Date:   Fri, 19 Feb 2021 16:21:46 +0100
Message-ID: <2570027.mvXUDI8C0e@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20210219151717.4cqc6lhrsocebw3p@linutronix.de>
References: <20201218161843.1764-1-dwagner@suse.de> <20210219145422.lvodigbgtymr5ajc@beryllium.lan> <20210219151717.4cqc6lhrsocebw3p@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.55.15]
X-RMX-ID: 20210219-162151-wwFwHFtbfbRN-0@out01.hq
X-RMX-SOURCE: 217.111.95.66
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

CONFIG_NUMA is not available on ARM32:

https://cateee.net/lkddb/web-lkddb/NUMA.html

regards,
Christian

On Friday, 19 February 2021, 16:17:17 CET, Sebastian Andrzej Siewior wrote:
> On 2021-02-19 15:54:22 [+0100], Daniel Wagner wrote:
> > I try to reproduce this here. Building libnuma from source right now.
> 
> |~# uname -m
> |x86_64
> |~# ./cyclictest 
> |FATAL: Couldn't initialize libnuma~# 
> 
> Just do
>  # CONFIG_NUMA is not set
> 
> in your .config and it is done.
> 
> Sebastian
> 




