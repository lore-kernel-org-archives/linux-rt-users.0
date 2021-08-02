Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBF3C4338F
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Aug 2021 08:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A8C060F36
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Aug 2021 08:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbhHBIli (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 2 Aug 2021 04:41:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:45945 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229917AbhHBIli (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 2 Aug 2021 04:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627893647;
        bh=S8Xjk9BlVfspQ9rOgHHKP13Ws7GQo5c0vYJFxqf7KEI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Ph8rAEQv8CKTv9fgNQZvQ9O3/4W4p9Igh+elJtNRxYbTnYNqiLQqhuwqjXI936lQC
         1kq6Z5x5p43qWFvnb1ViciFiekDIjg5G8+FEBA5YJ4Caa/5+kHQ02G+FvxknPnYAgW
         onKnmHr8bcB573DjtIv0Zhxj65MIHB9iJf6YlL/8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.151.211]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRmfi-1mcXye42xu-00TAF1; Mon, 02
 Aug 2021 10:40:47 +0200
Message-ID: <5609f8ed59d5881a5aa7319ee41356a66397e0ed.camel@gmx.de>
Subject: Re: v5.14-rc3-rt1 losing wakeups?
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Mon, 02 Aug 2021 10:40:45 +0200
In-Reply-To: <20210802082545.bykz23s3ouwa4drn@linutronix.de>
References: <20210730110753.jvli6alm63h5lefy@linutronix.de>
         <2ae27233ab091d09a7d1e971a47144b40dd51fa0.camel@gmx.de>
         <87pmuzsf1p.ffs@tglx>
         <6fce881efc3d8c24a5172528fe1f46ec2ddc0607.camel@gmx.de>
         <ed1d5f9ec17a5b8d758c234562dad47cfc872ed8.camel@gmx.de>
         <20210802070218.5js3exubjxvsicx6@linutronix.de>
         <edd2f9fd1489e1ff05bf526a3059a1dbb81107df.camel@gmx.de>
         <20210802082545.bykz23s3ouwa4drn@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:itZvzHXk3JGEXP95h2LLHeYaLCtpKj75B4rV0gmdV/bVSUhJsTm
 TJH99CDhAHaFCRZf1F3vkzlHU7SYX1CcTZIeiW29dpQmBzArYcrXKWWzpLIWLtmxiosoeux
 xkbeZDRFehbjMXMBggino9JsTGNpAmtiZpvGMWDL6Opz7dgtO0cPUAnzPRdxmxUwb+LfvFG
 I2CGeCHzEIBJmU4hVhj3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wRMyjVW0UtU=:xZHTwNlpyqCjDlC8CJtKgv
 OpeJdymA9GZB6mhD52fGe7OrlvhpN8qxg+4MnwwdgHDh/RFOfuHeFmkPmUbBbWkwDULNQf6d7
 n86JShLSbW7liNXa01vvi3tJQtWsCBVUCBEOvEURFQRU0yHTVJpREC0YTwBNpgr6hPwSP/7n9
 POhW1ExsWfAqEWo+URa+GrdlTIDQ1xIbfYJj+hP+3GDs5FVDxUWnlYNpZZTRfIwG+TjPVibV0
 5pKoOEi6SldoCraRkz5kim9pWY/dXjC1x5vhCazMq2NBFDMPccd+cr7KwQcfJ3a6ad2vzaOLH
 Djl3Mcz358q2kObYWy8iQtilpmFmkHTACDA+wbQGEBv326JIe9oW/CQ1ge2pfCRi6p5Q6DgkB
 eLGROdfwtE0qMRgYW+1RJ+MEe/mfUReSBzwVru8qFZ9NetEohY6x6ZMH+xNSUWPZ1vtwAOgQs
 PCQO5StnKBnELf17QOaFUeOf1/dCMfqpn5TWJHHCxLqxebEekjVvd9LMbJi/Nxew/q2ZYjuZp
 9mfeXDFhmaF9q6DFE72Ez8c9+l5KoCFxOyG/jcBofLpHEvn1YvkodhU565sSomCfuH+pPl7W6
 n/TCUxdI5vcWrN2Piagj2y204iThBV7q7jgQFaLqhhSt6MnCXPTSU8oh7gfBzYiguRwjKea0z
 3tr89O9cLXPm01od7JPLjFDSvRWkj6vz4SF8Jlv64WfpCVb29QyPSxemVYmXjLEFtb0ONLpzq
 jNjALfhVLWCZ3DNwGV0d6/rNxeKRr3cOq1KJNYH7EOTscgX8nNdIKKnvNhABb1nRAZ8BVv+JQ
 GRjP4HYq3MOIwL7nrwABGjmHSGbmbXvsa65vPqH0+9mthzTSRmYu1EAzY6qdaUiKdtTimWLZD
 emHdQLHJkc5Ej6QQQlVNkFZl4jcibqXIJLzbsIIYCPFsU+IkP6u7eorIkz+xaM0CakLpP+YJs
 niE4x7Xg2Pv1QEfYxZeckQUsIt8jGqztQQX267zroZv8xN6P3Apr/RznSV6nVGR4xASFh2kdJ
 CLcy28Y4nYf4qy99Hkandc/b/Mx5+Y3lpyALZTayMJFgQQz8xYPYSmrEhDR0pVgAiI/s5ociP
 5m2koIJtPXoDIkNjg+vEufxAV2Vdo4v6Uc2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2021-08-02 at 10:25 +0200, Sebastian Andrzej Siewior wrote:
>
> Okay. So the ww-mutex bits are not the cure then. All you do is booting
> KDE/Plasma in kvm with virtio as GPU or did I mix up things?

My VMs are all full on clones of my desktop box, running KDE/Plasma
desktop, CPUS are setup to mirror my i4790, and they get half of box's
ram.  VMs are a "mini-me" wart hanging off the side of the real box,
NFS mounting various spots of the host where the data won't fit its
64GB virtual disk.  Display is Spice, video is QXL.

	-Mike

