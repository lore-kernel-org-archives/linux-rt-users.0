From: "Denis Borisevich" <dennisfen@gmail.com>
Subject: Motherboard chipset advise needed.
Date: Thu, 21 Aug 2008 16:37:09 +0400
Message-ID: <902d99b50808210537s1f5d57d6l5a8bde00e9917912@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.251]:6555 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbYHUMhK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Aug 2008 08:37:10 -0400
Received: by an-out-0708.google.com with SMTP id d40so145024and.103
        for <linux-rt-users@vger.kernel.org>; Thu, 21 Aug 2008 05:37:09 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi everyone!
I need a general advise on what chipset (or even motherboard) is
preferred to use with -rt patch to get rid of latencies. Now I use
ICH6 based ASUS motherboard and have ~60us latencies in worst case
while running `cyclictest -n -p 99 -t1`. And that's not good for my
application. I also tried to run this test on EliteGroup SIS 761GX
chipset based motherboard and got ~13us for the worst case with the
same test. So can anyone provide some usefull info on which chipset to
choose? Or should I check something else in my system?

Thanks in advance.
Denis.
