From: Jaakko Sipari <jaakko.sipari@gmail.com>
Subject: Difference between chrt and nice
Date: Tue, 31 Mar 2009 08:43:30 +0300
Message-ID: <901f25b80903302243q5ae531fs92113638539ea557@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f165.google.com ([209.85.219.165]:49217 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324AbZCaFnc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 31 Mar 2009 01:43:32 -0400
Received: by ewy9 with SMTP id 9so2380271ewy.37
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2009 22:43:30 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi!

I've already asked this in a couple of forums but got no answers. I
would appreciate it if someone in this list could take some time to
answer to my possibly stupid question(s):

What's the difference of setting process priority with chrt and nice?
And how do using both of these commands compare with a normal vs.
realtime-kernel  (PREEMPT_RT)?

BR, Jaakko
