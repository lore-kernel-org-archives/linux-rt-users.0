From: Austin Hendrix <ahendrix@willowgarage.com>
Subject: kfree causing high latency on 3.4.4-rt13
Date: Tue, 29 Jan 2013 12:59:38 -0800
Message-ID: <CAOY97VYWzxz-=HNYamCdqOzjXPsAyKjETZ3Hv7V3K4CZ6YB1kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:63523 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972Ab3A2U7j (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Jan 2013 15:59:39 -0500
Received: by mail-ob0-f179.google.com with SMTP id un3so900115obb.24
        for <linux-rt-users@vger.kernel.org>; Tue, 29 Jan 2013 12:59:38 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

I'm running 3.4.4-rt13 on my systems, and while the realtime
performance is great, I occasionally see non-realtime processes block
for several seconds. Running latencytop, it looks like the kfree
kernel process is the worst offender. Does anyone have advice on how I
can troubleshoot this further?

I've poked around the intercatz, but either my google-fu is weak, or
there aren't many other people having this problem.

Thanks,
Austin Hendrix
Robot Systems Administrator
Willow Garage
