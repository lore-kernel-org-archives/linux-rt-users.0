From: Remy Bohmer <linux@bohmer.net>
Subject: Re: OHCI issue with RT patch
Date: Fri, 22 Oct 2010 21:18:54 +0200
Message-ID: <AANLkTi=OFXjCagmj4RgoLV6jNbq4-MCmZ0J+RAzQmXoi@mail.gmail.com>
References: <S1756980Ab0JVN4w/20101022135653Z+208@vger.kernel.org>
	<B85A65D85D7EB246BE421B3FB0FBB593023461A852@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "B, Ravi" <ravibabu@ti.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65272 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932789Ab0JVTSz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Oct 2010 15:18:55 -0400
Received: by iwn34 with SMTP id 34so1268021iwn.19
        for <linux-rt-users@vger.kernel.org>; Fri, 22 Oct 2010 12:18:54 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593023461A852@dbde02.ent.ti.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

2010/10/22 B, Ravi <ravibabu@ti.com>:
> Dear All,
>
> I am using Linux 2.6.33.7 stable kernel + patch-2.6.33.7-rt29 to test OHCI interface on TI OMAPL138 platform.
> We observed that during bootup and OHCI init sequence the kernel hangs. If we use plane Linux 2.6.33.7 stable kernel
> Without RT patch then OHCI works fine.

Just a guess: Are you using the SLAB or SLOB allocator?
We have seen that SLOB gives all kinds of weird problems in OHCI. SLAB
works fine here.

Kind regards,

Remy
