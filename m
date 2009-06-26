From: GeunSik Lim <leemgs1@gmail.com>
Subject: [PATCH 0/3] cyclictest: rt policy , priority-- , usage order
Date: Sat, 27 Jun 2009 00:36:42 +0900
Message-ID: <1246030602.2153.29.camel@centos51>
Reply-To: leemgs1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: tglx <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:10025 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbZFZPny (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Jun 2009 11:43:54 -0400
Received: by rv-out-0506.google.com with SMTP id k40so296161rvb.5
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Jun 2009 08:43:56 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



Dear Clark,

I made some patch files to improve current cyclictest.
If this is useful, Please merge this patch files. 
Hope it helps.

Regards.


GeunSik,Lim (3):
  cyclictest: added policy option to support FIFO or RR.
  cyclictest: Fix priority-- method of many threads with -h.
  cyclictest: Arrange alphabetically for readability of "cyclictest
    --help" output.

 src/cyclictest/cyclictest.c |   47 +++++++++++++++++++++++++++---------------
 1 files changed, 30 insertions(+), 17 deletions(-)



-----------------------------------------------
To unsubscribe from this list: send the line "unsubscribe linux-***" 
in the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

GeunSik Lim ( Samsung Electronics )
e-Mail  :1) geunsik.lim@samsung.com
         2) leemgs@gmail.com , leemgs1@gmail.com
HomePage: http://blog.naver.com/invain/
-----------------------------------------------

