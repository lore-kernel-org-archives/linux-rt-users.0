Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CA4C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Oct 2022 07:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiJEHqf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 5 Oct 2022 03:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiJEHqd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 5 Oct 2022 03:46:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F0C5815E
        for <linux-rt-users@vger.kernel.org>; Wed,  5 Oct 2022 00:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664955990;
        bh=9+OLwu+Ykg1lrOEjzly8CyAHBf0ig+IzX8B+bA81b1c=;
        h=X-UI-Sender-Class:Date:To:From:Subject;
        b=AdoULsW2n7+k0JmMy3cMFK+bhtaNNfL1rWF+TeWwbZXK1/bbe1XXIqt9yHj7d8+uG
         Zrshi8sLWwts9YDxm3Q4/4OydVz9VQ4F4XbwFIyIc6CTnQGclrEoatTI5eAAPniaqi
         0ZIa2ltUiPtmMNRqj5F8cJ06ofdQz60ELdPT9O7I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [129.70.76.171] ([129.70.76.171]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiaYJ-1pA4av2Fl9-00fh7M for
 <linux-rt-users@vger.kernel.org>; Wed, 05 Oct 2022 09:46:30 +0200
Message-ID: <565463ae-b86e-357d-962b-89d2a151ac73@gmx.net>
Date:   Wed, 5 Oct 2022 09:46:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To:     linux-rt-users@vger.kernel.org
From:   Florian Paul Schmidt <mista.tapas@gmx.net>
Subject: Regression (latency spike) between 5.16.2-rt19 and 5.17.1-rt17
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ijobFdtcXNxEBk7fZEKSmfhIC2f2EZ+mTnjQyp9ASMgCT5RPMNP
 6pCkfJWSKM88gqOowciVkTLa82HvQ6IuBZorLdC5vQutZMQO95c4A+Ibniki5KoMB3WKqmp
 0bPD31F7rC7ez4g7cnIUvwVtd804bISqQl4Dxmdi11/q5W7PCSUAzhKCLNbDJ0w5YJarf1O
 q5X3D3KwA8k19fzPUlFNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cyIUzoPKa/M=:j3ihkjzsuH8OLEz1BQdDt+
 +4gnC1Zv9Pt+U0lsBpqUyWKQoLcbToFxBaCqmLZpkVkUeXDGYp0DKKFZSkjNW0O1DofhkcPIa
 crariVDLLxMqpZk6JmFobBPX2yqvwv6/uE5Vxjtq7Ziu8YUzwYEKb68qrlYtzgaKHlqq5rZt1
 GDEQSKrg+PIIMUGXvTpnaut5q5RzDDChcs/OqgZME3la0i4xIp21W00+A5gkSbcGGz7KnbBjp
 S0Ll6Y/u9sBjtzeqnGBPQFvAuW39hG0J/GXtp8/1RuB0Acb+QknfSh4pAvusxeqQCqTnOQH4e
 eVrKzbmprUWtXsmcO5VLt3huOBh7t2YQLECPRQ+hMemZ6bty4eePFp8V/giWfsqIDNrlItoAf
 HjcRxOmfmI/zVGruY1EIK/7Ly/zOOYYK1bSqfddGLG5rRVECdX2517QuHHhjgb9zideBs8EMK
 LRB6GIwPTjGY2UIc+DiwgCYK8s1VOZtb3i/Nf28Kpe8DRDzV8xx7RRGHQLn3zk4T1PoGAKdml
 DU8GMI/TwyifnsdBr6KHZ7bbPL8UUTG//uRF3tEl6u4zIRYT4pwBfgTh/tdZtgX8eJi4/ZLgX
 v2nK2UEt/KfZ8HUz1lU2Jhk5NaYWh0/7y+wFBiWcnl/zyY7u5K7SsCFytGN02j6BTqnsHodN8
 ZmKwSILlk8+xUS6ATTXVWW8AOMpWN3JnLK4ZIGKWaUZd+wwwWf+G3Lg19fdFjxHtMP4h0S9Vs
 yzOunU1fvftbN1Syf1eGV5L2vnTFbbzbcisi5mu2IFqLc2WLq2L42LZwy6ZrTHCdAz3Dfgnt6
 7GyhVbwDn414TKmW00Y0q0JJziFtqR2GlqdpIf5hfzcb6Opke10nDV793rZPQQdDG1AZIGSpO
 cvHfECPGg5YhybYHh+UCM/EzlBT4pxFJMISnonmK2bshLXn2NHzxE7Ho4BJHZFJZmy2Tpks1F
 HOAFsB/pY4nhdTyvwmOOdASpd+S+pzJNYjXoA/ue/jUOvj+nJQpb3hQ4zkzbM7sgoKyc4Hu1m
 pMIk2AaKbNTXBBbMZszueFZMOe+QRaltgpzW6yihOorNndpoZkxwFrHO4HSKbD5Cmj9GXT0Pg
 hkgQGlJfEQWBSgs0BPanK3H/i7O/fEWYkDBZd4fsFYE8bth5uYJvcjMv8QhVOO+7qlcbaIhf6
 M4bnJpKWpD/+8wHAnGqpYasSTk
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Dear rt-users,

I was happily using kernel version 5.4.84-rt47 on this Celeron j4125
system (all power management and cpu frequency scaling disabled in bios)
and it was working great. Worst case cyclictest latency was around 30 to
40 us depending on system load.

Due to some USB fixes landing in 5.14 I went and tried upgrading my
kernel. I started with 5.19-rt10 but something weird showed up:
cyclictest reported _huge_ latencies on one of the four cores (thread 1
of cyclictest) of around 700 us. So I went back to my old kernel to make
sure it really was the kernel and sure thing. The old kernel still had
the nice 30 to 40 us worst case latencies I determined previously. So I
went through some kernel versions:

5.19-rt10    has the problem
5.17.1-rt17  has the problem
5.16.2-rt19  does not have the problem

So I would guess somewhere between 5.16.2-rt19 and 5.17.1-rt17 something
horrible happened ;)

Maybe interesting fact: It is always thread 1 of cyclictest that shows
the large latency. The other threads are seemingly completely in-line
with the expectation of 30 - 40 us.

Here's my cyclictest command:

sudo ./cyclictest -m -p 95 -S -M

cyclictest at stable/v1.0

I would possibly be willing to git bisect the issue. But I am a little
bit confused about how to go about that. What repo/tree would I
precisely bisect (I am using the the patch tarballs from
https://cdn.kernel.org/pub/linux/kernel/projects/rt/)?

Kind regards,
FPS

=2D-
https://fps.io
