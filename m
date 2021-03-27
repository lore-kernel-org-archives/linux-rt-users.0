Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CC1C433DB
	for <linux-rt-users@archiver.kernel.org>; Sat, 27 Mar 2021 05:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D764561968
	for <linux-rt-users@archiver.kernel.org>; Sat, 27 Mar 2021 05:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhC0FEA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 27 Mar 2021 01:04:00 -0400
Received: from mout.gmx.net ([212.227.17.21]:40711 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbhC0FDV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 27 Mar 2021 01:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616821398;
        bh=WuPw1z8BPrXMfSiGR2z+Ln/ohuTjDXcf3TAn8vQwY4k=;
        h=X-UI-Sender-Class:Subject:From:To:Date:In-Reply-To:References;
        b=O2HIxfofTE6b3xu/5CU5qCJ4SaBce3wVoBFPLriKOhSLh4P1H2R6hq4NKftZ1L2xc
         asKaq2xbXJmm4qcQ+k7qYkCnKLJsy1o74UVC/xQBZaQAAbxI/W6td/UXyzIyGH2k3E
         X27bagNJKYJFAVMkq2vYhJEUv1HEx8n9Ht9mJlZs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.1]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQMyf-1l4LW304Tx-00MJ9b; Sat, 27
 Mar 2021 06:03:18 +0100
Message-ID: <ee0fd2b1b9ca08f92446ddb0b5f8c603f55371c0.camel@gmx.de>
Subject: Re: [RT v5.12-rc3-rt3] __call_rcu with KASAN causes invalid
 sleeping function call
From:   Mike Galbraith <efault@gmx.de>
To:     Andrew Halaney <ahalaney@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Date:   Sat, 27 Mar 2021 06:03:17 +0100
In-Reply-To: <20210326212009.dvmga3e7axms3atk@halaneylaptop>
References: <20210326212009.dvmga3e7axms3atk@halaneylaptop>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cT2BtdJBKR8lhae3DJq7uvP6hFlJxjKG9z+GnjfbSqJrazqQ6H9
 wE0KIVl5rp1Z154GV0gNQBPyDaEBS0mWQ8VDkPrd88ucHagOA7YNnunOJAv+cBbwDCwFSxD
 0x912CvNRT4abaH9q7kQSVB6RExljs5ZvwCjskDrqrqkOww6cqFfwQNjpropQvAtabkhLR5
 cFbsRzN+ToSFOZ2T1J4XQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o2wwMQmNzOY=:4v7Vl+XMbRArLJ2uc94tQj
 KNo2AW4aVygO4UBq0oivzt3W/ZQo/IG5I6mAomaZextpV37TOQS6E+JeeEkGgWrUpT/2zlrF+
 wO+vaTsQQI0RtRD/3tXiASJlzKvD0H+csKmadQe81gTd1IspKDh9t8I+nafpZvb6cPPZOhzn0
 7dNFKHkEE59Wmwh5J5RCG03hi8U2ElNuWCgQZMPTVRHkxxFUBJFPERkY0o8ED9DIeaGZSDe9+
 DPZh4SlFrgTPYYL5pprqphhPfWEtmCiuzX+Mo/AsxxT/sw3S6jK3uPtaSiYSODB+ChMibK0NN
 t/SmSp11V6x5hZGZXTcepnl3XMWl7wqRdluC9tGbSbsNh7x1OMyn/Xpkqorhqy8tRhC9AlTDz
 6x4q8tLhfvQFmOx9dqFpJQlDU4Hvwa7n/BOMIlhIRUWso0wocT52hEr+A5JO8ExnWIWZt1g+h
 HSBhuB4XpOyCcUl6VG+q69TSlZy29W7sIUCgm1LvCnP8wGva8XdiNfruzwVVC1JJ+NBE/tZJq
 NotXH/GHQrnfjvaMLj5MQjew6SVQqkjk1FibrKeNf1DQ4HMzCXIkkID70HibOW13E1JBEMjtI
 ZxQHjkq2sI2llNQss3oCuLme1J4qzKlBtuzqnn3ljjPkqU993c5J6q+/pEM/c1/WrIM1GwaeV
 TBrXrVbIyzPuZAfVewAGUVZuVsirfZkewO7NtGJMMQf88sCiBeaQyutPznKpogf9TF41sxWb0
 eyVrzvFeR3iY/bv/Yce6zAKxWvaNvqpWIOOyI1qUtEMn7gZpHAxpwueQcJm5iLv8PlWiTYuF6
 mkw+44HNxWSBS0zF5+RbyxJPnllN56VpCERb2cC1yVE66lmcc5m+MBWAPJyx6MC1pjY4E8IPh
 GUcMa2H6/c73D8zsjSgy4h7xazhpMG3R0ijCEK1esfKhf+qXQFdk+PcN2Qae089i1ODv6jatz
 Q0NKKbt+84Af8IZdxZ/+1o3VQHoH8VmMNEkUX1flvc7ckONhXH0RwlHWIFP3T/XwAr2xl99HE
 10Hb9ZGMtL46rbo8esEcFhOormZSRIJkHHJvTHbn4jMPUBqvXtpYuqSaQp0IahCpwqtlwkJR7
 QSoJyu6+nLw0PEEljyB3o45Z1Ovndi45CLrJnx42C8wIurlc6HJMV437fIE02yqdZ5KxYkayl
 rnG3Qu3j2mwoRhbfBfgNltBEcMVlcocB6s8U8paO+9lcgh8xUJ3UlWeXg1MR3GJPs4WrY=
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 2021-03-26 at 16:20 -0500, Andrew Halaney wrote:
> Hi,
>
> I booted the RT kernel (v5.12-rc3-rt3) with KASAN enabled for the first
> time today and noticed this:

That should probably be one of the auto-disabled config options.  I
started down the fix the KASAN gripes path, and quickly determined that
that was a job for someone with motivation that I fortunately lacked.

	-Mike

