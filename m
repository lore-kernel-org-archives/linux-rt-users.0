From: spdev31 <spdev31@gmail.com>
Subject: Workqueue scheduling policy
Date: Thu, 15 Aug 2013 13:59:49 -0700
Message-ID: <CAEWbfHJwxup6RY9bS8G4cecJdAi=CHad3QUbSNYCqZ_cCC0chw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ea0-f194.google.com ([209.85.215.194]:58045 "EHLO
	mail-ea0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864Ab3HOU7u (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 15 Aug 2013 16:59:50 -0400
Received: by mail-ea0-f194.google.com with SMTP id q16so304055ead.1
        for <linux-rt-users@vger.kernel.org>; Thu, 15 Aug 2013 13:59:49 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I see the workqueue scheduling policys defaults to SCHED_FIFO with the
2.6.33 RT patch but is SCHED_NORMAL with the 3.0 RT patch (and newer
RT patches, I believe).  Can you help me understand the reason for
using realtime policies for 2.6.33 RT workqueues and non-realtime
policies for 3.0 RT patch workqueues?

Thanks,
Shaun
