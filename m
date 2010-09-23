From: Lars Segerlund <lars.segerlund@gmail.com>
Subject: Newbie question about profiling.
Date: Thu, 23 Sep 2010 16:42:24 +0200
Message-ID: <AANLkTi=6NUEod+pFZPhyZL0v8C-v1iMvQDZnuKgWxj9E@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:34902 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521Ab0IWOmY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 23 Sep 2010 10:42:24 -0400
Received: by qyk33 with SMTP id 33so2455089qyk.19
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Sep 2010 07:42:24 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

 Hello,

 I am fairly new to RT Preempt, but now to realtime embedded systems.
I am trying to get EMC2 running on RT Preempt, and I was given some
old patches on the mailing list which miracously worked.

 From here I am trying to get a complete system built from scratch
with 'latest' RT Preempt and EMC2.

 My question is how to go about finding out what causes latencies and
jitter, I have no problem to create some code to benchmark latencies
or jitter, but how do I find out where the kernel is spending it's
time ?

 Any hints would be much appreciated, since i really don't have a clue
on how to go about this.

 I was thinking that if I could create a realtime task to test for a
specific thing, I really would like a log of what the kernal was doing
right before this.
 The only way I can think of is creating a module with a ring buffer (
spill over ), and tracing the scheduler or interrupt handler .... ( by
hack=EDng some code to specifically do this ), this would only add a
small overhead AFAIK.

 Any idea's anyone ? or hints ?

 It seem's like just the thing that already might have a solution in
place, so I figured I should not reinvent the wheel.

 / best regards, Lars Segerlund.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
