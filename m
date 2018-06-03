Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-qt0-f175.google.com ([209.85.216.175]:39433 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbeFCSne (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 3 Jun 2018 14:43:34 -0400
Received: by mail-qt0-f175.google.com with SMTP id p23-v6so13337206qtn.6
        for <linux-rt-users@vger.kernel.org>; Sun, 03 Jun 2018 11:43:34 -0700 (PDT)
MIME-Version: 1.0
From: Ran Shalit <ranshalit@gmail.com>
Date: Sun, 3 Jun 2018 21:43:32 +0300
Message-ID: <CAJ2oMhJ3koLBA3=d0y+UBh2n1JH442vVLbFUxppSjFYN8wXLNg@mail.gmail.com>
Subject: printf & writing to disk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users <linux-rt-users@vger.kernel.org>

Hello,

How should printf and write to disk should be handled in rt application ?

1. printf - can it be used in rt application ? how ?

2. writing to file in disk - should it be done in separate thread with
lower priority ? or doesn't it make any difference in which thread ?

Thank you,
ranran
