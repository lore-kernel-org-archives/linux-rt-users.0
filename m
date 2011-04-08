From: dashesy <dashesy@gmail.com>
Subject: Preferred way for rt-linux using git
Date: Fri, 8 Apr 2011 09:51:57 -0600
Message-ID: <BANLkTi=3s8bZLibMZX7y6_NGhHivErwS_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54872 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757203Ab1DHPv7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Apr 2011 11:51:59 -0400
Received: by bwz15 with SMTP id 15so2944128bwz.19
        for <linux-rt-users@vger.kernel.org>; Fri, 08 Apr 2011 08:51:57 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I am new to rt-linux, what is the preferred way of getting the source
and applying the patch using git?
Should I do:
"git clone git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.git
rt/2.6.33"
or maybe I should start from the long-term 2.6.33 version?
"git clone git://git.kernel.org/pub/scm/linux/kernel/git/longterm/linux-2.6.33.y.git
linux-2.6.33"
then apply the newest patch?

Thanks for the great work BTW

dashesy
