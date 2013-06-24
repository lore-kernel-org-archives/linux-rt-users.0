From: Johnathan Van Why <jrvanwhy@gmail.com>
Subject: Large latencies with nouveau driver
Date: Mon, 24 Jun 2013 11:43:15 -0700
Message-ID: <CAGmM2K6z29XbLDsT0_fGLUJgXrD7r-e70CK-LMGx_k-WHsvHrQ@mail.gmail.com>
References: <CAGmM2K5KgLFt9FqMHPvymBvD9czdpGECouRKoxTCj8HO0jUxnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:47014 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964Ab3FXSnp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 24 Jun 2013 14:43:45 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so24594457ieb.24
        for <linux-rt-users@vger.kernel.org>; Mon, 24 Jun 2013 11:43:45 -0700 (PDT)
In-Reply-To: <CAGmM2K5KgLFt9FqMHPvymBvD9czdpGECouRKoxTCj8HO0jUxnw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

To Whom it May Concern:

We have been experiencing large latencies under a CONFIG_PREEMPT_RT_FULL
kernel for the past year. Recently, with the help of Carsten Emde at OSADL,
we've identified that the latencies are associated with the nouveau driver.

Under a 3.8.11-rt8 kernel (as well as a 3.8.4-rt2 kernel), we've
consistently seen latencies over 2ms. These latencies are reproducible in an
average of 10 seconds by scrolling in a web browser. They are only present
if the nouveau driver is compiled into the kernel.

We've demonstrated the issue on two computers:
  * Core 2 Duo with a Nvidia Quadro FX 580
  * Intel Atom with Nvidia Ion GT218

Steps to reproduce the issue:
1) Install a kernel with the nouveau driver on a machine with an Nvidia
graphics adapter
2) Run cyclictest -m -p99 -i100
3) Find any scrollable web page and scroll up and down in a web browser
(I've reproduced it using Chromium and Firefox).

Is anyone else able to reproduce this issue? Are any of you using the
nouveau driver and not experiencing large latencies?

I have attached the output of lspci, the kernel config, and a latency
trace for the first system.

Thank you for any help,
Johnathan Van Why
Dynamic Robotics Laboratory
Oregon State University
