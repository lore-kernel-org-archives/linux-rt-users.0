Return-Path: <SRS0=0dn7=D5=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D1EC388F9
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Oct 2020 14:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7672424182
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Oct 2020 14:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dyWoqO/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895402AbgJVOMz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Oct 2020 10:12:55 -0400
Received: from mout.gmx.net ([212.227.17.20]:55123 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895261AbgJVOMy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Oct 2020 10:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603375962;
        bh=mDW3vWakBGrS/8WD2Udbdhs/v4Xg8fon8aVmOLJIlZ0=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=dyWoqO/ofChigmieNILxq3a6jdr5NLE37v+KaKnHmEKU0rCxRyc8GdhYEqNdMpKAp
         M7mxZ6ExBGo+VBOA3vOSsI55/6MP0Cs6YpRS27xz8f79vD3V2Tgg2/YT/xl27KvjRl
         XEALlco0WSS6LTiWHbmEhU4WoYIijGHK8sbu8fp0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.221.150.153]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9nxt-1kS0pL1chR-005tfB; Thu, 22
 Oct 2020 16:12:42 +0200
Message-ID: <15cd3dc322eb1485fe1e67df465febdc6ad389d8.camel@gmx.de>
Subject: printk: add pr_flush()
From:   Mike Galbraith <efault@gmx.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Date:   Thu, 22 Oct 2020 16:12:41 +0200
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:1L7RaTVmGEK8Y1UFFrqpjSbHei5atQ5D1KSDtybP/P5ObdEm5+w
 je91MFV25ZEwuDrr9BVrt1gujlXz8UPxscf1VDwyseCMaQ7K6i8XsIq2XX9namELB81gpRN
 vbvV9pfnFFKmgKDhM9cDF3SjY/cyT6boM3t5IoxEToAXvu80isi4xGq1JtA/SdAOV78hAwT
 x8+r4gre0xXpubad4T9bw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aSF+8ugastA=:obdxQvjlRB49W72eY4dxJE
 4g/hecRe+6EwtD+cENjmdk2VX81Yd+GyY4QSCaV2/XZJgS+TRwoXGkQ/Z6AZiQxe2FUmu3W39
 E3y++yVdk6ojf3LFu/gC5D+ofNfrz188vfkt38hMcUA9EJls2YEXJ03uvHfgWFjTEEhZzmWf7
 Wb2Fy1u3m/RUAyDFU6FFHWD3/++3nbkmjB8VUKP6LypFE7SVun/Ibzwc8VPsXkuao7ynNGY5c
 SSsZqRy/HtQm3TBDEZg7EpNdAUr2V3RgkffQ+5IYNwIVAwIRNJiEzScS44bazfUtwrChBwnT2
 vKZQaCOuZvdNfGj7XfNa8c7oiX14IBsRv9YYnsXDNiA03R9NSBhy6oFFd0eZDlGajQ2nQPypv
 LSSbe+9yGr8TF7QtTfs+A/05/Qz1rPPJUhOHsQiXmC/pDQmKSp9Jc70/z43vh1M22wdcbS5/z
 c8bT/jGqCREpWwKJ4Ht/7G8G4kc1SmxM3kUT6FgmaKk8u/86VrJ+ZQ3iarYKvmlsKS5yXqZ3q
 udcDK99Lz04A3Wtfj4V1fAC1KMbVTpx+TbZsNdPAOOX5yjftNGCRZXQXvhOjvDG8F5oaS8H2F
 QQwF2hFXArmmWmsOfa0GJQnxeh2W4tJYiMx5hUYZTPA/pLi1erWvBc6qKaMaJRs5rr63TKoiT
 9SDy4NMRxqxKEiXiqRMlG5Fv6ESIwmJg8mdX8vpyn0JYJUDHAeDqfU012JFHF55UH5uslaL/V
 djqW1X4rLiUElDa1324PMzglOGOlUGeLdCdWQ76gPLVkrWf2YrH6S0aiOGMi1WHHF1jrOTQdz
 UAQvN2e1orPwG2jgMTEr10v8gP4KxSbGAPmf2SyKY/eWTsX9hR3xj1ErPLO5l2KG3qff8gFi6
 ONlMQBkBaQRAXm+jKDVg==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Greetings,

Seems this patch can cause hangs.  I can reliably reproduce one such
hang by poking sysrq-b, and it goes away if I revert that.

	-Mike

