Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EE0C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu,  6 Oct 2022 11:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbiJFLWk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 6 Oct 2022 07:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiJFLWj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 6 Oct 2022 07:22:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FF79C2FB
        for <linux-rt-users@vger.kernel.org>; Thu,  6 Oct 2022 04:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1665055353;
        bh=QApln2ldO3mxJ/b+8Ok33lRLJyCX1dB4HixpOrcc0Y0=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=LH1uzLf2hXMaNaFQqcU1C3qXgsPftnOr2S2kqnGvKi+p4uuhnEtfcGfr/tEblq2l1
         RTDGgCb4A41m6VWSXFGonDMS98RAx/8jYxxb2fux57wkBIBYardkOwjjhoSbD0vyni
         3KXPi5NPKOoNd5oGezrUu3C0qlXzhSP//rbnHyJI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [129.70.76.171] ([129.70.76.171]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MV67y-1onaTH2zxu-00S8T8; Thu, 06
 Oct 2022 13:22:33 +0200
Message-ID: <73948ebe-1e4d-5845-04f9-5255eb8a5a80@gmx.net>
Date:   Thu, 6 Oct 2022 13:22:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: Regression (latency spike) between 5.16.2-rt19 and 5.17.1-rt17
Content-Language: en-US
From:   Florian Paul Schmidt <mista.tapas@gmx.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-rt-users@vger.kernel.org
References: <565463ae-b86e-357d-962b-89d2a151ac73@gmx.net>
 <Yz2HQlzZ491HtOm+@linutronix.de>
 <5675da76-80ba-5708-e022-2385e3b56fad@redhat.com>
 <9a950f2b-94c2-7dad-51f2-545aa37850c2@gmx.net>
 <6b79b2f3-7ec9-88e9-48e4-71c6ec85b7db@redhat.com>
 <5d127d10-d606-52ad-b270-9bcbd66eec6c@gmx.net>
 <Yz51W0+ZVvYSa9kq@linutronix.de>
 <447228e9-2509-20e7-c259-c226e2ee4742@gmx.net>
In-Reply-To: <447228e9-2509-20e7-c259-c226e2ee4742@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Jy/OEk+hcUXOwGzl/fbJfBveH3eeksuDQm0Tb+5mFrpUvE4gGBE
 VDwoQAN8QjxF4sN1kd3ZGc0FAOrN9YQX8MHSGlX05fZy/PqM28EfGtmpQMIYZPvG0WCP4uM
 5UP1V9BgtVEQviGp4KHPd2OZYQztvIebzeDZwI9iFXSzBvdu8ycMYeBGqLF1DKo1F9QLytw
 fFooVwYXZUGr8AWwT+m+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nVfdkqFgfZs=:qg5Msv0SgqoexB83I1fG7Y
 EqWWWGDRfQPH9x9OL105moKwTzDCGgGJ2rmHDr+IbrsYT2Wu/cHEirVSM/udwEZMYGKSlvNCe
 bTgHRHTZXjd9mgwiMooVMun6G9JrBa1AbS6LlU1T0OHZs2CbSsg3LCxmzJ4sH7r7ZHeZe7Jkg
 jSbyRFCkPCN0Ayh3zrXHGsy1Wg8RxkLl19mN+S2YNqpsjUEKr5A1pHKXeU4+VOO2PohMxAmt/
 vyUVI6dCQj+xUIxkygTGzpvxcNYYaggitziDDDCoV7PIlSjJ2ciaJUnMpgJKvmpgPfgeoD+l5
 6fIoeDammJX32OpVTYTp8jO9c+5exB0nXlCecLGZbMav0/EEglRaysADXxxnMaM9oXtPxIqj3
 ZGdk0K42tpZLbHh/05Eg0DkC4jJNsF/XPrBMjJBAKPtDmM5d5lkkSp2GpmdchYVlgkL7gxTIG
 mFv309w91LEhxSHjPiN0XweNhSKiaxKlILySZ5Ef+RS5t4nzMQAZVxyPK79BDhCgXfRbmJUrL
 AidubHU7N8Yp6dNr0zZs0kX1EeVvQMRKVusj/xtVRBQad3cgTgtOAk1CExHqw0Y6GnK7A/x05
 31ysxWkNTm9OPL/Ub+mXyruNhSTN1b9Rl7iYKqzWoJWW+UL7mNfbkVJIy53wqkEAdTcsz/faX
 jOYbHolsl21NUB+q8HHmHZ8/PFL0yoXhaPrNhMqAzCwU6yhlXMJQqSLhJecq3oj/C8uofoaO3
 IjyXkUv45T/zAY4Qp3Op0CyO56bRhFSqKNXfG7zgMVsdOAsA/VKedyHy5iyhqlO7a3s1qNa8U
 Ji+dOGfVfTHOV35Oan4WtIeZ9dXPTb0rh4hm5LSHWnBun7HuozzA9t9A7pngvybjskJwHwtWm
 4MuJFchMplFDoFpEVvtoFKaZZ9nsvsmKtMpxWCpdh9Y1htek72diJ2VWoNH8SA9eUfnDmqzOB
 hJN+yDhHQLjJzbN/d9yUpARtQUJHD61Ejov3Dh6En3cLsEXKHRoM7skFwvdXEx45hp/pHWknc
 lUwtyh7wmLjdkWuteXQjHAiTfHNdW90Ce6G0amvgKEJjLxqeqlCJSeX3S2uhVU8SYcN4eiCdl
 ZL/1FGZLgUubURkZFJTtzXI2YHNbZfmZNRHpT8VtY1CYDQQwftRBJK9397U8Nv72Lt8H7BOIn
 mZKLQFd20IgqqbgQUL5gbfzZN0
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 10/6/2022 9:16 AM, Florian Paul Schmidt wrote:
> I passed acpi=3Doff as kernel parameter and that seems to have helped!

It helped on 5.17-rc1-rt1 but not on 5.19-rt10. But your comment about
powertop was really helpful for digging through those entries. Setting thi=
s:

 >> Bad           Runtime PM for PCI Device Intel Corporation GeminiLake
[UHD Graphics 600]

from Good to Bad fixed the spikes on that particular kernel.

FPS

=2D-
https://dfdx.eu
