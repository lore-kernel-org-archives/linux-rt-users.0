Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3D5C433F8
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Mar 2021 11:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DCCF619AF
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Mar 2021 11:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhCTLMd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 20 Mar 2021 07:12:33 -0400
Received: from mout.gmx.net ([212.227.15.18]:47235 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229873AbhCTLMI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 20 Mar 2021 07:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616238490;
        bh=bBjLCX1FN81wI6n/nGI3EtQ3GBM0eiF3V1gwzHLvOQo=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=cBLp26TAuaU7zY+10Obec10h23eevJSfHlASXQa1NPRn/fW84ROnYgr+eGGNrHacK
         rwn2xJ1E9HCiR643UP+u79KqewQ/Eog8sSM+VFkS3JMI2gJwSt8Bp4xAv+Zr61C/Xs
         ei061BQzUtDOppcOV+DSvcwzURrIg/F3Ef61P6DA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.49.112]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mel3n-1lvCwO11Eb-00akE8; Sat, 20
 Mar 2021 09:18:33 +0100
Message-ID: <1f63f1fcea10fc179881384cd838b1c9e5207b82.camel@gmx.de>
Subject: Re: [ANNOUNCE] v5.12-rc3-rt3
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Sat, 20 Mar 2021 09:18:32 +0100
In-Reply-To: <20210319223357.uknv2t5uvxvzb46x@linutronix.de>
References: <20210319223357.uknv2t5uvxvzb46x@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pKPXk35DjmhrgB/0o7wprTJ/KgyaPTIBVJr3avcvi84T03QRcBI
 eFjpChtPckYgusyBh+Lz4GaY5lpQtJZgUGp/wGY9LeZ6ksB7J8mcKuVdU1DaKqxwfmtAz8e
 mgI7zg95NOjg+lkMsFVoWcZtzU1u9oN99MiBanOemvVHxl+fRd/5ortL29Zq6ayI/CFQKyg
 9Qw1Wrh8ATCb0BNAED1tA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C7yYCAd/UXs=:pe9Be+/oB+JfEw0Ra7nITD
 AHkruhOwK4bLdWWLjpluLe0qM8zGKHT2i6c2UK/c7tpaNmShgac3rEXFK3o4ByaVlQAH5Z/C/
 tGCBZ7Dr3ygDqbCK0kHBThU+WvcK9p6aOHQqY4rtOCb4VAv6K3mx+AfcT1nw7oGaFbxilsvb/
 +POK48DYl+lQfKwRCTTAxtJc+7PvLsR1/kS2+EQobMIdcvR4ZGHtZ6SKJ3DwAOHwwe/LG36/l
 pc5/+Iexc18TrTcXu1MPBj8qp60LMubGoqC4BaaziDzaxTZGiD0EocFOL+cEUnNCsJjEwK071
 nA4/Our3a0M5EALfRGhwa4EdcVJ6p/N7IWxGJ41mLyzeaurAM8rtafXS6hASUoapOoeoUo8Bw
 RMqGMyXzhlE50r/ivS/PrV0pWOFkBlmR17gd6y/fSRW5DXPshAidj1D15lJwBS7i92SaSy4P/
 wwt7SrKbQclOtTsXyePzemc24p2ltpEkF59rBUEuoW22/Zkctw8DH2B+exFUqemRGbHK72YKz
 CvuKcWuXHczldQ69gHI36o4qGV+EevVcYdnMnux0myyHyaJJP3c1No/l65H/rcm/tXmQyazOf
 S8ywYjxdLu2PrAIeqdFA5usewMCagx/J3tp38zF9oFq1l57JxZKbcZcTxMZ/cYjdXt2AEppg3
 0XghBrgpqSK24eCcXJwLKjR/Rxv3e4CrYO9isQkimbbLNBFvf/TO5GmVJnN7W0EFVD7lG4ZIf
 VFOC33dtxGzTnhIZNBcZ6nBo4x9lavxtiDg7/mGAnGZsdYCYqRCvYEQO6Q0IbPFyP94ziKPCi
 Gks6lps5bmlsEdRoXud4VZt8P7u4IepBPJE2Pd2/7oQ4uexvvLVdfRtFfC3E3xLEX68LncQG1
 //xMKzXFBE9fiRi7sJU20xxk3sSk+0XmAFk+MnZVb+s8Zpno+vllOy5MK8my0xoze7FulnNty
 d1lDGVzewHT97CI2vXjhDoUNzSFMg8eLLJupKOj5csxUzJHNCkksQ7Xx5bj60svI4aAox/GZ5
 j1Gb5w0G9ZA+5z2HVlB9Epr2kT/1ozHdXJIIUqYc5NN+ZJUw/DX3uPZgKwvnkZr6mAZ6lEPc5
 TbD+quU6po5Sde5PAGmLZxWXuxt8pneTcXp8KqN8/E68++ta2WgqPv4h5BKyKV8JRoPUH9NxG
 r/thwmEfwy9/xs3yknOqYOT1rp0787K5AkiFWIZdHcRH7pzGm+oSiILFR+s3UneHRC3Us=
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 2021-03-19 at 23:33 +0100, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
>
> I'm pleased to announce the v5.12-rc3-rt3 patch set.

