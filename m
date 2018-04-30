Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-io0-f194.google.com ([209.85.223.194]:39586 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbeD3LFx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Apr 2018 07:05:53 -0400
Received: by mail-io0-f194.google.com with SMTP id r9-v6so9711189iod.6
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Apr 2018 04:05:53 -0700 (PDT)
MIME-Version: 1.0
From: Iain Hunter <drhunter95@gmail.com>
Date: Mon, 30 Apr 2018 12:05:52 +0100
Message-ID: <CALC81-sg=86AZgZv4bGSNPJEmw3r_j=yNv5HuGPBWKMYVoXJ1A@mail.gmail.com>
Subject: RT Patch and Xen
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org

Hi,

I am using 4.9-rt1 on an Ultrascale+ device which is running Xen.



By default whenever I enable RT Linux then Xen is disabled according
to the patch "arm64/xen: Make XEN depend on !RT" in

https://marc.info/?l=3Dlinux-rt-users&m=3D144509814328860&w=3D2


Can someone explain the background to this patch (which appears to
still be in latest 4.14 development release)?

Is it simply because Xen drivers in the kernel fail to build due to an
include file problem (which I have worked around)
Is there a fundamental stability problem on 64 bit ARM when RT Linux
is running in a DomU? Initial runs of cyclictest don=E2=80=99t show any.



Thanks,

Iain



-
