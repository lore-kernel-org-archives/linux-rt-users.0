Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-qt0-f174.google.com ([209.85.216.174]:35648 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbeEQOlq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 17 May 2018 10:41:46 -0400
Received: by mail-qt0-f174.google.com with SMTP id f5-v6so6070169qth.2
        for <linux-rt-users@vger.kernel.org>; Thu, 17 May 2018 07:41:45 -0700 (PDT)
MIME-Version: 1.0
From: Ran Shalit <ranshalit@gmail.com>
Date: Thu, 17 May 2018 17:41:44 +0300
Message-ID: <CAJ2oMhJmqTn5S-6Pk7j3-dwQMgK1Aii=B_spJFJmaj4iGOVGYw@mail.gmail.com>
Subject: How to investigate different timings of 2 HW with same kernel ?
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users <linux-rt-users@vger.kernel.org>

Hello,

We are using same BSP , Gentoo 3.18.11 rt7, with 2 different hadrwares:
1. kontron board
2. portwell board.

Both use came cpu intel i7.
Yet, the results are totally different with the same testing.

In kontron the error is 11usec, while in portwell it is 2000usec .

Testing is done using:
https://github.com/nma/preempt-rt/blob/master/test-rt.c

Is there any idea, how to start investigating such issue ?

Thank you,
Ranran
