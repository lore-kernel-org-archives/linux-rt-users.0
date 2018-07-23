Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-lj1-f175.google.com ([209.85.208.175]:40097 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388002AbeGWSfm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 23 Jul 2018 14:35:42 -0400
Received: by mail-lj1-f175.google.com with SMTP id j19-v6so1234868ljc.7
        for <linux-rt-users@vger.kernel.org>; Mon, 23 Jul 2018 10:33:25 -0700 (PDT)
MIME-Version: 1.0
From: Steve W Heim <heim.steve@gmail.com>
Date: Mon, 23 Jul 2018 19:33:24 +0200
Message-ID: <CAE_sPDHk13a8X+n3NS3z05Nw6wCCKbo1fPzjmVU8pWOZm3AuDg@mail.gmail.com>
Subject: compilation on 4.14.52
Content-Type: multipart/alternative; boundary="000000000000e3cc620571ae0add"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org

--000000000000e3cc620571ae0add
Content-Type: text/plain; charset="UTF-8"

I'm trying to patch ubuntu 16.04 to use the latest stable kernel, 4.14.52
with preempt-rt, and at compilation, when running `CONCURRENCY_LEVEL=8
make-kpkg --rootcmd fakeroot --initrd kernel_image kernel_headers`, I get
the error

./include/linux/interrupt.h:758:2: error: #endif without #if

When diffing this file with the same file for the patched 4.9 preempt-rt
kernel (which I've successfully patched before), the missing parts seem to
be `#if defined(CONFIG_FUNCTION_GRAPH_TRACER) || defined(CONFIG_KASAN)`

but simply adding this (and the other missing lines) results in more
errors. Is this a known issue?

--000000000000e3cc620571ae0add
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I&#39;m trying to patch ubuntu 16.04 to use the lates=
t stable kernel, 4.14.52 with preempt-rt, and at compilation, when running =
`CONCURRENCY_LEVEL=3D8 make-kpkg --rootcmd fakeroot --initrd kernel_image k=
ernel_headers`, I get the error</div><div><br></div><div>./include/linux/in=
terrupt.h:758:2: error: #endif without #if<br></div><div><br></div><div>Whe=
n diffing this file with the same file for the patched 4.9 preempt-rt kerne=
l (which I&#39;ve successfully patched before), the missing parts seem to b=
e `#if defined(CONFIG_FUNCTION_GRAPH_TRACER) || defined(CONFIG_KASAN)`</div=
><div><br></div><div>but simply adding this (and the other missing lines) r=
esults in more errors. Is this a known issue?<br></div></div>

--000000000000e3cc620571ae0add--
