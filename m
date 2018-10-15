Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from krieglstein.org ([176.28.13.145]:53590 "EHLO krieglstein.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbeJOXaa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 15 Oct 2018 19:30:30 -0400
From: Tim Sander <tim@krieglstein.org>
Subject: 100% RT load on 2 processor SMP machine
Date: Mon, 15 Oct 2018 17:44:42 +0200
Message-ID: <2762823.FS3CZOEJbg@dabox>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org

Hi

I just disovered a bug in my playground realtime application which led to 100% 
load on one core. This was the non normal case when the system was waiting for 
a network client to connect and i had a fifo buffer overflow which led 
accidentially to a busy wait loop with 98 fifo priority. This in turn lead to 
a system which did not accept any new network connections.

The expected behaviour for a SMP system which still has one processor lightly 
loaded should be that it still works "normal" even if one core is overloaded 
with hard realtime work. Are there any explanations for this behavior?

The embedded system im am using is an pretty dated Intel/Altera Cortex A9.

Best regards
Tim
