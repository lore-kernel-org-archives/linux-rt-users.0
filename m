Return-Path: <SRS0=8r5a=VJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5D5C742B2
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Jul 2019 11:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB3820863
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Jul 2019 11:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pILOb33a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfGLLS4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 12 Jul 2019 07:18:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37980 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfGLLS4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 12 Jul 2019 07:18:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id g17so9573125wrr.5
        for <linux-rt-users@vger.kernel.org>; Fri, 12 Jul 2019 04:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/aA4FegY5uYI45bndquHq95XU0MNJHx+Oj+WTfQdF54=;
        b=pILOb33atCuu61xcdaKDCjjVZ+RZSnK2I++Ge2QmxHVtLZXRiAlxRa4Mg//IghWAeA
         KAPfgzZAFnzRQlM1G71uusQ+2dAf0va92ove2t5qNEZDe2X0+bguaAI2QVFDyxQnMpeN
         JkPm/EG0uhBWsVhnFq0YFJrkuFnhFaOkDcXqEt336oDwpII6Mc4WTEr4+p4zlQuBSR5F
         U7HX7e3djj4HaEPih/ZjZPqYhccv7W1oAc9frUX7FCpS22p4duAOyHaioTJAmqJoORIo
         xAgdXaAwBRbzryo4zinjS7WfGCetOWg7E4WFHFFZUD5z6x5UxbMUd+DFIZ9tpv79N2CV
         3lLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/aA4FegY5uYI45bndquHq95XU0MNJHx+Oj+WTfQdF54=;
        b=XBpr6l48tmle5P1OmB6nnVgold43+eXUXFJetPv0VSvvfmyaQQMFRc97QPRSdwbfCk
         JTwWxnDA/+pZ3f955bQOJPUvEyOHe61TKZTKEakxg8DIu3WSSXGQ1+xLCv8sGJy8Lidv
         I1owN5Jl/2EBW6uBmfuClHZ6xl0ipCjeavQEoM6EjgrV+qF9tkDktjhUJo7odtexRZhR
         e8VHImMFskpChL6Gw3VDgtaKWkH+3p4lgGekCUhIrE72g/J8J1I+eXjyRk5DFgVfk2AK
         svUC0yneYZM23wKptDmBu+eBkM/K4qJphC3/9DMlr0BuqoivSszpCZSv3ZyfmrRLdIlq
         Kt+w==
X-Gm-Message-State: APjAAAUTd0yYSsWj2qo4lY/W7h4n2iXfTCrriikOJecb0yppQ7v8e6qp
        oweYbQczmStHMFD993XLvrnbVpSYeRxsZpwVXLygC3xO
X-Google-Smtp-Source: APXvYqxfoOkPVzqpJD/A8sBaSsH/n2/VI2JfjSj3TAhS36pZaYaNHeZ3svNd3Uo4cu1GksJfiPCLq4M10nDmshP3ecY=
X-Received: by 2002:adf:ec8e:: with SMTP id z14mr11725876wrn.269.1562930333400;
 Fri, 12 Jul 2019 04:18:53 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Fri, 12 Jul 2019 07:18:41 -0400
Message-ID: <CAD56B7fdr5w0Pk5WHVWXa1ORyM=i+Ew66O+8buBwH0geeX+X0Q@mail.gmail.com>
Subject: poor cyclictest results with 5.0 series rt for arm64
To:     linux-rt-users@vger.kernel.org
Cc:     dunc.mcphie@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello,

We're in the process of implementing a CI test setup for our use case
and HW. Unfortunately this was not up and running when the first 5.0
RT releases became available in March. We're using the Arm64 based
Zynq Ultrascale+ parts from Xilinx.

We have been using 4.18 since last fall with very good results, and we
see this carry through to 4.19.25-rt16. However, for the 5.0.3-rt1
release, cyclictest hits multi thousand microsecond latenies this
continues all the way through to 5.0.21-rt15.

For the 4.19 kernels the v11 zynqmp firmware patch is applied:
https://patchwork.kernel.org/cover/10555405/
Otherwise only a small EPROBE_AGAIN change is needed in
xilinx_uartps.c on top of the rt tag. For the 5.0 kernels there are no
c file changes. Both for 4.19 and 5.0 a custom devicetree is used.

We've tried to make the configs as simple as possible, and for the 5.0
config we start with the 4.19 .config and say N to anything new. (I had
an issue with the first email I'll follow up with the configs if this goes
through).

We do have trace data for a instance where cyclictest hit 5000 uS, but
the file is large 11MB, and I wasn't sure if I should directly attach
it to the email. What is the best way to post or send this?

We would like to bisect this further, but it becomes more difficult
between 4.19.25-rt16 and 5.0.3-rt1.

Some other details: CPU frequency is 1.2 GHz, memory is 2GB, rootfs is debian 9.

For 4.19.25-rt16 we get this (histogram removed):
# ./cyclictest -S -m -n -p 99 -i 200 -h 400 -D 900
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 2.58 2.77 1.93 1/122 2595

T: 0 ( 2577) P:99 I:200 C:4499985 Min:      5 Act:    6 Avg:    6 Max:      24
T: 1 ( 2578) P:99 I:200 C:4499893 Min:      6 Act:    6 Avg:    6 Max:      13
T: 2 ( 2579) P:99 I:200 C:4499779 Min:      6 Act:    6 Avg:    6 Max:      33
T: 3 ( 2580) P:99 I:200 C:4499666 Min:      6 Act:    6 Avg:    6 Max:      26

And for 5.0.3-rt1 we get:
# ./cyclictest -S -m -n -p 99 -i 200 -h 400 -D 900
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 4.37 4.28 2.88 1/129 2773

T: 0 ( 2757) P:99 I:200 C:4499958 Min:      5 Act:    9 Avg:    6 Max:      31
T: 1 ( 2758) P:99 I:200 C:4499500 Min:      5 Act:    7 Avg:    6 Max:    9045
T: 2 ( 2759) P:99 I:200 C:4498926 Min:      5 Act:    6 Avg:    6 Max:     263
T: 3 ( 2760) P:99 I:200 C:4499644 Min:      5 Act:    6 Avg:    6 Max:      34

Thanks in advance for any help.

-Paul
