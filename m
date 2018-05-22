Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-qt0-f169.google.com ([209.85.216.169]:41892 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752895AbeEVVRU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 22 May 2018 17:17:20 -0400
Received: by mail-qt0-f169.google.com with SMTP id g13-v6so25407157qth.8
        for <linux-rt-users@vger.kernel.org>; Tue, 22 May 2018 14:17:20 -0700 (PDT)
MIME-Version: 1.0
From: Ran Shalit <ranshalit@gmail.com>
Date: Wed, 23 May 2018 00:17:18 +0300
Message-ID: <CAJ2oMhL=AT0K4rqMpaYGEfM+oxSPgw7n-KaWzhg5VNvkujDVJw@mail.gmail.com>
Subject: i7 vs Atom
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users <linux-rt-users@vger.kernel.org>

Hello,

We are using same BSP , kernel 3.18.11 rt7, with 2 different hardwares:
1. kontron board - i7 cpu
2. portwell board. - atom cpu (E3845 )


The results are totally different with the same testing.

In kontron the error is 11usec, while in portwell it is 2000usec .

The results of portwell seems more than just bad - they same
unbelievable, the error is VERY high (2msec).

I've tried to find a benchmark which can support my results, but found
no benchmark with ATOM.

Thank you for any suggestion.

Ranran
