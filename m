From: Juuso Alasuutari <juuso.alasuutari@gmail.com>
Subject: 2.6.23.8-rt11, tasks freezing
Date: Wed, 21 Nov 2007 12:50:39 +0200
Message-ID: <200711211250.39265.juuso.alasuutari@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.233]:21134 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755206AbXKUKup (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Nov 2007 05:50:45 -0500
Received: by wr-out-0506.google.com with SMTP id c49so1357146wra
        for <linux-rt-users@vger.kernel.org>; Wed, 21 Nov 2007 02:50:44 -0800 (PST)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

I use vanilla kernels with realtime-preempt patches on a Core 2 E6600 running 
32-bit Linux. Kernels up to 2.6.22.1-rt9 work fine, but I'm experiencing 
strange freezing of some tasks with 2.6.23.8-rt11. (Actually all 2.6.23 
rt-kernels I've so far tried hang the same way.)

The system boots up nicely and seems to be running properly, until something 
tips it off and some commands begin to get "jammed". What seems to trigger it 
is accessing the hard disk, for instance doing something like `grep -r 
foo /var`. When it happens the desktop seems mostly responsive, but trying to 
run commands like `ls` will freeze the terminal. Other commands will succeed, 
for instance `ps aux` works as usual.

Alt-SysRq-w shows more than one blocked pdflush task, as well as metalog and 
whatever commands have become "jammed" so far, like `ls`.

I'll be happy to post more information, I just need to know what. I'd attach 
my .config here, but I can't access the computer from where I'm at the 
moment.

Juuso Alasuutari
