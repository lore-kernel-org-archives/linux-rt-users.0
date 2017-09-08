From: =?iso-8859-1?Q?Andr=E9_Pribil?= <a.pribil@beck-ipc.com>
Subject: Re: RT and tty communication
Date: Fri, 8 Sep 2017 13:50:43 +0200
Message-ID: <681500CE65202E47A192754B01DAB4671B22332E5F@SDE12.beckipc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "CAD2hpBW1YNbS+C1osQ0zMF=f_w+fpmpZvsv=x6u-1BQrSvz3Dw@mail.gmail.com"
        <CAD2hpBW1YNbS+C1osQ0zMF=f_w+fpmpZvsv=x6u-1BQrSvz3Dw@mail.gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx.beck-ipc.com ([195.243.140.130]:56268 "EHLO mx.beck-ipc.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752858AbdIHL6d (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 8 Sep 2017 07:58:33 -0400
Received: from remote.beck-ipc.com (sde12.beckipc.net [172.30.2.12])
        by mx.beck-ipc.com (Postfix) with ESMTPS id 970C311F7FC
        for <linux-rt-users@vger.kernel.org>; Fri,  8 Sep 2017 13:50:46 +0200 (CEST)
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I'm having the same problem. 

In my RT application, running currently at kernel 4.9.13-rt12, a high priority 
thread communicates with a tty serial port. This thread is checking for incoming 
characters with a non-blocking read() call. The execution time of this read() 
call is normally within some hundreds of microseconds. In case some lower 
priority thread/process accesses some other tty, e.g. for console output, 
the non-blocking read() execution time within the high priority task rises to 
hundreds of milliseconds. 

After reverting the OpenSSH patch that Niels Kolthoff mentioned, I do no longer 
see these big delays inside the non-blocking read(). However, now the high 
priority task does not receive any characters from the tty serial port during 
these long periods. The non-blocking read() returns -1, although there
must be characters available. This leads to timeouts in my application. 
So just reverting this patch is no workaround for me.

Any ideas how to solve this issue are very welcome.

Regards,
Andre