My little rpi4b is fairly unhappy with 5.12-rt, whereas 5.11-rt works
fine on it.  The below spew is endless, making boot endless.  I turned
it into a WARN_ON_ONCE to see if the thing would finish boot, and
surprisingly, it seems perfectly fine with that bad idea. Having not
the foggiest clue what I'm doing down in arm arch-land, bug is in no
immediate danger :)

[    2.216913] WARNING: CPU: 0 PID: 1 at arch/arm64/include/asm/pgtable.h:=
982 do_set_pte+0x1cc/0x1d4
[    2.216949] Modules linked in:
[    2.216961] CPU: 0 PID: 1 Comm: init Not tainted 5.12.0.g425ed5a-v8-rt =
#33
[    2.216973] Hardware name: Raspberry Pi 4 Model B Rev 1.4 (DT)
[    2.216979] pstate: 20000005 (nzCv daif -PAN -UAO -TCO BTYPE=3D--)
[    2.216990] pc : do_set_pte+0x1cc/0x1d4
[    2.217004] lr : filemap_map_pages+0x178/0x380
[    2.217016] sp : ffffffc01153bbb0
[    2.217020] x29: ffffffc01153bbb0 x28: fffffffe07d93080
[    2.217033] x27: 0000000000000000 x26: ffffff8101c9e000
[    2.217044] x25: ffffff8101b40fd8 x24: 0000000000000000
[    2.217054] x23: ffffff8101674170 x22: 0000007fb1b4b000
[    2.217064] x21: fffffffe07d93080 x20: ffffffc01153bcf0
[    2.217073] x19: 00200001f64c2fc3 x18: 0000000000000000
[    2.217082] x17: 0000000000000000 x16: 0000000000000000
[    2.217091] x15: 0000000000000000 x14: 0000000000000000
[    2.217100] x13: 0000000000000000 x12: 0000000000000000
[    2.217108] x11: 0000000000000000 x10: 0000000000000000
[    2.217117] x9 : ffffffc010209068 x8 : 000000000000000f
[    2.217126] x7 : ffffff8101e87c68 x6 : fffffffe00000000
[    2.217135] x5 : 0000000000101e8b x4 : ffffff8101e880a8
[    2.217144] x3 : 0020000000000fc3 x2 : 0000000000000000
[    2.217153] x1 : 0000000000000000 x0 : 0000000000000000
[    2.217162] Call trace:
[    2.217166]  do_set_pte+0x1cc/0x1d4
[    2.217181]  filemap_map_pages+0x178/0x380
[    2.217189]  __handle_mm_fault+0x75c/0x930
[    2.217202]  handle_mm_fault+0x178/0x25c
[    2.217214]  do_page_fault+0x16c/0x470
[    2.217233]  do_translation_fault+0xbc/0xd8
[    2.217244]  do_mem_abort+0x4c/0xbc
[    2.217259]  el0_ia+0x68/0xcc
[    2.217272]  el0_sync_handler+0x180/0x1b0
[    2.217284]  el0_sync+0x170/0x180

