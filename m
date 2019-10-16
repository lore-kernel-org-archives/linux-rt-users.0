Return-Path: <SRS0=+bg5=YJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A88FA372A
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Oct 2019 13:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B07E218DE
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Oct 2019 13:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQUPX6ws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732432AbfJPNoe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 16 Oct 2019 09:44:34 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:47054 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbfJPNoe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 16 Oct 2019 09:44:34 -0400
Received: by mail-oi1-f182.google.com with SMTP id k25so20033659oiw.13
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Oct 2019 06:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=XSwph53WGQmecFqDQIRRJWyMQ4dNje7iaV+5LInDm84=;
        b=lQUPX6wsrZI+sU5UPFNTQ3gQR+GeUYL0Fl/M3cJceX2xue766iXaz2uvDZA1oo3pc5
         QE48HQsSSCrfMwRxwth3ec0rnHu/FU0bu8KyqGyYfrTPn+WlOz3YsffK52F9MMJZOd5M
         s/+0CdoC1WHFedKXdqqLe4deCamxw0ZmQuL4xRD55fvKQYx+wzpTtTn9oJngZxnD+5JG
         9TDKZjKMXj+j2w6iYezzNGzK9JisrBwcQSfRu3r0sovxytEaMH8RRSMc7TmNZzm8DDbK
         +/+CTmQvXCoroxCRKFQqGo+4t7Mct+CSdI9geqrrVQODCZIBMxLsFGWpgZKkuk8jL4gI
         ydkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XSwph53WGQmecFqDQIRRJWyMQ4dNje7iaV+5LInDm84=;
        b=qtfFTMmWcebqvrSm84GrHA1fqEJJGV/9IQH5aiSgMyO4EjZvMKiram6VGaE6vzWCvK
         5TgjSMhoXOAXohJV7kQHbdef81TebEm8zbuwr701Mnwdn6wAD9l7TYGrP26a4iSgG16K
         g7DwqKzTLpsiJjAFGI006pJMa0r6vVTDbIr8/yM6xVXQRXhBg/TULkdBqNvKVoS2c7aH
         J7Pb5TMuNhLJZAcPzF98rxBSoJ/Rn1IxufB+CyQF9ZviMJq3gVK4XFWq37CS9fBmNSnn
         vO881cz4s0yRKfXyf+BUXkIxMFi0ip1U5ky0h3Hx1JV9ETr2zdIjkc1zqKaNXCvnMY3y
         BfKg==
X-Gm-Message-State: APjAAAUkxBp0f+cYglCW8On5GBARjOt8DN+pLxwnzjabq1ZJzdP+zTI3
        uKW7lPZ0OzvQJ3HZ69ix5i7P8BdQwilWKiL392pygHXiO0mxGA==
X-Google-Smtp-Source: APXvYqyEF81KqlBpc0Us7AaNXII2vZ9EG9VZFcto35V5+wN3z5iTfSUoVz6S2uRDwnBiWNHF+lvY8/Omodc9zT8FwKo=
X-Received: by 2002:a05:6808:8d9:: with SMTP id k25mr2566596oij.153.1571233473374;
 Wed, 16 Oct 2019 06:44:33 -0700 (PDT)
MIME-Version: 1.0
From:   Mukul Joshi <mukuljoshi2011@gmail.com>
Date:   Wed, 16 Oct 2019 09:43:57 -0400
Message-ID: <CANaw-r5Kzn0kEUWZpB8F28SYjUm5ZtLxqfD3w9c1+MDfGwN=KA@mail.gmail.com>
Subject: ktimersoftd running at 100% CPU usage - 4.9.196-rt131
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

I am observing an issue with the latest 4.9 RT patch where sometimes
after reboot, I see ktimersoftd is running at 100% CPU usage. Because
of this, other applications on our box (our own custom applications)
get stuck during their initialization (they are waiting for a
semaphore to be signaled by a thread which never gets scheduled
because of this ktimersoftd).

I am running the latest 4.9.196+RT131 patches on a 2-core ARM platform.
I have also tried with an older 4.9.82-rt61 and I have observed the
same behavior.

Moving to 4.14/4.19 branches is not an option for us right now
unfortunately, so I cannot try this on those branches.

I saw a similar issue being seen with Wireshark (mentioned at
https://lore.kernel.org/patchwork/patch/931504/) and some work related
to that was done and a patch was submitted by Haris:
https://lkml.org/lkml/2018/6/28/581 and
https://lkml.org/lkml/2018/6/28/582

I don't think the patch has made it through into the official release.
I have tried incorporating his patch also but again I see the same issue.

A snippet of the top command shows the following:
top - 06:30:52 up  1:14,  0 users,  load average: 7.00, 7.00, 6.99
Tasks: 104 total,   7 running,  97 sleeping,   0 stopped,   0 zombie
%Cpu(s):  4.7 us, 13.4 sy,  0.0 ni, 43.6 id,  0.2 wa,  0.0 hi, 38.0 si,  0.0 st
KiB Mem:   1025608 total,    55668 used,   969940 free,     2500 buffers
KiB Swap:        0 total,        0 used,        0 free.    19668 cached Mem

  PID USER      PR  NI    VIRT    RES    SHR    S    %CPU %MEM
TIME+      COMMAND
    5      root      -2      0       0         0          0       R
  100.0     0.0        74:06.20   ktimersoftd/0
15423  root      20     0    2984     1760   1388    R        6.0
0.2         0:00.02    top
    1       root      20    0    5124     3768    2144   S        0.0
    0.4         0:06.36    systemd
    2       root      20    0       0         0            0      S
    0.0      0.0         0:00.00    kthreadd
    3       root      20    0       0         0             0     S
    0.0      0.0         0:00.00    ktwork
    4       root      20    0       0         0             0     R
    0.0      0.0        0:00.05     ksoftirqd/0
    6       root      20    0       0         0            0      R
    0.0      0.0        0:00.00     kworker/0:0

Another observation is that the rescheduling interrupts on CPU 1 is
very high compared to CPU 0 and increasing at a very high rate.

IPI2:      35231    4341660  Rescheduling interrupts

I am not sure how can I debug this further to figure out whats causing
ktimersoftd to run at 100% CPU.
Can you guys offer any pointers to further debug this issue?

Thanks,
Mukul
