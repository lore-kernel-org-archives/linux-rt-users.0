From: Dennis Borgmann <dennis.borgmann@googlemail.com>
Subject: [RT]adjtimex gives wrong number of ticks
Date: Thu, 29 Sep 2011 14:42:45 +0200
Message-ID: <4E8467C5.9060704@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57733 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756042Ab1I2MoF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Sep 2011 08:44:05 -0400
Received: by fxe4 with SMTP id 4so1666376fxe.19
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Sep 2011 05:44:03 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello RT-users!

I am observing strange behaviour regarding CONFIG_HZ on various 
machines, while trying to adjust the tickrate of some systems. I found, 
that adjtimex(2) is not behaving the way it should. If I write a simple 
program like this:

#include <stdio.h>
#include <sys/timex.h>
int main() {
     struct timex t;
     adjtimex(&t);
     printf("%ld\n",t.tick);
}

, which simply is to print the time in usec between two kernel ticks, 
the output makes no sense. On a RT-System with CONFIG_HZ=1000, the 
output is "10000" and on a non-RT system with CONFIG_HZ=250 (my 
desktop-laptop), the output is "9999" - almost the same.

If I calculate correctly, it should be 1000 with CONFIG_HZ and 4000 with 
CONFIG_HZ=250.

Am i wrong, or is this an error?

Btw: adjtimex with a tick of of 1000 gives me this:

root@ap:/tmp# adjtimex --tick 1000
adjtimex: Invalid argument
for this kernel:
    USER_HZ = 100 (nominally 100 ticks per second)
    9000 <= tick <= 11000
    -32768000 <= frequency <= 32768000

on the RT-system with CONFIG_HZ=1000. This is also odd - it should print 
"USER_HZ=1000" and not "USER_HZ=100".

Strange... Any ideas?

Best regards,
Dennis
